--allow user sys create user
alter session set "_ORACLE_SCRIPT"=true;
--create user
create user doanhe2 identified by 1;
--Grant all privileges
GRANT ALL PRIVILEGES TO doanhe2;




--xoa cac bang neu chung da ton tai
drop table ctdonhang;
drop table tonkho;
drop table dscafe;
drop table dondathang;
drop table chinhanh;
drop table thuonghieu;
drop table loaicafe;
drop table nhanvien;
drop table hoahong;
drop table congviec;
drop table khachhang;
drop table khuvuc;



--tao cac bang

--Tao bang khuvuc
create table khuvuc
(
    makv number(2) primary key,
    tenkv varchar(100) not null
);
--Tao bang chinhanh
create table chinhanh
(
    macn char(4) primary key,
    tencn varchar(100) not null,
    diachi varchar(250) not null,
    hotline varchar(11) not null,
    makv number(2) constraint fk_chinhanh_makv references khuvuc(makv) 
);
--Tao bang loaicafe
create table loaicafe
(
    maloaicf char(3) primary key,
    tenloaicf varchar(100) not null
);
--Tao bang thuonghieu
create table thuonghieu
(
    math char(2) primary key,
    tenth varchar(100) not null
);

--Tao bang dscafe
create table dscafe
(
    macf char(10) primary key,
    tencf varchar(100) not null,
    ngaysx date not null,
    hsd varchar(100) not null,
    khoiluong float default 0 check(khoiluong >= 0),
    dvt varchar(50) not null,
    giaban int not null check(giaban >=0),
    mota varchar(2000),
    maloaicf char(3) constraint fk_dscafe_maloaicf references loaicafe(maloaicf),
    math char(2) constraint fk_dscafe_math references thuonghieu(math)
);
--Tao bang tonkho
create table tonkho
(
    macn char(4) constraint fk_tonkho_macn references chinhanh(macn),
    macf char(10) constraint fk_tonkho_macf references dscafe(macf),
    slton int not null check(slton >= 0),
    primary key (macn, macf)
);
--Tao bang hoahong
create table hoahong
(
    mahh number(2) primary key,
    hoahong number(7) not null check (hoahong >=0)
);
--Tao bang congviec
create table congviec
(
    macv char(2) primary key,
    tencv varchar(100) not null
);
--Tao bang nhanvien
create table nhanvien
(
    manv char(6) primary key,
    honv varchar(60) not null,
    tennv varchar(40) not null,
    ngayvaolam date not null,
    luong number(10) not null check(luong >= 3000000),
    sdt varchar(11) not null,
    email varchar(100),
    mahh number(2) default 0 constraint fk_nhanvien_mahh references hoahong(mahh),
    macv char(2) constraint fk_nhanvien_macv references congviec(macv),
    makv number(2) constraint fk_nhanvien_makv references khuvuc(makv)
);
--Tao bang khachhang
create table khachhang
(
    makh char(6) primary key,
    tenkh varchar(100) not null,
    diachi varchar(250) not null,
    sdt varchar(11) not null,
    email varchar(100)
);
--Tao bang dondathang
create table dondathang
(
    maddh char(10) primary key,
    ngaylap date not null,
    makh char(6) constraint fk_dondathang_makh references khachhang(makh),
    manv char(6) constraint fk_dondathang_manv references nhanvien(manv),
    makv number(2) constraint fk_dondathang_makv references khuvuc(makv),
    macn char(4) constraint fk_dondathang_macn references chinhanh(macn),
    ten_nguoinhan varchar(100) not null,
    diachi_giao varchar(250) not null,
    thoihan_giao date not null,
    sdt_nguoinhan varchar(11) not null,
    thanhtien number(10) default 0,
    tinhtrang varchar(100) default 'Chua duoc giao',
    ghichu varchar(200)
);
--Tao bang ctdonhang
create table ctdonhang
(
    maddh char(10) constraint fk_ctdonhang_maddh references dondathang(maddh),
    macf char(10) constraint fk_ctdonhang_macf references dscafe(macf),
    sl int not null check(sl > 0),
    primary key (maddh, macf)
);




--them du lieu

delete from khuvuc;
insert into khuvuc (makv, tenkv) values ( '1', 'khu vuc tay nguyen');
insert into khuvuc (makv, tenkv) values ( '2', 'khu vuc phia nam');
insert into khuvuc (makv, tenkv) values ( '3', 'khu vuc mien trung');
insert into khuvuc (makv, tenkv) values ( '4', 'khu vuc phia bac');


delete from chinhanh;
insert into chinhanh (macn, tencn, diachi, hotline, makv) values ('CN01', 'Chi nhanh Thang Loi, Buon Ma Thuot', '203 Nguyen Van Troi, Thang Loi, thanh pho Buon Ma Thuot, Dak Lak', '0706664515', 1);
insert into chinhanh (macn, tencn, diachi, hotline, makv) values ('CN02', 'Chi nhanh Tan Thanh, Buon Ma Thuot', '106 Le Duan, Tan Thanh, thanh pho Buon Ma Thuot, Dak Lak', '0184787422', 1);
insert into chinhanh (macn, tencn, diachi, hotline, makv) values ('CN03', 'Chi nhanh Quan 7, TPHCM', '37 Nguyen Thi Thap, Binh Thuan, quan 7, thanh pho Ho Chi Minh', '0845125762', 2);
insert into chinhanh (macn, tencn, diachi, hotline, makv) values ('CN04', 'Chi Nhanh Quan 10, TPHCM', '850 Su Van Hanh, phuong 12, quan 10, thanh pho Ho Chi Minh', '0235846941', 2);
insert into chinhanh (macn, tencn, diachi, hotline, makv) values ('CN05', 'Chi nhanh Da Nang', '104 Dong Da, Thuan Phuoc, Hai Chau, Da Nang', '0815489658', 3);
insert into chinhanh (macn, tencn, diachi, hotline, makv) values ('CN06', 'Chi nhanh Ha Noi', '12c Hoang Dieu, Dien Ban, Ba Dinh, Ha Noi', '0276956698', 4);


delete from loaicafe;
insert into loaicafe (maloaicf, tenloaicf) values ('L00', 'Khac');
insert into loaicafe (maloaicf, tenloaicf) values ('L01', 'Ca phe rang nguyen hat');
insert into loaicafe (maloaicf, tenloaicf) values ('L02', 'Ca phe ranng xay');
insert into loaicafe (maloaicf, tenloaicf) values ('L03', 'Ca phe hoa tan');
insert into loaicafe (maloaicf, tenloaicf) values ('L04', 'Ca phe phin giay');
insert into loaicafe (maloaicf, tenloaicf) values ('L05', 'Ca phe nhan chua xu ly');


delete from thuonghieu;
insert into thuonghieu (math, tenth) values ('00', 'Khac');
insert into thuonghieu (math, tenth) values ('TN', 'Trung Nguyen');
insert into thuonghieu (math, tenth) values ('TK', 'TNI King Coffee');
insert into thuonghieu (math, tenth) values ('NL', 'Non La Coffee');
insert into thuonghieu (math, tenth) values ('LC', 'Lion Cafe');


