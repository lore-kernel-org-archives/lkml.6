Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB7AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5239B20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="czZ3NqX0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dQKlMYaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5239B20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932885AbeFTIwR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:52:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49638 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932863AbeFTIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 405B760B16; Wed, 20 Jun 2018 07:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479702;
        bh=WS8MxSclPbx+M4a6KfV5x36G2bqbtTeAz98NE/0tK7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czZ3NqX0Fs3mmVAX6sqveB7CdLxNgXO5EZdnOs1d5Qdgzs3dva+z0loR/G/aruHRa
         mGlKUha/XEBWU47q3rqInTs5NplQ+5gxk9jOQAMns75AiTMSqxUaRwc2ar+BYUpK0d
         jd0H47gJ7QHuRw4OpR0C6G58D5kxOvfxr2qU43q0=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D152A60B16;
        Wed, 20 Jun 2018 07:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479701;
        bh=WS8MxSclPbx+M4a6KfV5x36G2bqbtTeAz98NE/0tK7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQKlMYaYiaRoPXQ6CR34owj/EC5+KToOiKvn9RUzi1b7Myx03lh+EL6e2WXN2MiNB
         sKG7/4a91SNKm3tknOHMMV7AbKbceiTEzNJVaZ8Iat08mT1VasrYs/KGawPIePNY6l
         49ty8MxgrpV1vTfsXGl6AFNBtHDSrQZl1PKFRsQ4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D152A60B16
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
Subject: [PATCH v4 07/15] mtd: rawnand: qcom: erased page detection for uncorrectable errors only
Date:   Wed, 20 Jun 2018 12:57:34 +0530
Message-Id: <1529479662-4026-8-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following is the flow in the HW if controller tries to read erased
page:

1. First ECC uncorrectable error will be generated from ECC engine
   since ECC engine first calculates the ECC with all 0xff and match
   the calculated ECC with ECC code in OOB (which is again all 0xff).
2. After getting ECC error, erased CW detection logic will be
   applied which is different for BCH and RS ECC
    a. For BCH, HW checks if all the bytes in page are 0xff and then
       it updates the status in separate register
       NAND_ERASED_CW_DETECT_STATUS.
    b. For RS ECC, the HW reports the same error when reading an
       erased CW, but it notifies that it is an erased CW by
       placing special characters at certain offsets in the
       buffer.

So the erased CW detect status should be checked only if ECC engine
generated the uncorrectable error.

Currently for all other operational errors also (like TIMEOUT, MPU
errors, etc.), the erased CW detect logic is being applied so fix this
and return EIO for other operational errors.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
  NONE

* Changes from v2:
  1. Changed commit message slightly

* Changes from v1:
  1. Added more detail in commit message
  2. Added comment before each if/else
  3. Removed redundant check for BS_UNCORRECTABLE_BIT

 drivers/mtd/nand/raw/qcom_nandc.c | 65 ++++++++++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index fc20149..0d931d5 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1576,6 +1576,7 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	unsigned int max_bitflips = 0;
 	struct read_stats *buf;
+	bool flash_op_err = false;
 	int i;
 
 	buf = (struct read_stats *)nandc->reg_read_buf;
@@ -1597,8 +1598,18 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 		buffer = le32_to_cpu(buf->buffer);
 		erased_cw = le32_to_cpu(buf->erased_cw);
 
-		if (flash & (FS_OP_ERR | FS_MPU_ERR)) {
+		/*
+		 * Check ECC failure for each codeword. ECC failure can
+		 * happen in either of the following conditions
+		 * 1. If number of bitflips are greater than ECC engine
+		 *    capability.
+		 * 2. If this codeword contains all 0xff for which erased
+		 *    codeword detection check will be done.
+		 */
+		if ((flash & FS_OP_ERR) && (buffer & BS_UNCORRECTABLE_BIT)) {
 			bool erased;
+			int ret, ecclen, extraooblen;
+			void *eccbuf;
 
 			/* ignore erased codeword errors */
 			if (host->bch_enabled) {
@@ -1616,29 +1627,36 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 				continue;
 			}
 
-			if (buffer & BS_UNCORRECTABLE_BIT) {
-				int ret, ecclen, extraooblen;
-				void *eccbuf;
+			eccbuf = oob_buf ? oob_buf + oob_len : NULL;
+			ecclen = oob_buf ? host->ecc_bytes_hw : 0;
+			extraooblen = oob_buf ? oob_len : 0;
 
-				eccbuf = oob_buf ? oob_buf + oob_len : NULL;
-				ecclen = oob_buf ? host->ecc_bytes_hw : 0;
-				extraooblen = oob_buf ? oob_len : 0;
-
-				/*
-				 * make sure it isn't an erased page reported
-				 * as not-erased by HW because of a few bitflips
-				 */
-				ret = nand_check_erased_ecc_chunk(data_buf,
-					data_len, eccbuf, ecclen, oob_buf,
-					extraooblen, ecc->strength);
-				if (ret < 0) {
-					mtd->ecc_stats.failed++;
-				} else {
-					mtd->ecc_stats.corrected += ret;
-					max_bitflips =
-						max_t(unsigned int, max_bitflips, ret);
-				}
+			/*
+			 * make sure it isn't an erased page reported
+			 * as not-erased by HW because of a few bitflips
+			 */
+			ret = nand_check_erased_ecc_chunk(data_buf,
+				data_len, eccbuf, ecclen, oob_buf,
+				extraooblen, ecc->strength);
+			if (ret < 0) {
+				mtd->ecc_stats.failed++;
+			} else {
+				mtd->ecc_stats.corrected += ret;
+				max_bitflips =
+					max_t(unsigned int, max_bitflips, ret);
 			}
+		/*
+		 * Check if MPU or any other operational error (timeout,
+		 * device failure, etc.) happened for this codeword and
+		 * make flash_op_err true. If flash_op_err is set, then
+		 * EIO will be returned for page read.
+		 */
+		} else if (flash & (FS_OP_ERR | FS_MPU_ERR)) {
+			flash_op_err = true;
+		/*
+		 * No ECC or operational errors happened. Check the number of
+		 * bits corrected and update the ecc_stats.corrected.
+		 */
 		} else {
 			unsigned int stat;
 
@@ -1652,6 +1670,9 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 			oob_buf += oob_len + ecc->bytes;
 	}
 
+	if (flash_op_err)
+		return -EIO;
+
 	return max_bitflips;
 }
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

