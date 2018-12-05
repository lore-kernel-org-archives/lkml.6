Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1295C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022DE206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p3d7K0QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022DE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeLEGcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:32:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39356 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:32:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181205063244euoutp02c53c12c2b7897a3182bcb7233a63b386~tXCXWeEIX1433414334euoutp02m;
        Wed,  5 Dec 2018 06:32:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181205063244euoutp02c53c12c2b7897a3182bcb7233a63b386~tXCXWeEIX1433414334euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543991564;
        bh=AzySfyVogNCBV+acKTWZlI2/RKqui6RetNiEtEgQxes=;
        h=From:To:Subject:Date:References:From;
        b=p3d7K0QDNDO4tjMPSTnrv6wJZJvqdPVfj9Ux7f28Y9lwPpa6j22Pz7yqaC+dxUlZa
         vOxfvAE3vyTmZDDJk1J6OvW8QLtCjLlrqiMG6lCqeGmFvSj9J0PoDFrJ9t9jQlTJA5
         FRJjXRS8pmTJfv4jxYHv55piiy+A1owKdbtVOW5Q=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205063244eucas1p1f283cf4137cfc23d6cd9878bc543b93f~tXCWs5Io51609916099eucas1p1Y;
        Wed,  5 Dec 2018 06:32:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 6D.41.04294.B01770C5; Wed,  5
        Dec 2018 06:32:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181205063243eucas1p1792e0cf7d0e8a3cfb928a091f5548550~tXCWENY2W0464004640eucas1p1_;
        Wed,  5 Dec 2018 06:32:43 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-82-5c07710bb866
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8F.B7.04284.B01770C5; Wed,  5
        Dec 2018 06:32:43 +0000 (GMT)
Received: from localhost.localdomain ([10.88.100.192]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PJ900CCM3I7V060@eusync3.samsung.com>;
        Wed, 05 Dec 2018 06:32:43 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        js07.lee@samsung.com, js07.lee@gmail.com
Subject: [RFC PATCH 1/2] mtd: spi-nor: add 4bit block protection support
Date:   Wed, 05 Dec 2018 15:32:19 +0900
Message-id: <20181205063220.22279-1-js07.lee@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsWy7djPc7rchewxBu/2GlnsO9XPYnHkwlpm
        i4krJzNb/J3zjsni0c3frBaXd81hs9jdtIzd4uiee8wWk3e+YXTg9Ji3ptpj56y77B6bV2h5
        bF5S73FzXqFH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZezYe4G54IZBxdaWO4wNjO9Vuxg5
        OSQETCQWnb3P0sXIxSEksIJRYu/pTawQzmdGiRX3p7PAVJ0+0sUIkVjGKNF3+zQrSEJI4B+j
        xL85KiA2m4CWxI3fEN0iAnuZJP6dOMAOkhAW8JCYvfEpUDcHB4uAqsSBXWogYV4BS4mlDw6z
        QSyQl1i94QAzSK+EwE9WiY0T9jBCJFwkPp6+zw5hC0u8Or4FypaR6Ow4yARhF0vsXDmRHaK5
        hVHi0fIlUEXGEu/ermUGsZkF+CQmbZvODHKEhACvREebEESJh8TCdb+hnomV2DjnNOMERvEF
        jAyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAuPt9L/jX3Yw7vqTdIhRgINRiYdXYgpb
        jBBrYllxZe4hRgkOZiUR3hU27DFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeasZHkQLCaQnlqRm
        p6YWpBbBZJk4OKUaGN1DV3omJ5bMnzDvi9Ir3fB4z8mLr++vcbLUs9+qljJxY43gRKvNMz/d
        afC2+PWJ56TAG9WXc3eqyWxTmayUs5Lrok3NnFwf1ck3T3feCvzA913vQXH7NNYnEi8rZe3X
        Oz391O0+uTLyTsDDRcHt95uP1Ky+O+nQC/6+hX06JkK3F0bmrb3bsU+JpTgj0VCLuag4EQC6
        2dPiswIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJMWRmVeSWpSXmKPExsVy+t/xq7rchewxBo33JC32nepnsThyYS2z
        xcSVk5kt/s55x2Tx6OZvVovLu+awWexuWsZucXTPPWaLyTvfMDpwesxbU+2xc9Zddo/NK7Q8
        Ni+p97g5r9Cjb8sqRo/Pm+QC2KO4bFJSczLLUov07RK4MnbsvcBccMOgYmvLHcYGxveqXYyc
        HBICJhKnj3QxdjFycQgJLGGUeH/hDQuE08AkcbzvHitIFZuAlsSN35tYQRIiAnuZJI6ems0G
        khAW8JCYvfEpUDsHB4uAqsSBXWogYV4BS4mlDw6zQWyQl1i94QDzBEbOBYwMqxhFUkuLc9Nz
        iw31ihNzi0vz0vWS83M3MQKDYtuxn5t3MF7aGHyIUYCDUYmHV3IKW4wQa2JZcWXuIUYJDmYl
        Ed4VNuwxQrwpiZVVqUX58UWlOanFhxilOViUxHnPG1RGCQmkJ5akZqemFqQWwWSZODilGhgr
        2LUuh9pbz1vE8v/j3b9PXX78mmlReuLRtkvTU7Y9tp8uI1V3WVfuZ4/JleS8xGbTiw8jnzAy
        7Gx/3dBszOGz95zGn497e37fs+Lykt9UWczxp4ZRmeVbd9+2jc4Su/7k+C+KOmE40XVNyj1N
        Xm7pz0sUonacqvihJ5T9LDL6ZZHF5uivbVFKLMUZiYZazEXFiQAwl7xpBgIAAA==
X-CMS-MailID: 20181205063243eucas1p1792e0cf7d0e8a3cfb928a091f5548550
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205063243eucas1p1792e0cf7d0e8a3cfb928a091f5548550
References: <CGME20181205063243eucas1p1792e0cf7d0e8a3cfb928a091f5548550@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we are supporting block protection only for
flash chips with 3 block protection bits in the SR register.
This patch enables block protection support for some flash with
4 block protection bits(bp0-3).

Because this feature is not universal to all flash that support
lock/unlock, control it via a new flag.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 61 ++++++++++++++++++++++++++++++-----
 include/linux/mtd/spi-nor.h   |  4 +++
 2 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1fdd2834fbcb..c261d8f7bef4 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -90,6 +90,7 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define SPI_NOR_HAS_BP3		BIT(15)	/* use 4 bits field for block protect */
 
 	int	(*quad_enable)(struct spi_nor *nor);
 };