delete from dscafe;
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0001', 'Cafe TNI King Coffee 450g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 450, 'hop', 315000, 'khoi dau voi mot chut huong nong nan cua nhung hat arabica hao hang, tiep noi voi vi chua nhe va nt diu nguyen ban cua hat ca phe', 'L02', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0002', 'Cafe nguyen hat TNI King Coffee arabica guatemala 340g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 340, 'goi', 276000, 'duoc che bien tu hat Cafe arabica guatemala theo quy trinh hien dai ket hop voi cong thuc pha che chuyen biet tu cac chuyen gia TNI King Coffee, cho ra san pham Cafe phin TNI King Coffee chat luong', 'L01', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0003', 'Cafe nguyen hat TNI King Coffee arabica colombia 340g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 340, 'goi', 258000, 'duoc lam tu nhung hat Cafe arabica colombia, voi cong nghe che bien hien dai cung cong thuc chuyen biet cua cac chuyen gia tu TNI King Coffee, tao ra san pham Cafe phin dac trung', 'L01', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0004', 'Cafe nguyen hat TNI King Coffee arabica brazil 340g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 340, 'goi', 224000, 'su dung hat Cafe arabica brazil - la mot trong nhung loai Cafe nn va duoc nhieu nguoi yeu thich tren thi truong hien tai', 'L01', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0005', 'Cafe nguyen hat TNI King Coffee signature blend 340g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 340, 'goi', 190000, 'su dung hat Cafe arabica ethiopia, Cafe arabica guatemala, Cafe arabica brazil, Cafe robusta viet nam, Cafe arabica cau dat - la bon trong nhung loai Cafe nn va duoc nhieu nguoi yeu thich tai viet nam', 'L01', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0006', 'Cafe nguyen hat TNI King Coffee breakfast 340g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 340, 'goi', 183000, 'tu 4 loai hat Cafe chinh Cafe arabica brazil, Cafe arabica guatemala, Cafe robusta viet nam, Cafe arabica cau dat, tao nen huong vi dam da kho quen', 'L01', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0007', 'Cafe nguyen hat TNI King Coffee da lat 340g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 340, 'goi', 129000, 'duoc che bien theo quy trinh hien dai ket hop voi hat Cafe arabica cau dat - la mot trong nhung loai Cafe nn va duoc nhieu nguoi viet yeu thich', 'L01', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0008', 'Cafe nguyen hat TNI King Coffee buon ma thuot 340g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 340, 'goi', 113000, 'su dung hat Cafe robusta buon ma thuot, Cafe arabica cau dat nguyen chat nhung san pham Cafe nguyen hat cua king coffee deu co vi dang, dam dac trung, rieng biet', 'L01', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0009', 'Cafe TNI King Coffee inspire blend 250g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 250, 'goi', 52000, 'tu nhung hat Cafe tot cua vung dat do bazan,so huu cong thuc rang xay truyen thong tao ra dong san pham Cafe doc dao, mang den cho moi nguoi huong vi tuyet voi', 'L02', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0010', 'Cafe den TNI King Coffee espresso 250g (100 i x 25g)', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 250, 'hop', 295000, 'thanh phan duoc chon lua tu nhung hat Cafe arabica thien nhien 100%, khong co chat phu gia doc hai co vi chua thanh xen lan voi vi dang nhe', 'L03', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0011', 'Cafe den hoa tan TNI King Coffee pure black coffee 300g (150 i x 2g)', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 300, 'hop', 202000, 'voi vi dang quen thuoc va huong thom tu nhien von co cua ca phe, san pham duoc tao ra de mang den niem dam me ve mot loai Cafe nguyen chat va thuan khiet', 'L03', 'TK');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0012', 'Cafe urmet blend - 500gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'hop', 94100, 'nuoc pha mau nau den sanh, huong vi dam da, loi cuon, ham luong caffeine: khoang 10%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0013', 'Cafe lon lon premium blend - 425gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 425, 'hop', 138000, 'nuoc pha mau nau dam, mui thom dac trung, ben, dam, vi dam da ham luong caffeine: ? 1 %', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0014', 'Cafe house blend - 500gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'hop', 70000, 'Cafe house blend m 4 loai hat Cafe arabica, robusta, cherry va catimor ham luong caffeine: khoang 10%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0015', 'Cafe sang tao 1 - 340gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 340, 'goi', 53200, 'voi thanh phan Cafe culi robusta nuoc pha mau nau canh gian dam, mui thom diu nhe, vi dam da ham luong caffeine khoang 25%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0016', 'Cafe sang tao 2 - 340gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 340, 'goi', 61800, 'su ket hop giua hat robustava arabica, tao nen mui thom nhe, vi dang em, dam da ham luong caffeine khoang 20%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0017', 'Cafe sang tao 3 - 340gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 340, 'goi', 74700, 'duoc lam tuhat arabica se, nuoc pha mau nau canh gian nhat, mui thom nong, vi dang hoi chua, the chat nhe vua phai ham luong caffeine: khoang 17%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0018', 'Cafe sang tao 4 - 340gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 340, 'goi', 84800, 'ket hop tu nhung hat culi cua 4 loai Cafe arabica, robusta, catimor va excelsa nuoc pha mau nau canh gian dam, mui thom ben, vi rat dac biet, the chat dam, ham luong caffeine khoang 24%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0019', 'Cafe sang tao 5 - 340gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 340, 'goi', 103500, 'duoc lam tu hat culi arabica tao nen mui thom dac trung, vi em nhe va it dang, mui thom ham luong caffeine: khoang 20%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0020', 'Cafe che phin loai 1 - 500gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 87800, 'che bien tu nhung hat Cafe culi robusta hao hang, mui thom diu nhe, vi dam da ham luong caffeine: khoang 25%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0021', 'Cafe che phin loai 2 - 500 gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 101400, 'che bien tu nhung hat Cafe robusta va arabica nn nhat the gioi mang mui thom nhe, vi dang em, dam da ham luong caffeine: khoang 20%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0022', 'Cafe che phin loai 3 - 500 gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 119200, 'che bien tu nhung hat Cafe arabica se nuoc pha mau nau canh gian nhat, mui thom nong, vi dang hoi chua, the chat nhe vua phai ham luong caffeine: khoang 17%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0023', 'Cafe che phin loai 4 - 500 gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 141200, 'ket hop tu nhung hat culi cua 4 loai Cafe arabica, robusta, catimor va excelsa nuoc pha mau nau canh gian dam, mui thom ben, vi rat dac biet, the chat dam ham luong caffeine khoang 24%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0024', 'Cafe che phin loai 5 - 500 gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 168300, 'che bien tu hat Cafe culi arabica nuoc pha mau nau canh gian dam, mui thom dac trung, vi em nhe va it dang, mui thom ham luong caffeine: khoang 20%', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0025', 'Cafe i (khat vong) - 500 gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 57500, 'huong vi Cafe dac trung voi su ket hop cua 4 loai hat ca phe: arabica, robusta, excelsa, catimor theo ti le phoi tron dac biet Cafe Trung Nguyen i voi mau nuoc nau dam, huong thom nong, vi dam da dac trung', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0026', 'Cafe s (chinh phuc) - 500gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 489000, 'huong vi Cafe dac trung voi su ket hop cua 4 loai hat ca phe: arabica, robusta, excelsa, catimor theo ti le phoi tron dac biet Cafe Trung Nguyen s co mau nuoc nau sanh, huong thom day, vi dam da', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0027', 'Cafe suc song ( nau) - 500gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 70000, 'huong vi Cafe dac trung voi su ket hop cua 4 loai hat ca phe: arabica, robusta, excelsa va catimor co mui huong thom nong quyen ru, vi dam da dac trung', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0028', 'Cafe drip - culi robusta hat so 1 - 250gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '1 nam ke tu nsx', 250, 'goi', 37800, 'culi robusta duoc chon loc tu nhung hat Cafe tron cua giong robusta nuoc pha mau nau den, mui thom nhe, vi dang hoi gat', 'L01', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0029', 'Cafe drip - premium culi hat so 4 - 250gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '1 nam ke tu nsx', 250, 'goi', 60400, 'Cafe hat xay drip - premium culi co nuoc pha mau canh gian dam mui thom dam va rat lau', 'L01', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0030', 'Cafe drip - arabica robusta hat so 2 - 250gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '1 nam ke tu nsx', 250, 'goi', 45175, 'a phe hat xay drip - arabica robusta khi pha co mau den nhat mui thom nhe, vi em va hoi dang', 'L01', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0031', 'Cafe drip - culi arabica hat so 5 - 250gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '1 nam ke tu nsx', 250, 'goi', 76125, 'Cafe hat xay drip - culi arabica co vi em nhe it dang va mui thom rat dac trung', 'L01', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0032', 'Cafe drip - chon (weasel) hat so 8 - 250gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), ' nam ke tu nsx', 250, 'goi', 183100, 'duoc che bien bang cong nghe u men sinh hoc hien dai bac nhat theo bi quyet phoi tron tu nhung hat Cafe arabica, robusta, excelsa nuoc pha sanh dam da, huong thom dac trung cua Cafe chon la mot su can bang hoan hao giua huong va vi', 'L01', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0033', 'Cafe sang tao 8 Trung Nguyen - 250gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '12 thang ke tu nsx', 250, 'hop', 175000, 'duoc chon lua tu nhung hat Cafe arabica, robusta, excelsa nn nhat cua viet nam, jamaica, barazil, ethiopia, la san pham Cafe sieu sach, sang tao va kich thich nao', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0034', 'Cafe chon legend Trung Nguyen - 225gr', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '12 thang ke tu nsx', 225, 'hop', 795000, 'Cafe cao cap chon legend Trung Nguyen la cafe duoc san xuat bang phuong phap "len men sinh hoc" chon tu nhung hat Cafe nn nhat tu viet nam, jamaica, brazil, ethiopia, Cafe legend phu hop lam qua bieu tang', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0035', 'Cafe chon weasel - 250 gram', TO_DATE('2021-09-02', 'YYYY-MM-DD'), '24 thang ke tu nsx', 250, 'hop', 17000000, 'duoc thu m hoan toan tu tu nhien, chon loc mot cach ti my va trai qua mot qua trinh sieu tiet trung dac biet truoc khi tham gia vao cong doan che tac san pham Cafe weasel san xuat gioi han, moi nam chi 40 – 50kg', 'L02', 'TN');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0036', 'Cafe non la arabica dark 350g', TO_DATE('2021-02-16', 'YYYY-MM-DD'), '24 thang ke tu nsx', 350, 'goi', 80000, 'tu nhung hat Cafe arabica hao hang dem rang va xay theo quy trinh che bien hien dai Cafe co mui Cafe rat dam va thom, hoa quyen cung vi dang dac trung cua Cafe nguyen chat kem chut vi nt o hau rat tuyet voi', 'L02', 'NL');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0037', 'Cafe hat non la arabica dark 500g', TO_DATE('2021-02-16', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 130000, 'tu nhung hat Cafe arabica hao hang tao ra san pham co mui Cafe rat dam va thom, hoa quyen cung vi dang dac trung cua Cafe nguyen chat va co kem chut vi nt o hau rat tuyet voi', 'L01', 'NL');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0038', 'Cafe hat non la robusta dark 500g', TO_DATE('2021-02-16', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 120000, 'su dung thanh phan la nhung hat Cafe robusta thuong hang qua quy trinh u va che bien hien dai Cafe chat luong thom nong mui ca phe, hoa quyen cung vi dam da dac trung cua Cafe robusta nguyen chat va mau nau sam dep mat', 'L01', 'NL');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0039', 'Cafe phin giay non la 180g', TO_DATE('2021-02-16', 'YYYY-MM-DD'), '24 thang ke tu nsx', 180, 'hop', 105000, 'su dung thanh phan la nhung hat Cafe arabica dem rang va xay theo quy trinh che bien hien dai, cho ra san pham Cafe phin chat luong dung vi Cafe viet nam voi vi Cafe nong dam, mau sac dep mat cung huong thom quyen ru ngat ngay', 'L04', 'NL');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0040', 'cafe rang xay lion chon sanh dieu 500gr (250gr * 2 i)', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'hop', 108000, 'duoc chat loc tu nhung hat Cafe robusta tai dak lak, viet nam bang mot cong thuc phuc hop va u hat bang men sinh hoc dac biet, co mau nuoc pha sanh dam mui thom rat dac biet de chiu va em diu va thom lau sau khi uong', 'L02', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0041', 'cafe rang xay culi thuong hang Lion Cafe 205gr', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 205, 'hop', 64000, 'ket hop cua loai Cafe robusta dam dac va arabica thom huong Cafe duoc u va tam uop theo bi quyet pha che dac trung phuong dong cua thuong hieu Lion Cafe, mang den huong vi dam da kho quen', 'L02', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0042', 'cafe rang xay lion moka hoang hon 500gr', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 76000, 'duoc chon loc va che bien tu nhung hat Cafe arabica cho ra mot huong vi Cafe rat thom, rat nhe, em diu va hoi chua neu ban thich vi chua nt cua o mai, vi dang diu cua chocolate', 'L02', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0043', 'cafe rang xay lion robusta binh minh 500gr', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 500, 'goi', 72000, 'cafe rang xay lion robusta binh minh co vi dang dam da, vi nt tu nhien vi cua robusta binh minh nam trong khoang tu trung tinh cho den rat gat vi cua chung thuong duoc dien ta la giong nhu bot yen mach', 'L02', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0044', 'cafe hat moka lion 300gr', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 300, 'goi', 106000, 'cafe tui hat lion moka duoc chon loc va che bien tu nhung hat Cafe nn nhat cho ra mot huong vi Cafe rat thom, rat nhe, em diu va hoi chua', 'L01', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0045', 'cafe hat robusta lion 300gr', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 300, 'goi', 90000, 'cafe tui hat lion robusta co ham luong cafein cao hon, thich hop voi nhung nguoi thich huong vi Cafe hoi dang va nong, giup chung ta tuoi tinh va giai stress', 'L01', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0046', 'cafe hat arabica lion 300gr', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 300, 'goi', 98000, 'vi chua thanh lan xen lan dang diu cung voi mui thom ngay ngat, tao nha cua cafe hat arabicala mot mon qua quy gia troi ban cho nhung ai sanh dieu ca phe, huong vi doc dao nay danh thuc niem dam me Cafe cua ca nhan loai', 'L01', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0047', 'cafe hoa tan 007 3in1 gu dam x2 10 i – 180gr', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 180, 'hop', 29000, 'duoc chiet xuat truc tiep tu nhung hat Cafe chin mong, sach, thuan khiet tu vung dat bazan huyen thoai: pong drang, krong buk, buon ho, dak lak', 'L03', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0048', 'cafe hoa tan lion 3in1 ( 39 que )', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 702, 'goi', 125000, 'Cafe lion hoa tan 3in1 duoc chiet xuat truc tiep tu nhung hat Cafe chin mong, sach, thuan khiet tu vung dat bazan huyen thoai: pong drang, krong buk, buon ho, dak lak ', 'L03', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0049', 'Cafe tuoi hoa tan lion 3in1 say lanh – gu nha lam', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 288, 'hop', 50000, 'duoc chiet xuat truc tiep tu nhung hat Cafe chin mong, sach, thuan khiet tu vung dat bazan huyen thoai pong drang, krong buk, buon ho, dak lak', 'L03', 'LC');
insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math) values ('CF0050', 'cafe hoa tan lion 4in1 capuccino vi dua - 360gr', TO_DATE('2021-03-20', 'YYYY-MM-DD'), '24 thang ke tu nsx', 360, 'hop', 108000, 'su ket hop cung cot dua da dem den 1 huong vi rat khac cho ca phe, vua dang lai nt beo thanh nhe, vua thom Cafe lai thom sua dua rat rieng ', 'L03', 'LC');


delete from hoahong;
insert into hoahong (mahh, hoahong) values (0, 0);
insert into hoahong (mahh, hoahong) values (1, 200000);
insert into hoahong (mahh, hoahong) values (2, 300000);
insert into hoahong (mahh, hoahong) values (3, 400000);
insert into hoahong (mahh, hoahong) values (4, 500000);



delete from congviec;
insert into congviec (macv, tencv) values ('DH', 'dong hang');
insert into congviec (macv, tencv) values ('GH', 'giao hang');
insert into congviec (macv, tencv) values ('KK', 'kiem kho');
insert into congviec (macv, tencv) values ('KT', 'ke toan');
insert into congviec (macv, tencv) values ('TV', 'tu van khach hang');
insert into congviec (macv, tencv) values ('QL', 'quan ly chi nhanh');


