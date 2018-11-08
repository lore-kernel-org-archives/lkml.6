Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D67C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7052F2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKwZFQEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7052F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbeKHSjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:39:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33232 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeKHSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:39:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id f19-v6so1037332wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 01:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vfYBXlI8TGzQiJThszSCkUGyt2x6cRpuleHBiD2O0WI=;
        b=gKwZFQEdxyx71OjEc1WYHh9hL7tMQAk1Q8NN1gKz3OPhXyowjVnmGmtP0pclDo03UO
         jjKBlQLxFIkeyqHRGQsU/p+AQxRhePTpYb9qaM1xBbr821jcgAfPA1Av1uKR1HzXbFeP
         acI/vnI+Lg+psXV1HGPrLaaUyj1gdfRBbrkuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vfYBXlI8TGzQiJThszSCkUGyt2x6cRpuleHBiD2O0WI=;
        b=QrvLbUDz9lncsmqW6Qmi6LZruPHB+iTsNgoWojTFeyha740qJJ8j6fmGzqzJdOzcGi
         Utzn6IF06/bmm34ixBQeoo+eFXZvVdB9D0qmI0ZASTfNvRYaU7ck/v390H5H2P0QXRZ2
         uJquzeLaHG+EErwegYrxfsXEScMxjZrDIBmv+etNDxPy/cKWZhhX8PFxRf+xOnbZRwpJ
         SZUPrnccTbVeyj9HCh/kgYOds7x/KK9hVeX/ANztB7ZUX4AcYQSH8teVKPr72di6N8jF
         3WcBU1ntgS0QBZot7I25jsitJ84iV9SPNlSmCktPS3IB8Cdi7jt/lTnB5H2V5OsSdJjF
         mAog==
X-Gm-Message-State: AGRZ1gJK0cEdIcV/V8YKHmWVQmSaTjl5/3W/aKP92qievz2Nrvky714X
        0ox6q/FB+150UV6s568V711MDg==
X-Google-Smtp-Source: AJdET5daqR3GTzFPF6l1if10VOkqfNJEXMu/mgNdH/Wxr1L2Ju2kHGfkTLvH6nFDdqH4PTUsvvOX4A==
X-Received: by 2002:a1c:5706:: with SMTP id l6-v6mr443683wmb.51.1541667918008;
        Thu, 08 Nov 2018 01:05:18 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1094:149:440c:9368:8cda:a020])
        by smtp.gmail.com with ESMTPSA id l140-v6sm6974469wmb.24.2018.11.08.01.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 01:05:17 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 2/4] hwspinlock: add STM32 hwspinlock device
Date:   Thu,  8 Nov 2018 10:05:00 +0100
Message-Id: <20181108090502.14543-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181108090502.14543-1-benjamin.gaignard@st.com>
References: <20181108090502.14543-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of hardware semaphores for stm32mp1 SoC.
The hardware block provides 32 semaphores.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2 :
- change clock name from hwspinlock to hsem to be align with hardware
  documentation
- remove useless licence terms from header
- fix alphabetic order issues
- do not abort remove function if hwspin_lock_unregister() failed

 drivers/hwspinlock/Kconfig            |   9 +++
 drivers/hwspinlock/Makefile           |   1 +
 drivers/hwspinlock/stm32_hwspinlock.c | 144 ++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index e895d29500ee..7869c67e5b6b 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -49,6 +49,15 @@ config HWSPINLOCK_SPRD
 
 	  If unsure, say N.
 
+config HWSPINLOCK_STM32
+	tristate "STM32 Hardware Spinlock device"
+	depends on MACH_STM32MP157
+	depends on HWSPINLOCK
+	help
+	  Say y here to support the STM32 Hardware Spinlock device.
+
+	  If unsure, say N.
+
 config HSEM_U8500
 	tristate "STE Hardware Semaphore functionality"
 	depends on HWSPINLOCK
diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
index b87c01a506a4..ed053e3f02be 100644
--- a/drivers/hwspinlock/Makefile
+++ b/drivers/hwspinlock/Makefile
@@ -8,4 +8,5 @@ obj-$(CONFIG_HWSPINLOCK_OMAP)		+= omap_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
+obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
 obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