@@ -898,18 +899,36 @@ static void stm_get_locked_range(struct spi_nor *nor, u8 sr, loff_t *ofs,
 	int shift = ffs(mask) - 1;
 	int pow;
 
+	if (nor->flags & SNOR_F_HAS_SR_BP3)
+		mask |= SR_BP3;
+
 	if (!(sr & mask)) {
 		/* No protection */
 		*ofs = 0;
 		*len = 0;
+		return;
+	}
+
+	if (nor->flags & SNOR_F_HAS_SR_BP3) {
+		u8 temp = sr & mask;
+
+		if (temp & SR_BP3)
+			temp = (temp & ~SR_BP3) | BIT(5);
+
+		pow = ilog2(nor->n_sectors) + 1 - (temp >> shift);
+		if (pow > 0)
+			*len = mtd->size >> pow;
+		else
+			*len = mtd->size;
 	} else {
 		pow = ((sr & mask) ^ mask) >> shift;
 		*len = mtd->size >> pow;
-		if (nor->flags & SNOR_F_HAS_SR_TB && sr & SR_TB)
-			*ofs = 0;
-		else
-			*ofs = mtd->size - *len;
 	}
+
+	if (nor->flags & SNOR_F_HAS_SR_TB && sr & SR_TB)
+		*ofs = 0;
+	else
+		*ofs = mtd->size - *len;
 }
 
 /*
@@ -989,6 +1008,9 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
 	bool use_top;
 
+	if (nor->flags & SNOR_F_HAS_SR_BP3)
+		mask |= SR_BP3;
+
 	status_old = read_sr(nor);
 	if (status_old < 0)
 		return status_old;
@@ -1028,7 +1050,16 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	 *   pow = ceil(log2(size / len)) = log2(size) - floor(log2(len))
 	 */
 	pow = ilog2(mtd->size) - ilog2(lock_len);