delete from nhanvien;
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0001', 'Nguyen Thuy', 'Linh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4000000, '0377699829', 'thuylinh2308@gmailcom', 'DH', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0002', 'Hoang Anh', 'Tuan', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4000000, '0964872434', 'anhtuan0204@gamilcom', 'DH', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0003', 'Tran Thi Hoang', 'Anh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4000000, '0369954954', 'anhanh719@gmailcom', 'DH', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0004', 'Doan Anh', 'Toan', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4000000, '0986667211', 'toandoan4729@gmailcom', 'DH', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0005', 'Nguyen Tran Anh', 'Thu', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4000000, '0974665644', 'anhthu1429@gamilcom', 'DH', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0006', 'Duong Truc', 'Phuong', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4000000, '0815778358', 'trucfhuong22@gamilcom', 'DH', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0007', 'Nguyen Hong', 'Nhung', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 3500000, '0986578982', 'hongnhung921@gmailcom', 'DH', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0008', 'Vo Yen', 'Nhi', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 3500000, '0369353363', 'nhinhi2206@gmailcom', 'DH', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0009', 'Nguyen Anh', 'Quan', TO_DATE('2020-03-19', 'YYYY-MM-DD'), 3000000, '0378728782', 'anhquan2211@gmailcom', 'DH', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0010', 'Ta Xuan', 'Huy', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 3500000, '0984653734', 'tahuy1998@gmailcom', 'DH', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0011', 'Do Van', 'Anh', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 3500000, '0374872494', 'vananhdo@gmailcom', 'DH', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('DH0012', 'Duong Nguyen Chi', 'Dung', TO_DATE('2020-04-07', 'YYYY-MM-DD'), 3000000, '0358720018', 'chidung0803@gmailcom', 'DH', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0001', 'Le Xuan', 'Quy', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0388271916', 'xuanquy23@gmailcom', 'GH', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0002', 'Tran Dinh', 'Chinh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0891264192', 'chinhtran79@gmailcom', 'GH', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0003', 'Tu Quang', 'Chung', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0388241369', 'quangchung12@gmailcom', 'GH', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0004', 'Nguyen Huu', 'Trung', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0328989748', 'huutrung873@gmailcom', 'GH', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0005', 'Phan Trong', 'Hieu', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0941610179', 'tronghieujr123@gmailcom', 'GH', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0006', 'Nguyen Xuan', 'Huy', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0819744671', 'xuanhuy013@gmailcom', 'GH', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0007', 'Le Thanh', 'Phuoc', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0832767107', 'thanhphuoc43@gmailcom', 'GH', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0008', 'Hoang Thien', 'Phuc', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0301749703', 'thienphuc087@gmailcom','GH', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0009', 'Nguyen Truong', 'Son', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0937617097', 'truongson812@gmailcom', 'GH', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0010', 'Do Quoc', 'Hung', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0942701737', 'quochung0827@gmailcom', 'GH', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0011', 'Tran Viet', 'Anh', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0747418911', 'vietanh8734@gmailcom', 'GH', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0012', 'Phan Tien', 'Tung', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0863966194', 'tientung09124@gmailcom', 'GH', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0013', 'Do Thanh', 'Vinh', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0936720983', 'thanhvinh12@gmailcom', 'GH', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0014', 'Pham Van', 'Phong', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0927219093', 'vanphong784@gmailcom', 'GH', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0015', 'Vo Ngoc', 'Hung', TO_DATE('2021-01-02', 'YYYY-MM-DD'), 3500000, '0938038941', 'nchung084@gmailcom', 'GH', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0016', 'Hoang Xuan', 'Anh', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0937827510', 'xuananh874@gmailcom', 'GH', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0017', 'Nguyen Tuan', 'Anh', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0967291712', 'tuananh43@gmailcom', 'GH', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0018', 'Tran Thai', 'Hoa', TO_DATE('2020-09-11', 'YYYY-MM-DD'), 3500000, '0937923451', 'thaihoa0983@gmailcom', 'GH', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0019', 'Hoang Gia', 'Bao', TO_DATE('2020-07-21', 'YYYY-MM-DD'), 3500000, '0942576529', 'giabao72@gmailcom', 'GH', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('GH0020', 'Nguyen Hoang Thai', 'An', TO_DATE('2021-09-02', 'YYYY-MM-DD'), 3500000, '0983781002', 'thaian925@gmailcom', 'GH', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0001', 'Dao Trong', 'Anh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0987021031', 'tronganh1209@gmailcom', 'KK', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0002', 'Nguyen Xuan', 'Quy', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0812667842', 'gacon1299@gmailcom', 'KK', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0003', 'Le Anh', 'Duc', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0396723346', 'anhduc718@gmailcom', 'KK', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0004', 'Do Quoc', 'Cuong', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0987413423', 'quoccuong74@gmailcom', 'KK', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0005', 'Tran Mai', 'Phuong', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0376386329', 'mphuong16@gmailcom', 'KK', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0006', 'Nguyen Van', 'Dung', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 4500000, '0984912915', 'dungnguyen720@gmailcom', 'KK', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0007', 'Dang Van', 'Hai', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0935517434', 'haidang21@gmailcom', 'KK', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0008', 'Duong Hai', 'Quan', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0987209308', 'quanduong4729@gmailcom', 'KK', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0009', 'Nguyen Dinh', 'Quy', TO_DATE('2021-05-07', 'YYYY-MM-DD'), 3500000, '0393104284', 'dinhquy02@gmailcom', 'KK', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0010', 'Dang Phuong', 'Nam', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0977728729', 'phuongnam23@gmailcom', 'KK', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0011', 'Hoang Truong', 'Giang', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4000000, '0396380559', 'truonggiang98@gmailcom', 'KK', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KK0012', 'Dang Ngoc', 'Chau', TO_DATE('2020-08-10', 'YYYY-MM-DD'), 4000000, '0355307703', 'chaudang0212@gmailcom', 'KK', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KT0001', 'Mai Phuong', 'Thanh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5500000, '0984972108', 'mpthanh2904@gmailcom', 'KT', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KT0002', 'Nguyen Lan', 'Anh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5500000, '0814567097', 'lanhlanh1102@gmailcom', 'KT', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KT0003', 'Nghiem Tuong', 'Vy', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5500000, '0937113023', 'tuongvi0909@gmailcom', 'KT', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KT0004', 'Vo Thi Nhu', 'Y', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5500000, '0364774842', 'nhuyvo11@gmailcom', 'KT', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KT0005', 'Mai Tien', 'Phi', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 5500000, '0966872474', 'phiphi1218@gmailcom', 'KT', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KT0006', 'Nguyen Thi Lan', 'Huong', TO_DATE('2021-01-30', 'YYYY-MM-DD'), 4500000, '0977819424', 'lanhuong119@gmailcom', 'KT', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KT0007', 'Hoang Thi Thien', 'Nga', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 5000000, '0964672912', 'thiennga09@gmailcom', 'KT', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('KT0008', 'Duong Thi Ngoc', 'Mai', TO_DATE('2020-12-22', 'YYYY-MM-DD'), 4500000, '0366472474', 'ncmai0610@gmailcom', 'KT', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0001', 'Pham Bich', 'Phuong', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5000000, '0397220110', 'bichphuong19@gmailcom', 'TV', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0002', 'Nguyen Hoang', 'Anh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5000000, '0972091837', 'hoanganh1221@gmailcom', 'TV', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0003', 'Tran Thi', 'Hue', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5000000, '0377037372', 'huetran23@gmailcom', 'TV', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0004', 'Hoang Thuy', 'Linh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5000000, '0936427491', 'thuylinh2308@gmailcom', 'TV', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0005', 'Nguyen Hoang Mai', 'Anh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5000000, '0371638273', 'nhmaianh30@gmailcom', 'TV', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0006', 'Tran Doan Kim', 'Anh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 5000000, '0936219664', 'kanh3234@gmailcom', 'TV', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0007', 'Le Dang Sy', 'Hung', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4500000, '0932847961', 'ldsyhung298@gmailcom', 'TV', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0008', 'Pham Bao', 'Chau', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4500000, '0936276491', 'baochau782@gmailcom', 'TV', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0009', 'Le Dang', 'Hung', TO_DATE('2020-06-28', 'YYYY-MM-DD'), 4500000, '0849737492', 'danghungle32@gmailcom', 'TV', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0010', 'Hoang Thi My', 'Duyen', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4500000, '0387174649', 'myduyen2821@gmailcom', 'TV', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0011', 'Nguyen Hai', 'Nam', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 4500000, '0923762819', 'hainam201@gmailcom', 'TV', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('TV0012', 'Le Thi My', 'Hanh', TO_DATE('2020-12-02', 'YYYY-MM-DD'), 4000000, '0387382521', 'myhanh0183@gmailcom', 'TV', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL01', 'Duong Hoang Dai', 'Duong', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 7500000, '0937465009', 'ocean08921@gmailcom', 'QL', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL02', 'Nguyen Phan Hoang', 'Anh', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 7500000, '0984629010', 'hoanganh0905@gmailcom', 'QL', 1);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL03', 'Nguyen Bao', 'Ngoc', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 7500000, '0972396194', 'nguyenbaonc1410@gmailcom', 'QL', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL04', 'Le Thi Quynh', 'Trang', TO_DATE('2018-11-18', 'YYYY-MM-DD'), 7500000, '0369183002', 'trangmun22@gmailcom', 'QL', 2);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL05', 'Nguyen Chien', 'Thang', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 7000000, '0943250931', 'chienthang948@gmailcom', 'QL', 3);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL06', 'Nguyen Khanh', 'Huyen', TO_DATE('2019-09-02', 'YYYY-MM-DD'), 7000000, '0932478719', 'khanhhuyen1105@gmailcom', 'QL', 4);


delete from khachhang;
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0001', 'Nguyen Quoc Khanh', 'Duong 385, phuong Tang Nhon Phu A, tp Thu Duc', '0838263820', 'quockhanh29@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0002', 'Tran Thanh Thuy', '17 Hoang Dieu 2, phuong Linh Chieu, tp Thu Duc', '0382957329', 'thanhthuy08@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0003', 'Phan Lan Anh', '56 Nguyen Chi Thanh, Chi Lang, Thanh pho Pleiku, Gia Lai', '0948927717', 'lananh23@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0004', 'Nguyen Khanh Linh', '123, thon 2a, xa Eakly, huyen Krong Pac, Tinh Dak Lak', '0932784661', 'khanhlinh103@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0005', 'Nguyen Tien Nam', ' 224 Duong so 48, Phuong 5, Quan 4, Thanh pho Ho Chi Minh', '0832748718', 'tiennam134@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0006', 'Doan Phan My Linh', '223 Nguyen Huy Tu, Nguyen Du, Ha Tinh', '0898397102', 'mylinh81@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0007', 'Pham Dinh Quan', 'Phan Chau Trinh, TT. Kham Duc, Phuoc Son, Quang Nam', '0994887281', 'dinhquan2927@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0008', 'Phan Van Quy', '212 Dien Bien Phu, Chinh Gian, Thanh Khe, Da Nang', '0993809317', 'quyphan827@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0009', 'Vo Ngoc Thuong', 'Tran Hung Dao, Phuong Nghia Trung, Gia Nghia, Dak Nong', '0782136786', 'vongocthuong36@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0010', 'Dinh Tien Dat', '64 Ly Thai To, Thong Nhat, Kon Tum', '0116237466', 'tiendat837@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0011', 'Luong Thuy Quynh', '40 Nha Chung, Hang Trong, Hoan Kiem, Ha Noi', '0992711336', 'thuyquynh12@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0012', 'Truong Quang Loi', '3 Truong Chinh, P. Bui Thi Xuan, Thanh pho Hai Duong, Hai Duong', '0484882492', 'truongquangloi13@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0013', 'Ngo Duc Hanh', '30 Huyen Quang, Dinh Ke, Bac Giang', '0487364764', 'ngoduchanh42@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0014', 'Cao Bui Thuy Tien', '241A Chu Van An, Phuong 12, Binh Thanh, Thanh pho Ho Chi Minh', '0972811101', 'caotien544@gmail.com');
insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH0015', 'Pham Quynh Huong', '170 Pho Ngoc Khanh, Giang Vo, Ba Dinh, Ha Noi', '0946660099', 'phamquynhhuong2005@gmail.com');


delete from dondathang;
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000001', to_date('2021-08-30', 'YYYY-MM-DD'), 'KH0001', 'TV0004', 2, 'CN03', 'Quoc Khanh', 'Duong 385, phuong Tang Nhon Phu A, tp Thu Duc', to_date('2021-09-01', 'YYYY-MM-DD'), '0838263820' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000002', to_date('2020-09-01', 'YYYY-MM-DD'), 'KH0002', 'TV0005', 2, 'CN03', 'Thanh Thuy', '17 Hoang Dieu 2, phuong Linh Chieu, tp Thu Duc', to_date('2020-09-02', 'YYYY-MM-DD'), '0382957329' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000003', to_date('2021-09-01', 'YYYY-MM-DD'), 'KH0003', 'TV0002', 1, 'CN01', 'Lan Anh', '56 Nguyen Chi Thanh, Chi Lang, Thanh pho Pleiku, Gia Lai', to_date('2021-09-03', 'YYYY-MM-DD'), '0948927717' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000004', to_date('2021-09-02', 'YYYY-MM-DD'), 'KH0004', 'TV0001', 1, 'CN02', 'Khanh Linh', '123, thon 2a, xa Eakly, huyen Krong Pac, Tinh Dak Lak', to_date('2021-09-03', 'YYYY-MM-DD'), '0932784661' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000005', to_date('2021-09-02', 'YYYY-MM-DD'), 'KH0005', 'TV0006', 2, 'CN03', 'Tien Nam', ' 224 Duong so 48, Phuong 5, Quan 4, Thanh pho Ho Chi Minh', to_date('2021-09-03', 'YYYY-MM-DD'), '0832748718' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000006', to_date('2021-09-03', 'YYYY-MM-DD'), 'KH0006', 'TV0008', 3, 'CN05', 'My Linh', '223 Nguyen Huy Tu, Nguyen Du, Ha Tinh', to_date('2021-09-06', 'YYYY-MM-DD'), '0898397102' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000007', to_date('2021-09-03', 'YYYY-MM-DD'), 'KH0007', 'TV0007', 3, 'CN05', 'Dinh Quan', 'Phan Chau Trinh, TT. Kham Duc, Phuoc Son, Quang Nam', to_date('2021-09-05', 'YYYY-MM-DD'), '0994887281' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000008', to_date('2020-09-05', 'YYYY-MM-DD'), 'KH0008', 'TV0009', 3, 'CN05', 'Phan Quy', '212 Dien Bien Phu, Chinh Gian, Thanh Khe, Da Nang', to_date('2020-09-06', 'YYYY-MM-DD'), '0993809317' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000009', to_date('2020-09-06', 'YYYY-MM-DD'), 'KH0009', 'TV0002', 1, 'CN01', 'Ngoc Thuong', 'Tran Hung Dao, Phuong Nghia Trung, Gia Nghia, Dak Nong', to_date('2020-09-08', 'YYYY-MM-DD'), '0782136786' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000010', to_date('2021-09-06', 'YYYY-MM-DD'), 'KH0010', 'TV0003', 1, 'CN01', 'Tien Dat', '64 Ly Thai To, Thong Nhat, Kon Tum', to_date('2021-09-08', 'YYYY-MM-DD'), '0116237466' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000011', to_date('2021-09-07', 'YYYY-MM-DD'), 'KH0011', 'TV0010', 4, 'CN06', 'Thuy Quynh', '40 Nha Chung, Hang Trong, Hoan Kiem, Ha Noi', to_date('2021-09-08', 'YYYY-MM-DD'), '0992711336' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000012', to_date('2021-09-07', 'YYYY-MM-DD'), 'KH0012', 'TV0011', 4, 'CN06', 'Truong Quang Loi', '3 Truong Chinh, P. Bui Thi Xuan, Thanh pho Hai Duong, Hai Duong', to_date('2021-09-09', 'YYYY-MM-DD'), '0484882492' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000013', to_date('2021-09-09', 'YYYY-MM-DD'), 'KH0013', 'TV0012', 4, 'CN06', 'Duc Hanh', '30 Huyen Quang, Dinh Ke, Bac Giang', to_date('2021-09-12', 'YYYY-MM-DD'), '0487364764' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000014', to_date('2020-09-10', 'YYYY-MM-DD'), 'KH0014', 'TV0006', 2, 'CN04', 'Cao Tien', '241A Chu Van An, Phuong 12, Binh Thanh, Thanh pho Ho Chi Minh', to_date('2020-09-11', 'YYYY-MM-DD'), '0972811101' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000015', to_date('2021-09-10', 'YYYY-MM-DD'), 'KH0015', 'TV0011', 4, 'CN06', 'Quynh Huong', '170 Pho Ngoc Khanh, Giang Vo, Ba Dinh, Ha Noi', to_date('2021-09-11', 'YYYY-MM-DD'), '0946660099' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000016', to_date('2021-09-14', 'YYYY-MM-DD'), 'KH0005', 'TV0004', 2, 'CN03', 'Tien Nam', ' 224 Duong so 48, Phuong 5, Quan 4, Thanh pho Ho Chi Minh', to_date('2021-09-15', 'YYYY-MM-DD'), '0832748718' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000017', to_date('2021-09-15', 'YYYY-MM-DD'), 'KH0001', 'TV0006', 2, 'CN04', 'Quoc Khanh', 'Duong 385, phuong Tang Nhon Phu A, tp Thu Duc', to_date('2021-09-17', 'YYYY-MM-DD'), '0838263820' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000018', to_date('2021-09-15', 'YYYY-MM-DD'), 'KH0009', 'TV0003', 1, 'CN01', 'Ngoc Thuong', 'Tran Hung Dao, Phuong Nghia Trung, Gia Nghia, Dak Nong', to_date('2021-09-17', 'YYYY-MM-DD'), '0782136786' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000019', to_date('2021-09-16', 'YYYY-MM-DD'), 'KH0007', 'TV0009', 3, 'CN05', 'Dinh Quan', 'Phan Chau Trinh, TT. Kham Duc, Phuoc Son, Quang Nam', to_date('2021-09-18', 'YYYY-MM-DD'), '0994887281' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000020', to_date('2021-09-16', 'YYYY-MM-DD'), 'KH0013', 'TV0011', 4, 'CN06', 'Duc Hanh', '30 Huyen Quang, Dinh Ke, Bac Giang', to_date('2021-09-19', 'YYYY-MM-DD'), '0487364764' , NULL);


