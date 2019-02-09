Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855D8C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544722070B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="TuUZdKTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfBITYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:24:06 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42382 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfBITYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:24:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549740241; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4tCVpj0ZLCCQiGRTUhuqZSKTObKEQ/2B03JHOjqX1AM=;
        b=TuUZdKTR852zXJK3oA5pIVrxbYMxutQnMBy5BZY3lh468kBMonLat9AFooCSnhhSiglg5y
        dMk/QxWADUFFZxu0T7OOpqGbuTWp5rjlXMF4vpJlfvJ8puVQpC3CFG987t7wfDxr/VAhvy
        hs8k1VVSf0SVuXuPZAWEWm5HbZ4ikG8=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 9/9] mtd: rawnand: ingenic: Add ooblayout for the Qi Ben Nanonote
Date:   Sat,  9 Feb 2019 16:23:05 -0300
Message-Id: <20190209192305.4434-9-paul@crapouillou.net>
In-Reply-To: <20190209192305.4434-1-paul@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ben Nanonote from Qi Hardware expects a specific OOB layout on its
NAND.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: New patch

v3: Use the qi,lb60 layout unconditionally if we detect that we're
    running on that board.

v4: No change

 drivers/mtd/nand/raw/ingenic/ingenic_nand.c | 41 ++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
index 4837bbce7099..3c4ad6d79764 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
@@ -72,6 +72,41 @@ static inline struct ingenic_nfc *to_ingenic_nfc(struct nand_controller *ctrl)
 	return container_of(ctrl, struct ingenic_nfc, controller);
 }
 
+static int qi_lb60_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	if (section || !ecc->total)
+		return -ERANGE;
+
+	oobregion->length = ecc->total;
+	oobregion->offset = 12;
+
+	return 0;
+}
+
+static int qi_lb60_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = mtd->oobsize - ecc->total - 12;
+	oobregion->offset = 12 + ecc->total;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops = {
+	.ecc = qi_lb60_ooblayout_ecc,
+	.free = qi_lb60_ooblayout_free,
+};
+
 static int jz4725b_ooblayout_ecc(struct mtd_info *mtd, int section,
 				 struct mtd_oob_region *oobregion)
 {
@@ -247,7 +282,11 @@ static int ingenic_nand_attach_chip(struct nand_chip *chip)
 		return -EINVAL;
 	}
 
-	mtd_set_ooblayout(mtd, nfc->soc_info->oob_layout);
+	/* For legacy reasons we use a different layout on the qi,lb60 board. */
+	if (of_machine_is_compatible("qi,lb60"))
+		mtd_set_ooblayout(mtd, &qi_lb60_ooblayout_ops);
+	else
+		mtd_set_ooblayout(mtd, nfc->soc_info->oob_layout);
 
 	return 0;
 }
-- 
2.11.0

