Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeETKQb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 06:16:31 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40797 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeETKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 06:16:28 -0400
X-Google-Smtp-Source: AB8JxZreFvDIGdQrBBmGilIYW7GzUE61QpBdDGftDZr52J2gKAqosFfMbeEejd40HgJyK1NlPa1ehg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v1 5/5] ARM: tegra: Always boot CPU in ARM-mode
Date: Sun, 20 May 2018 13:15:42 +0300
Message-Id: <20180520101542.12206-6-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180520101542.12206-1-digetx@gmail.com>
References: <20180520101542.12206-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU always jumps into the reset handler in ARM-mode from the Trusted
Foundations firmware, hence make CPU to always jump into kernel in
ARM-mode regardless of the firmware presence to support Thumb2 kernel + TF
case.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 arch/arm/mach-tegra/reset.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index d84c74a95806..7e15c3bdf118 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -115,6 +115,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
index b02ae7699842..3f1ef4561298 100644
--- a/arch/arm/mach-tegra/reset.c
+++ b/arch/arm/mach-tegra/reset.c
@@ -97,7 +97,7 @@ void __init tegra_cpu_reset_handler_init(void)
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
 		*((u32 *)cpu_possible_mask);
 	__tegra_cpu_reset_handler_data[TEGRA_RESET_STARTUP_SECONDARY] =
-		__pa_symbol((void *)secondary_startup);
+		__pa_symbol((void *)secondary_startup_arm);
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.17.0