delete from ctdonhang;
insert into ctdonhang (maddh, macf, sl) values ('DDH0000001', 'CF0003', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000001', 'CF0009', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000001', 'CF0022', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000002', 'CF0020', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000002', 'CF0035', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000003', 'CF0019', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000004', 'CF0023', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000004', 'CF0025', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000005', 'CF0002', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000005', 'CF0043', 3);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000006', 'CF0008', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000006', 'CF0017', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000007', 'CF0020', 3);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000008', 'CF0030', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000009', 'CF0046', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000010', 'CF0012', 4);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000011', 'CF0024', 3);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000011', 'CF0031', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000012', 'CF0017', 3);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000013', 'CF0006', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000013', 'CF0013', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000013', 'CF0018', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000014', 'CF0009', 4);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000015', 'CF0035', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000016', 'CF0021', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000016', 'CF0045', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000017', 'CF0032', 3);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000018', 'CF0021', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000018', 'CF0037', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000019', 'CF0026', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000019', 'CF0039', 1);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000020', 'CF0025', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000020', 'CF0034', 2);
insert into ctdonhang (maddh, macf, sl) values ('DDH0000020', 'CF0050', 1);


delete from tonkho;
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0001', 1109);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0002', 1109);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0003', 1000);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0004', 1928);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0005', 1009);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0006', 1009);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0007', 1392);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0008', 1022);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0009', 1229);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0010', 1209);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0011', 1656);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0012', 1213);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0013', 1109);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0014', 1809);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0015', 1409);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0016', 1109);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0017', 1122);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0018', 1409);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0019', 1289);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0020', 1109);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0021', 1319);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0022', 909);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0023', 839);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0024', 1109);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0025', 1129);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0026', 839);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0027', 129);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0028', 839);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0029', 2219);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0030', 939);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0031', 839);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0032', 1223);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0033', 723);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0034', 23);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0035', 8);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0036', 1323);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0037', 1661);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0038', 1223);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0039', 1223);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0040', 943);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0041', 813);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0042', 913);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0043', 1333);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0044', 943);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0045', 1233);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0046', 943);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0047', 642);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0048', 1293);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0049', 1313);
insert into tonkho (macn, macf, slton) values ('CN01', 'CF0050', 1243);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0001', 1109);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0002', 1109);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0003', 1000);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0004', 1928);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0005', 1009);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0006', 1009);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0007', 1392);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0008', 1022);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0009', 1229);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0010', 1209);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0011', 1656);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0012', 1213);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0013', 1109);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0014', 1809);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0015', 1409);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0016', 1109);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0017', 1122);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0018', 1409);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0019', 1289);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0020', 1109);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0021', 1319);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0022', 909);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0023', 839);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0024', 1109);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0025', 19);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0026', 839);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0027', 8129);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0028', 839);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0029', 2219);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0030', 939);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0031', 839);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0032', 1223);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0033', 723);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0034', 37);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0035', 5);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0036', 1323);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0037', 1661);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0038', 1223);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0039', 123);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0040', 943);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0041', 813);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0042', 913);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0043', 1333);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0044', 943);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0045', 1233);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0046', 943);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0047', 642);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0048', 1293);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0049', 1313);
insert into tonkho (macn, macf, slton) values ('CN02', 'CF0050', 1243);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0001', 1109);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0002', 1109);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0003', 1000);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0004', 90);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0005', 1009);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0006', 1009);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0007', 1392);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0008', 1022);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0009', 1229);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0010', 1209);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0011', 1656);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0012', 1213);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0013', 1109);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0014', 1809);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0015', 1409);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0016', 1109);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0017', 1122);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0018', 1409);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0019', 1289);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0020', 1109);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0021', 1319);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0022', 909);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0023', 839);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0024', 1109);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0025', 1129);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0026', 839);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0027', 8129);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0028', 839);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0029', 29);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0030', 99);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0031', 839);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0032', 1223);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0033', 723);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0034', 23);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0035', 2);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0036', 1323);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0037', 1661);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0038', 1223);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0039', 1223);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0040', 943);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0041', 813);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0042', 913);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0043', 1333);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0044', 943);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0045', 1233);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0046', 943);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0047', 642);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0048', 1293);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0049', 1313);
insert into tonkho (macn, macf, slton) values ('CN03', 'CF0050', 1243);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0001', 1109);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0002', 1109);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0003', 1000);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0004', 1928);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0005', 1009);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0006', 1009);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0007', 1392);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0008', 1022);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0009', 1229);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0010', 1209);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0011', 1656);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0012', 1213);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0013', 1109);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0014', 1809);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0015', 1409);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0016', 1109);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0017', 1122);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0018', 1409);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0019', 1289);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0020', 1109);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0021', 1319);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0022', 909);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0023', 839);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0024', 1109);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0025', 1129);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0026', 839);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0027', 8129);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0028', 839);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0029', 2219);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0030', 939);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0031', 839);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0032', 1223);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0033', 723);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0034', 23);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0035', 4);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0036', 1323);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0037', 161);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0038', 1223);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0039', 1223);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0040', 943);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0041', 813);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0042', 93);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0043', 1333);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0044', 943);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0045', 1233);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0046', 943);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0047', 642);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0048', 1293);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0049', 1313);
insert into tonkho (macn, macf, slton) values ('CN04', 'CF0050', 1243);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0001', 1109);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0002', 1109);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0003', 130);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0004', 1928);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0005', 1009);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0006', 1009);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0007', 1392);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0008', 1022);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0009', 1229);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0010', 1209);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0011', 1656);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0012', 1213);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0013', 1109);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0014', 1809);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0015', 1409);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0016', 1109);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0017', 1122);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0018', 1409);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0019', 1289);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0020', 1109);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0021', 1319);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0022', 909);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0023', 839);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0024', 1109);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0025', 1129);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0026', 839);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0027', 8129);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0028', 839);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0029', 19);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0030', 939);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0031', 839);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0032', 1223);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0033', 723);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0034', 12);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0035', 4);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0036', 1323);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0037', 1661);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0038', 1223);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0039', 23);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0040', 943);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0041', 813);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0042', 913);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0043', 1333);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0044', 943);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0045', 1233);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0046', 33);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0047', 642);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0048', 1293);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0049', 1313);
insert into tonkho (macn, macf, slton) values ('CN05', 'CF0050', 1243);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0001', 1109);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0002', 1109);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0003', 30);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0004', 1928);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0005', 1009);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0006', 1009);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0007', 12);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0008', 1022);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0009', 1229);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0010', 1209);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0011', 1656);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0012', 1213);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0013', 1109);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0014', 1809);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0015', 1409);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0016', 1109);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0017', 1122);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0018', 1409);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0019', 1289);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0020', 1109);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0021', 1319);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0022', 909);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0023', 839);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0024', 1109);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0025', 1129);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0026', 839);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0027', 8129);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0028', 839);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0029', 2219);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0030', 239);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0031', 839);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0032', 1223);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0033', 723);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0034', 23);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0035', 2);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0036', 1323);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0037', 1661);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0038', 1223);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0039', 1223);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0040', 943);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0041', 813);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0042', 913);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0043', 1333);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0044', 943);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0045', 1233);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0046', 943);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0047', 642);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0048', 1293);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0049', 1313);
insert into tonkho (macn, macf, slton) values ('CN06', 'CF0050', 1243);


COMMENT ON TABLE KHUVUC IS 'Bang cho biet su phan chia cac khu vuc hoat dong cua cua hang tren ca nuoc, cu the la Do Mem hoat dong tren 4 khu vuc,
quan ly khu vuc gom hai thuoc tinh: makv(ma khu vuc) va tenkv(ten khu vuc) ';
COMMENT ON COLUMN khuvuc.makv
IS'Primary Key (Khoa chinh) c?a bang khu vuc';
COMMENT ON COLUMN khuvuc.tenkv
IS'ten cac khu vuc dang hoat dong cua cua hang, ung voi tung ma khu vuc de co the de phan biet va quan ly';


COMMENT ON TABLE CHINHANH IS 'o moi khu vuc se co nhieu chi nhanh khac nhau,
cac chi nhanh duoc quan ly dua tren hai thuoc tinh gom macn(ma chi nhanh) va tencn (ten chi nhanh),
diachi(dia chi), hotline(so dien thoai lien he ho tro) va makv(ma khu vuc) ma chi nhanh dang hoat dong.
Tai cua hang Do Mem dang quan ly hien tai co 6 chi nhanh dang hoat dong';
COMMENT ON COLUMN chinhanh.macn
IS 'Primary Key (Khoa chinh) c?a bang chi nhanh';
COMMENT ON COLUMN chinhanh.tencn
IS'Ten cua 6 chi nhanh tuong ung voi cac dia diem ma chi nhanh dang hoat dong';
COMMENT ON COLUMN chinhanh.diachi
IS'Dia chi cua cac chi nhanh gom co so nha, ten duong, khu pho, quan(huyen), ten thanh pho mà chi nhanh hoat dong';
COMMENT ON COLUMN chinhanh.hotline
IS'so dien thoai lien he ho tro ? chi nhanh gan nhat de khach hang goi va giai dap thac mac';
COMMENT ON COLUMN chinhanh.makv
IS'Cac chi nhanh thuoc khu vuc quan ly khac nhau. makv(ma khu vuc) là Foreign Key (khoa ngoai) cho cot makv cua bang khu vuc';


COMMENT ON TABLE LOAICAFE IS 'Loai ca phe ma Do Mem kinh doanh gom 4 loai ca phe chinh
và mot so loai khac ch?a xac dinh se duoc xep vao loai Khac. 
Gom 2 thuoc tinh là maloaicf(ma loai ca phe) va tenloaicf(ten loai ca phe)';
COMMENT ON COLUMN loaicafe.maloaicf
IS 'Primary Key (Khoa chinh) c?a bang loaicafe';
COMMENT ON COLUMN loaicafe.tenloaicf
IS 'Ten cua loai ca phe duoc xac dinh dua vao hinh thai va cach thuc san xuat cua mat hang';


COMMENT ON TABLE THUONGHIEU IS 'Cac mat hang ca phe thuoc cac thuong hieu khac nhau.
Tai Do Mem dang kinh doanh 4 thuong hieu chinh, ngoai ra cung có mot o mat hang khac.
Cac thuoc tinh trong bang thuong hieun gom math(ma thuong hieu) và tenth(ten thuong hieu)';
COMMENT ON COLUMN thuonghieu.math
IS 'Primary Key (Khoa chinh) c?a bang thuonghieu';
COMMENT ON COLUMN thuonghieu.tenth
IS'Ten mot so thuong hieu noi tieng ma cua hang dang kinh doanh';

COMMENT ON TABLE DSCAFE IS 'cho biet thong tin cac san pham ca phe hien dang kinh doanh cua cua hang Do Mem.
Bang gom 50 dong du lieu voi mot so thuoc tinh nhu: macf(ma ca phe), tencf(ten ca phe), ngaysx(ngay san xuat mat hang do), 
hsd(han su dung cua mat hang), khoiluong(khoi luong cua san pham la bao nhieu), dvt(don vi tinh), giaban(gia ban cua mat hang),
mota(mo ta), maloaicf(loai ca phe), math(thuong hieu) ';
COMMENT ON COLUMN dscafe.macf
IS 'Primary Key (Khoa chinh) c?a bang dscafe';
COMMENT ON COLUMN dscafe.tencf
IS 'Ten cac mat hang de phan biet cac mat hang voi nhau, trong ten co the co khoi luong hoac thuong hieu tuy vao cac san pham';
COMMENT ON COLUMN dscafe.ngaysx
IS 'cho biet ngay san xuat cua mat hang de quan ly han dung cua mat hang';
COMMENT ON COLUMN dscafe.hsd
IS 'so thang hoac so nam du dung duoc san pham, dua vao ngay san xuat de co the tinh duoc han su dung cua san pham ';
COMMENT ON COLUMN dscafe.khoiluong
IS 'cho biet khoi luong cua mat hang de phu hop voi gia ban và yeu cau su dung cua khach hang';
COMMENT ON COLUMN dscafe.dvt
IS 'Cho biet don vi tinh cua mat hang gom mot so don vi tinh nh?: hop, goi,...';
COMMENT ON COLUMN dscafe.giaban
IS 'Moi mat hang ca phe co mot gia ban khac nhau tuy vao thuong hieu và khoi luong mà gia bvan de tinh thanh tien khi khach hang chon mua';
COMMENT ON COLUMN dscafe.mota
IS'Chi tiet thong tin cua cac san pham ca phe nhu: huong vi, xuat xu, nguyen lieu va dac trung rien cua mat hang do';
COMMENT ON COLUMN dscafe.maloaicf
IS 'Moi san phan se thuoc mot loai ca phe khac nhau và maloaicf la Foreign Key (khoa ngoai) cho cot maloaicf trong bang loaicafe';
COMMENT ON COLUMN dscafe.maloaicf
IS 'Moi san pham cung duoc mot thuong hieu san xuat và math  la Foreign Key (khoa ngoai) cho cot math trong bang thuonghieu ';


COMMENT ON TABLE HOAHONG IS 'hoa hong la muc tien thuong cho nhan vien lam viec tai Do Mem voi 5 muc thuong.
Va trong bang gom 2 thuoc tinh: mahh (ma hoa hong), hoahong(muc hoa hoc duoc huong)';
COMMENT ON COLUMN  hoahong.mahh
IS 'Primary Key (Khoa chinh) c?a bang hoahong';
COMMENT ON COLUMN  hoahong.hoahong
IS 'Cac muc tien ma nhan vien duoc huong va ung vói cac ma hoa hong ma cua hang dat ra';


