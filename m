Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC812C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3CC208A4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LM9V0BdG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A5m8UB0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3CC208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933218AbeFTI5j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:57:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49554 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932756AbeFTIpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3C40960BEA; Wed, 20 Jun 2018 07:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479733;
        bh=0o9UaX6OlMlC14uc977Q2L5xn6v+M44C1rFiRFUatq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LM9V0BdGF0nFoQ2IvEWIPk9Fe3ziALVC9QXIHQIDYGbyeT3XdlnqcvdITw+6fRUu+
         dbQFuQpZaT0OEDF5KOkY68VDrS6aUmONTl3Lh9nixcGgmuy1Crg24uCo7HETNATaRJ
         OwAzYd3T8uN12aXgKgia4lcYXdWFjC7Aj4IwlxH4=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7294C60B19;
        Wed, 20 Jun 2018 07:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479731;
        bh=0o9UaX6OlMlC14uc977Q2L5xn6v+M44C1rFiRFUatq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5m8UB0ceI8t8WqAAtLmSxoENd1k/ey3/dNmlHmkm4WHc2oEV997rMtDMckEqb65t
         Y3KDlNZONOMd6vjjohyUcYWScwkJsCl8OGs/eY8tYtJjEreaK+BuMZU1mQNvUq4i85
         NuxtQte8+2pddINwK6/BnoUz+FVY9jQGBYOGqiBk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7294C60B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 15/15] mtd: rawnand: provide only single helper function for ECC conf
Date:   Wed, 20 Jun 2018 12:57:42 +0530
Message-Id: <1529479662-4026-16-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function nand_ecc_choose_conf() will be help for all the cases, so
other helper functions can be made static.

nand_check_ecc_caps(): Invoke nand_ecc_choose_conf() with
                       both chip->ecc.size and chip->ecc.strength
                       value set.

nand_maximize_ecc(): Invoke nand_ecc_choose_conf() with
                     NAND_ECC_MAXIMIZE flag.

nand_match_ecc_req(): Invoke nand_ecc_choose_conf() with either
                      chip->ecc.size or chip->ecc.strength value
                      set and without NAND_ECC_MAXIMIZE flag.

CC: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
Changes from v3:

NEW PATCH

 drivers/mtd/nand/raw/nand_base.c | 39 +++++++++++++++------------------------
 include/linux/mtd/rawnand.h      |  9 ---------
 2 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index c64e3fc..f620236 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -6077,24 +6077,17 @@ static int nand_set_ecc_soft_ops(struct mtd_info *mtd)
  * by the controller and the calculated ECC bytes fit within the chip's OOB.
  * On success, the calculated ECC bytes is set.
  */
-int nand_check_ecc_caps(struct nand_chip *chip,
-			const struct nand_ecc_caps *caps, int oobavail)
+static int
+nand_check_ecc_caps(struct nand_chip *chip,
+		    const struct nand_ecc_caps *caps, int oobavail)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	const struct nand_ecc_step_info *stepinfo;
 	int preset_step = chip->ecc.size;
 	int preset_strength = chip->ecc.strength;
-	int nsteps, ecc_bytes;
+	int ecc_bytes, nsteps = mtd->writesize / preset_step;
 	int i, j;
 
-	if (WARN_ON(oobavail < 0))
-		return -EINVAL;
-
-	if (!preset_step || !preset_strength)
-		return -ENODATA;
-
-	nsteps = mtd->writesize / preset_step;
-
 	for (i = 0; i < caps->nstepinfos; i++) {
 		stepinfo = &caps->stepinfos[i];
 
@@ -6127,7 +6120,6 @@ int nand_check_ecc_caps(struct nand_chip *chip,
 
 	return -ENOTSUPP;
 }
-EXPORT_SYMBOL_GPL(nand_check_ecc_caps);
 
 /**
  * nand_match_ecc_req - meet the chip's requirement with least ECC bytes
@@ -6139,8 +6131,9 @@ int nand_check_ecc_caps(struct nand_chip *chip,
  * number of ECC bytes (i.e. with the largest number of OOB-free bytes).
  * On success, the chosen ECC settings are set.
  */
-int nand_match_ecc_req(struct nand_chip *chip,
-		       const struct nand_ecc_caps *caps, int oobavail)
+static int
+nand_match_ecc_req(struct nand_chip *chip,
+		   const struct nand_ecc_caps *caps, int oobavail)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	const struct nand_ecc_step_info *stepinfo;
@@ -6151,9 +6144,6 @@ int nand_match_ecc_req(struct nand_chip *chip,
 	int best_ecc_bytes_total = INT_MAX;
 	int i, j;
 
-	if (WARN_ON(oobavail < 0))
-		return -EINVAL;
-
 	/* No information provided by the NAND chip */
 	if (!req_step || !req_strength)
 		return -ENOTSUPP;
@@ -6212,7 +6202,6 @@ int nand_match_ecc_req(struct nand_chip *chip,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nand_match_ecc_req);
 
 /**
  * nand_maximize_ecc - choose the max ECC strength available
@@ -6223,8 +6212,9 @@ int nand_match_ecc_req(struct nand_chip *chip,
  * Choose the max ECC strength that is supported on the controller, and can fit
  * within the chip's OOB.  On success, the chosen ECC settings are set.
  */
-int nand_maximize_ecc(struct nand_chip *chip,
-		      const struct nand_ecc_caps *caps, int oobavail)
+static int
+nand_maximize_ecc(struct nand_chip *chip,
+		  const struct nand_ecc_caps *caps, int oobavail)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	const struct nand_ecc_step_info *stepinfo;
@@ -6234,9 +6224,6 @@ int nand_maximize_ecc(struct nand_chip *chip,
 	int best_strength, best_ecc_bytes;
 	int i, j;
 
-	if (WARN_ON(oobavail < 0))
-		return -EINVAL;
-
 	for (i = 0; i < caps->nstepinfos; i++) {
 		stepinfo = &caps->stepinfos[i];
 		step_size = stepinfo->stepsize;
@@ -6285,7 +6272,6 @@ int nand_maximize_ecc(struct nand_chip *chip,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nand_maximize_ecc);
 
 /**
  * nand_ecc_choose_conf - Set the ECC strength and ECC step size
@@ -6307,6 +6293,11 @@ int nand_maximize_ecc(struct nand_chip *chip,
 int nand_ecc_choose_conf(struct nand_chip *chip,
 			 const struct nand_ecc_caps *caps, int oobavail)
 {
+	struct mtd_info *mtd = nand_to_mtd(chip);
+
+	if (WARN_ON(oobavail < 0 || oobavail > mtd->oobsize))
+		return -EINVAL;
+
 	if (chip->ecc.size && chip->ecc.strength)
 		return nand_check_ecc_caps(chip, caps, oobavail);
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 03a0061..0945868 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1641,15 +1641,6 @@ int nand_check_erased_ecc_chunk(void *data, int datalen,
 				void *extraoob, int extraooblen,
 				int threshold);
 
-int nand_check_ecc_caps(struct nand_chip *chip,
-			const struct nand_ecc_caps *caps, int oobavail);
-
-int nand_match_ecc_req(struct nand_chip *chip,
-		       const struct nand_ecc_caps *caps,  int oobavail);
-
-int nand_maximize_ecc(struct nand_chip *chip,
-		      const struct nand_ecc_caps *caps, int oobavail);
-
 int nand_ecc_choose_conf(struct nand_chip *chip,
 			 const struct nand_ecc_caps *caps, int oobavail);
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

