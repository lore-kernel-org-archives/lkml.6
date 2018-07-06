Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC79C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3593D2409A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 07:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kEwJhQra";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ub9PMlpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3593D2409A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbeGFHwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 03:52:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34524 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753467AbeGFHw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 03:52:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E830F60B67; Fri,  6 Jul 2018 07:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530863546;
        bh=kPlWg2lP5ptOAnrn4Dj0PeLy1vx0pFNapKVBY+IXnTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEwJhQraVUUkrUZOXXHt8kOLmRsGo2AOgj/2PutzD7tNkVSAWq8lAq4KIurftsnyr
         nD0IRvSukV7uea4vEnhuNC37EHpdZNLHvHapc93lJbltcl1fH5ymf4bTuk12ax6Fw5
         bdngul3gtd8fsUSxuojjvnSYGhvffBx4k/QLQRjI=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19C4F60B67;
        Fri,  6 Jul 2018 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530863544;
        bh=kPlWg2lP5ptOAnrn4Dj0PeLy1vx0pFNapKVBY+IXnTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ub9PMlpxEF6pwQVcypfjbp6mSeI+CO+U1Q6Umv7gHrDp4weGZiJILGPpUX+00H9qv
         udXXgA+it/aP6+0yO26RLQ0iNMdkuH+GSUXPb3zAeQlyS4Bc4UobsJsnTRHmwb/Z0G
         4ORDJY1ZGTiUksPfyHSo/TrUxwt8N+j0rnFEShZQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19C4F60B67
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
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH 5/5] mtd: rawnand: qcom: reorganization by removing read/write helpers
Date:   Fri,  6 Jul 2018 13:21:59 +0530
Message-Id: <1530863519-5564-6-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver does not send the commands to NAND device for page
read/write operations in ->cmdfunc(). It just does some
minor variable initialization and rest of the things
are being done in actual ->read/write_oob[_raw].

The generic helper function calls for invoking commands during
page read/write are making this driver complicated. For QCOM NAND
driver, ->cmdfunc() does minor part of initialization and rest of
the initialization is performed by actual page read/write
functions. Also, ->read/write_oob() does not calls helper
function and all the initialization is being done in
->read/write_oob() itself.

Since after 'commit 25f815f66a14 ("mtd: nand: force drivers to
explicitly send READ/PROG commands")', sending of commands has
been moved to driver for page read/write, so this patch does
following changes to make code more readable:

1. Introduce qcom_nand_init_page_op() and qcom_nand_start_page_op()
   helper functions which helps in removing code duplication in each
   operation.

2. After issuing PROGRAM PAGE/BLOCK ERASE, QCOM NAND
   controller waits for BUSY signal to be de asserted and
   automatically issues the READ STATUS command. Currently, driver
   is storing this status privately and returns the same when status
   command comes from helper function after program/erase operation.
   Now, for write operations, the status can be returned from main
   function itself, so storing status can be removed for program
   operations.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 222 ++++++++++++++++----------------------
 1 file changed, 91 insertions(+), 131 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 6fb85d3..f73ee0e 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1382,39 +1382,37 @@ static void pre_command(struct qcom_nand_host *host, int command)
 	host->last_command = command;
 
 	clear_read_regs(nandc);
-
-	if (command == NAND_CMD_RESET || command == NAND_CMD_READID ||
-	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
-		clear_bam_transaction(nandc);
+	clear_bam_transaction(nandc);
 }
 
 /*
- * this is called after NAND_CMD_PAGEPROG and NAND_CMD_ERASE1 to set our
- * privately maintained status byte, this status byte can be read after
- * NAND_CMD_STATUS is called
+ * QCOM NAND controller by default issues READ STATUS command after PROGRAM
+ * PAGE/BLOCK ERASE operation and updates the same in its internal status
+ * register for last codeword. This function parses status for each CW and
+ * return actual status byte for write/erase operation.
  */
-static void parse_erase_write_errors(struct qcom_nand_host *host, int command)
+static u8 parse_erase_write_errors(struct qcom_nand_host *host, int num_cw)
 {
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	int num_cw;
 	int i;
+	u8 status = 0;
 
-	num_cw = command == NAND_CMD_PAGEPROG ? ecc->steps : 1;
 	nandc_read_buffer_sync(nandc, true);
 
 	for (i = 0; i < num_cw; i++) {
 		u32 flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
 
 		if (flash_status & FS_MPU_ERR)
-			host->status &= ~NAND_STATUS_WP;
+			status &= ~NAND_STATUS_WP;
 
 		if (flash_status & FS_OP_ERR || (i == (num_cw - 1) &&
 						 (flash_status &
 						  FS_DEVICE_STS_ERR)))
-			host->status |= NAND_STATUS_FAIL;
+			status |= NAND_STATUS_FAIL;
 	}
+
+	return status;
 }
 
 static void post_command(struct qcom_nand_host *host, int command)