COMMENT ON TABLE CONG VIEC IS 'Cong viec la cac bo phan lam viec tuy vao cap do quan ly hoac nhan vien tai cua hang.
Tai day có 6 bo phan lam viec khac nhau. Trong bnag gom 2 thuoc tinh: macv(ma cua tung cong viec), tencv(ten cua cong viec)';
COMMENT ON COLUMN  congviec.macv
IS 'Primary Key (Khoa chinh) c?a bang congviec';
COMMENT ON COLUMN  congviec.tencv
IS 'Ten cua tung bo phan lam viec trong cua hàng phu hop voi cac c=nghiep vu cu the';


COMMENT ON TABLE NHANVIEN IS 'The hien cac thong tin co ban ve nhan vien tai cua hang.
Trong bang có 50 dong du lieu thong tin lien quan và gom 9 thuoc tinh: manv(Ma nhan vien), 
honv(co và ten lot nhan vien), tennv(ten nhan vien), ngayvaolam(ngay bat dau lam viec), luong, sdt(so dien thoai lien lac), email, macv(ma cong viec), makv(ma khu vuc)';
COMMENT ON COLUMN nhanvien.manv
IS 'Primary Key (Khoa chinh) c?a bang nhanvien, moi nhan vien co mot ma nhan vien khac nhau';
COMMENT ON COLUMN nhanvien.honv
IS 'Thuoc tinh gom ho va ten lot cua nhanh vien';
COMMENT ON COLUMN nhanvien.tennv
IS 'Ten cua nhan vien lam viec tai cua hang';
COMMENT ON COLUMN nhanvien.ngayvaolam
IS 'Ngay nhan vien bat dau lam viec tai cua hang';
COMMENT ON COLUMN nhanvien.luong
IS 'So tien tra hang thang cho nhan vien tuy vao thoi gian lam viec va cong viec nhan vien dang lam';
COMMENT ON COLUMN nhanvien.sdt
IS 'So dien thoai lien lac ca nhan cua tung nhan vien';
COMMENT ON COLUMN nhanvien.email
IS 'Dia chi email ca nhan cua nhan vien';
COMMENT ON COLUMN nhanvien.macv
IS 'Moi nhan vien se lam viec o cac bo phan khac nhau. macv la Foreign Key (khoa ngoai) cho cot macv trong bang congviec';
COMMENT ON COLUMN nhanvien.makv
IS 'cac nhan vien duoc phan bo o cac khu vuc khac nhau de thuan tien trong cong viec va phuc vu khach hang. makv (ma khu vuc) là Foreign Key (khoa ngoai) cho cot makv cua bang khu vuc';


COMMENT ON TABLE KHACHHANG IS 'Hien thi thong tin cua khach hang giao dich tai Do Mem, 
trong bang gòm co 15 khach hang và co 5 thuoc tinh: makh(ma khach hang),
tenkh(ten khach hang), diachi(diachi), sdt(so dien thoai), email';
COMMENT ON COLUMN khachhang.manv
IS 'Primary Key (Khoa chinh) c?a bang khachhang, moi khach hang co mot ma khach hang khac nhau';
COMMENT ON COLUMN khachhang.tenkh
IS 'Ten khach hang gom co ho day du ho ten cua khach hang dat don';
COMMENT ON COLUMN khachhang.diachi
IS 'dia chi khach hang dang ky thong tin gom so nha, duong, quan(huyen), thanh pho phuc vu cho viec quan ly';
COMMENT ON COLUMN khachhang.sdt
IS 'So dien thoai ca nhan de lien he khi can tu van hoac giao hang';
COMMENT ON COLUMN khachhang.email
IS 'dia chi email se duoc gui thong bao khi thong lien he duoc bnag dien thoai';


COMMENT ON TABLE DONDATHANG IS 'thong tin cac don dat hang ma khach hang dat mua,
hien tai bang có 20 don dat hang va co 11 thuoc tinh: maddh, ngaylap, makh, manv,
makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu';
COMMENT ON COLUMN dondathang.maddh
IS 'Primary Key (Khoa chinh) c?a bang dondathang';
COMMENT ON COLUMN dondathang.ngaylap
IS 'thoi gian ma khach hang mua san pham thi don hang se tu dong lap vao thoi diem dó';
COMMENT ON COLUMN dondathang.makh
IS 'don duoc lap ma khach hang cung se duoc luu l?i. makh là Foreign Key (khoa ngoai) cho cot makh trong bang khachhang';
COMMENT ON COLUMN dondathang.manv
IS 'don hang se co mot nhan vien len d?n va truc tiep tu van, manv là Foreign Key (khoa ngoai) cho cot manv trong bang nhanvien ';
COMMENT ON COLUMN dondathang.makv
IS 'xac nhan khu vuc cua don dat hang phu thuoc vao dia chi cua nguoi nhan de thuan tien trong viec phan cong
cu the cho chi nhanh gan nhat. makv là Foreign Key (khoa ngoai) cho cot makv trong bang khuvuc';
COMMENT ON COLUMN dondathang.macn
IS 'phu thuoc vao dia chi cua nguoi nhan de thuan tien trong viec cac dinh chi nhanh de phan cong nhan vien len,
don dong hnag va giao hnag gan nhat. macn là Foreign Key (khoa ngoai) cho cot makv trong bang chinhanh';
COMMENT ON COLUMN dondathang.ten_nguoinhan
IS 'Ten nguoi nhan hang cuoi cung khi bo phan giao hang den';
COMMENT ON COLUMN dondathang.diachi_giao
IS 'khach hang co the dat hang de lam qua hay gui den dia chi cua nguoi nhan don, gom: so nha, ten duong, quan(huyen), thanh pho';
COMMENT ON COLUMN dondathang.thoihan_giao
IS 'thoi han du tinh cuoi cung de co the giao don hang do co the giao dung ngay hoac som hon du tinh';
COMMENT ON COLUMN dondathang.sdt_nguoinhan
IS 'so dien thoai lien lac de nhan vien giao hang goi cho khach khi tien hanh chuyen don';
COMMENT ON COLUMN dondathang.thanhtien
IS 'thanh tien cua don dat hang';
COMMENT ON COLUMN dondathang.ghichu
IS 'phan nay de khach hang khi dat hnag online se ghi yeu cau hoac luu y de nhan vien tiep nhan va xu ly,
hoac neu nhu co van de trong qua trinh giao hang thi se duoc nhan vien ghi chu lai';


COMMENT ON TABLE CTDONHANG IS 'The hien chi tiet cua tung don dat hang de thong ke so luong ca phe duoc dat.
trong bang hien có 34 dong du lieu va co 3 thuoc tinh: madddh(Ma don dat hang), macf(ma san pham ca phe), sl(so luong dat hang)';
COMMENT ON COLUMN ctdonhang.maddh
IS 'Primary Key (Khoa chinh) c?a bang ctdonhang va cung la Foreign Key (khoa ngoai) cho cot maddh trong bang dondathang';
COMMENT ON COLUMN ctdonhang.macf
IS 'Primary Key (Khoa chinh) c?a bang ctdonhang va cung la Foreign Key (khoa ngoai) cho cot macf trong bang dscafe';
COMMENT ON COLUMN ctdonhang.sl
IS 'so luong cua moi san pham ca phe duoc khach hang dat trong don dat hang va so luong dat phai lon hon 0';


COMMENT ON TABLE TONKHO IS 'Thong ke so luong moi san pham con lai trong kho o cac chi nhanh tu do de dang quan ly xuat nhap kho.
Trong bang co 300 dong du lieu va 3 thuoc tinh: macn(ma chi nhanh), macf(ma ca phe), slton(so luong ton)';
COMMENT ON COLUMN tonkho.macn
IS 'Primary Key (Khoa chinh) c?a bang tonkho va cung la Foreign Key (khoa ngoai) cho cot macn trong bang chinhanh';
COMMENT ON COLUMN tonkho.macf
IS 'Primary Key (Khoa chinh) c?a bang tonkho va cung la Foreign Key (khoa ngoai) cho cot macf trong bang dscafe';
COMMENT ON COLUMN tonkho.slton
IS 'Cap nhat so luong san pham con lai trong kho cua cac chi nhanh tuong ung va so luong ton phai tu 0 tro len';





------------------------------MOT SO TRUY VAN UPDATE--------------------------------------------
-- Cau 1: gi?m 5% cho t?t c? các m?t hàng cà phê có trong c?a hàng cà phê ?? M?m
update dscafe
set giaban = giaban - (giaban*5/100);

 --Câu 2: T?ng thêm 5000 cho các s?n ph?m cà phê thu?c th??ng hi?u Nón lá Coffee t?i c?a hàng
update dscafe
set giaban = giaban + 5000
where math = 'NL';
 
 /*select * from nhanvien;
 SELECT * FROM dscafe;*/
 
 --Câu 3: C?p nh?t s? ?i?n tho?i c?a nhân viên có mã DH0005 t?i c?a hàng ?? M?m thành 0975301025
update nhanvien
set sdt = '0975301025'
where manv = 'DH0005';
 
 --Câu 4: Chuy?n nhân viên có giao hàng có mã nhân viên là GH0007 chuy?n sang b? ph?n khác làm vi?c (Công vi?c khác) trong c?a hàng ?õ M?m
update nhanvien
set manv = '&newmanv', macv = '&newmacv'
where manv = 'GH0007';
 
 --Câu 5: C?p nh?t ngày s?n xu?t thành 10/11/2021 và giá c?a s?n ph?m cà phê ???c bán t?i c?a hàng ?? M?m t?ng lên 5% v?i mã s?n ph?m ng??i dùng nh?p vào
update dscafe
set ngaysx = TO_DATE('2021/11/10', 'YYYY/MM/DD'),
    giaban = giaban + (giaban*5/100)
where macf = '&cp_id';
 
 --Câu 6: C?p nh?t s? l??ng t?n c?a các m?t hàng trong b?ng t?n kho khi s?n ph?m ?ã ???c bán ?i
update tonkho
set slton = slton - &daban
where macf = '&ma_cafe' and macn = '&macn';
 
 --select * from tonkho;
 --Câu 7: S?a giá ti?n c?a s?n ph?m cà phê có mã CF0003 b?ng v?i giá cà phê c?a m?t hàng có mã CF0002
update dscafe
set giaban = (Select giaban from dscafe where macf = 'CF0002')
where macf = 'CF0003';
 
 --Câu 8: Nh?p thêm 50 s?n ph?m cà phê cho cho các m?t hàng có s? l??ng t?n d??i 20 s?n ph?m t?i c?a hàng ?? M?m
update tonkho
set slton = slton + 50
where slton <= 20;
 
 /*SELECT * FROM tonkho where slton <= 50;*/
 
 --Câu 9: C?p nh?t gi?m giá 10% cho các m?t hàng ch?a có ??n ??t hàng nào
update dscafe
set giaban = giaban - (giaban*10/100)
where NOT EXISTS (select macf from ctdonhang where macf = dscafe.macf);
 
 --Câu 10: T?ng giá bán lên 5% cho nh?ng s?n ph?m cà phê có s? l??ng mua nhi?u nh?t
UPDATE dscafe
set giaban = giaban + (giaban*5/100)
where macf IN (SELECT macf from ctdonhang JOIN dondathang on dondathang.maddh = ctdonhang.maddh
                GROUP BY macf HAVING SUM(sl) >= ALL (Select SUM(sl) from dondathang join ctdonhang on dondathang.maddh = ctdonhang.maddh GROUP BY macf));
 
select * from dscafe;
 
 Select * from ctdonhang;
 
 
 ----------------------------------------------MOT SO TRUY VAN DELETE--------------------------------------------------------
 --Câu 1: Xóa kh?i b?ng nhân viên nh?ng nhân viên ?ã ngh? vi?c t?i c?a hàng cafe ?? M?m có mã nhân viên ???c ng??i dùng nh?p  
 DELETE from nhanvien
 WHERE manv = '&manv';
 
 --Câu 2: Cho phép ng??i dùng nh?p vào macf ?? xóa m?t hàng ?ã ng?ng s?n xu?t trong kho c?a c?a hàng cà phê ?? M?m.
 DELETE from tonkho
 WHERE macf = '&macf';
 
 ---Câu 3: Xóa nhân viên có tên "Phan Trong Hieu" trong c?a hàng cà phê ?? M?m.
 DELETE from nhanvien
 WHERE honv = 'Phan Trong' and tennv = 'Hieu';
 
 --Câu 4: Xóa các m?t hàng cafe trong kho có s? l??ng t?n kho trên 1500
 DELETE from tonkho
 where slton > 1500;
 
--Câu 5: Xóa t?t c? các m?t hàng trong CTDONHANG thu?c DONDATHANG  ???c l?p b?i nhân viên có mã là TV0004 trong c?a hàng cà phê ?? M?m. 
 DELETE from ctdonhang
 where maddh IN (SELECT maddh from dondathang where manv = 'TV0004') ;
 
 --Câu 6: Xóa kh?i b?ng loaicafe nh?ng lo?i hàng mà không có m?t hàng hi?n ???c bán t?i c?a hàng cà phê ?? M?m.
 DELETE from loaicafe
 where NOT EXISTS (Select macf from dscafe where maloaicf = loaicafe.maloaicf);
 
 --Câu 7: Khách hàng yêu c?u nhân viên c?a hàng ?? M?m xóa m?t m?t hàng b?t kì trong hóa ??n (CTDONHANG) 
 DELETE from ctdonhang
 where maddh = '&maddh' and macf = '&macf';
 
 --Câu 8: Xóa các m?t hàng trong kho thu?c các chi nhánh c?a c?a hàng cà phê ?? M?m có l??ng t?n kho <= 10, v?i mã chi nhánh do ng??i dùng nh?p   
 DELETE from tonkho
 where slton <= 10 and macn = '&macn';
 
 --Câu 9: Xóa các m?t hàng trong b?ng chi ti?t bán hàng thu?c ??n ??t hàng ???c l?p tr??c n?m 2021 c?a c?a hàng cà phê ?? M?m.
 DELETE from ctdonhang
 where maddh IN (SELECT maddh from dondathang where dondathang.ngaylap = TO_DATE('2021/01/01', 'YYYY/MM/DD'));
 
