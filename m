Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C44BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0244624C8E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RVNwY27D";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JGdBeAQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0244624C8E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeGCMGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:06:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43530 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbeGCMGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:06:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B08E607DC; Tue,  3 Jul 2018 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530619582;
        bh=hcs23kT/RnGU7gRwQNJaI4clZ+LpZKCC+o550l/RQcw=;
        h=From:To:Cc:Subject:Date:From;
        b=RVNwY27DJ8P0ZWjfsjXIX5Ot6tqUE6/eAcX3aQ/a4NSpS7C7sup+opSVqCmAlruQj
         A0lZ0xJ7y3qKuKz4OjvUo6hMi8htAWS4Cl9jIsZaBMBg6qk/Pniednc9/CIbgVKqfj
         oWxjgrTdkDNHRIuVfyUZzmUmpUw9waWyymKWOEro=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F05F6063F;
        Tue,  3 Jul 2018 12:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530619581;
        bh=hcs23kT/RnGU7gRwQNJaI4clZ+LpZKCC+o550l/RQcw=;
        h=From:To:Cc:Subject:Date:From;
        b=JGdBeAQ+cj+/rRMGKPYdnIvx1j3ZkL6TEByEvk4391rAjXgQtlrdQE7Sc3mT0FUml
         hMphXp+b41jMNazIrbUjwK74BXlT1KvkJmxvE2hcM3fv5sNRhXrEdxmINbZpGE1huu
         oRlRuObjRtpSa3qY2w5EKKMqwLRvXH5pyYL0Hw0E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F05F6063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v5] mtd: rawnand: qcom: erased page bitflips detection
Date:   Tue,  3 Jul 2018 17:36:03 +0530
Message-Id: <1530619563-24712-1-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAND parts can have bitflips in an erased page due to the
process technology used. In this case, QCOM NAND controller
is not able to identify that page as an erased page.
Currently the driver calls nand_check_erased_ecc_chunk() for
identifying the erased pages but this won’t work always since the
checking is being with ECC engine returned data. In case of
bitflips, the ECC engine tries to correct the data and then it
generates the uncorrectable error. Now, this data is not equal to
original raw data. For erased CW identification, the raw data
should be read again from NAND device and this
nand_check_erased_ecc_chunk function() should be called for raw
data only.

Now following logic is being added to identify the erased
codeword bitflips.

1. In most of the cases, not all the codewords will have bitflips
   and only single CW will have bitflips. So, there is no need to
   read the complete raw page data. The NAND raw read can be
   scheduled for any CW in page. The NAND controller works on CW
   basis and it will update the status register after each CW read.
   Maintain the bitmask for the CW which generated the uncorrectable
   error.
2. Do raw read for all the CW's which generated the uncorrectable
   error.
3. Both DATA and OOB need to be checked for number of 0. The
   top-level API can be called with only data buf or OOB buf so use
   chip->databuf if data buf is null and chip->oob_poi if
   OOB buf is null for copying the raw bytes temporarily.
4. For each CW, check the number of 0 in cw_data and usable
   oob bytes, The bbm and spare (unused) bytes bit flip won’t
   affect the ECC so don’t check the number of bitflips in this area.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v4:

 1. Used for_each_set_bit for determining CW’s which generated
    uncorrectable errors.
 2. Introduced cw_data_buf and cw_oob_buf which will have starting
    buffer address for current codeword and used the same in helper
    functions.
 3. Added new line before calling of nand_check_erased_ecc_chunk for
    better code readability.

* Changes from v3:

 1. Major changes in erased codeword detection for
    raw read function

* Changes from v2:
  NONE

* Changes from v1:
 1. Minor change in commit message
 2. invalidate pagebuf if databuf or oob_poi is used

 drivers/mtd/nand/raw/qcom_nandc.c | 126 +++++++++++++++++++++++++++-----------
 1 file changed, 89 insertions(+), 37 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 160acdf..994f980 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1656,20 +1656,94 @@ static int check_flash_errors(struct qcom_nand_host *host, int cw_cnt)
 }
 
 /*
+ * Bitflips can happen in erased codewords also so this function counts the
+ * number of 0 in each CW for which ECC engine returns the uncorrectable
+ * error. The page will be assumed as erased if this count is less than or
+ * equal to the ecc->strength for each CW.
+ *
+ * 1. Both DATA and OOB need to be checked for number of 0. The
+ *    top-level API can be called with only data buf or OOB buf so use
+ *    chip->data_buf if data buf is null and chip->oob_poi if oob buf
+ *    is null for copying the raw bytes.
+ * 2. Perform raw read for all the CW which has uncorrectable errors.
+ * 3. For each CW, check the number of 0 in cw_data and usable OOB bytes.
+ *    The BBM and spare bytes bit flip won’t affect the ECC so don’t check
+ *    the number of bitflips in this area.
+ */
+static int
+check_for_erased_page(struct qcom_nand_host *host, u8 *data_buf,
+		      u8 *oob_buf, unsigned long uncorrectable_cws,
+		      int page, unsigned int max_bitflips)
+{
+	struct nand_chip *chip = &host->chip;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+	u8 *cw_data_buf, *cw_oob_buf;
+	int cw, data_size, oob_size, ret = 0;
+
+	if (!data_buf) {
+		data_buf = chip->data_buf;
+		chip->pagebuf = -1;
+	}
+
+	if (!oob_buf) {
+		oob_buf = chip->oob_poi;
+		chip->pagebuf = -1;
+	}
+
+	for_each_set_bit(cw, &uncorrectable_cws, ecc->steps) {
+		if (cw == (ecc->steps - 1)) {
+			data_size = ecc->size - ((ecc->steps - 1) * 4);
+			oob_size = (ecc->steps * 4) + host->ecc_bytes_hw;
+		} else {
+			data_size = host->cw_data;
+			oob_size = host->ecc_bytes_hw;
+		}
+
+		/* determine starting buffer address for current CW */
+		cw_data_buf = data_buf + (cw * host->cw_data);
+		cw_oob_buf = oob_buf + (cw * ecc->bytes);
+
+		ret = qcom_nandc_read_cw_raw(mtd, chip, cw_data_buf,
+					     cw_oob_buf, page, cw);
+		if (ret)
+			return ret;
+
+		/*
+		 * make sure it isn't an erased page reported
+		 * as not-erased by HW because of a few bitflips
+		 */
+		ret = nand_check_erased_ecc_chunk(cw_data_buf, data_size,
+						  cw_oob_buf + host->bbm_size,
+						  oob_size, NULL,
+						  0, ecc->strength);
+		if (ret < 0) {
+			mtd->ecc_stats.failed++;
+		} else {
+			mtd->ecc_stats.corrected += ret;
+			max_bitflips = max_t(unsigned int, max_bitflips, ret);
+		}
+	}
+
+	return max_bitflips;
+}
+
+/*
  * reads back status registers set by the controller to notify page read
  * errors. this is equivalent to what 'ecc->correct()' would do.
  */
 static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
