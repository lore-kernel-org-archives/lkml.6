Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeEOM3v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:29:51 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753300AbeEOM3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:29:47 -0400
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 1/3] crypto: ccree: drop signature register check
Date: Tue, 15 May 2018 13:29:27 +0100
Message-Id: <1526387370-17142-2-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were using the content of the signature register as a sanity
check for the hardware functioning but it turns out not all
implementers use the same values so the check is giving false
negative on certain SoCs and so we drop it.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 89ce013..f8ff358 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -38,21 +38,20 @@ MODULE_PARM_DESC(cc_dump_bytes, "Dump buffers to kernel log as debugging aid");
 struct cc_hw_data {
 	char *name;
 	enum cc_hw_rev rev;
-	u32 sig;
 };
 
 /* Hardware revisions defs. */
 
 static const struct cc_hw_data cc712_hw = {
-	.name = "712", .rev = CC_HW_REV_712, .sig =  0xDCC71200U
+	.name = "712", .rev = CC_HW_REV_712
 };
 
 static const struct cc_hw_data cc710_hw = {
-	.name = "710", .rev = CC_HW_REV_710, .sig =  0xDCC63200U
+	.name = "710", .rev = CC_HW_REV_710
 };
 
 static const struct cc_hw_data cc630p_hw = {
-	.name = "630P", .rev = CC_HW_REV_630, .sig = 0xDCC63000U
+	.name = "630P", .rev = CC_HW_REV_630
 };
 
 static const struct of_device_id arm_ccree_dev_of_match[] = {
@@ -186,7 +185,6 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	struct cc_drvdata *new_drvdata;
 	struct device *dev = &plat_dev->dev;
 	struct device_node *np = dev->of_node;
-	u32 signature_val;
 	u64 dma_mask;
 	const struct cc_hw_data *hw_rev;
 	const struct of_device_id *dev_id;
@@ -275,16 +273,6 @@ static int init_cc_resources(struct platform_device *plat_dev)
 		return rc;
 	}
 
-	/* Verify correct mapping */
-	signature_val = cc_ioread(new_drvdata, CC_REG(HOST_SIGNATURE));
-	if (signature_val != hw_rev->sig) {
-		dev_err(dev, "Invalid CC signature: SIGNATURE=0x%08X != expected=0x%08X\n",
-			signature_val, hw_rev->sig);
-		rc = -EINVAL;
-		goto post_clk_err;
-	}
-	dev_dbg(dev, "CC SIGNATURE=0x%08X\n", signature_val);
-
 	/* Display HW versions */
 	dev_info(dev, "ARM CryptoCell %s Driver: HW version 0x%08X, Driver version %s\n",
 		 hw_rev->name, cc_ioread(new_drvdata, CC_REG(HOST_VERSION)),
-- 
2.7.4
