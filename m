Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7ECC282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD3921479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 23:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="yR5u+quP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfBBXUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 18:20:14 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:53260 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfBBXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 18:20:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549149609; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vVN5VtadRVOJSLQl/c/1jRVzXuFZu0B1bzeIau0Tvdw=;
        b=yR5u+quPqVo06NiV7bOYHcvs2r1r/zdVFBZTsf7SYSQ0ndCXbLWQqpKlNpb+irZvnHplAb
        m7meO7ch8WzXtxUXXvHWEpXVsoIFVcdkSwAnETXgb5onXheo2yP3ZZ5B1dWYAEFtjr1Xuh
        RYv13uFNEFVn5PC+owvkOLigPkuVQJ4=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 5/9] mtd: rawnand: jz4780: Add ooblayout for the JZ4725B
Date:   Sat,  2 Feb 2019 20:19:22 -0300
Message-Id: <20190202231926.2444-6-paul@crapouillou.net>
In-Reply-To: <20190202231926.2444-1-paul@crapouillou.net>
References: <20190202231926.2444-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot ROM of the JZ4725B SoC expects a specific OOB layout on the
NAND.

Add an optional "ingenic,oob-layout" device property. When set to
"ingenic,jz4725b", this specific OOB layout is used.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: Instead of forcing the OOB layout, leave it to the board code or
    devicetree to decide if the jz4725b-specific layout should be used
    or not.

 drivers/mtd/nand/raw/ingenic/jz4780_nand.c | 51 +++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
index c0855fef7735..baebb9a5c7c8 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
@@ -44,6 +44,7 @@ struct jz4780_nand_cs {
 struct jz4780_nand_controller {
 	struct device *dev;
 	const struct jz_soc_info *soc_info;
+	const struct mtd_ooblayout_ops *oob_layout;
 	struct jz4780_bch *bch;
 	struct nand_controller controller;
 	unsigned int num_banks;
@@ -213,7 +214,7 @@ static int jz4780_nand_attach_chip(struct nand_chip *chip)
 		return -EINVAL;
 	}
 
-	mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
+	mtd_set_ooblayout(mtd, nfc->oob_layout);
 
 	return 0;
 }
@@ -345,11 +346,47 @@ static int jz4780_nand_init_chips(struct jz4780_nand_controller *nfc,
 	return 0;
 }
 
+static int jz4725b_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	if (section || !ecc->total)
+		return -ERANGE;
+
+	oobregion->length = ecc->total;
+	oobregion->offset = 3;
+
+	return 0;
+}
+
+static int jz4725b_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = mtd->oobsize - ecc->total - 3;
+	oobregion->offset = 3 + ecc->total;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops jz4725b_ooblayout_ops = {
+	.ecc = jz4725b_ooblayout_ecc,
+	.free = jz4725b_ooblayout_free,
+};
+
 static int jz4780_nand_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	unsigned int num_banks;
 	struct jz4780_nand_controller *nfc;
+	const char *layout;
 	int ret;
 
 	num_banks = jz4780_nemc_num_banks(dev);
@@ -366,6 +403,18 @@ static int jz4780_nand_probe(struct platform_device *pdev)
 	if (!nfc->soc_info)
 		return -EINVAL;
 
+	nfc->oob_layout = &nand_ooblayout_lp_ops;
+
+	ret = device_property_read_string(dev, "ingenic,oob-layout", &layout);
+	if (!ret) {
+		if (!strcmp(layout, "ingenic,jz4725b")) {
+			nfc->oob_layout  = &jz4725b_ooblayout_ops;
+		} else {
+			dev_err(dev, "Unrecognized OOB layout %s\n", layout);
+			return -EINVAL;
+		}
+	}
+
 	/*
 	 * Check for BCH HW before we call nand_scan_ident, to prevent us from
 	 * having to call it again if the BCH driver returns -EPROBE_DEFER.
-- 
2.20.1

