Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AE1C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3152175E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOxMsADw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3152175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390117AbeHGS3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389018AbeHGS3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:29:22 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC1B2175E;
        Tue,  7 Aug 2018 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658461;
        bh=HHbsEV44iXnyTBgdjgLEHDsQ75FZ8eAuDLMJ7pLq9eY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iOxMsADwX+B+Nq0vbfC6JKKru3gsRmVUBO4VDUuiQr1yCcghYtIdzEYremgxlJ100
         jqsXYcEvFFCVbnrjQtthwqoTXPlY+/bGbkmLOVa/NRbKO5Z0AtwEI+gZWYf36zFsOg
         M0/yZLYWiKDXhYMT9Pt5GNWyDwtmax9MOqOI2BRo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/4] mfd: sec-core: Allow building as module
Date:   Tue,  7 Aug 2018 18:11:25 +0200
Message-Id: <20180807161125.18155-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180807161125.18155-1-krzk@kernel.org>
References: <20180807161125.18155-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main MFD driver for Samsung PMICs (S2MPSXX, S5M876X) used with
Exynos SoCs can be compiled and used as a module.  The dependent clock,
regulator and RTC drivers already can be built as a module.

Building entire set of drivers as modules might require using initial
ramdisk and can make booting process longer (due to probe deferrals).
However adding such option is useful for testing and for multi-platform
configurations.

This also add required module authors to sec-irq.c file based on recent
main contributors.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/Kconfig   | 11 +++++++++--
 drivers/mfd/sec-irq.c |  8 ++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5810e6ff81f7..04db35d075fd 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1023,17 +1023,24 @@ config MFD_RN5T618
 	  functionality of the device.
 
 config MFD_SEC_CORE
-	bool "SAMSUNG Electronics PMIC Series Support"
+	tristate "SAMSUNG Electronics PMIC Series Support"
 	depends on I2C=y
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
 	help
-	  Support for the Samsung Electronics MFD series.
+	  Support for the Samsung Electronics PMIC devices coming
+	  usually along with Samsung Exynos SoC chipset.
 	  This driver provides common support for accessing the device,
 	  additional drivers must be enabled in order to use the functionality
 	  of the device
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called sec-core.
+	  Have in mind that important core drivers (like regulators) depend
+	  on this driver so building this as a module might require proper
+	  initial ramdisk or might not boot up as well in certain scenarios.
+
 config MFD_SI476X_CORE
 	tristate "Silicon Laboratories 4761/64/68 AM/FM radio."
 	depends on I2C
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index 295d24d4501d..ad0099077e7e 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
 
 #include <linux/mfd/samsung/core.h>
@@ -493,3 +494,10 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(sec_irq_init);
+
+MODULE_AUTHOR("Sangbeom Kim <sbkim73@samsung.com>");
+MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
+MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
+MODULE_DESCRIPTION("Interrupt support for the S5M MFD");
+MODULE_LICENSE("GPL");
-- 
2.14.1

