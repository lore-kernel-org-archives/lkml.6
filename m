Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FB9C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3872420846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X5/g9SCU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M1dIOHRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3872420846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbeFTIvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:51:53 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932552AbeFTIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BE9E360B14; Wed, 20 Jun 2018 07:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479721;
        bh=gcPPzcOJhf3N2bOo1iYtxuUu4qDfNe+lICRZ/U5PNcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X5/g9SCU0EuEoYofbcp16zmUPVPST3G7OnLp0zL+sqegIHY+fQ5tILG+4u5KaJon1
         /pRc7e6CblP/l0eHttvGZk7oVIMfOxLfOUB3gj1BwHqb71eUzBJeUO9yjrRuYnVDLX
         ceuazruNhCe6hHv4vyI94zgGu5lnKgPjpjB0O2fg=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06D6B60B14;
        Wed, 20 Jun 2018 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479720;
        bh=gcPPzcOJhf3N2bOo1iYtxuUu4qDfNe+lICRZ/U5PNcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1dIOHRpyux6A+/TQAJyv2f5BsqTpDzGPvZNiPpHSfaeVT7sfwNF9cjm6priPYdqf
         +FzvXLSJ2EDt0vl68jh6Z54YuaiTwbc75NaS9ohdIuHPPYMimIVUZxPW+Prqik0BDq
         ivUtE0vT5yMcyWdFndShff3xYTtd021KgTNkMj0I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06D6B60B14
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
Subject: [PATCH v4 12/15] mtd: rawnand: qcom: check for operation errors in case of raw read
Date:   Wed, 20 Jun 2018 12:57:39 +0530
Message-Id: <1529479662-4026-13-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no error checking for raw read. For raw
reads, there won’t be any ECC failure but the operational
failures are possible, so schedule the NAND_FLASH_STATUS read
after each codeword.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
 1. Since bad block reorganization patch has removed from this
    patch series so following change is required in copy_last_cw)
    config_nand_single_cw_page_read(nandc);
    -> config_nand_single_cw_page_read(nandc, host->use_ecc);

* Changes from v2:
  NONE

* Changes from v1:
 1. Removed the code for copy_last_cw.

 drivers/mtd/nand/raw/qcom_nandc.c | 58 +++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 887b1f6..5999c39 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1096,7 +1096,8 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
  * Helper to prepare DMA descriptors for configuring registers
  * before reading each codeword in NAND page.
  */
-static void config_nand_cw_read(struct qcom_nand_controller *nandc)
+static void
+config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
 {
 	if (nandc->props->is_bam)
 		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
@@ -1105,19 +1106,25 @@ static void config_nand_cw_read(struct qcom_nand_controller *nandc)
 	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
 	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 
-	read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
-	read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
-		     NAND_BAM_NEXT_SGL);
+	if (use_ecc) {
+		read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
+		read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
+			     NAND_BAM_NEXT_SGL);
+	} else {
+		read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
+	}
 }
 
 /*
  * Helper to prepare dma descriptors to configure registers needed for reading a
  * single codeword in page
  */
-static void config_nand_single_cw_page_read(struct qcom_nand_controller *nandc)
+static void
+config_nand_single_cw_page_read(struct qcom_nand_controller *nandc,
+				bool use_ecc)
 {
 	config_nand_page_read(nandc);
-	config_nand_cw_read(nandc);
+	config_nand_cw_read(nandc, use_ecc);
 }
 
 /*
@@ -1198,7 +1205,7 @@ static int nandc_param(struct qcom_nand_host *host)
 	nandc->buf_count = 512;
 	memset(nandc->data_buffer, 0xff, nandc->buf_count);
 
-	config_nand_single_cw_page_read(nandc);
+	config_nand_single_cw_page_read(nandc, false);
 
 	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
 		      nandc->buf_count, 0);
@@ -1563,6 +1570,23 @@ struct read_stats {
 	__le32 erased_cw;
 };
 
+/* reads back FLASH_STATUS register set by the controller */
+static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
+{
+	struct nand_chip *chip = &host->chip;
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	int i;
+
+	for (i = 0; i < cw_cnt; i++) {
+		u32 flash = le32_to_cpu(nandc->reg_read_buf[i]);
+
+		if (flash & (FS_OP_ERR | FS_MPU_ERR))
+			return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * reads back status registers set by the controller to notify page read
  * errors. this is equivalent to what 'ecc->correct()' would do.
@@ -1729,7 +1753,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			}
 		}
 
-		config_nand_cw_read(nandc);
+		config_nand_cw_read(nandc, true);
 
 		if (data_buf)
 			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
@@ -1791,7 +1815,7 @@ static int copy_last_cw(struct qcom_nand_host *host, int page)
 	set_address(host, host->cw_size * (ecc->steps - 1), page);
 	update_rw_regs(host, 1, true);
 
-	config_nand_single_cw_page_read(nandc);
+	config_nand_single_cw_page_read(nandc, host->use_ecc);
 
 	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
 
@@ -1874,7 +1898,7 @@ static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
 			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
 		}
 
-		config_nand_cw_read(nandc);
+		config_nand_cw_read(nandc, false);
 
 		read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
 		reg_off += data_size1;
@@ -1893,12 +1917,13 @@ static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
 	}
 
 	ret = submit_descs(nandc);
-	if (ret)
+	free_descs(nandc);
+	if (ret) {
 		dev_err(nandc->dev, "failure to read raw page\n");
+		return ret;
+	}
 
-	free_descs(nandc);
-
-	return ret;
+	return check_flash_errors(host, ecc->steps);
 }
 
 /* implements ecc->read_oob() */
@@ -2117,7 +2142,6 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int page, ret, bbpos, bad = 0;
-	u32 flash_status;
 
 	page = (int)(ofs >> chip->page_shift) & chip->pagemask;
 
@@ -2134,9 +2158,7 @@ static int qcom_nandc_block_bad(struct mtd_info *mtd, loff_t ofs)
 	if (ret)
 		goto err;
 
-	flash_status = le32_to_cpu(nandc->reg_read_buf[0]);
-
-	if (flash_status & (FS_OP_ERR | FS_MPU_ERR)) {
+	if (check_flash_errors(host, 1)) {
 		dev_warn(nandc->dev, "error when trying to read BBM\n");
 		goto err;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

