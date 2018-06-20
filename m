Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D6FC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5D620652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oaOMot0F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GNkf+TvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD5D620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933253AbeFTI5m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:57:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49550 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932269AbeFTIpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8CABA60B22; Wed, 20 Jun 2018 07:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479681;
        bh=pzadrc6s0gw4dN3aVQSYr9jYJbcZE8Q5gKt7Ce8bAgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaOMot0F1i2vICNtMn1HOWEt25j0iGgHiq6VlAUdL01xTkwg3eo/9gzOu/Sh+8nAY
         ZRwY5kLm9eu9h8H4HzrEMhTZr944u0BNatwUwev6TQAJvPVNE0PJTrM76d7y9x+O+X
         V2BJr/BWqpqTjD+nKTblNjzKXtc5W0MAfaLEC8/E=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6945660B14;
        Wed, 20 Jun 2018 07:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479680;
        bh=pzadrc6s0gw4dN3aVQSYr9jYJbcZE8Q5gKt7Ce8bAgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNkf+TvBTKNyCaFxdvGUsawxh1PmM0Gn9GsGqkXT2OTJY2bsDkYVEh5UjTVhO/KIG
         unPAn+bg0Zu8sh4SdoopfoB8vGBx8ILytRF1AQRc07vON32rwzyfK4Ax4SCHQvoVPt
         5yA2scGLAGUoVwNnzTHhbgmANPHwH1CnT/9mbshc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6945660B14
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
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v4 02/15] mtd: rawnand: denali: use helper function for ecc setup
Date:   Wed, 20 Jun 2018 12:57:29 +0530
Message-Id: <1529479662-4026-3-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the NAND core helper function nand_ecc_choose_conf to tune
the ECC parameters instead of the function locally defined.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
 NONE

* Changes from v2:

  1. Changed commit message

* Changes from v1:
  NEW PATCH

 drivers/mtd/nand/raw/denali.c | 30 ++----------------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 2a302a1..a586a1d 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1120,33 +1120,6 @@ int denali_calc_ecc_bytes(int step_size, int strength)
 }
 EXPORT_SYMBOL(denali_calc_ecc_bytes);
 
-static int denali_ecc_setup(struct mtd_info *mtd, struct nand_chip *chip,
-			    struct denali_nand_info *denali)
-{
-	int oobavail = mtd->oobsize - denali->oob_skip_bytes;
-	int ret;
-
-	/*
-	 * If .size and .strength are already set (usually by DT),
-	 * check if they are supported by this controller.
-	 */
-	if (chip->ecc.size && chip->ecc.strength)
-		return nand_check_ecc_caps(chip, denali->ecc_caps, oobavail);
-
-	/*
-	 * We want .size and .strength closest to the chip's requirement
-	 * unless NAND_ECC_MAXIMIZE is requested.
-	 */
-	if (!(chip->ecc.options & NAND_ECC_MAXIMIZE)) {
-		ret = nand_match_ecc_req(chip, denali->ecc_caps, oobavail);
-		if (!ret)
-			return 0;
-	}
-
-	/* Max ECC strength is the last thing we can do */
-	return nand_maximize_ecc(chip, denali->ecc_caps, oobavail);
-}
-
 static int denali_ooblayout_ecc(struct mtd_info *mtd, int section,
 				struct mtd_oob_region *oobregion)
 {
@@ -1317,7 +1290,8 @@ int denali_init(struct denali_nand_info *denali)
 	chip->ecc.mode = NAND_ECC_HW_SYNDROME;
 	chip->options |= NAND_NO_SUBPAGE_WRITE;
 
-	ret = denali_ecc_setup(mtd, chip, denali);
+	ret = nand_ecc_choose_conf(chip, denali->ecc_caps,
+				   mtd->oobsize - denali->oob_skip_bytes);
 	if (ret) {
 		dev_err(denali->dev, "Failed to setup ECC settings.\n");
 		goto disable_irq;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