@@ -1428,9 +1426,12 @@ static void post_command(struct qcom_nand_host *host, int command)
 		memcpy(nandc->data_buffer, nandc->reg_read_buf,
 		       nandc->buf_count);
 		break;
-	case NAND_CMD_PAGEPROG:
 	case NAND_CMD_ERASE1:
-		parse_erase_write_errors(host, command);
+		/*
+		 * update privately maintained status byte, this status byte can
+		 * be read after NAND_CMD_STATUS is called.
+		 */
+		host->status = parse_erase_write_errors(host, 1);
 		break;
 	default:
 		break;
@@ -1448,7 +1449,6 @@ static void qcom_nandc_command(struct mtd_info *mtd, unsigned int command,
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
 	struct qcom_nand_host *host = to_qcom_nand_host(chip);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	bool wait = false;
 	int ret = 0;
@@ -1477,23 +1477,6 @@ static void qcom_nandc_command(struct mtd_info *mtd, unsigned int command,
 		wait = true;
 		break;
 
-	case NAND_CMD_READ0:
-		/* we read the entire page for now */
-		WARN_ON(column != 0);
-
-		host->use_ecc = true;
-		set_address(host, 0, page_addr);
-		update_rw_regs(host, ecc->steps, true);
-		break;
-
-	case NAND_CMD_SEQIN:
-		WARN_ON(column != 0);
-		set_address(host, 0, page_addr);
-		break;
-
-	case NAND_CMD_PAGEPROG:
-	case NAND_CMD_STATUS:
-	case NAND_CMD_NONE:
 	default:
 		break;
 	}
@@ -1589,6 +1572,61 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 	return 0;
 }
 
+/* check if page write is successful */
+static int check_write_errors(struct qcom_nand_host *host, int cw_cnt)
+{
+	u8 status = parse_erase_write_errors(host, cw_cnt);
+
+	return (status & NAND_STATUS_FAIL) ? -EIO : 0;
+}
+
+/* performs the common init for page read/write operations */
+static void
+qcom_nand_init_page_op(struct qcom_nand_host *host, int num_cw, int page,
+		       u16 addr, bool read)
+{
+	struct nand_chip *chip = &host->chip;
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+
+	clear_read_regs(nandc);
+	clear_bam_transaction(nandc);
+	set_address(host, addr, page);
+	update_rw_regs(host, num_cw, read);
+	if (read)
+		config_nand_page_read(nandc);
+	else
+		config_nand_page_write(nandc);
+}
+
+/*
+ * Performs the page operation by submitting DMA descriptors and checks
+ * the errors. For read with ecc, the read function needs to do erased
+ * page detection so skips the error check.
+ */
+static int
+qcom_nand_start_page_op(struct qcom_nand_host *host, int num_cw, bool read)
+{
+	struct nand_chip *chip = &host->chip;
+	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
+	int ret;
+
+	ret = submit_descs(nandc);
+	free_descs(nandc);
+	if (ret) {
+		dev_err(nandc->dev, "%s operation failure\n",
+			read ? "READ" : "WRITE");
+		return ret;
+	}
+
+	if (!read)
+		return check_write_errors(host, num_cw);
+
+	if (!host->use_ecc)
+		return check_flash_errors(host, num_cw);
+
+	return 0;
+}
+
 /* performs raw read for one codeword */
 static int
 qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
@@ -1598,15 +1636,10 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	int data_size1, data_size2, oob_size1, oob_size2;
-	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
+	int reg_off = FLASH_BUF_ACC, read_loc = 0;
 
-	nand_read_page_op(chip, page, 0, NULL, 0);
 	host->use_ecc = false;
-
-	clear_bam_transaction(nandc);
-	set_address(host, host->cw_size * cw, page);
-	update_rw_regs(host, 1, true);
-	config_nand_page_read(nandc);
+	qcom_nand_init_page_op(host, 1, page, host->cw_size * cw, true);
 
 	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
 	oob_size1 = host->bbm_size;
@@ -1647,14 +1680,7 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 
 	read_data_dma(nandc, reg_off, oob_buf + oob_size1, oob_size2, 0);
 
-	ret = submit_descs(nandc);
-	free_descs(nandc);
-	if (ret) {
-		dev_err(nandc->dev, "failure to read raw cw %d\n", cw);
-		return ret;
-	}
-
-	return check_flash_errors(host, 1);
+	return qcom_nand_start_page_op(host, 1, true);
 }
 
 /*
@@ -1857,7 +1883,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 	int i, ret;
 
-	config_nand_page_read(nandc);
+	host->use_ecc = true;
+	qcom_nand_init_page_op(host, ecc->steps, page, 0, true);
 
 	/* queue cmd descs for each codeword */
 	for (i = 0; i < ecc->steps; i++) {
@@ -1914,13 +1941,9 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 			oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
-	free_descs(nandc);
-
-	if (ret) {
-		dev_err(nandc->dev, "failure to read page/oob\n");
+	ret = qcom_nand_start_page_op(host, ecc->steps, true);
+	if (ret)
 		return ret;
-	}
 
 	return parse_read_errors(host, data_buf_start, oob_buf_start, page);
 }
