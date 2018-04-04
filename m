Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753958AbeDDDP1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 23:15:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34827 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbeDDDPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 23:15:24 -0400
X-Google-Smtp-Source: AIpwx4/sDZKLq9W5AG2MEQ17k4o0SCRsg/5WqaP4JLlGz+1Y2VH6KYaj6d/P8+llbfy2XfSRd+SLgA==
From: Leo Yan <leo.yan@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Leo Yan <leo.yan@linaro.org>, Kaihua Zhong <zhongkaihua@huawei.com>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: [PATCH 5/5] hisi: Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX
Date: Wed,  4 Apr 2018 11:14:35 +0800
Message-Id: <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
References: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The current defconfig is inconsistent as it selects the mailbox and
the clock for the hi6220 and the hi3660 without having their Kconfigs
making sure the dependencies are correct. It ends up when selecting
different versions for the kernel (for example when git bisecting)
those options disappear and they don't get back, leading to unexpected
behaviors. In our case, the cpufreq driver does no longer work because
the clock fails to initialize due to the clock stub and the mailbox
missing.

In order to have the dependencies correctly set when defaulting, let's
do the same as commit 3a49afb84ca074e ("clk: enable hi655x common clk
automatically") where we select automatically the driver when the
parent driver is selected. With sensible defaults in place, we can leave
other choices for EXPERT.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/configs/defconfig  |  1 -
 drivers/clk/hisilicon/Kconfig | 13 ++++++++-----
 drivers/mailbox/Kconfig       | 12 ++++++++----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..1d9d8b9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -549,7 +549,6 @@ CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_ARM_MHU=y
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
-CONFIG_HI6220_MBOX=y
 CONFIG_QCOM_APCS_IPC=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
index 1bd4355..becdb1d 100644
--- a/drivers/clk/hisilicon/Kconfig
+++ b/drivers/clk/hisilicon/Kconfig
@@ -44,14 +44,17 @@ config RESET_HISI
 	  Build reset controller driver for HiSilicon device chipsets.
 
 config STUB_CLK_HI6220
-	bool "Hi6220 Stub Clock Driver"
-	depends on COMMON_CLK_HI6220 && MAILBOX
-	default ARCH_HISI
+	bool "Hi6220 Stub Clock Driver" if EXPERT
+	depends on (COMMON_CLK_HI6220 || COMPILE_TEST)
+	depends on MAILBOX
+	default COMMON_CLK_HI6220
 	help
 	  Build the Hisilicon Hi6220 stub clock driver.
 
 config STUB_CLK_HI3660
-	bool "Hi3660 Stub Clock Driver"
-	depends on COMMON_CLK_HI3660 && MAILBOX
+	bool "Hi3660 Stub Clock Driver" if EXPERT
+	depends on (COMMON_CLK_HI3660 || COMPILE_TEST)
+	depends on MAILBOX
+	default COMMON_CLK_HI3660
 	help
 	  Build the Hisilicon Hi3660 stub clock driver.
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index a2bb274..567cd02 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -109,16 +109,20 @@ config TI_MESSAGE_MANAGER
 	  platform has support for the hardware block.
 
 config HI3660_MBOX
-	tristate "Hi3660 Mailbox"
-	depends on ARCH_HISI && OF
+	tristate "Hi3660 Mailbox" if EXPERT
+	depends on (ARCH_HISI || COMPILE_TEST)
+	depends on OF
+	default ARCH_HISI
 	help
 	  An implementation of the hi3660 mailbox. It is used to send message
 	  between application processors and other processors/MCU/DSP. Select
 	  Y here if you want to use Hi3660 mailbox controller.
 
 config HI6220_MBOX
-	tristate "Hi6220 Mailbox"
-	depends on ARCH_HISI
+	tristate "Hi6220 Mailbox" if EXPERT
+	depends on (ARCH_HISI || COMPILE_TEST)
+	depends on OF
+	default ARCH_HISI
 	help
 	  An implementation of the hi6220 mailbox. It is used to send message
 	  between application processors and MCU. Say Y here if you want to
-- 
1.9.1
