Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22909C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C8820843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebiZIiAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C8820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbeJaS2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:28:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34992 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbeJaS2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:28:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id q12-v6so11131356wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OCewN85BXjXK6qI/FZdB9QY1FkUVogdwEIt0smFxfhs=;
        b=ebiZIiAcOFS+c+u43A22LaTq48add9ZKsgKdQoX+XEj2Oqdne0CRjNM9vSl+y46ZJI
         Kz6prWMdHKZXBlX9qOWVcKlAX7k8xrB4j92tM4L0aYf6sT2W/t8//1ermdRcyI35JplU
         osGpoR0wsai40PeQ6+yjlMVXWSRlWWz+IEgWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OCewN85BXjXK6qI/FZdB9QY1FkUVogdwEIt0smFxfhs=;
        b=WWcSiVtKIFTAmmR1OsTWUpWDOfKHNenT9hydSSH8hsIKGBOq+xGFqlDe3WllRWXHa/
         pPHqLxwwokEkVD8J6BNF0HcBY6rmpRY0hLK8rwaWgfC9wf+2KuUnM6fK6aosuZmRThcz
         f6ZxdGzYPSQkhpFF4X5ajD3t2ggLMp94UtCwA6ShqYqxwmcODrerWj2R9ZPGQ2KLJkL6
         fy3MVLa7bKUCqaUdeERivj06H/QjGB5ZsZgvaP4sddZ2h+3vfTbduwF2pWeM0gNtIf79
         SN668cTs6epDdskrNVm437gs98gd4ntW532OpHPtVlh0EtmrIlvfRPUCcBjngsLxOc1H
         r0zQ==
X-Gm-Message-State: AGRZ1gLtdmHjvwrZy6T7j6JAtl2CoJm/6vp/0XlEIIyzkart9X2DYqp7
        I5TIex8aeuSJviCQMrT65Kskhw==
X-Google-Smtp-Source: AJdET5c3uYVY9Lo0ileEfE2sU8QuE8viihMcrLdNsmesrKHwypEh8qHlvonv2Zdp3c2w2dggUT6MoQ==
X-Received: by 2002:a1c:84cd:: with SMTP id g196-v6mr1723453wmd.38.1540978252699;
        Wed, 31 Oct 2018 02:30:52 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1086:999:fd1b:8629:a7fc:68b])
        by smtp.gmail.com with ESMTPSA id w14-v6sm10737377wrt.73.2018.10.31.02.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Oct 2018 02:30:51 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 2/5] hwspinlock: add STM32 hwspinlock device
Date:   Wed, 31 Oct 2018 10:30:29 +0100
Message-Id: <20181031093032.20386-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181031093032.20386-1-benjamin.gaignard@st.com>
References: <20181031093032.20386-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support of hardware semaphores for stm32mp1 SoC.
The hardware block provides 32 semaphores.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/hwspinlock/Kconfig            |   9 +++
 drivers/hwspinlock/Makefile           |   1 +
 drivers/hwspinlock/stm32_hwspinlock.c | 147 ++++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 drivers/hwspinlock/stm32_hwspinlock.c

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index e895d29500ee..e1a20b460590 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -59,3 +59,12 @@ config HSEM_U8500
 	  SoC.
 
 	  If unsure, say N.
+
+config HWSPINLOCK_STM32
+	tristate "STM32 Hardware Spinlock device"
+	depends on MACH_STM32MP157
+	depends on HWSPINLOCK
+	help
+	  Say y here to support the STM32 Hardware Spinlock device.
+
+	  If unsure, say N.
diff --git a/drivers/hwspinlock/Makefile b/drivers/hwspinlock/Makefile
index b87c01a506a4..c0a9505b4dcf 100644
--- a/drivers/hwspinlock/Makefile
+++ b/drivers/hwspinlock/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_HWSPINLOCK_QCOM)		+= qcom_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SIRF)		+= sirf_hwspinlock.o
 obj-$(CONFIG_HWSPINLOCK_SPRD)		+= sprd_hwspinlock.o
 obj-$(CONFIG_HSEM_U8500)		+= u8500_hsem.o
+obj-$(CONFIG_HWSPINLOCK_STM32)		+= stm32_hwspinlock.o
diff --git a/drivers/hwspinlock/stm32_hwspinlock.c b/drivers/hwspinlock/stm32_hwspinlock.c
new file mode 100644
index 000000000000..6a0fafac7389
--- /dev/null
+++ b/drivers/hwspinlock/stm32_hwspinlock.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics SA 2018
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ * License terms:  GNU General Public License (GPL), version 2
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
+	hw->clk = devm_clk_get(&pdev->dev, "hwspinlock");
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
+	if (ret) {
+		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
+		return ret;
+	}
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

