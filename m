Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753053AbeEVUpm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:45:42 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37290 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeEVUpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:45:41 -0400
X-Google-Smtp-Source: AB8JxZoAPmg3Z9CI/Vqhj1xvmYOx8KteEIjvjosGkS2ovKI8zekCYv1EnNmMmLkGuvNV0r7tSZnyDA==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: sboyd@kernel.org, mturquette@baylibre.com
Cc: leo.yan@linaro.org, olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH V2] clk/driver/hisi: Consolidate the Kconfig for the CLOCK_STUB
Date: Tue, 22 May 2018 22:45:28 +0200
Message-Id: <1527021928-1243-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527021018-31698-1-git-send-email-daniel.lezcano@linaro.org>
References: <1527021018-31698-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Split the patch into the clk specific and resent as requested by Olof
Johansson.
---
 drivers/clk/hisilicon/Kconfig | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

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
-- 
2.7.4