-	val = mask - (pow << shift);
+
+	if (nor->flags & SNOR_F_HAS_SR_BP3) {
+		val = ilog2(nor->n_sectors) + 1 - pow;
+		val = val << shift;
+		if (val & BIT(5))
+			val = (val & ~BIT(5)) | SR_BP3;
+	} else {
+		val = mask - (pow << shift);
+	}
+
 	if (val & ~mask)
 		return -EINVAL;
 	/* Don't "lock" with no region! */
@@ -1069,6 +1100,9 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	bool can_be_top = true, can_be_bottom = nor->flags & SNOR_F_HAS_SR_TB;
 	bool use_top;
 
+	if (nor->flags & SNOR_F_HAS_SR_BP3)
+		mask |= SR_BP3;
+
 	status_old = read_sr(nor);
 	if (status_old < 0)
 		return status_old;
@@ -1110,13 +1144,19 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	pow = ilog2(mtd->size) - order_base_2(lock_len);
 	if (lock_len == 0) {
 		val = 0; /* fully unlocked */
+	} else if (nor->flags & SNOR_F_HAS_SR_BP3) {
+		val = ilog2(nor->n_sectors) + 1 - pow;
+		val = val << shift;
+		if (val & BIT(5))
+			val = (val & ~BIT(5)) | SR_BP3;
 	} else {
 		val = mask - (pow << shift);
-		/* Some power-of-two sizes are not supported */
-		if (val & ~mask)
-			return -EINVAL;
 	}
 
+	/* Some power-of-two sizes are not supported */
+	if (val & ~mask)
+		return -EINVAL;
+
 	status_new = (status_old & ~mask & ~SR_TB) | val;
 
 	/* Don't protect status register if we're fully unlocked */
@@ -2114,6 +2154,7 @@ enum spi_nor_pp_command_index {
 struct spi_nor_flash_parameter {
 	u64				size;
 	u32				page_size;
+	u16				n_sectors;
 
 	struct spi_nor_hwcaps		hwcaps;
 	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
@@ -3251,6 +3292,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 	memset(params, 0, sizeof(*params));
 
 	/* Set SPI NOR sizes. */
+	params->n_sectors = info->n_sectors;
 	params->size = info->sector_size * info->n_sectors;
 	params->page_size = info->page_size;
 
@@ -3793,12 +3835,15 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 	if (info->flags & USE_CLSR)
 		nor->flags |= SNOR_F_USE_CLSR;
+	if (info->flags & SPI_NOR_HAS_BP3)
+		nor->flags |= SNOR_F_HAS_SR_BP3;
 
 	if (info->flags & SPI_NOR_NO_ERASE)
 		mtd->flags |= MTD_NO_ERASE;
 
 	mtd->dev.parent = dev;
 	nor->page_size = params.page_size;
+	nor->n_sectors = params.n_sectors;
 	mtd->writebufsize = nor->page_size;
 
 	if (np) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 7f0c7303575e..5b7391feb308 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -122,6 +122,7 @@
 #define SR_BP1			BIT(3)	/* Block protect 1 */
 #define SR_BP2			BIT(4)	/* Block protect 2 */
 #define SR_TB			BIT(5)	/* Top/Bottom protect */
+#define SR_BP3			BIT(6)	/* Block protect 3 */
 #define SR_SRWD			BIT(7)	/* SR write protect */
 /* Spansion/Cypress specific status bits */
 #define SR_E_ERR		BIT(5)
@@ -236,6 +237,7 @@ enum spi_nor_option_flags {
 	SNOR_F_READY_XSR_RDY	= BIT(4),
 	SNOR_F_USE_CLSR		= BIT(5),
 	SNOR_F_BROKEN_RESET	= BIT(6),
+	SNOR_F_HAS_SR_BP3	= BIT(7),
 };
 
 /**
@@ -339,6 +341,7 @@ struct flash_info;
  * @dev:		point to a spi device, or a spi nor controller device.
  * @info:		spi-nor part JDEC MFR id and other info
  * @page_size:		the page size of the SPI NOR
+ * @n_sectors:		number of sector
  * @addr_width:		number of address bytes
  * @erase_opcode:	the opcode for erasing a sector
  * @read_opcode:	the read opcode
@@ -375,6 +378,7 @@ struct spi_nor {
 	struct device		*dev;
 	const struct flash_info	*info;
 	u32			page_size;
+	u16			n_sectors;
 	u8			addr_width;
 	u8			erase_opcode;
 	u8			read_opcode;
-- 
2.17.1

