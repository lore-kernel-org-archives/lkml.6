Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67BEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2F2208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Et11Y3HX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Et11Y3HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2F2208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754789AbeFTIwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:52:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932872AbeFTIpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:45:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D9A6B60B3C; Wed, 20 Jun 2018 07:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479705;
        bh=U7xGhBoBUaYz2FbRCFOOBwygcVX+Ji3Lpr50mrN4E/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Et11Y3HXYQtc0ijRyf8M8JvBiOp1dg0nhX1gQob3Uoe/Y1HsN1DvuxAcPz4M0wBCq
         8Oo776kRU3wkjaVUe4lGAXLdRoYJKh6ESQWcK43U4D2v5w08kDjb9fx2MqtdONYwVr
         96Mi3K6N2Ww+/SITIDM6bh4xwMLm3o8vuGX7bRbs=
Received: from absahu-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: absahu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1C3A60AD8;
        Wed, 20 Jun 2018 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529479705;
        bh=U7xGhBoBUaYz2FbRCFOOBwygcVX+Ji3Lpr50mrN4E/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Et11Y3HXYQtc0ijRyf8M8JvBiOp1dg0nhX1gQob3Uoe/Y1HsN1DvuxAcPz4M0wBCq
         8Oo776kRU3wkjaVUe4lGAXLdRoYJKh6ESQWcK43U4D2v5w08kDjb9fx2MqtdONYwVr
         96Mi3K6N2Ww+/SITIDM6bh4xwMLm3o8vuGX7bRbs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1C3A60AD8
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
Subject: [PATCH v4 08/15] mtd: rawnand: qcom: fix null pointer access for erased page detection
Date:   Wed, 20 Jun 2018 12:57:35 +0530
Message-Id: <1529479662-4026-9-git-send-email-absahu@codeaurora.org>
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

parse_read_errors can be called with only oob_buf in which case
data_buf will be NULL.  If data_buf is NULL, then don’t
treat this page as completely erased in case of ECC uncorrectable
error for RS ECC. For BCH ECC, the controller itself tells
regarding erased page in status register.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
* Changes from v3:
  NONE

* Changes from v2:
  NONE

* Changes from v1:
  1. Added more detail in commit message
  2. Added comment before each if/else

 drivers/mtd/nand/raw/qcom_nandc.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 0d931d5..a831f9c 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -1611,13 +1611,24 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 			int ret, ecclen, extraooblen;
 			void *eccbuf;
 
-			/* ignore erased codeword errors */
+			/*
+			 * For BCH ECC, ignore erased codeword errors, if
+			 * ERASED_CW bits are set.
+			 */
 			if (host->bch_enabled) {
 				erased = (erased_cw & ERASED_CW) == ERASED_CW ?
 					 true : false;
-			} else {
+			/*
+			 * For RS ECC, HW reports the erased CW by placing
+			 * special characters at certain offsets in the buffer.
+			 * These special characters will be valid only if
+			 * complete page is read i.e. data_buf is not NULL.
+			 */
+			} else if (data_buf) {
 				erased = erased_chunk_check_and_fixup(data_buf,
 								      data_len);
+			} else {
+				erased = false;
 			}
 
 			if (erased) {
@@ -1665,7 +1676,8 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
 			max_bitflips = max(max_bitflips, stat);
 		}
 
-		data_buf += data_len;
+		if (data_buf)
+			data_buf += data_len;
 		if (oob_buf)
 			oob_buf += oob_len + ecc->bytes;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.
is a member of Code Aurora Forum, hosted by The Linux Foundation

