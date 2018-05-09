Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965972AbeEIR2h (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:28:37 -0400
Received: from vern.gendns.com ([206.190.152.46]:52104 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965671AbeEIR1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:17 -0400
From: David Lechner <david@lechnology.com>
To: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org,
        David Lechner <david@lechnology.com>
Subject: [PATCH v10 25/27] ARM: davinci: add device tree support to timer
Date: Wed,  9 May 2018 12:26:04 -0500
Message-Id: <20180509172606.29387-26-david@lechnology.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509172606.29387-1-david@lechnology.com>
References: <20180509172606.29387-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device tree support to the davinci timer so that when clocks
are moved to device tree, the timer will still work.

Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- change compatible to "ti,da830-timer"
- remove comment clocks as platform devices

v9 changes:
- none (there were supposed to be changed, but apparently they got squashed
  into the next commit - will fix on the next round)

v8 changes:
- none

v7 changes:
- rebased
- add davinci prefix to commit message

v6 changes:
- rebased


 arch/arm/mach-davinci/Kconfig |  1 +
 arch/arm/mach-davinci/time.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index ba9912b4dfab..da8a039d65f9 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -59,6 +59,7 @@ config MACH_DA8XX_DT
 	default y
 	depends on ARCH_DAVINCI_DA850
 	select PINCTRL
+	select TIMER_OF
 	help
 	  Say y here to include support for TI DaVinci DA850 based using
 	  Flattened Device Tree. More information at Documentation/devicetree
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 7ea3db0ff062..184e72922cc1 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/sched_clock.h>
 
@@ -397,3 +398,34 @@ void __init davinci_timer_init(struct clk *timer_clk)
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
 }
+
+static int __init of_davinci_timer_init(struct device_node *np)
+{
+	struct clk *clk;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		struct of_phandle_args clkspec;
+
+		/*
+		 * Fall back to using ref_clk if the actual clock is not
+		 * available. There will be problems later if the real clock
+		 * source is disabled.
+		 */
+
+		pr_warn("%s: falling back to ref_clk\n", __func__);
+
+		clkspec.np = of_find_node_by_name(NULL, "ref_clk");
+		if (IS_ERR(clkspec.np)) {
+			pr_err("%s: No clock available for timer!\n", __func__);
+			return PTR_ERR(clkspec.np);
+		}
+		clk = of_clk_get_from_provider(&clkspec);
+		of_node_put(clkspec.np);
+	}
+
+	davinci_timer_init(clk);
+
+	return 0;
+}
+TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_init);
-- 
2.17.0
