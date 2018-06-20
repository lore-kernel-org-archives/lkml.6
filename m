Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E11C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9001620652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="H9J3+mHK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b0hTaK87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9001620652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933013AbeFTI5d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:57:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49590 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932862AbeFTIpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 681F360BE3; Wed, 20 Jun 2018 07:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479725;
        bh=kqWQOOk0xz9efo42aAJtuF+eDiEPhgy6Il3gCDA8Ufc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H9J3+mHKwhzXv1TexJtl/vYMWMW6uqRwJonxreq/RTUjGIBQYalgMcibINbgK6owM
         qHlSMjFR3Erdi/D/OOw2NwNRo5v+wKLGxyw2iGkBYqXwc+Db6yQav1oSHZSbR8W1Nm
         h5UWFIihac48pqh8982WVKHcbaenVs2AqhFOHitU=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D05E660B19;
        Wed, 20 Jun 2018 07:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479724;
        bh=kqWQOOk0xz9efo42aAJtuF+eDiEPhgy6Il3gCDA8Ufc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0hTaK87/lCEjMpHoRXUl7MHu4AvQ8shryGU+uLk+g3mjOi2cvobr6JE8833gDpdM
         LMzIaIIhzDm5mDpKMQt7lHHvGsp/c0bJHGe1FLMCjDWY9Pl7+uRp/JI9cBFl7InWZo
         9yeXFz8233fCMRyJosC43fw1lEbLZIgnAp4dN5s8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D05E660B19
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
Subject: [PATCH v4 13/15] mtd: rawnand: qcom: code reorganization for raw read
Date:   Wed, 20 Jun 2018 12:57:40 +0530
Message-Id: <1529479662-4026-14-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make separate function to perform raw read for one codeword and
call this function multiple times for each codeword in case of
raw page read. This separate function will help in subsequent
patches related with erased codeword bitflip detection.

It will decrease throughput for raw page read. Raw page read
is used for debug purpose so it won't affect normal flash
operations.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
  1. Major code changes for making separate function for raw_read
  2. Changed commit message

* Changes from v2:
  NONE

* Changes from v1:
 1. Included more detail in function comment

 drivers/mtd/nand/raw/qcom_nandc.c | 146 ++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 68 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 5999c39..160acdf 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1587,6 +1587,74 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 	return 0;
 }
 
+/* performs raw read for one codeword */
+static int
+qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
+		       u8 *data_buf, u8 *oob_buf, int page, int cw)
+{
+	struct qcom_nand_host *host = to_qcom_nand_host(chip);
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	int data_size1, data_size2, oob_size1, oob_size2;
+	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
+
+	nand_read_page_op(chip, page, 0, NULL, 0);
+	host->use_ecc = false;
+
+	clear_bam_transaction(nandc);
+	set_address(host, host->cw_size * cw, page);
+	update_rw_regs(host, 1, true);
+	config_nand_page_read(nandc);
+
+	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
+	oob_size1 = host->bbm_size;
+
+	if (cw == (ecc->steps - 1)) {
+		data_size2 = ecc->size - data_size1 -
+			     ((ecc->steps - 1) * 4);
+		oob_size2 = (ecc->steps * 4) + host->ecc_bytes_hw +
+			    host->spare_bytes;
+	} else {
+		data_size2 = host->cw_data - data_size1;
+		oob_size2 = host->ecc_bytes_hw + host->spare_bytes;
+	}
+
+	if (nandc->props->is_bam) {
+		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
+		read_loc += data_size1;
+
+		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
+		read_loc += oob_size1;
+
+		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
+		read_loc += data_size2;
+
+		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
+	}
+
+	config_nand_cw_read(nandc, false);
+
+	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
+	reg_off += data_size1;
+
+	read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
+	reg_off += oob_size1;
+
+	read_data_dma(nandc, reg_off, data_buf + data_size1, data_size2, 0);
+	reg_off += data_size2;
+
+	read_data_dma(nandc, reg_off, oob_buf + oob_size1, oob_size2, 0);
+
+	ret = submit_descs(nandc);
+	free_descs(nandc);
+	if (ret) {
+		dev_err(nandc->dev, "failure to read raw cw %d\n", cw);
+		return ret;
+	}
+
+	return check_flash_errors(host, 1);
+}
+
 /*
  * reads back status registers set by the controller to notify page read
  * errors. this is equivalent to what 'ecc->correct()' would do.
@@ -1851,79 +1919,21 @@ static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
 				    int oob_required, int page)
 {
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	u8 *data_buf, *oob_buf;
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	int i, ret;
-	int read_loc;
+	int cw, ret;
+	u8 *data_buf = buf, *oob_buf = chip->oob_poi;
 
-	nand_read_page_op(chip, page, 0, NULL, 0);
-	data_buf = buf;
-	oob_buf = chip->oob_poi;
+	for (cw = 0; cw < ecc->steps; cw++) {
+		ret = qcom_nandc_read_cw_raw(mtd, chip, data_buf, oob_buf,
+					     page, cw);
+		if (ret)
+			return ret;
 
-	host->use_ecc = false;
-
-	clear_bam_transaction(nandc);
-	update_rw_regs(host, ecc->steps, true);
-	config_nand_page_read(nandc);
-
-	for (i = 0; i < ecc->steps; i++) {
-		int data_size1, data_size2, oob_size1, oob_size2;
-		int reg_off = FLASH_BUF_ACC;
-
-		data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
-		oob_size1 = host->bbm_size;
-
-		if (i == (ecc->steps - 1)) {
-			data_size2 = ecc->size - data_size1 -
-				     ((ecc->steps - 1) << 2);
-			oob_size2 = (ecc->steps << 2) + host->ecc_bytes_hw +
-				    host->spare_bytes;
-		} else {
-			data_size2 = host->cw_data - data_size1;
-			oob_size2 = host->ecc_bytes_hw + host->spare_bytes;
-		}
-
-		if (nandc->props->is_bam) {
-			read_loc = 0;
-			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
-			read_loc += data_size1;
-
-			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
-			read_loc += oob_size1;
-
-			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
-			read_loc += data_size2;
-
-			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
-		}
-
-		config_nand_cw_read(nandc, false);
-
-		read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
-		reg_off += data_size1;
-		data_buf += data_size1;
-
-		read_data_dma(nandc, reg_off, oob_buf, oob_size1, 0);
-		reg_off += oob_size1;
-		oob_buf += oob_size1;
-
-		read_data_dma(nandc, reg_off, data_buf, data_size2, 0);
-		reg_off += data_size2;
-		data_buf += data_size2;
-
-		read_data_dma(nandc, reg_off, oob_buf, oob_size2, 0);
-		oob_buf += oob_size2;
-	}
-
-	ret = submit_descs(nandc);
-	free_descs(nandc);
-	if (ret) {
-		dev_err(nandc->dev, "failure to read raw page\n");
-		return ret;
+		data_buf += host->cw_data;
+		oob_buf += ecc->bytes;
 	}
 
-	return check_flash_errors(host, ecc->steps);
+	return 0;
 }
 
 /* implements ecc->read_oob() */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

