Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936083AbeCBG5b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 01:57:31 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:53229 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935863AbeCBG53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 01:57:29 -0500
X-Google-Smtp-Source: AG47ELtJLZttUzM0kmZn01SGXBiPC79npHN2wnELQ5nL2hTVyNNxdU+hpjP8v8LXjeU6HmqW0Q4Gxm4EIv6W4xd2+W8=
MIME-Version: 1.0
From: Maxim Uvarov <muvarov@gmail.com>
Date: Fri, 2 Mar 2018 09:57:27 +0300
Message-ID: <CAJGZr0KKRv3GbdkpFerAzNMazQ5YWnT9P==gy0BqY4ZCpKCwgg@mail.gmail.com>
Subject: fsl,ifc + MT29F64G08CBAAAWP
To: kernel list <linux-kernel@vger.kernel.org>
Cc: boris.brezillon@free-electrons.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w226vbkP012569

Hello,

I'm trying to make work NAND MT29F64G08CBAAAWP with fsl IFC driver.
And that seems trickly or I'm missing some fundamental thing.

>From MT29F64G08CBAAAWP  it's said:

Organization Page
– Page size x8: 8640 bytes (8192 + 448 bytes)
– Block size: 256 pages (2048K + 112K bytes)
– Plane size: 2 planes x 2048 blocks per plane
– Device size: 64Gb: 4096 blocks; 128Gb: 8192 blocks; 256Gb: 16,384
blocks; 512Gb: 32,786 blocks
- Minimum required ECC 24-bit ECC per 1080 bytes of data (BCH algo for ECC)

And it looks like drivers/mtd/nand/fsl_ifc_nand.c works well only with
512K blocks.

So the question is - should I set up IFC driver absolutely the same as
NAND chip spec says? Or it can work
with smaller blocks?

fsl_ifc_chip_init() csor = 0x9518c300 csor_ext 0x100000
fsl_ifc_chip_init() csor pgs = 0x180000
fsl_ifc_chip_init() CSOR_NAND_ECC_DEC_EN 1, CSOR_NAND_ECC_ENC_EN 1
fsl_ifc_chip_init() csor CSOR_NAND_ECC_MODE 268435456
fsl_ifc_chip_init() NAND_BUSWIDTH_16 0
nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x88
nand: Micron MT29F64G08CBAAAWP
nand: 8192 MiB, MLC, erase size: 2048 KiB, page size: 8192, OOB size: 448
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->numchips = 1
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->chipsize = 8589934592
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->pagemask =    fffff
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->chip_delay = 200
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->badblockpos = 0
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->chip_shift = 33
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->page_shift = 13
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->phys_erase_shift = 21
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->ecc.mode = 2
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->ecc.steps = 0
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->ecc.bytes = 16
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: nand->ecc.total = 0
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: mtd->ooblayout = (ptrval)
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: mtd->flags = 00000000
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: mtd->size = 8589934592
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: mtd->erasesize = 2097152
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: mtd->writesize = 8192
fsl,ifc-nand 60000000.nand: fsl_ifc_chip_init_tail: mtd->oobsize = 448
nand: WARNING: 60000000.flash: the ECC used on your system is too weak
compared to the one required by the NAND chip
1 ofpart partitions found on MTD device 60000000.flash
Creating 1 MTD partitions on "60000000.flash":
0x000000000000-0x000040000000 : "rootfs"

Issue is that on mtd_test I get I/O errors. The same as ubu_attach.
ubi_format looks like pass first cycle but can not place bad blocks.
Should this NAND chip work with IFC or there is some limitation?

-- 
Best regards,
Maxim Uvarov
