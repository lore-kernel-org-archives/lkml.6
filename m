Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D72C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D235B20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="I9DfH3Tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D235B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933216AbeFUKen (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:34:43 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52154 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932993AbeFUKdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:33:45 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A75B38448A;
        Thu, 21 Jun 2018 22:33:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529577221;
        bh=grDTHuiRVnY9AHfszxzkJkAoEyuqxn4PHjR0Y2jxkm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=I9DfH3TtgLNCoOIWgoXvj9j14Twzr1sGB+/Oc/SyDqrC8skSBL5wFRWWqrCUNCsdq
         k+guUm5JfAmOEEvU4Gzv3Cj+VcGUqMWkIol6Zc9FPZa60Gy4XnreQpJ/trTqz8DYod
         RzCUnHfnq24LGLfRIceEqQd1lyMeiSrT+fdc2GMQ=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2b7f010003>; Thu, 21 Jun 2018 22:33:42 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 5E37013EFB0;
        Thu, 21 Jun 2018 22:33:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 26E781E2626; Thu, 21 Jun 2018 22:33:37 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v4 3/6] mtd: rawnand: add defines for ONFI version bits
Date:   Thu, 21 Jun 2018 22:33:25 +1200
Message-Id: <20180621103328.28206-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621103328.28206-1-chris.packham@alliedtelesis.co.nz>
References: <20180621103328.28206-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add defines for the ONFI version bits and use them in
nand_flash_detect_onfi().

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
Changes in v4:
- New

 drivers/mtd/nand/raw/nand_base.c | 10 +++++-----
 include/linux/mtd/rawnand.h      | 11 +++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 65250308c82d..36048e0cf1f5 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5178,15 +5178,15 @@ static int nand_flash_detect_onfi(struct nand_chip *chip)
 
 	/* Check version */
 	val = le16_to_cpu(p->revision);
-	if (val & (1 << 5))
+	if (val & ONFI_VERSION_2_3)
 		chip->parameters.onfi.version = 23;
-	else if (val & (1 << 4))
+	else if (val & ONFI_VERSION_2_2)
 		chip->parameters.onfi.version = 22;
-	else if (val & (1 << 3))
+	else if (val & ONFI_VERSION_2_1)
 		chip->parameters.onfi.version = 21;
-	else if (val & (1 << 2))
+	else if (val & ONFI_VERSION_2_0)
 		chip->parameters.onfi.version = 20;
-	else if (val & (1 << 1))
+	else if (val & ONFI_VERSION_1_0)
 		chip->parameters.onfi.version = 10;
 
 	if (!chip->parameters.onfi.version) {
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index ef7e3b4e91ea..015bc3f2fc13 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -230,6 +230,17 @@ enum nand_ecc_algo {
 /* Keep gcc happy */
 struct nand_chip;
 
+/* ONFI version bits */
+#define ONFI_VERSION_1_0		BIT(1)
+#define ONFI_VERSION_2_0		BIT(2)
+#define ONFI_VERSION_2_1		BIT(3)
+#define ONFI_VERSION_2_2		BIT(4)
+#define ONFI_VERSION_2_3		BIT(5)
+#define ONFI_VERSION_3_0		BIT(6)
+#define ONFI_VERSION_3_1		BIT(7)
+#define ONFI_VERSION_3_2		BIT(8)
+#define ONFI_VERSION_4_0		BIT(9)
+
 /* ONFI features */
 #define ONFI_FEATURE_16_BIT_BUS		(1 << 0)
 #define ONFI_FEATURE_EXT_PARAM_PAGE	(1 << 7)
-- 
2.17.1

