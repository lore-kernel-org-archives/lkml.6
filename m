Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E81DC1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F0420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oJWvgfSn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZTYQrDCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F0420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933110AbeFTIwV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:52:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49636 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754084AbeFTIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C83CA60B81; Wed, 20 Jun 2018 07:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479709;
        bh=vKqOAbGs/MymQoeZdna2c6Zbz8j39+1dj051jUWWzLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJWvgfSnGyNxddRdy88c/3JhcJadfXkFQ8BNxbhvPjwMBXxs4+T1LYXNL19vk9Hyc
         ficyordA+RBHiorRDOTbxqbwNUALp3kk7VXWdI+AuKQCJzmyqPGrbMrCxS2YRbzJ7I
         R4AYdgyoFH2UOmoc64k0eXSXgh2soiPpec9qq9RM=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 872C960B19;
        Wed, 20 Jun 2018 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479708;
        bh=vKqOAbGs/MymQoeZdna2c6Zbz8j39+1dj051jUWWzLY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTYQrDCdC0MEwLox6E1yYnk10A/eqXn9vaVYf2BMNybOx9NTJ6l0tr3/WsQNA74O7
         ziABLB+ZPCpe1MYKD0fHqpy/wI1/K31VrAidF2gd4wlEVpijR2luFFeeyGkAqmgsmS
         gNFG4QWnVVWtt41M9s0nUj9zRNNqOeOTqDLleoXo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 872C960B19
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
Subject: [PATCH v4 09/15] mtd: rawnand: qcom: parse read errors for read oob also
Date:   Wed, 20 Jun 2018 12:57:36 +0530
Message-Id: <1529479662-4026-10-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_page and read_oob both calls the read_page_ecc function.
The QCOM NAND controller protect the OOB available bytes with
ECC so read errors should be checked for read_oob also.
This patch moves the error checking code inside read_page_ecc
so caller does not have to check explicitly for read errors.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
  NONE

* Changes from v2:
  NONE

* Changes from v1:
  1. Minor code change for return early in case of error

 drivers/mtd/nand/raw/qcom_nandc.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index a831f9c..285b2ad3 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1698,6 +1698,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 	int i, ret;
 
 	config_nand_page_read(nandc);
@@ -1758,12 +1759,14 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	}
 
 	ret = submit_descs(nandc);
-	if (ret)
+	free_descs(nandc);
+
+	if (ret) {
 		dev_err(nandc->dev, "failure to read page/oob\n");
+		return ret;
+	}
 
-	free_descs(nandc);
-
-	return ret;
+	return parse_read_errors(host, data_buf_start, oob_buf_start);
 }
 
 /*
@@ -1808,20 +1811,14 @@ static int qcom_nandc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	u8 *data_buf, *oob_buf = NULL;
-	int ret;
 
 	nand_read_page_op(chip, page, 0, NULL, 0);
 	data_buf = buf;
 	oob_buf = oob_required ? chip->oob_poi : NULL;
 
 	clear_bam_transaction(nandc);
-	ret = read_page_ecc(host, data_buf, oob_buf);
-	if (ret) {
-		dev_err(nandc->dev, "failure to read page\n");
-		return ret;
-	}
 
-	return parse_read_errors(host, data_buf, oob_buf);
+	return read_page_ecc(host, data_buf, oob_buf);
 }
 
 /* implements ecc->read_page_raw() */
@@ -1911,7 +1908,6 @@ static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	int ret;
 
 	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
@@ -1920,11 +1916,7 @@ static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	set_address(host, 0, page);
 	update_rw_regs(host, ecc->steps, true);
 
-	ret = read_page_ecc(host, NULL, chip->oob_poi);
-	if (ret)
-		dev_err(nandc->dev, "failure to read oob\n");
-
-	return ret;
+	return read_page_ecc(host, NULL, chip->oob_poi);
 }
 
 /* implements ecc->write_page() */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