--Câu 10: Xóa các nhân viên ?óng hàng thu?c khu v?c 1 c?a c?a hàng cà phê ?? M?m.
DELETE from nhanvien
where macv = 'DH' and makv = 1;







--== ***** INDEX ***** ==--
--1--tao index tren bang ton kho
create index indx_tonkho
on tonkho (macf, macn);


--2--tao index tren bang chi tiet don hang
create index indx_ctddh
on ctdonhang (macf, maddh);


--3--tao index tren bang nhan vien
create index indx_nv
on nhanvien(macv, makv);


--== ***** SELECT ***** ==--

--1--truy van thong tin cua nhan vien trong cua hang sap xep theo khu vuc
select kv.makv, manv, honv || ' ' || tennv as "Ho Ten", tencv, ngayvaolam, luong sdt, email
from nhanvien nv join congviec cv on nv.macv = cv.macv
                join khuvuc kv on nv.makv = kv.makv
order by kv.makv;


--2--truy van thong tin khach hang
select makh, tenkh, sdt, email, diachi 
from khachhang;


--3--truy van thong tin cac mat hang
select macf, tencf, giaban, khoiluong|| 'gram/' ||dvt as "Khoi_luong", ngaysx, hsd, mota
from dscafe;


--4--truy van thong tin cac don dat hang cua khach hang sap xep theo ma don dat hang va ma khach hang
select maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu
from dondathang
order by maddh, makh;


--5--truy van thong tin ton kho cua moi chi nhanh voi ma chi nhanh duoc nguoi dung nhap vao
select tk.macf, tencf, slton
from tonkho tk join dscafe ds on tk.macf = ds.macf
where macn = '&macn';


--6--truy van cac cong viec duoc cac nhan vien thuc hien tai cua hang
select macv, tencv
from congviec;


--7--truy van cac chi nhanh cua cua hang
Select macn, tencn, hotline, diachi, tenkv
from chinhanh cn join khuvuc kv on cn.makv = kv.makv;


--8--truy van thong tin cac loai cafe co tai cua hang
select maloaicf, tenloaicf
from loaicafe;


--9--truy van thong tin cac thuong hieu cafe ma cua hang co
select math, tenth
from thuonghieu;


--10--truy van thong tin ton kho
select macn, macf, slton
from tonkho;


--11--truy van thong tin chi tiet don dat hang
select maddh, macf, sl
from ctdonhang;


--12--truy van liet ke ten va gia ban cua mat hang co gia ban tu 100000 den 1000000 sap xep theo gia ban tang dan
Select tencf, giaban
from dscafe
where  giaban >= 100000 and giaban <= 1000000
order by giaban;


--13--truy van danh sach ma cafe, ten ca phe, co trong it hon 5 dan hang
Select macf, tencf, count(macf) as So_don_hang_dat
from dscafe
where macf in (select macf from ctdonhang)
group by macf, tencf
having count(macf) < 5 ;


--14--truy van cho biet macf, tencf, tenth, giaban cua nhung mat hang thuoc thuong hieu "Trung Nguyen" và "Lion Cafe" co muc giá duoi 100000
Select dscafe.macf, dscafe.tencf, thuonghieu.tenth, dscafe.giaban
from dscafe join thuonghieu on dscafe.math = thuonghieu.math
where thuonghieu.tenth in ('Trung Nguyen', 'Lion Cafe') 
        AND dscafe.giaban < 100000;


--15--truy van cho biet macf, tencf, giaban, gia_khuyen_mai = giaban - giaban*15/100
Select macf, tencf, giaban, round(giaban - (Giaban*15/100)) as gia_sau_giam
from dscafe;


--16--truy van cho biet so luong mat hang cua cac loai cafe co tai cua hang
Select dscafe.maloaicf, loaicafe.tenloaicf, count(*) as so_luong
from loaicafe inner join dscafe on loaicafe.maloaicf = dscafe.maloaicf
group by dscafe.maloaicf, loaicafe.tenloaicf
order by dscafe.maloaicf;


--17--truy van cho biet tong so don dat hang trong nam hien hanh
Select to_char(sysdate,'yyyy') as Nam, count(*)
from dondathang
where to_char(ngaylap,'yyyy') = to_char(sysdate,'yyyy');


--18--truy van cac nhan vien tu van cua cua hang
select manv, honv || ' ' || tennv as "Ho Ten", ngayvaolam, luong, sdt
from nhanvien 
where macv = 'TV';


--19--truy van so luong nhan vien cua tung cong viec
select cv.macv, tencv, count(cv.macv) as so_luong_nv
from nhanvien nv join congviec cv on nv.macv = cv.macv
group by cv.macv, tencv;


--20--truy van thong tin cac don dat hang cua nhan vien phu trach do nguoi dung nhap vao
select maddh, ngaylap, makh, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu
from dondathang dh
where manv = '&ma_nhan_vien';


--21--truy van thong tin cac hat cafe duoc san xuat sau thang 9/2021
select macf, tencf, giaban, khoiluong|| 'gram/' ||dvt as "Khoi_luong", ngaysx, hsd, mota
from dscafe
where extract(month from(ngaysx)) >= 9 and extract(year from(ngaysx)) >= 2021;


--22--truy van thong tin nhan vien bat dau lam viec tu nam 2020
select manv, honv || ' ' || tennv as "Ho Ten", ngayvaolam, luong, sdt, email, macv, makv
from nhanvien
where extract(year from ngayvaolam) >= 2020;


--23--truy van thong tin nhan vien co thoi gian vao lam tren 3 nam
select manv, honv || ' ' || tennv as "Ho Ten", round((sysdate - ngayvaolam)/365) as So_nam_lam_viec, luong, sdt, email, macv, makv
from nhanvien
where round((sysdate - ngayvaolam)/365) >= 3;


--24--truy van thong tin nhan vien co luong it hon 4000000
select manv, honv || ' ' || tennv as "Ho Ten", ngayvaolam, luong, sdt, email, macv, makv
from nhanvien nv join hoahong hh on nv.mahh = hh.mahh
where luong + hoahong < 4000000;


--25--





--== ***** SEQUENCE ***** ==--

--1--sequence danh so tu dong cho maddh
drop sequence sq_maddh;
create sequence sq_maddh
increment by 1
minvalue 0
maxvalue 999999
cycle
nocache;


--2--sequence danh so tu dong cho makh
drop sequence sq_makh;
create sequence sq_makh
increment by 1
minvalue 16
maxvalue 9999
nocycle
nocache;


--3--sequence danh so tu dong cho macf
drop sequence sq_macf;
create sequence sq_macf
increment by 1
minvalue 51
maxvalue 9999
nocycle
nocache;




--== ***** VIEW ***** ==--

--1--view xem bang gia cac hat cafe duoc ban tai cua hang
drop view v_banggia;
create view v_banggia
as
    select macf, tencf, tenloaicf, tenth, giaban
    from dscafe cf join thuonghieu th on cf.math = th.math
                    join loaicafe l on cf.maloaicf = l.maloaicf;

select * from v_banggia;


--2--view xem thong tin nhan vien
drop view v_thongtin_nhanvien;
create view v_thongtin_nhanvien
as
    select manv, honv, tennv, ngayvaolam, luong, sdt, tencv
    from nhanvien nv join congviec cv on nv.macv = cv.macv;
                    
select * from v_thongtin_nhanvien;


--3--view xem so nhan vien cua moi cong viecj tai cua hang
drop view v_sonv_1congviec;
create view v_sonv_1congviec
as
    select nv.macv, tencv, count(manv) as so_luong
    from nhanvien nv join congviec cv on nv.macv = cv.macv
    group by nv.macv, tencv;
    
select * from v_sonv_1congviec;


--4--view xem cac don hang duoc lap tai nam hien hanh (sap xep theo maddh tang dan)
drop view v_thongtin_dondathang_tainamhienhanh;
create view v_thongtin_dondathang_tainamhienhanh
as
    select maddh, ngaylap, tenkh, tennv, tenkv, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, tinhtrang, ghichu
    from dondathang dh join khachhang kh on dh.makh = kh.makh
                        join nhanvien nv on dh.manv = nv.manv
                        join khuvuc kv on dh.makv = kv.makv
    where extract(year from (ngaylap)) = extract(year from (sysdate))
    order by maddh;
    
select * from v_thongtin_dondathang_tainamhienhanh;


--5--view xem thanh tien cua cac don hang có trong chi tiet don hang
drop view v_thanhtien_ctdonhang;
create view v_thanhtien_ctdonhang
as
    select maddh, sum(sl*giaban) as Thanh_tien
    from ctdonhang ct join dscafe ds on ct.macf = ds.macf
    group by maddh
    order by maddh;

select * from v_thanhtien_ctdonhang;


--6--view xem danh sach cafe con ton kho tai cac chi nhanh
drop view v_thongtin_tonkho;
create view v_thongtin_tonkho
as
    select tk.macn, tencn, tencf, slton, dvt
    from tonkho tk join dscafe ds on tk.macf = ds.macf
                    join chinhanh cn on tk.macn = cn.macn
    order by macn;

select * from v_thongtin_tonkho;


--7--view xem danh sach nhan vien tu van chua phu trach don hang nao
drop view v_ds_nv_phutrach0donhang;
create view v_ds_nv_phutrach0donhang
as
    select manv, honv, tennv, ngayvaolam, luong, sdt, email, mahh, macv, makv
    from nhanvien
    where manv not in (select distinct manv from dondathang) and macv = 'TV';

select * from v_ds_nv_phutrach0donhang;



--== ***** function ***** ==--



--1--tao ham cho biet ten san pham ca phe, voi ma ca phe la tham so truyen vao
drop function f_name_caphe;
create FUNCTION f_name_caphe (p_macf dscafe.macf%TYPE)
return VARCHAR2 is
    var_tencf VARCHAR2(100);
Begin
    SELECT dscafe.tencf into var_tencf
    from dscafe
    where dscafe.macf = p_macf;
    return (var_tencf);
   EXCEPTION
    WHEN no_data_found then return ('Khong tim thay du lieu!');
    WHEN others then return ('Ham co loi!');
End;
--drop FUNCTION name_thuonghieu;

--THUC THI:
set serveroutput on
set verify off
declare cafe varchar2(100);
BEGIN
    cafe := f_name_caphe ('&macf');
    dbms_output.put_line('Ten san pham ca phe la: '|| cafe);
end;


--2--tao ham co tham so truyen vao la maloaicf, tra ve trung binh gia ban cua tat ca cac san pham thuoc loai ca phe do
drop function f_avg_giaban_loaicf;
create FUNCTION f_avg_giaban_loaicf (p_maloai dscafe.maloaicf%TYPE)
return dscafe.giaban%TYPE is
    var_avg_gia dscafe.giaban%TYPE;
Begin
    Select avg(giaban) into var_avg_gia
    from dscafe 
    where dscafe.maloaicf = p_maloai;
    return (var_avg_gia);
    EXCEPTION
    WHEN no_data_found then return ('Khong tim thay du lieu!');
    WHEN others then return ('Ham co loi!');
End;

--THUC THI
set serveroutput on;
set verify off
declare GiabanTB dscafe.giaban%TYPE;
Begin
    GiabanTB := f_avg_giaban_loaicf('&maloai');
    dbms_output.put_line('Gia ban trung binh cua loai ca phe nay la: '|| GiabanTB);
End;

--3--tao ham co tham so truyen cao la macf, tra ve so thang ma mat hang da san xuat cho den thoi diem hien tai
drop function f_time_sanxuat;
Create FUNCTION f_time_sanxuat(p_macf dscafe.macf%TYPE)
return number is
    var_tgiansx number;
Begin
    Select round(months_between(sysdate, ngaysx)) into var_tgiansx
    from dscafe
    where macf = p_macf;
    return var_tgiansx;
    EXCEPTION
    WHEN no_data_found then return ('Khong tim thay du lieu!');
    WHEN others then return ('Ham co loi!');
End;

--select * from dscafe;

--THUC THI
set serveroutput on
declare time number(20);
Begin
    time := f_time_sanxuat('&macf');
    dbms_output.put_line('San pham nay da san xuat duoc: '||time|| ' thang');
End;



--4--tao ham co tham so truyen vao la macf, tra ve tong so luong ton kho cua  mat hang
drop function f_sum_slton_macf;
Create FUNCTION f_sum_slton_macf (p_macf dscafe.macf%TYPE)
return number is
    var_sum_slton number;
Begin
    Select sum(slton) into var_sum_slton
    from dscafe join tonkho on dscafe.macf = tonkho.macf
    where dscafe.macf = p_macf;
    return var_sum_slton;
    EXCEPTION
    WHEN no_data_found then return ('Khong tim thay du lieu!');
    WHEN others then return ('Ham co loi!');
End;

--THUC THI
set serveroutput on
declare sltonkho number;
Begin
    sltonkho := f_sum_slton_macf('&macf');
    dbms_output.put_line('Tong so luong ton kho cua san pham nay la: '||sltonkho);
End;


--5--tao ham tim mat hang co so luong ton kho nho nhat cua cac chi nhanh, tham so truyen vao la macn
drop function f_cafe_min_slton;
Create FUNCTION f_cafe_min_slton (p_macn tonkho.macn%TYPE)
return VARCHAR2 is
    var_cafe VARCHAR2(100);
Begin
    Select min(slton) into var_cafe
    from dscafe join tonkho on dscafe.macf = tonkho.macf
    where tonkho.macn = p_macn;
    return var_cafe;
     EXCEPTION
    WHEN no_data_found then return ('Khong tim thay du lieu!');
    WHEN others then return ('Ham co loi!');
End;

--THUCTHI
set serveroutput on
declare luongtoncf VARCHAR2(100);
Begin
    luongtoncf := f_cafe_min_slton('&macn');
    dbms_output.put_line('Luong ton nho nhat cua chi nhanh nay la: ' || luongtoncf);
