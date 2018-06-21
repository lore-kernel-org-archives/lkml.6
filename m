Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A60C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12004208B7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="hHHsXVil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12004208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbeFUKdq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:33:46 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:52127 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932944AbeFUKdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:33:43 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6FE0F8365F;
        Thu, 21 Jun 2018 22:33:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529577221;
        bh=Ly2vYIasQ6ZPYVBRLDLrVaGhnS3D5anDj4miNCHHEq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hHHsXVil3l/w/UTxrgyMrvthVy86eeCWGL4wgjgSrCGQDO8u7pmet2Q/Cc70Fl4ZC
         mA87qzqMpOB41wF7uOnRHhnZYNbm98E84CiJlA3Asx5msY0+iRaaGdzuIj0XkaXA0Q
         t8ujIMq1u5wDccrTPjpD2xUfMd7ZQMiRmWAFlk9s=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2b7f050001>; Thu, 21 Jun 2018 22:33:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id A8A3B13EFC9;
        Thu, 21 Jun 2018 22:33:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 7468B1E2626; Thu, 21 Jun 2018 22:33:37 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v4 6/6] mtd: rawnand: micron: detect forced on-die ECC
Date:   Thu, 21 Jun 2018 22:33:28 +1200
Message-Id: <20180621103328.28206-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621103328.28206-1-chris.packham@alliedtelesis.co.nz>
References: <20180621103328.28206-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Micron NAND chips have on-die ECC forceably enabled. The detect
these based on chip ID as there seems to be no other way of
distinguishing these chips from those that have optional support for
on-die ECC.

When a chip with mandatory on-die ECC is detected change the current ECC
mode to on-die.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
I'm not convinced that just changing chip->ecc.mode is sensible. An
alternative I considered was only proceeding if the ecc.mode is set to
ON_DIE.

Changes in v4:
- New

 drivers/mtd/nand/raw/nand_micron.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index f1ecd4986b50..9ba9007a9a06 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -227,6 +227,14 @@ enum {
 	MICRON_ON_DIE_MANDATORY,
 };
 
+/*
+ * These parts are known to have on-die ECC forceably enabled
+ */
+static u8 micron_on_die_ecc[] = {
+	0xd1, /* MT29F1G08ABAFA */
+	0xa1, /* MT29F1G08ABBFA */
+};
+
 /*
  * Try to detect if the NAND support on-die ECC. To do this, we enable
  * the feature, and read back if it has been enabled as expected. We
@@ -241,6 +249,11 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
 {
 	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = { 0, };
 	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(micron_on_die_ecc); i++)
+		if (chip->id.data[1] == micron_on_die_ecc[i])
+			return MICRON_ON_DIE_MANDATORY;
 
 	if (!chip->parameters.onfi.version)
 		return MICRON_ON_DIE_UNSUPPORTED;
@@ -289,8 +302,8 @@ static int micron_nand_init(struct nand_chip *chip)
 	ondie = micron_supports_on_die_ecc(chip);
 
 	if (ondie == MICRON_ON_DIE_MANDATORY) {
-		pr_err("On-die ECC forcefully enabled, not supported\n");
-		return -EINVAL;
+		pr_info("On-die ECC forcefully enabled\n");
+		chip->ecc.mode = NAND_ECC_ON_DIE;
 	}
 
 	if (chip->ecc.mode == NAND_ECC_ON_DIE) {
-- 
2.17.1

