Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F010C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED4F23F4A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED4F23F4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934083AbeGARJC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:09:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031802AbeGAQl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:41:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9B89EACC;
        Sun,  1 Jul 2018 16:41:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4.17 105/220] mtd: rawnand: All AC chips have a broken GET_FEATURES(TIMINGS).
Date:   Sun,  1 Jul 2018 18:22:09 +0200
Message-Id: <20180701160912.778392924@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mason Yang <masonccyang@mxic.com.tw>

commit fe3dd97dd66bb7fb23b8077a3803d2f951e60b00 upstream.

Make sure we flag all broken chips as not supporting this feature.
Also move this logic to a new function to keep things readable.

Fixes: 34c5c01e0c8c ("mtd: rawnand: macronix: nack the support of changing timings for one chip")
Cc: <stable@vger.kernel.org>
Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/raw/nand_macronix.c |   48 ++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 12 deletions(-)

--- a/drivers/mtd/nand/raw/nand_macronix.c
+++ b/drivers/mtd/nand/raw/nand_macronix.c
@@ -17,23 +17,47 @@
 
 #include <linux/mtd/rawnand.h>
 
+/*
+ * Macronix AC series does not support using SET/GET_FEATURES to change
+ * the timings unlike what is declared in the parameter page. Unflag
+ * this feature to avoid unnecessary downturns.
+ */
+static void macronix_nand_fix_broken_get_timings(struct nand_chip *chip)
+{
+	unsigned int i;
+	static const char * const broken_get_timings[] = {
+		"MX30LF1G18AC",
+		"MX30LF1G28AC",
+		"MX30LF2G18AC",
+		"MX30LF2G28AC",
+		"MX30LF4G18AC",
+		"MX30LF4G28AC",
+		"MX60LF8G18AC",
+	};
+
+	if (!chip->parameters.supports_set_get_features)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(broken_get_timings); i++) {
+		if (!strcmp(broken_get_timings[i], chip->parameters.model))
+			break;
+	}
+
+	if (i == ARRAY_SIZE(broken_get_timings))
+		return;
+
+	bitmap_clear(chip->parameters.get_feature_list,
+		     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
+	bitmap_clear(chip->parameters.set_feature_list,
+		     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
+}
+
 static int macronix_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
 		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
 
-	/*
-	 * MX30LF2G18AC chip does not support using SET/GET_FEATURES to change
-	 * the timings unlike what is declared in the parameter page. Unflag
-	 * this feature to avoid unnecessary downturns.
-	 */
-	if (chip->parameters.supports_set_get_features &&
-	    !strcmp("MX30LF2G18AC", chip->parameters.model)) {
-		bitmap_clear(chip->parameters.get_feature_list,
-			     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
-		bitmap_clear(chip->parameters.set_feature_list,
-			     ONFI_FEATURE_ADDR_TIMING_MODE, 1);
-	}
+	macronix_nand_fix_broken_get_timings(chip);
 
 	return 0;
 }