End;

---select * from tonkho where macn = 'CN01';


--6--ham tinh luong cua mot nhan vien voi tham so la manv
drop function f_luong_nhanvien;
Create FUNCTION f_luong_nhanvien(var_manv nhanvien.manv%type)
return number is
    var_luong nhanvien.luong%type;
Begin
    select  luong + hoahong into var_luong
    from nhanvien nv join hoahong hh on nv.mahh = hh.mahh
    where manv = var_manv;
    return var_luong;
End;

--test
set serveroutput on
declare 
    var_luong number(11);
    var_manv nhanvien.manv%type;
Begin
    var_manv := '&ma_nhan_vien';
    var_luong := f_luong_nhanvien(var_manv);
    dbms_output.put_line('Luong cua nhan vien ' || var_manv || ' la: ' || var_luong || ' VND');
End;


--7--ham tinh tong luong cua tat ca nhan vien cua cua hang
drop function f_tong_luong;
Create FUNCTION f_tong_luong
return number is
    var_tongluong nhanvien.luong%type;
Begin
    select  sum(luong + hoahong) into var_tongluong
    from nhanvien nv join hoahong hh on nv.mahh = hh.mahh;
    return var_tongluong;
End;

--THUC THI
set serveroutput on
declare var_tong number(11);
Begin
    var_tong := f_tong_luong;
    dbms_output.put_line('Tong luong cua nhan vien la: ' || var_tong || ' VND');
End;


--8--ham tra ve thanh tien cua don hang duoc nhap vao
drop function f_thanhtien_ddh;
create function f_thanhtien_ddh (var_maddh dondathang.maddh%type)
return number is
    var_thanhtien number(11);
begin
    select thanh_tien into var_thanhtien
    from v_thanhtien_ctdonhang
    where maddh = var_maddh;
    return var_thanhtien;
end;

--test
set serveroutput on
declare 
    var_tt number(11);
    var_maddh dondathang.maddh%type;
Begin
    var_maddh := '&ma_don';
    var_tt := f_thanhtien_ddh(var_maddh);
    dbms_output.put_line('Thanh tien cua don hang ' || var_maddh || ' la: ' || var_tt || ' VND');
End;






--== ***** SP ***** ==--

--1--procedure cap nhat luong cua cac nhan vien co cong viec nao do
drop procedure proc_capnhat_luong_congviec;
create procedure proc_capnhat_luong_congviec (var_macv in nhanvien.macv%type,
                                var_luong in nhanvien.luong%type)
is
begin
    update nhanvien set luong = var_luong where macv = var_macv;
end;
select manv, macv, luong as truoc from nhanvien where macv = 'DH';
exec proc_capnhat_luong_congviec('DH', 4500000);
select manv, macv, luong as sau from nhanvien where macv = 'DH';
--2--procedure tang gia tat ca san pham them mot phan ty le %
drop procedure proc_tang_giaban;
create procedure proc_tang_giaban(var_tyle in int)
is
begin
    update dscafe set giaban = giaban + giaban*var_tyle/100;
end;


select macf, giaban as truoc from dscafe;
exec proc_tang_giaban(5);
select macf, giaban as sau from dscafe;


--3--procedure giam gia tat ca san pham them mot phan ty le %
drop procedure proc_giam_giaban;
create procedure proc_giam_giaban(var_tyle in int)
is
begin
    update dscafe set giaban = giaban - giaban*var_tyle/100;
end;

select macf, giaban as truoc from dscafe;
exec proc_giam_giaban(5);
select macf, giaban as sau from dscafe;


--4--procedure lam tron gia ban cua cac mat hang
drop procedure proc_lamtron_giaban;
create procedure proc_lamtron_giaban
is
    cursor cur_tt_giaban is
        select macf, giaban
        from dscafe;
    rec_tt_giaban cur_tt_giaban%rowtype;
    var_du int;
begin
    open cur_tt_giaban;
    loop
        fetch cur_tt_giaban into rec_tt_giaban;
        exit when cur_tt_giaban%notfound;
        var_du := to_number(substr(mod(rec_tt_giaban.giaban,1000),1,1));
        if(var_du >= 5) then
            update dscafe set giaban = round(giaban/1000)*1000 where macf = rec_tt_giaban.macf;
        else
            update dscafe set giaban = (round(giaban/1000) + 1)*1000 where macf = rec_tt_giaban.macf;
        end if;
    end loop;
    close cur_tt_giaban;
end;

exec proc_tang_giaban(5);
select macf, giaban as truoc from dscafe;
exec proc_lamtron_giaban;
select macf, giaban as sau from dscafe;


--5--procedure cap nhat ma hoa hong cua nhan vien
drop procedure proc_capnhat_mahh;
create procedure proc_capnhat_mahh
is
    cursor cur_mahh is 
        select manv, ngayvaolam
        from nhanvien;
    rec_mahh cur_mahh%rowtype;
    var_mahh nhanvien.mahh%type;
begin
    open cur_mahh;
    loop
        fetch cur_mahh into rec_mahh;
        exit when cur_mahh%notfound;
        var_mahh := to_number(round((sysdate - rec_mahh.ngayvaolam)/365));
        if(var_mahh <= 4) then
            update nhanvien set mahh = var_mahh where manv = rec_mahh.manv;
        else
            update nhanvien set mahh = 4 where manv = rec_mahh.manv;
        end if;
    end loop;
    close cur_mahh;
end;

select manv, mahh as mahh_truoc from nhanvien;
exec proc_capnhat_mahh;
select manv, mahh as mahh_sau from nhanvien;



--6--procedure cap nhat danh sach nhan vien phu trach don dat hang khi quyet dinh thoi viec 1 nhan vien nao do
drop procedure proc_capnhat_nhanvien_phutrachddh;
create procedure proc_capnhat_nhanvien_phutrachddh (manv_delete in nhanvien.manv%type,
                                                    manv_update in nhanvien.manv%type)
is
    v_dem int;
begin
    select count(manv) into v_dem from dondathang where manv = manv_delete;
    if (v_dem >= 1) then
        update dondathang set manv = manv_update where manv = manv_delete;
    end if;
    delete from nhanvien where manv = manv_delete;
end;

--test
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL10', 'Nguyen Khanh', 'Huyen', TO_DATE('2020-09-02', 'YYYY-MM-DD'), 7000000, '0932478719', 'khanhhuyen1105@gmailcom', 'QL', 4);
insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL11', 'Nguyen Khanh', 'Huyen', TO_DATE('2020-09-02', 'YYYY-MM-DD'), 7000000, '0932478719', 'khanhhuyen1105@gmailcom', 'QL', 4);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000050', to_date('2021-09-16', 'YYYY-MM-DD'), 'KH0013', 'QL10', 4, 'CN06', 'Duc Hanh', '30 Huyen Quang, Dinh Ke, Bac Giang', to_date('2021-09-19', 'YYYY-MM-DD'), '0487364764' , NULL);
select manv from nhanvien where manv = 'QL10' or manv = 'QL11';
select maddh, manv as truoc from dondathang where maddh = 'DDH0000050';
exec proc_capnhat_nhanvien_phutrachddh('QL10', 'QL11');
select maddh, manv as sau from dondathang where maddh = 'DDH0000050';
select manv from nhanvien where manv = 'QL10';

delete from ctdonhang where maddh = 'DDH0000050';
delete from dondathang where maddh = 'DDH0000050';
delete from nhanvien where manv = 'QL11';




--7--procedure xem danh sach cafe con ton kho tai cac chi nhanh duoc nguoi dung nhap vao
drop procedure proc_thongtin_tonkho;
create procedure proc_thongtin_tonkho (var_machinhanh in tonkho.macn%type)
is
    cursor cur_tt_tonkho is 
        select macn, tencn, tencf, slton, dvt
        from v_thongtin_tonkho
        where macn = var_machinhanh;
    rec_tt_tonkho v_thongtin_tonkho%rowtype;
    var_tencn v_thongtin_tonkho.tencn%type;
    var_dem int;
begin
    select tencn into var_tencn 
    from chinhanh 
    where macn = var_machinhanh;
    select count(tencn) into var_dem 
    from chinhanh 
    where macn = var_machinhanh;
    if(var_dem = 0) then
        dbms_output.put_line ('--Ma chi nhanh khong ton tai--');
    else 
        open cur_tt_tonkho;
        dbms_output.put_line ('--DANH SACH HANG TON KHO '|| upper(var_tencn) || '--');
        loop
            fetch cur_tt_tonkho into rec_tt_tonkho;
            exit when cur_tt_tonkho%notfound;
            dbms_output.put_line ('---------------------------------------------------------------------------------------------------');
            dbms_output.put_line ('Ten cafe: ' || rec_tt_tonkho.tencf || '        So luong: ' || rec_tt_tonkho.slton || ' ' || rec_tt_tonkho.dvt);
        end loop;
        close cur_tt_tonkho;
    end if;
end;

set serveroutput on;
exec proc_thongtin_tonkho ('CN01');




--8--procedure tim kiem va xem thong tin cua nhan vien co ma duoc nhap vao boi nguoi dung
drop procedure proc_timkiem_nhanvien;
create procedure proc_timkiem_nhanvien (var_manv in nhanvien.manv%type)
is
    cursor cur_tt_nhanvien is 
        select manv, honv, tennv, tencv, ngayvaolam, luong, hoahong, sdt, email, tenkv 
        from nhanvien nv join congviec cv on nv.macv = cv.macv
                        join khuvuc kv on nv.makv = kv.makv
                        join hoahong hh on nv.mahh = hh.mahh
        where manv = var_manv;
    rec_tt_nhanvien cur_tt_nhanvien%rowtype;
begin
    open cur_tt_nhanvien;
    loop
        fetch cur_tt_nhanvien into rec_tt_nhanvien;
        exit when cur_tt_nhanvien%notfound;
        dbms_output.put_line ('Thong tin cua nhan vien co ma ' || upper(rec_tt_nhanvien.manv));
        dbms_output.put_line ('--------------------------------------------');
        dbms_output.put_line ('Ho va ten: ' || rec_tt_nhanvien.honv || ' ' || rec_tt_nhanvien.tennv);
        dbms_output.put_line ('Cong viec: ' || rec_tt_nhanvien.tencv);
        dbms_output.put_line ('Ngay vao lam: ' || rec_tt_nhanvien.ngayvaolam);
        dbms_output.put_line ('Luong: ' || rec_tt_nhanvien.luong || ' VND');
        dbms_output.put_line ('Hoa hong: ' || rec_tt_nhanvien.hoahong || ' VND');
        dbms_output.put_line ('So dien thoai: ' || rec_tt_nhanvien.sdt);
        dbms_output.put_line ('Khu vuc lam viec: ' || rec_tt_nhanvien.tenkv);
    end loop;
    close cur_tt_nhanvien;
end;

set serveroutput on;
exec proc_timkiem_nhanvien('TV0004');


--9--procedure cho xem danh sach cafe duoc ban tu nhieu nhat den it nhat
drop procedure proc_danhsach_banhang;
create procedure proc_danhsach_banhang
is
    cursor cur_ds_banhang is 
        select ct.macf, tencf, sum(sl) as soluong
        from ctdonhang ct join dscafe ds on ct.macf = ds.macf
        group by ct.macf, tencf
        order by sum(sl) desc;
    rec_ds_banhang cur_ds_banhang%rowtype;
    var_sodem int;
begin
    var_sodem := 1;
    open cur_ds_banhang;
    loop
        fetch cur_ds_banhang into rec_ds_banhang;
        exit when cur_ds_banhang%notfound;
        dbms_output.put_line ('--------------------------------------------------');
        dbms_output.put_line (var_sodem || '   ' || rec_ds_banhang.macf || '   ' || rec_ds_banhang.tencf);
        dbms_output.put_line ('    So luong ban: ' || rec_ds_banhang.soluong);
        var_sodem := var_sodem + 1;
    end loop;
    close cur_ds_banhang;
end;

set serveroutput on;
exec proc_danhsach_banhang;


--10--procedure nhap vao manv tra ve cac don dat hang do nhan vien do phu trach
drop procedure proc_thongtin_ddh_cuanvphutrach;
create procedure proc_thongtin_ddh_cuanvphutrach(var_manv in nhanvien.manv%type)
is
    cursor cur_ddh is 
        select maddh, ngaylap, tenkh, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu, tenkv, tencn
        from dondathang dh join khachhang kh on dh.makh = kh.makh
                            join khuvuc kv on dh.makv = kv.makv
                            join chinhanh cn on dh.macn = cn.macn
        where dh.manv = var_manv
        order by maddh;
    rec_ds_ddh cur_ddh%rowtype;
    var_sodem int;
begin
    var_sodem := 1;
    open cur_ddh;
    loop
        fetch cur_ddh into rec_ds_ddh;
        exit when cur_ddh%notfound;
        dbms_output.put_line ('Don dat hang ' || var_sodem);
        dbms_output.put_line ('--------------------------------------------------');
        dbms_output.put_line ('Ma don hang: ' || rec_ds_ddh.maddh);
        dbms_output.put_line ('Ngay lap: ' || rec_ds_ddh.ngaylap);
        dbms_output.put_line ('Ten khach hang: ' || rec_ds_ddh.tenkh);
        dbms_output.put_line ('Ten nguoi nhan: ' || rec_ds_ddh.ten_nguoinhan);
        dbms_output.put_line ('Dia chi giao hang: ' || rec_ds_ddh.diachi_giao);
        dbms_output.put_line ('Thoi han giao: ' || rec_ds_ddh.thoihan_giao);
        dbms_output.put_line ('SDT nguoi nhan: ' || rec_ds_ddh.sdt_nguoinhan);
        dbms_output.put_line ('Ghi chu: ' || rec_ds_ddh.ghichu);
        dbms_output.put_line ('Chi nhanh giao hang: ' || rec_ds_ddh.tencn);
        dbms_output.put_line ('Don thuoc khu vuc: ' || rec_ds_ddh.tenkv);
        dbms_output.put_line ('');
        var_sodem := var_sodem + 1;
    end loop;
    close cur_ddh;
