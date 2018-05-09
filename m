Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935572AbeEIR1g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:27:36 -0400
Received: from vern.gendns.com ([206.190.152.46]:51917 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935540AbeEIR1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:27:02 -0400
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
Subject: [PATCH v10 04/27] ARM: davinci: pass clock as parameter to davinci_timer_init()
Date: Wed,  9 May 2018 12:25:43 -0500
Message-Id: <20180509172606.29387-5-david@lechnology.com>
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

This changes davinci_timer_init() so that we pass the clock as a
parameter instead of using clk_get(). This is done in preparation
for converting to the common clock framework.

It removes the requirement that we have to have a clock with con_id
of "timer0", which will be good for DT bindings since clock-names =
"timer0" doesn't really make sense.

Also, drop use of extern in header file since we are touching the
definition.

Reviewed-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
---

v10 changes:
- none

v9 changes:
- drop comment about using ref_clk

v8 changes:
- none

v7 changes:
- new in v7


 arch/arm/mach-davinci/da830.c               | 2 +-
 arch/arm/mach-davinci/da850.c               | 2 +-
 arch/arm/mach-davinci/dm355.c               | 2 +-
 arch/arm/mach-davinci/dm365.c               | 2 +-
 arch/arm/mach-davinci/dm644x.c              | 2 +-
 arch/arm/mach-davinci/dm646x.c              | 2 +-
 arch/arm/mach-davinci/include/mach/common.h | 3 ++-
 arch/arm/mach-davinci/time.c                | 5 +----
 8 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 350d7673aa4d..0b17e5a22e5e 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1224,5 +1224,5 @@ void __init da830_init(void)
 void __init da830_init_time(void)
 {
 	davinci_clk_init(da830_clks);
-	davinci_timer_init();
+	davinci_timer_init(&timerp64_0_clk);
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 34117e614e08..1dbf01c4124b 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1396,5 +1396,5 @@ void __init da850_init(void)
 void __init da850_init_time(void)
 {
 	davinci_clk_init(da850_clks);
-	davinci_timer_init();
+	davinci_timer_init(&timerp64_0_clk);
 }
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index f29480495c18..0da7516018ca 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1047,7 +1047,7 @@ void __init dm355_init(void)
 void __init dm355_init_time(void)
 {
 	davinci_clk_init(dm355_clks);
-	davinci_timer_init();
+	davinci_timer_init(&timer0_clk);
 }
 
 int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 1e3df9df1e10..871372a59da8 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1172,7 +1172,7 @@ void __init dm365_init(void)
 void __init dm365_init_time(void)
 {
 	davinci_clk_init(dm365_clks);
-	davinci_timer_init();
+	davinci_timer_init(&timer0_clk);
 }
 
 static struct resource dm365_vpss_resources[] = {
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index a2e8586c8a6d..708df0ed8554 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -935,7 +935,7 @@ void __init dm644x_init(void)
 void __init dm644x_init_time(void)
 {
 	davinci_clk_init(dm644x_clks);
-	davinci_timer_init();
+	davinci_timer_init(&timer0_clk);
 }
 
 int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 109ab1fa0d2c..e1d6e92f434a 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -956,7 +956,7 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	ref_clk.rate = ref_clk_rate;
 	aux_clkin.rate = aux_clkin_rate;
 	davinci_clk_init(dm646x_clks);
-	davinci_timer_init();
+	davinci_timer_init(&timer0_clk);
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index f0d5e858f158..5f45d0ac66a8 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -12,11 +12,12 @@
 #ifndef __ARCH_ARM_MACH_DAVINCI_COMMON_H
 #define __ARCH_ARM_MACH_DAVINCI_COMMON_H
 
+#include <linux/clk.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/reboot.h>
 
-extern void davinci_timer_init(void);
+void davinci_timer_init(struct clk *clk);
 
 extern void davinci_irq_init(void);
 extern void __iomem *davinci_intc_base;
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 1bb991ad9c1e..486896f309c5 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -334,10 +334,8 @@ static struct clock_event_device clockevent_davinci = {
 	.set_state_oneshot	= davinci_set_oneshot,
 };
 
-
-void __init davinci_timer_init(void)
+void __init davinci_timer_init(struct clk *timer_clk)
 {
-	struct clk *timer_clk;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	unsigned int clockevent_id;
 	unsigned int clocksource_id;
@@ -373,7 +371,6 @@ void __init davinci_timer_init(void)
 		}
 	}
 
-	timer_clk = clk_get(NULL, "timer0");
 	BUG_ON(IS_ERR(timer_clk));
 	clk_prepare_enable(timer_clk);
 
-- 
2.17.0
