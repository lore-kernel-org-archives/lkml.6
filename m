Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C678AC282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A15B2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="h8tsc3Gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbfBDTF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:05:27 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48234 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfBDTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549307124; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vthIpkcg+W2fGl7aalmxWYYWdtCZSykAzyNauPZEVCc=;
        b=h8tsc3GhoJi2KmxKb45OxnZS6rm5kbHm113/y2fmniNbtRmNk6h6Y7y0YZmaYgJKpZRzAw
        fCOvhR6TOJgBDJB5cVm3A5ryhyWMxnCw8dnEQqxwgNPrAqVNsIdlafmJ9lsiyTqvY9r0NQ
        Y3fOyetMVPBySeD+CqAOWlDOZymghEY=
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
Subject: [PATCH v3 9/9] mtd: rawnand: ingenic: Add ooblayout for the Qi Ben Nanonote
Date:   Mon,  4 Feb 2019 16:04:26 -0300
Message-Id: <20190204190426.11618-9-paul@crapouillou.net>
In-Reply-To: <20190204190426.11618-1-paul@crapouillou.net>
References: <20190204190426.11618-1-paul@crapouillou.net>
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

 drivers/mtd/nand/raw/ingenic/ingenic_nand.c | 41 ++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
index 0e6d79993ff3..fc6309895162 100644
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