end;

set serveroutput on;
exec proc_thongtin_ddh_cuanvphutrach('TV0004');


--11--procedure them don dat hang voi danh so tu dong
drop procedure proc_them_ddh;
create procedure proc_them_ddh(var_makh in dondathang.makh%type, 
                                var_manv in dondathang.manv%type, 
                                var_makv in dondathang.makv%type,
                                var_macn in dondathang.macn%type, 
                                var_ten_nguoinhan in dondathang.ten_nguoinhan%type, 
                                var_diachi_giao in dondathang.diachi_giao%type, 
                                var_thoihan_giao in dondathang.thoihan_giao%type, 
                                var_sdt_nguoinhan in dondathang.sdt_nguoinhan%type, 
                                var_ghichu in dondathang.ghichu%type)
is
    var_maddh dondathang.maddh%type;
    var_sq number(6);
begin
    var_sq := sq_maddh.nextval;
    var_maddh := to_char(to_number(mod(extract(year from sysdate),2000) || extract(month from sysdate))*1000000 + var_sq);
    insert into dondathang(maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu)
    values(var_maddh, sysdate, var_makh, var_manv, var_makv, var_macn, var_ten_nguoinhan, var_diachi_giao, var_thoihan_giao, var_sdt_nguoinhan, var_ghichu);
end;


exec proc_them_ddh('KH0001', 'TV0004', 2, 'CN03', 'Quoc Khanh', 'Duong 385, phuong Tang Nhon Phu A, tp Thu Duc', to_date('2021-09-01', 'YYYY-MM-DD'), '0838263820' , NULL);
select maddh from dondathang where substr(maddh,1,4) = '2111';

delete from dondathang where substr(maddh,1,4) = '2111';  


--12--procedure them khach hang voi danh so tu dong
drop procedure proc_them_kh;
create procedure proc_them_kh (var_tenkh in khachhang.tenkh%type, 
                                var_diachi in khachhang.diachi%type, 
                                var_sdt in khachhang.sdt%type, 
                                var_email in khachhang.email%type)
is
    var_makh khachhang.makh%type;
    var_sq number(4);
begin
    var_sq := sq_makh.nextval;
    if(length(var_sq) = 1) then
        var_makh := to_char('KH000' || var_sq);
    elsif (length(var_sq) = 2) then
        var_makh := to_char('KH00' || var_sq);
    elsif (length(var_sq) = 3) then
        var_makh := to_char('KH0' || var_sq);
    elsif (length(var_sq) = 4) then
        var_makh := to_char('KH' || var_sq);
    end if;
    insert into khachhang (makh, tenkh, diachi, sdt, email)
    values(var_makh, var_tenkh, var_diachi, var_sdt, var_email);
end;

exec proc_them_kh('Nguyen Quoc Khanh', 'Duong 385, phuong Tang Nhon Phu A, tp Thu Duc', '0838263820', 'quockhanh29@gmail.com');
select makh from khachhang;

delete from khachhang where makh in ('KH0016', 'KH0017', 'KH0018', 'KH0019', 'KH0020');


--13--procedure them cafe voi danh so tu dong
drop procedure proc_them_cf;
create procedure proc_them_cf (var_tencf in dscafe.tencf%type, 
                                var_ngaysx in dscafe.ngaysx%type, 
                                var_hsd in dscafe.hsd%type, 
                                var_khoiluong in dscafe.khoiluong%type, 
                                var_dvt in dscafe.dvt%type, 
                                var_giaban in dscafe.giaban%type, 
                                var_mota in dscafe.mota%type, 
                                var_maloaicf in dscafe.maloaicf%type, 
                                var_math in dscafe.math%type)
is
    var_macf dscafe.macf%type;
    var_sq number(4);
begin
    var_sq := sq_macf.nextval;
    if(length(var_sq) = 1) then
        var_macf := to_char('CF000' || var_sq);
    elsif (length(var_sq) = 2) then
        var_macf := to_char('CF00' || var_sq);
    elsif (length(var_sq) = 3) then
        var_macf := to_char('CF0' || var_sq);
    elsif (length(var_sq) = 4) then
        var_macf:= to_char('CF' || var_sq);
    end if;
    insert into dscafe (macf, tencf, ngaysx, hsd, khoiluong, dvt, giaban, mota, maloaicf, math)
    values(var_macf, var_tencf, var_ngaysx, var_hsd, var_khoiluong, var_dvt, var_giaban, var_mota, var_maloaicf, var_math);
end;

exec proc_them_cf('Cafe TNI King Coffee 450g', TO_DATE('2021-08-27', 'YYYY-MM-DD'), '2 nam ke tu nsx', 450, 'hop', 315000, 'test....', 'L02', 'TK');
select * from dscafe order by macf;

delete from dscafe where macf in('CF0051', 'CF0052', 'CF0053', 'CF0054');


--14--procedure cap nhat thanh tien cua don dat hang
drop procedure proc_capnhat_thanhtien_ddh;
create procedure proc_capnhat_thanhtien_ddh(var_ngay in dondathang.ngaylap%type)
is
    cursor cur_ddh is 
        select maddh
        from dondathang
        where ngaylap >= var_ngay;
    rec_ds_ddh cur_ddh%rowtype;
    var_thanhtien dondathang.thanhtien%type;
begin
    open cur_ddh;
    loop
        fetch cur_ddh into rec_ds_ddh;
        exit when cur_ddh%notfound;
        var_thanhtien := f_thanhtien_ddh(rec_ds_ddh.maddh);
        update dondathang set thanhtien = var_thanhtien where maddh = rec_ds_ddh.maddh;        
    end loop;
    close cur_ddh;
end;

select thanhtien from dondathang where ngaylap >= TO_DATE('2021-01-01', 'YYYY-MM-DD');
select thanhtien from dondathang where ngaylap < TO_DATE('2021-01-01', 'YYYY-MM-DD');
exec proc_tang_giaban(5);
exec proc_lamtron_giaban;
exec proc_capnhat_thanhtien_ddh(TO_DATE('2021-01-01', 'YYYY-MM-DD'));
select thanhtien from dondathang where ngaylap >= TO_DATE('2021-01-01', 'YYYY-MM-DD');
select thanhtien from dondathang where ngaylap < TO_DATE('2021-01-01', 'YYYY-MM-DD');
--== ***** TRIGGER ***** ==--

--1--trigger kiem tra thoi han giao cua don hang phai sau ngaylap
drop trigger tg_ktra_thoihangiao_sau_ngaylapddh;
create trigger tg_ktra_thoihangiao_sau_ngaylapddh
after insert or update
on dondathang
for each row
begin
    if (:new.thoihan_giao < :new.ngaylap) then 
        raise_application_error (-20511, 'Thoi han giao hang phai sau ngay lap don dat hang');
    end if;
end;

insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000050', to_date('2021-09-16', 'YYYY-MM-DD'), 'KH0013', 'TV0011', 4, 'CN06', 'Duc Hanh', '30 Huyen Quang, Dinh Ke, Bac Giang', to_date('2020-09-19', 'YYYY-MM-DD'), '0487364764' , NULL);
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000050', to_date('2021-09-16', 'YYYY-MM-DD'), 'KH0013', 'TV0011', 4, 'CN06', 'Duc Hanh', '30 Huyen Quang, Dinh Ke, Bac Giang', to_date('2021-09-19', 'YYYY-MM-DD'), '0487364764' , NULL);

select * from dondathang where maddh = 'DDH0000050';



--2--trigger kiem tra so luong hang duoc dat phai nho hon so luong ton kho va cap nhat so luong ton(insert)
drop trigger tg_ktra_dat_nhohon_ton_i;
create trigger tg_ktra_dat_nhohon_ton_i
after insert
on ctdonhang
for each row
declare
    var_tonkho tonkho.slton%type;
    var_chinhanh chinhanh.macn%type;
begin 
    select macn into var_chinhanh from dondathang where maddh = :new.maddh;
    select slton into var_tonkho from tonkho where macf = :new.macf and macn = var_chinhanh;
    if(:new.sl > var_tonkho) then
        raise_application_error (-20512, 'Kho khong du so luong de cung cap cho don dat hang');
    else
        update tonkho set slton = slton - :new.sl where macf = :new.macf and macn = var_chinhanh;
    end if;
end;

insert into ctdonhang values('DDH0000050', 'CF0001', 100000000);

select slton from tonkho where macn = 'CN06' and macf = 'CF0001';
insert into ctdonhang values('DDH0000050', 'CF0001', 10);
select slton from tonkho where macn = 'CN06' and macf = 'CF0001';


--3--trigger kiem tra so luong hang duoc dat phai nho hon so luong ton kho va cap nhat so luong ton(cap nhat)
drop trigger tg_ktra_dat_nhohon_ton_u;
create trigger tg_ktra_dat_nhohon_ton_u
after update
on ctdonhang
for each row
declare
    var_tonkho tonkho.slton%type;
    var_chinhanh chinhanh.macn%type;
begin 
    select macn into var_chinhanh from dondathang where maddh = :new.maddh;
    select slton into var_tonkho from tonkho where macf = :new.macf and macn = var_chinhanh;
    if(:new.sl > var_tonkho) then
        raise_application_error (-20512, 'Kho khong du so luong de cung cap cho don dat hang');
    else
        update tonkho set slton = slton - (:new.sl - :old.sl) where macf = :new.macf and macn = var_chinhanh;
    end if;
end;

select slton from tonkho where macn = 'CN06' and macf = 'CF0001';
update ctdonhang set sl = 20 where maddh = 'DDH0000050' and macf = 'CF0001';
select slton from tonkho where macn = 'CN06' and macf = 'CF0001'


--4--trigger khi huy don dat hang thi huy ca chi tiet cua don dat hang do va cap nhat so luong ton
drop trigger tg_huy_ct_khihuydon;
create trigger tg_huy_ct_khihuydon
before delete
on dondathang
for each row
declare
    cursor cur_huy_don is 
        select macf, sl
        from ctdonhang
        where maddh = :old.maddh;
    rec_huy_don cur_huy_don%rowtype;
begin 
    open cur_huy_don;
    loop
        fetch cur_huy_don into rec_huy_don;
        exit when cur_huy_don%notfound;
        update tonkho set slton = slton + rec_huy_don.sl where macf = rec_huy_don.macf and macn = :old.macn;
    end loop;
    close cur_huy_don;
    delete from ctdonhang where maddh = :old.maddh;
end;



--5--trigger xoa khach hang => xoa ca don dat hang
drop trigger tg_huy_don_khihuykhachhang;
create trigger tg_huy_don_khihuykhachhang
before delete
on khachhang
for each row
declare
begin 
    delete from dondathang where makh = :old.makh;
end;


insert into khachhang (makh, tenkh, diachi, sdt, email) values ('KH1000', 'Pham Quynh Huong', '170 Pho Ngoc Khanh, Giang Vo, Ba Dinh, Ha Noi', '0946660099', 'phamquynhhuong2005@gmail.com');
insert into dondathang (maddh, ngaylap, makh, manv, makv, macn, ten_nguoinhan, diachi_giao, thoihan_giao, sdt_nguoinhan, ghichu) values ('DDH0000050', to_date('2021-09-16', 'YYYY-MM-DD'), 'KH1000', 'TV0011', 4, 'CN01', 'Duc Hanh', '30 Huyen Quang, Dinh Ke, Bac Giang', to_date('2021-09-19', 'YYYY-MM-DD'), '0487364764' , NULL);
insert into ctdonhang values ('DDH0000050', 'CF0001',50);

select * from khachhang where makh = 'KH1000';
select * from dondathang where maddh = 'DDH0000050';
select * from ctdonhang where maddh = 'DDH0000050';
select slton from tonkho where macf = 'CF0001';

delete from khachhang where makh = 'KH1000';


--6--trigger ngay vao lam phai nho hon hoac bang ngay hien hanh
drop trigger tg_ktra_ngayvaolam;
create trigger tg_ktra_ngayvaolam
after insert or update
on nhanvien
for each row
begin
    if (:new.ngayvaolam > sysdate) then 
        raise_application_error (-20513, 'Ngay vao lam phai nho hon hoac bang ngay hien tai');
    end if;
end;


insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL10', 'Nguyen Khanh', 'Huyen', TO_DATE('2022-09-02', 'YYYY-MM-DD'), 7000000, '0932478719', 'khanhhuyen1105@gmailcom', 'QL', 4);

insert into nhanvien (manv, honv, tennv, ngayvaolam, luong, sdt, email, macv, makv) values ('QL10', 'Nguyen Khanh', 'Huyen', TO_DATE('2020-09-02', 'YYYY-MM-DD'), 7000000, '0932478719', 'khanhhuyen1105@gmailcom', 'QL', 4);



--7--trigger xoa loai cafe thi ma loai cafe o dscafe se duoc cap nhat thanh "L00"
drop trigger tg_capnhat_xoaloai_capnhatmaloai;
create trigger tg_capnhat_xoaloai_capnhatmaloai
before delete
on loaicafe
for each row
begin
    update dscafe set maloaicf = 'L00' where maloaicf = :old.maloaicf;
end;


--8--trigger xoa thuong hieu thi ma thuong hieu o dscafe se duoc cap nhat thanh "00"
drop trigger tg_capnhat_xoath_capnhatmath;
create trigger tg_capnhat_xoath_capnhatmath
before delete
on thuonghieu
for each row
begin
    update dscafe set math = '00' where math = :old.math;
end;


--9--trigger kiem tra ngay sx cau cafe phai nho hon hoac bang ngay hien tai
drop trigger tg_ktra_ngaysx;
create trigger tg_ktra_ngaysx
after insert or update
on dscafe
for each row
begin
    if (:new.ngaysx > sysdate) then 
        raise_application_error (-20514, 'Ngay san xuat nho hon hoac bang ngay hien tai');
    end if;
end;


commit;