@@ -1929,17 +1952,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 static int qcom_nandc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 				uint8_t *buf, int oob_required, int page)
 {
-	struct qcom_nand_host *host = to_qcom_nand_host(chip);
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	u8 *data_buf, *oob_buf = NULL;
-
-	nand_read_page_op(chip, page, 0, NULL, 0);
-	data_buf = buf;
-	oob_buf = oob_required ? chip->oob_poi : NULL;
-
-	clear_bam_transaction(nandc);
-
-	return read_page_ecc(host, data_buf, oob_buf, page);
+	return read_page_ecc(to_qcom_nand_host(chip), buf,
+			     oob_required ? chip->oob_poi : NULL, page);
 }
 
 /* implements ecc->read_page_raw() */
@@ -1969,18 +1983,8 @@ static int qcom_nandc_read_page_raw(struct mtd_info *mtd,
 static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 			       int page)
 {
-	struct qcom_nand_host *host = to_qcom_nand_host(chip);
-	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
-	struct nand_ecc_ctrl *ecc = &chip->ecc;
-
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
-
-	host->use_ecc = true;
-	set_address(host, 0, page);
-	update_rw_regs(host, ecc->steps, true);
-
-	return read_page_ecc(host, NULL, chip->oob_poi, page);
+	return read_page_ecc(to_qcom_nand_host(chip), NULL,
+			     chip->oob_poi, page);
 }
 
 /* implements ecc->write_page() */
@@ -1991,19 +1995,12 @@ static int qcom_nandc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *data_buf, *oob_buf;
-	int i, ret;
-
-	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	int i;
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
-
 	host->use_ecc = true;
-	update_rw_regs(host, ecc->steps, false);
-	config_nand_page_write(nandc);
+	qcom_nand_init_page_op(host, ecc->steps, page, 0, false);
 
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size, oob_size;
@@ -2041,16 +2038,7 @@ static int qcom_nandc_write_page(struct mtd_info *mtd, struct nand_chip *chip,
 		oob_buf += oob_size;
 	}
 
-	ret = submit_descs(nandc);
-	if (ret)
-		dev_err(nandc->dev, "failure to write page\n");
-
-	free_descs(nandc);
-
-	if (!ret)
-		ret = nand_prog_page_end_op(chip);
-
-	return ret;
+	return qcom_nand_start_page_op(host, ecc->steps, false);
 }
 
 /* implements ecc->write_page_raw() */
@@ -2062,18 +2050,13 @@ static int qcom_nandc_write_page_raw(struct mtd_info *mtd,
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *data_buf, *oob_buf;
-	int i, ret;
-
-	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
-	clear_read_regs(nandc);
-	clear_bam_transaction(nandc);
+	int i;
 
 	data_buf = (u8 *)buf;
 	oob_buf = chip->oob_poi;
 
 	host->use_ecc = false;
-	update_rw_regs(host, ecc->steps, false);
-	config_nand_page_write(nandc);
+	qcom_nand_init_page_op(host, ecc->steps, page, 0, false);
 
 	for (i = 0; i < ecc->steps; i++) {
 		int data_size1, data_size2, oob_size1, oob_size2;
@@ -2113,16 +2096,7 @@ static int qcom_nandc_write_page_raw(struct mtd_info *mtd,
 		config_nand_cw_write(nandc);
 	}
 
-	ret = submit_descs(nandc);
-	if (ret)
-		dev_err(nandc->dev, "failure to write raw page\n");
-
-	free_descs(nandc);
-
-	if (!ret)
-		ret = nand_prog_page_end_op(chip);
-
-	return ret;
+	return qcom_nand_start_page_op(host, ecc->steps, false);
 }
 
 /*
@@ -2140,9 +2114,6 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	u8 *oob = chip->oob_poi, bbm_byte;
 	int data_size, oob_size, bbm_offset, write_size;
-	int ret;
-
-	clear_bam_transaction(nandc);
 
 	/*
 	 * The NAND base layer calls ecc->write_oob() by setting bytes at
@@ -2183,24 +2154,13 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 		write_size = data_size + oob_size;
 	}
 
-	set_address(host, host->cw_size * (ecc->steps - 1), page);
-	update_rw_regs(host, 1, false);
-
-	config_nand_page_write(nandc);
+	qcom_nand_init_page_op(host, 1, page,
+			       host->cw_size * (ecc->steps - 1), false);
 	write_data_dma(nandc, FLASH_BUF_ACC,
 		       nandc->data_buffer, write_size, 0);
 	config_nand_cw_write(nandc);
 
-	ret = submit_descs(nandc);
-
-	free_descs(nandc);
-
-	if (ret) {
-		dev_err(nandc->dev, "failure to write oob\n");
-		return -EIO;
-	}
-
-	return nand_prog_page_end_op(chip);
+	return qcom_nand_start_page_op(host, 1, false);
 }
 
 /*
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