-			     u8 *oob_buf)
+			     u8 *oob_buf, int page)
 {
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
-	unsigned int max_bitflips = 0;
+	unsigned int max_bitflips = 0, uncorrectable_cws = 0;
 	struct read_stats *buf;
-	bool flash_op_err = false;
+	bool flash_op_err = false, erased;
 	int i;
+	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
 
 	buf = (struct read_stats *)nandc->reg_read_buf;
 	nandc_read_buffer_sync(nandc, true);
@@ -1699,10 +1773,6 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 		 *    codeword detection check will be done.
 		 */
 		if ((flash & FS_OP_ERR) && (buffer & BS_UNCORRECTABLE_BIT)) {
-			bool erased;
-			int ret, ecclen, extraooblen;
-			void *eccbuf;
-
 			/*
 			 * For BCH ECC, ignore erased codeword errors, if
 			 * ERASED_CW bits are set.
@@ -1723,31 +1793,8 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 				erased = false;
 			}
 
-			if (erased) {
-				data_buf += data_len;
-				if (oob_buf)
-					oob_buf += oob_len + ecc->bytes;
-				continue;
-			}
-
-			eccbuf = oob_buf ? oob_buf + oob_len : NULL;
-			ecclen = oob_buf ? host->ecc_bytes_hw : 0;
-			extraooblen = oob_buf ? oob_len : 0;
-
-			/*
-			 * make sure it isn't an erased page reported
-			 * as not-erased by HW because of a few bitflips
-			 */
-			ret = nand_check_erased_ecc_chunk(data_buf,
-				data_len, eccbuf, ecclen, oob_buf,
-				extraooblen, ecc->strength);
-			if (ret < 0) {
-				mtd->ecc_stats.failed++;
-			} else {
-				mtd->ecc_stats.corrected += ret;
-				max_bitflips =
-					max_t(unsigned int, max_bitflips, ret);
-			}
+			if (!erased)
+				uncorrectable_cws |= BIT(i);
 		/*
 		 * Check if MPU or any other operational error (timeout,
 		 * device failure, etc.) happened for this codeword and
@@ -1777,7 +1824,12 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 	if (flash_op_err)
 		return -EIO;
 
-	return max_bitflips;
+	if (!uncorrectable_cws)
+		return max_bitflips;
+
+	return check_for_erased_page(host, data_buf_start, oob_buf_start,
+				     uncorrectable_cws, page,
+				     max_bitflips);
 }
 
 /*
@@ -1785,7 +1837,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
  * ecc->read_oob()
  */
 static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
-			 u8 *oob_buf)
+			 u8 *oob_buf, int page)
 {
 	struct nand_chip *chip = &host->chip;
 	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
@@ -1858,7 +1910,7 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
 		return ret;
 	}
 
-	return parse_read_errors(host, data_buf_start, oob_buf_start);
+	return parse_read_errors(host, data_buf_start, oob_buf_start, page);
 }
 
 /*
@@ -1910,7 +1962,7 @@ static int qcom_nandc_read_page(struct mtd_info *mtd, struct nand_chip *chip,
 
 	clear_bam_transaction(nandc);
 
-	return read_page_ecc(host, data_buf, oob_buf);
+	return read_page_ecc(host, data_buf, oob_buf, page);
 }
 
 /* implements ecc->read_page_raw() */
@@ -1951,7 +2003,7 @@ static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	set_address(host, 0, page);
 	update_rw_regs(host, ecc->steps, true);
 
-	return read_page_ecc(host, NULL, chip->oob_poi);
+	return read_page_ecc(host, NULL, chip->oob_poi, page);
 }
 
 /* implements ecc->write_page() */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

