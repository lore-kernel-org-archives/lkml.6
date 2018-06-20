Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1092BC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B765E20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F2WoM/dv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QUn50H0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B765E20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932948AbeFTI5a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:57:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753709AbeFTIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 99A6C60B83; Wed, 20 Jun 2018 07:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479713;
        bh=f1ZuNS+AL96dc3Yu0tDYkuTUIUz22p8bk9WRXfBFcuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2WoM/dvacd2auHolS9xWvEMsq+9IzwLYhtx6NpoVdTZcXC96okyFw3OAfiVVi6DA
         IZKh1vPkMKTo2jfsX4wEQyBQ8wmAMZc8eA45IfbwJQnZnk+xPomKyJvi/1Gokmlc78
         r/EVqkgG4M1r++H9bFLHGFTXfjtZlMeeSfLeNVq4=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 618EB60B15;
        Wed, 20 Jun 2018 07:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479712;
        bh=f1ZuNS+AL96dc3Yu0tDYkuTUIUz22p8bk9WRXfBFcuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUn50H0S/VR8kpaRhthubXYIdqb0hzhbWiBlYnOooQVBCL2HBIVXkJQ+GRgegjLUy
         OTDbYOu3aj2Dv/gpYyJPbbdG82X+3nl3EFW5Hs2/7GxyO8kUq2XDKkaep58NYLrFnz
         w+UnTsWY1L4Zj4S94B6m+lYFK3jVyspY7jHt7vCA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 618EB60B15
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
Subject: [PATCH v4 10/15] mtd: rawnand: qcom: modify write_oob to remove read codeword part
Date:   Wed, 20 Jun 2018 12:57:37 +0530
Message-Id: <1529479662-4026-11-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
References: <1529479662-4026-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCOM NAND controller layout protects available OOB data bytes with
ECC also so when ecc->write_oob() is being called then it
can't update just OOB bytes. Currently, it first reads the last
codeword which includes old OOB bytes. Then it updates the old OOB
bytes with new ones and then again writes the codeword back.
The reading codeword is unnecessary since user is responsible to
have these bytes cleared to 0xFF.

This patch removes the read part and updates the OOB bytes with
data area padded with OxFF.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
  NONE

* Changes from v2:

  1. Changed commit message and comments slightly
  2. Changed host->use_ecc assignment place

* Changes from v1:
  NEW CHANGE

 drivers/mtd/nand/raw/qcom_nandc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 285b2ad3..28361b5 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2064,11 +2064,9 @@ static int qcom_nandc_write_page_raw(struct mtd_info *mtd,
 /*
  * implements ecc->write_oob()
  *
- * the NAND controller cannot write only data or only oob within a codeword,
- * since ecc is calculated for the combined codeword. we first copy the
- * entire contents for the last codeword(data + oob), replace the old oob
- * with the new one in chip->oob_poi, and then write the entire codeword.
- * this read-copy-write operation results in a slight performance loss.
+ * the NAND controller cannot write only data or only OOB within a codeword
+ * since ECC is calculated for the combined codeword. So update the OOB from
+ * chip->oob_poi, and pad the data area with OxFF before writing.
  */
 static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 				int page)
@@ -2081,19 +2079,13 @@ static int qcom_nandc_write_oob(struct mtd_info *mtd, struct nand_chip *chip,
 	int ret;
 
 	host->use_ecc = true;
-
-	clear_bam_transaction(nandc);
-	ret = copy_last_cw(host, page);
-	if (ret)
-		return ret;
-
-	clear_read_regs(nandc);
 	clear_bam_transaction(nandc);
 
 	/* calculate the data and oob size for the last codeword/step */
 	data_size = ecc->size - ((ecc->steps - 1) << 2);
 	oob_size = mtd->oobavail;
 
+	memset(nandc->data_buffer, 0xff, host->cw_data);
 	/* override new oob content to last codeword */
 	mtd_ooblayout_get_databytes(mtd, nandc->data_buffer + data_size, oob,
 				    0, mtd->oobavail);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

