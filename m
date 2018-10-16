Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC589C169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC11208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC11208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=benyossef.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeJPV0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:26:15 -0400
Received: from foss.arm.com ([217.140.101.70]:36424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbeJPV0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:26:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CF67A78;
        Tue, 16 Oct 2018 06:35:44 -0700 (PDT)
Received: from sugar.kfn.arm.com (unknown [10.50.4.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEC0A3F5D3;
        Tue, 16 Oct 2018 06:35:41 -0700 (PDT)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Ofir Drang <Ofir.Drang@arm.com>, Yael Chemla <Yael.Chemla@arm.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] crypto: ccree: add support for CryptoCell 713
Date:   Tue, 16 Oct 2018 14:35:31 +0100
Message-Id: <1539696935-4433-2-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539696935-4433-1-git-send-email-gilad@benyossef.com>
References: <1539696935-4433-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Arm TrustZone CryptoCell 713.
Note that this patch just enables using a 713 in backwards compatible mode
to 712. Newer 713 specific features will follow.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/Kconfig           |  2 +-
 drivers/crypto/ccree/cc_driver.c | 23 +++++++++++++++--------
 drivers/crypto/ccree/cc_driver.h |  5 +++--
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index a8c4ce0..bea4de6 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -754,7 +754,7 @@ config CRYPTO_DEV_CCREE
 	help
 	  Say 'Y' to enable a driver for the REE interface of the Arm
 	  TrustZone CryptoCell family of processors. Currently the
-	  CryptoCell 712, 710 and 630 are supported.
+	  CryptoCell 713, 712, 710 and 630 are supported.
 	  Choose this if you wish to use hardware acceleration of
 	  cryptographic operations on the system REE.
 	  If unsure say Y.
diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 1ff229c..630c598 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -43,6 +43,10 @@ struct cc_hw_data {
 
 /* Hardware revisions defs. */
 
+static const struct cc_hw_data cc713_hw = {
+	.name = "713", .rev = CC_HW_REV_713
+};
+
 static const struct cc_hw_data cc712_hw = {
 	.name = "712", .rev = CC_HW_REV_712, .sig =  0xDCC71200U
 };
@@ -56,6 +60,7 @@ static const struct cc_hw_data cc630p_hw = {
 };
 
 static const struct of_device_id arm_ccree_dev_of_match[] = {
+	{ .compatible = "arm,cryptocell-713-ree", .data = &cc713_hw },
 	{ .compatible = "arm,cryptocell-712-ree", .data = &cc712_hw },
 	{ .compatible = "arm,cryptocell-710-ree", .data = &cc710_hw },
 	{ .compatible = "arm,cryptocell-630p-ree", .data = &cc630p_hw },
@@ -297,15 +302,17 @@ static int init_cc_resources(struct platform_device *plat_dev)
 		return rc;
 	}
 
-	/* Verify correct mapping */
-	signature_val = cc_ioread(new_drvdata, new_drvdata->sig_offset);
-	if (signature_val != hw_rev->sig) {
-		dev_err(dev, "Invalid CC signature: SIGNATURE=0x%08X != expected=0x%08X\n",
-			signature_val, hw_rev->sig);
-		rc = -EINVAL;
-		goto post_clk_err;
+	if (hw_rev->rev <= CC_HW_REV_712) {
+		/* Verify correct mapping */
+		signature_val = cc_ioread(new_drvdata, new_drvdata->sig_offset);
+		if (signature_val != hw_rev->sig) {
+			dev_err(dev, "Invalid CC signature: SIGNATURE=0x%08X != expected=0x%08X\n",
+				signature_val, hw_rev->sig);
+			rc = -EINVAL;
+			goto post_clk_err;
+		}
+		dev_dbg(dev, "CC SIGNATURE=0x%08X\n", signature_val);
 	}
-	dev_dbg(dev, "CC SIGNATURE=0x%08X\n", signature_val);
 
 	/* Display HW versions */
 	dev_info(dev, "ARM CryptoCell %s Driver: HW version 0x%08X, Driver version %s\n",
diff --git a/drivers/crypto/ccree/cc_driver.h b/drivers/crypto/ccree/cc_driver.h
index d608a4f..a06e5c9 100644
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -36,12 +36,13 @@
 extern bool cc_dump_desc;
 extern bool cc_dump_bytes;
 
-#define DRV_MODULE_VERSION "4.0"
+#define DRV_MODULE_VERSION "5.0"
 
 enum cc_hw_rev {
 	CC_HW_REV_630 = 630,
 	CC_HW_REV_710 = 710,
-	CC_HW_REV_712 = 712
+	CC_HW_REV_712 = 712,
+	CC_HW_REV_713 = 713
 };
 
 #define CC_COHERENT_CACHE_PARAMS 0xEEE
-- 
2.7.4

