Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E8BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4110421533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4110421533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeI0EX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:23:28 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45617 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeI0EX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:23:28 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42LBsK56v8z1qyLM;
        Thu, 27 Sep 2018 00:08:21 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42LBsK3TQ2z1qql9;
        Thu, 27 Sep 2018 00:08:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id sEcYjIMFJ6Wj; Thu, 27 Sep 2018 00:08:19 +0200 (CEST)
X-Auth-Info: +VfsWiVnptGs8R0euN51ovntDv15rdXxE4yZJw5LG28=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 27 Sep 2018 00:08:19 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        boris.brezillon@bootlin.com, Mark Rutland <mark.rutland@arm.com>
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr,
        Lukasz Majewski <lukma@denx.de>
Subject: [RFC/RFT PATCH v1 8/9] mtd: spi: Allocate memory corresponding to maximal fsl-quadspi.c controller area
Date:   Thu, 27 Sep 2018 00:07:38 +0200
Message-Id: <20180926220739.620-9-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180926220739.620-1-lukma@denx.de>
References: <20180926220739.620-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit changes the way how QUADSPI controller allocates memory for
reading data via AHB.

After this change it is a fixed buffer with maximal size (for up to four
SPI-NOR memories connected).

In my case:

----------------- 0x0
SPI0 (QSPI0, A1 -> QUAD)
----------------- 0x1000000
HOLE
----------------- 0x2000000
SPI1 (QSPI0, B1 -> DUAL)
----------------- 0x3000000
HOLE
----------------- 0x4000000

Without this change, some single bytes are missing when reading single
bytes from 256B buffer.

dd if=/dev/mtd7 of=aaa.img bs=1 count=256

root@nix:~# hexdump aaa.img
0000000 464c eec0 baa5 c5ff 7b99 4dfb e0b6 8a2e
0000010 e98e 5265 683c a635 c069 e402 303f d936
0000020 c243 01a7 7064 fce8 e3a9 200a 7e85 28bc
0000030 4296 a30e 1bb4 88d4 b456 b4a6 f3aa 8cff
0000040 01c9 462d 0a43 f893 0e42 67f1 57f0 787c
0000050 49c0 fb2a e514 e954 1d21 affa bac4 38f1
0000060 1ca5 ec46 77eb a854 98b6 e71a c1cb 876c
0000070 b441 2baf ee33 596c 98b6 e71a c1cb 876c
0000080 7d8b 5739 5cca 873f c3df 8aca 2d5b 2bbb
0000090 5afe 6ad9 6072 b092 5ace 905b e217 faee
00000a0 58c6 6851 a1b9 c756 5ace 905b e217 faee
00000b0 b3dd 98be 0412 73d2 cbca c47c 6ab0 7c6d
00000c0 65cf b1e2 1457 a3cf 502b 6449 9a84 d83f
00000d0 a6e7 df30 b0e6 ea23 502b 6449 9a84 d83f
00000e0 5638 26bf d680 c47a 0225 6762 cf65 75fc
00000f0 2faa edf1 f8b6 dc13 ffff ffff ffff ffff
0000100


Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 97546fa70b79..915e5a203895 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -908,6 +908,9 @@ static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
 	struct fsl_qspi *q = nor->priv;
 	u8 cmd = nor->read_opcode;
 	int seqid;
+	size_t qlen = q->nor_size * 4;
+	int nor_idx = nor - q->nor;
+	size_t nor_ofs = q->nor_size * nor_idx;
 
 	/* Set the actual lut sequence for AHB Read from the considered nor. */
 	seqid = fsl_qspi_get_seqid(q, nor->read_opcode);
@@ -926,8 +929,9 @@ static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
 
 	/* if necessary,ioremap buffer before AHB read, */
 	if (!q->ahb_addr) {
-		q->memmap_offs = q->chip_base_addr + from;
-		q->memmap_len = len > QUADSPI_MIN_IOMAP ? len : QUADSPI_MIN_IOMAP;
+		q->memmap_offs = q->chip_base_addr;
+		q->memmap_len = qlen > QUADSPI_MIN_IOMAP ?
+			qlen : QUADSPI_MIN_IOMAP;
 
 		q->ahb_addr = ioremap_nocache(
 				q->memmap_phy + q->memmap_offs,
@@ -942,8 +946,9 @@ static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
 			q->memmap_offs + q->memmap_len) {
 		iounmap(q->ahb_addr);
 
-		q->memmap_offs = q->chip_base_addr + from;
-		q->memmap_len = len > QUADSPI_MIN_IOMAP ? len : QUADSPI_MIN_IOMAP;
+		q->memmap_offs = q->chip_base_addr;
+		q->memmap_len = qlen > QUADSPI_MIN_IOMAP ?
+			qlen : QUADSPI_MIN_IOMAP;
 		q->ahb_addr = ioremap_nocache(
 				q->memmap_phy + q->memmap_offs,
 				q->memmap_len);
@@ -954,12 +959,11 @@ static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
 	}
 
 	dev_dbg(q->dev, "cmd [%x],read from %p, len:%zd\n",
-		cmd, q->ahb_addr + q->chip_base_addr + from - q->memmap_offs,
+		cmd, q->ahb_addr + nor_ofs + from - q->memmap_offs,
 		len);
 
 	/* Read out the data directly from the AHB buffer.*/
-	memcpy(buf, q->ahb_addr + q->chip_base_addr + from - q->memmap_offs,
-		len);
+	memcpy(buf, q->ahb_addr + nor_ofs + from - q->memmap_offs, len);
 
 	return len;
 }
-- 
2.11.0

