Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB687C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7561B2246B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbSsGKxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7561B2246B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754431AbeGCGFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754330AbeGCGF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:05:29 -0400
Received: from localhost.localdomain (unknown [171.61.87.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1ACB2246B;
        Tue,  3 Jul 2018 06:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530597928;
        bh=aF3rf44giV/wvjQxhP5XV8IvH31YiGS4j2a0DW/7JAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbSsGKxsjEznU5RWPLr8Vfrqh0JKLVCtiqZEeEx7zS5RCcOsq6+8iWqsnfM9SAu8k
         Dh5s0dXhLOFU18Tv2HkofI5nIBVEqiEH2EiFAibmIVw0kKYJyh2FHlr4/mi5AWb0xh
         zS6eVxXTeN0hZx+WpseXo08f9keQQuIotUODGSuQ=
From:   Vinod Koul <vkoul@kernel.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 6/6] crypto: qcom: Add ACPI support
Date:   Tue,  3 Jul 2018 11:34:34 +0530
Message-Id: <20180703060434.19293-7-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703060434.19293-1-vkoul@kernel.org>
References: <20180703060434.19293-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timur Tabi <timur@codeaurora.org>

Add support for probing on ACPI systems, with ACPI HID QCOM8160.

On ACPI systems, clocks are always enabled, the PRNG should
already be enabled, and the register region is read-only.
The driver only verifies that the hardware is already
enabled never tries to disable or configure it.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
[port to crypto API]
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/crypto/qcom-rng.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index fdbbcac7bcb8..bc0131d130d6 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -4,6 +4,7 @@
 // Based on msm-rng.c and downstream driver
 
 #include <crypto/internal/rng.h>
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/crypto.h>
 #include <linux/module.h>
@@ -154,6 +155,7 @@ static int qcom_rng_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	struct qcom_rng *rng;
+	u32 val;
 	int ret;
 
 	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
@@ -168,11 +170,27 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->base))
 		return PTR_ERR(rng->base);
 
-	rng->clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(rng->clk))
-		return PTR_ERR(rng->clk);
 
-	rng->skip_init = (unsigned long)of_device_get_match_data(&pdev->dev);
+	/*
+	 * ACPI systems have v2 hardware. The clocks are always enabled,
+	 * the PRNG register space is read-only and the PRNG should
+	 * already be enabled.
+	 */
+	if (has_acpi_companion(&pdev->dev)) {
+		val = readl(rng->base + PRNG_CONFIG);
+		if (!(val & PRNG_CONFIG_HW_ENABLE)) {
+			dev_err(&pdev->dev, "device is not enabled\n");
+			return -ENODEV;
+		}
+		rng->skip_init = 1;
+	} else {
+		rng->clk = devm_clk_get(&pdev->dev, "core");
+		if (IS_ERR(rng->clk))
+			return PTR_ERR(rng->clk);
+
+		rng->skip_init =
+			(unsigned long)of_device_get_match_data(&pdev->dev);
+	}
 
 	qcom_rng_dev = rng;
 	ret = crypto_register_rng(&qcom_rng_alg);
@@ -193,6 +211,16 @@ static int qcom_rng_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_ACPI)
+static const struct acpi_device_id qcom_rng_acpi_match[] = {
+	{
+		.id = "QCOM8160",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, msm_rng_acpi_match);
+#endif
+
 static const struct of_device_id qcom_rng_of_match[] = {
 	{ .compatible = "qcom,prng", .data = (void *)0},
 	{ .compatible = "qcom,prng-ee", .data = (void *)1},
@@ -206,6 +234,7 @@ static struct platform_driver qcom_rng_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = of_match_ptr(qcom_rng_of_match),
+		.acpi_match_table = ACPI_PTR(qcom_rng_acpi_match),
 	}
 };
 module_platform_driver(qcom_rng_driver);
-- 
2.14.4

