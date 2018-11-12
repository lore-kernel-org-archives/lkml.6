Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A68DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2956A20685
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IlHdHvbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2956A20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeKMBRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:17:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47013 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbeKMBRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:17:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id 74-v6so9790798wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S8bHhUupkUTqv4GrIPDVQt3PTDb9g6MRhgvHMF/6NzU=;
        b=IlHdHvbIMsbZPOp6BcEzfi081E1nBwMoOoOCCVyl8k/KhFbV303J7JfVO79FU6nCKT
         3cHwQfNISRvfaIlwEgKJ9rlzFqtTWBOJoVxk/PqEWpqglGHqa1WLjCB10wX+3qux7snj
         oph3ekQPWgiNowFuLstDMXdXZtjlK11a0g0fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S8bHhUupkUTqv4GrIPDVQt3PTDb9g6MRhgvHMF/6NzU=;
        b=gS/vGbInkkLgYzeLEacxsLLXAXIAskxGNkq8HQw454ZuUWEv8WBvxWtVefZYhYfr9v
         YbSAEiHKPTaI2fbp2bORiRG3GusVK2rpLprK9phSQEkFFd98+9V4dsQFdbMYqOnFmEb6
         DlDalIo0fMrX3T0apfmrdlihnXitMkan1QwLcpy0aJsxCw9G8FLhx2W5IoJF+B6BIqx2
         Rr9Nf8r9RiEQQGLvT7npU9DE5tJL7zFk61umKp5da8FJue6TosAVhp32QDj8FlSeaDmL
         pP8ZWJ5QxMVe8x3Fcn7KpAVCCQM9/CzzKJmrmEbP3lbDGAkWaRlhrwz8aQU4YBjmMxsq
         AAbA==
X-Gm-Message-State: AGRZ1gITZii11ktuj9D+chetg2iqu4I82qG6m+d7Pzym+6xMuVj+0eoS
        HoCR4R294IMj5vvGed0E2LO8qA==
X-Google-Smtp-Source: AJdET5cA2bajNqmYhIHLB1k1FJaj2+oQrwHDCnL2ofiDikN+XhF36fA4774jKtj0ApmhCZWIqHdANA==
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr1474539wrc.188.1542036233846;
        Mon, 12 Nov 2018 07:23:53 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:105e:a8d5:7c2c:2737:d373:11ee])
        by smtp.gmail.com with ESMTPSA id t82-v6sm11192849wme.30.2018.11.12.07.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 07:23:53 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 2/4] hwspinlock: add STM32 hwspinlock device
Date:   Mon, 12 Nov 2018 16:23:40 +0100
Message-Id: <20181112152342.6561-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181112152342.6561-1-benjamin.gaignard@st.com>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of hardware semaphores for stm32mp1 SoC.
The hardware block provides 32 semaphores.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 3 :
- use postcore_initcall() instead of module_platform_driver()
  
version 2 :
- change clock name from hwspinlock to hsem to be align with hardware
  documentation
- remove useless licence terms from header
- fix alphabetic order issues
- do not abort remove function if hwspin_lock_unregister() failed

 drivers/hwspinlock/Kconfig            |   9 ++
 drivers/hwspinlock/Makefile           |   1 +
 drivers/hwspinlock/stm32_hwspinlock.c | 156 ++++++++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+)
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
index 000000000000..34a8e009dc93
--- /dev/null
+++ b/drivers/hwspinlock/stm32_hwspinlock.c
@@ -0,0 +1,156 @@
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
+
+static int __init stm32_hwspinlock_init(void)
+{
+	return platform_driver_register(&stm32_hwspinlock_driver);
+}
+/* board init code might need to reserve hwspinlocks for predefined purposes */
+postcore_initcall(stm32_hwspinlock_init);
+
+static void __exit stm32_hwspinlock_exit(void)
+{
+	platform_driver_unregister(&stm32_hwspinlock_driver);
+}
+module_exit(stm32_hwspinlock_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Hardware spinlock driver for STM32 SoCs");
+MODULE_AUTHOR("Benjamin Gaignard <benjamin.gaignard@st.com>");
-- 
2.15.0