new file mode 100644
index 000000000000..7eb36a5bbf68
--- /dev/null
+++ b/drivers/hwspinlock/stm32_hwspinlock.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics SA 2018
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#include <linux/clk.h>
+#include <linux/hwspinlock.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+#include "hwspinlock_internal.h"
+
+#define STM32_MUTEX_COREID	BIT(8)
+#define STM32_MUTEX_LOCK_BIT	BIT(31)
+#define STM32_MUTEX_NUM_LOCKS	32
+
+struct stm32_hwspinlock {
+	struct clk *clk;
+	struct hwspinlock_device bank;
+};
+
+static int stm32_hwspinlock_trylock(struct hwspinlock *lock)
+{
+	void __iomem *lock_addr = lock->priv;
+	u32 status;
+
+	writel(STM32_MUTEX_LOCK_BIT | STM32_MUTEX_COREID, lock_addr);
+	status = readl(lock_addr);
+
+	return status == (STM32_MUTEX_LOCK_BIT | STM32_MUTEX_COREID);
+}
+
+static void stm32_hwspinlock_unlock(struct hwspinlock *lock)
+{
+	void __iomem *lock_addr = lock->priv;
+
+	writel(STM32_MUTEX_COREID, lock_addr);
+}
+
+static const struct hwspinlock_ops stm32_hwspinlock_ops = {
+	.trylock	= stm32_hwspinlock_trylock,
+	.unlock		= stm32_hwspinlock_unlock,
+};
+
+static int stm32_hwspinlock_probe(struct platform_device *pdev)
+{
+	struct stm32_hwspinlock *hw;
+	void __iomem *io_base;
+	struct resource *res;
+	size_t array_size;
+	int i, ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	io_base = devm_ioremap_resource(&pdev->dev, res);
+	if (!io_base)
+		return -ENOMEM;
+
+	array_size = STM32_MUTEX_NUM_LOCKS * sizeof(struct hwspinlock);
+	hw = devm_kzalloc(&pdev->dev, sizeof(*hw) + array_size, GFP_KERNEL);
+	if (!hw)
+		return -ENOMEM;
+
+	hw->clk = devm_clk_get(&pdev->dev, "hsem");
+	if (IS_ERR(hw->clk))
+		return PTR_ERR(hw->clk);
+
+	for (i = 0; i < STM32_MUTEX_NUM_LOCKS; i++)
+		hw->bank.lock[i].priv = io_base + i * sizeof(u32);
+
+	platform_set_drvdata(pdev, hw);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = hwspin_lock_register(&hw->bank, &pdev->dev, &stm32_hwspinlock_ops,
+				   0, STM32_MUTEX_NUM_LOCKS);
+
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int stm32_hwspinlock_remove(struct platform_device *pdev)
+{
+	struct stm32_hwspinlock *hw = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = hwspin_lock_unregister(&hw->bank);
+	if (ret)
+		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_hwspinlock_runtime_suspend(struct device *dev)
+{
+	struct stm32_hwspinlock *hw = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(hw->clk);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_hwspinlock_runtime_resume(struct device *dev)
+{
+	struct stm32_hwspinlock *hw = dev_get_drvdata(dev);
+
+	clk_prepare_enable(hw->clk);
+
+	return 0;
+}
+
+static const struct dev_pm_ops stm32_hwspinlock_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_hwspinlock_runtime_suspend,
+			   stm32_hwspinlock_runtime_resume,
+			   NULL)
+};
+
+static const struct of_device_id stm32_hwpinlock_ids[] = {
+	{ .compatible = "st,stm32-hwspinlock", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_hwpinlock_ids);
+
+static struct platform_driver stm32_hwspinlock_driver = {
+	.probe		= stm32_hwspinlock_probe,
+	.remove		= stm32_hwspinlock_remove,
+	.driver		= {
+		.name	= "stm32_hwspinlock",
+		.of_match_table = stm32_hwpinlock_ids,
+		.pm	= &stm32_hwspinlock_pm_ops,
+	},
+};
+module_platform_driver(stm32_hwspinlock_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Hardware spinlock driver for STM32 SoCs");
+MODULE_AUTHOR("Benjamin Gaignard <benjamin.gaignard@st.com>");
-- 
2.15.0

