Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C8BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D75220836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iwVQbMV+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Jh/iXYs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D75220836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933085AbeFTI5g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:57:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932858AbeFTIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 332BF60B62; Wed, 20 Jun 2018 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479694;
        bh=MdPAtPQdZttTiELGEaRalu6bDPUoaiIDUe8pyutvMXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwVQbMV+VoPJADMDhy7y77xECWSki9o8qraV+awCFy3vXVjn8s5cJuCgTn+wIoPNr
         LcMKWvuH3hebRyVMkk0w6i7gb4ZrVediqrTK0NQKr8ubg6J4NDx1pKJTSXcT05h25u
         qv7rzSwamsYAfnZnsrq1mkk3uylZawORynSsEDnU=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E97E260B27;
        Wed, 20 Jun 2018 07:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479693;
        bh=MdPAtPQdZttTiELGEaRalu6bDPUoaiIDUe8pyutvMXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jh/iXYs3WvnU0z42B2k1qHjDN/6NN4+T+lC99G4ceDAPZ/hBu7q/eMfqBP8O3zRTX
         8qJ4EYLaDqxhW0Y+tk2nPmNwgGGEWltVDX8J/2sdiCis1BENNtkqsx51fYNvIZ6pAN
         52PcJ4h78Sl4t65nZRfMpUwjKp7EE1kRIvlgn6fo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E97E260B27
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
Subject: [PATCH v4 05/15] mtd: rawnand: qcom: use the ecc strength from device parameter
Date:   Wed, 20 Jun 2018 12:57:32 +0530
Message-Id: <1529479662-4026-6-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver uses the ECC strength specified in DT.
The QPIC/EBI2 NAND supports 4 or 8-bit ECC correction. The same
kind of board can have different NAND parts so use the ECC
strength from device parameters if it is not specified in DT.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
  1. Added parenthesis around (cwperpage * 4)

* Changes from v2:
  1. s/<< 2/* 4/
  2. Updated the cwperpage location
  3. The block handling the ecc-step-size property has been
     removed in a previous patch

* Changes from v1:

  1. Removed the custom logic and used the helper fuction.

 drivers/mtd/nand/raw/qcom_nandc.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index bf80a61..2375780 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2315,19 +2315,39 @@ static int qcom_nand_ooblayout_free(struct mtd_info *mtd, int section,
 	.free = qcom_nand_ooblayout_free,
 };
 
+static int
+qcom_nandc_calc_ecc_bytes(int step_size, int strength)
+{
+	return strength == 4 ? 12 : 16;
+}
+NAND_ECC_CAPS_SINGLE(qcom_nandc_ecc_caps, qcom_nandc_calc_ecc_bytes,
+		     NANDC_STEP_SIZE, 4, 8);
+
 static int qcom_nand_host_setup(struct qcom_nand_host *host)
 {
 	struct nand_chip *chip = &host->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	int cwperpage, bad_block_byte;
+	int cwperpage, bad_block_byte, ret;
 	bool wide_bus;
 	int ecc_mode = 1;
 
 	/* controller only supports 512 bytes data steps */
 	ecc->size = NANDC_STEP_SIZE;
 	wide_bus = chip->options & NAND_BUSWIDTH_16 ? true : false;
+	cwperpage = mtd->writesize / NANDC_STEP_SIZE;
+
+	/*
+	 * Each CW has 4 available OOB bytes which will be protected with ECC
+	 * so remaining bytes can be used for ECC.
+	 */
+	ret = nand_ecc_choose_conf(chip, &qcom_nandc_ecc_caps,
+				   mtd->oobsize - (cwperpage * 4));
+	if (ret) {
+		dev_err(nandc->dev, "No valid ECC settings possible\n");
+		return ret;
+	}
 
 	if (ecc->strength >= 8) {
 		/* 8 bit ECC defaults to BCH ECC on all platforms */
@@ -2396,7 +2416,6 @@ static int qcom_nand_host_setup(struct qcom_nand_host *host)
 
 	mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
 
-	cwperpage = mtd->writesize / ecc->size;
 	nandc->max_cwperpage = max_t(unsigned int, nandc->max_cwperpage,
 				     cwperpage);
 
@@ -2412,12 +2431,6 @@ static int qcom_nand_host_setup(struct qcom_nand_host *host)
 	 * for 8 bit ECC
 	 */
 	host->cw_size = host->cw_data + ecc->bytes;
-
-	if (ecc->bytes * (mtd->writesize / ecc->size) > mtd->oobsize) {
-		dev_err(nandc->dev, "ecc data doesn't fit in OOB area\n");
-		return -EINVAL;
-	}
-
 	bad_block_byte = mtd->writesize - host->cw_size * (cwperpage - 1) + 1;
 
 	host->cfg0 = (cwperpage - 1) << CW_PER_PAGE
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

