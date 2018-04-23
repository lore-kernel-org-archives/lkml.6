Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AIpwx4/Ur4shSvslK3J8tByZsTMVApdL/uwaXoeEyTtA1CdsPsBAzQkerTCnCEJEswQxcieZqx/U
ARC-Seal: i=1; a=rsa-sha256; t=1524505577; cv=none;
        d=google.com; s=arc-20160816;
        b=DpjSOUesS6hkcI/JmYNRibdU5lJUxnTB6bocykznOU5SUZ1aEXSTjAIYgOFNzVslh6
         r1qlcQB/5To/1m/1wXEahRmbSmzwjGWatjFCti0ypaOLJMEXKs/rZkmn9eUBg1wne653
         yRMAPDV43MMjFnz09FmB3omH777NF+hN08wx4HrT+SPJxjln9IWteUR2TZICUK4/UBVD
         yPHLdxMrY3PhnIMd7JyHUw+u9cl97aIo/oReQ5d8rUPm3eowFJBuA9hECR1aQS+0Qpzl
         zzQFOHnO8MEI6d6JJsXKuhf8T+/6oEi/UxTBYhsh6F7UYXRYU+QmXcg7ga4r3TX45hSW
         yrpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ctaf8SbHLQBM3lzhi0+zPciLpwMryg4nRlhkvvGIdLY=;
        b=zXc9ymb/oRDM2QE42myAknXojotgaxGwRzu/8MrhKqhePSEt9O1pBnLXlZhysVHDMc
         NUKWN6ni6esyCJJBrF/MT4LSdParBDLQyBjpjPd23p3r4SmT8y+k/WQLK757HVUKAMlm
         EpMhrhISbR+6RJvNBgXQOtUZExh0buhvgH/kRZNi3WZxaUP6DYd2+L/REMlePWMFdZax
         2R4L36LGUBFivGVHNic/gtJQKs7fySNtpOzp3SoRlXtF+n9lFbZKX49g+HD8yFGKCSCC
         q1HP+u209WCXlH5/3GjZ38K2Wt9cADf/2rXJxQup0VvpnafE/GqRMODFZI3OFcikI1/G
         iyUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nishanth Menon <nm@ti.com>,
	Suman Anna <s-anna@ti.com>,
	Tero Kristo <t-kristo@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Keerthy <j-keerthy@ti.com>
Subject: [PATCH 05/16] ARM: OMAP2+: Initialize SoC PM later
Date: Mon, 23 Apr 2018 10:45:38 -0700
Message-Id: <20180423174549.57412-6-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423174549.57412-1-tony@atomide.com>
References: <20180423174549.57412-1-tony@atomide.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598559959953040733?=
X-GMAIL-MSGID: =?utf-8?q?1598559959953040733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There's no need to probe devices until at module_init time and we
currently have at least PM trying to use I2C for PMICs early on.

As only a part of the SoC init_early is SoC specific, we only need to call
the SoC specific PM init function. And we can modify omap2_common_pm_late_init()
so it becomes a late_initcall().

Note that this changes am335x to call omap2_clk_enable_autoidle_all() that
seems to be missing currently.

Cc: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h      | 16 ++++----
 arch/arm/mach-omap2/io.c          | 67 +++++--------------------------
 arch/arm/mach-omap2/pm.c          | 19 +++++++++
 arch/arm/mach-omap2/pm33xx-core.c |  4 +-
 4 files changed, 40 insertions(+), 66 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -44,6 +44,9 @@
 
 #define OMAP_INTC_START		NR_IRQS
 
+extern int (*omap_pm_soc_init)(void);
+int omap_pm_nop_init(void);
+
 #if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP2)
 int omap2_pm_init(void);
 #else
@@ -79,9 +82,12 @@ static inline int omap4_pm_init_early(void)
 
 #if defined(CONFIG_PM) && (defined(CONFIG_SOC_AM33XX) || \
 	defined(CONFIG_SOC_AM43XX))
-void amx3_common_pm_init(void);
+int amx3_common_pm_init(void);
 #else
-static inline void amx3_common_pm_init(void) { }
+static inline int amx3_common_pm_init(void)
+{
+	return 0;
+}
 #endif
 
 extern void omap2_init_common_infrastructure(void);
@@ -122,14 +128,10 @@ void am43xx_init_early(void);
 void am43xx_init_late(void);
 void omap4430_init_early(void);
 void omap5_init_early(void);
-void omap3_init_late(void);	/* Do not use this one */
+void omap3_init_late(void);
 void omap4430_init_late(void);
 void omap2420_init_late(void);
 void omap2430_init_late(void);
-void omap3430_init_late(void);
-void omap35xx_init_late(void);
-void omap3630_init_late(void);
-void am35xx_init_late(void);
 void ti81xx_init_late(void);
 void am33xx_init_late(void);
 void omap5_init_late(void);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -422,11 +422,6 @@ static void __init __maybe_unused omap_hwmod_init_postsetup(void)
 	omap_hwmod_for_each(_set_hwmod_postsetup_state, &postsetup_state);
 }
 
-static void __init __maybe_unused omap_common_late_init(void)
-{
-	omap2_common_pm_late_init();
-}
-
 #ifdef CONFIG_SOC_OMAP2420
 void __init omap2420_init_early(void)
 {
@@ -447,9 +442,7 @@ void __init omap2420_init_early(void)
 
 void __init omap2420_init_late(void)
 {
-	omap_common_late_init();
-	omap2_pm_init();
-	omap2_clk_enable_autoidle_all();
+	omap_pm_soc_init = omap2_pm_init;
 }
 #endif
 
@@ -473,9 +466,7 @@ void __init omap2430_init_early(void)
 
 void __init omap2430_init_late(void)
 {
-	omap_common_late_init();
-	omap2_pm_init();
-	omap2_clk_enable_autoidle_all();
+	omap_pm_soc_init = omap2_pm_init;
 }
 #endif
 
@@ -526,43 +517,12 @@ void __init am35xx_init_early(void)
 
 void __init omap3_init_late(void)
 {
-	omap_common_late_init();
-	omap3_pm_init();
-	omap2_clk_enable_autoidle_all();
-}
-
-void __init omap3430_init_late(void)
-{
-	omap_common_late_init();
-	omap3_pm_init();
-	omap2_clk_enable_autoidle_all();
-}
-
-void __init omap35xx_init_late(void)
-{
-	omap_common_late_init();
-	omap3_pm_init();
-	omap2_clk_enable_autoidle_all();
-}
-
-void __init omap3630_init_late(void)
-{
-	omap_common_late_init();
-	omap3_pm_init();
-	omap2_clk_enable_autoidle_all();
-}
-
-void __init am35xx_init_late(void)
-{
-	omap_common_late_init();
-	omap3_pm_init();
-	omap2_clk_enable_autoidle_all();
+	omap_pm_soc_init = omap3_pm_init;
 }
 
 void __init ti81xx_init_late(void)
 {
-	omap_common_late_init();
-	omap2_clk_enable_autoidle_all();
+	omap_pm_soc_init = omap_pm_nop_init;
 }
 #endif
 
@@ -618,8 +578,7 @@ void __init am33xx_init_early(void)
 
 void __init am33xx_init_late(void)
 {
-	omap_common_late_init();
-	amx3_common_pm_init();
+	omap_pm_soc_init = amx3_common_pm_init;
 }
 #endif
 
@@ -642,9 +601,7 @@ void __init am43xx_init_early(void)
 
 void __init am43xx_init_late(void)
 {
-	omap_common_late_init();
-	omap2_clk_enable_autoidle_all();
-	amx3_common_pm_init();
+	omap_pm_soc_init = amx3_common_pm_init;
 }
 #endif
 
@@ -672,9 +629,7 @@ void __init omap4430_init_early(void)
 
 void __init omap4430_init_late(void)
 {
-	omap_common_late_init();
-	omap4_pm_init();
-	omap2_clk_enable_autoidle_all();
+	omap_pm_soc_init = omap4_pm_init;
 }
 #endif
 
@@ -700,9 +655,7 @@ void __init omap5_init_early(void)
 
 void __init omap5_init_late(void)
 {
-	omap_common_late_init();
-	omap4_pm_init();
-	omap2_clk_enable_autoidle_all();
+	omap_pm_soc_init = omap4_pm_init;
 }
 #endif
 
@@ -725,9 +678,7 @@ void __init dra7xx_init_early(void)
 
 void __init dra7xx_init_late(void)
 {
-	omap_common_late_init();
-	omap4_pm_init();
-	omap2_clk_enable_autoidle_all();
+	omap_pm_soc_init = omap4_pm_init;
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -230,8 +230,20 @@ static void __init omap4_init_voltages(void)
 	omap2_set_init_voltage("iva", "dpll_iva_m5x2_ck", "iva");
 }
 
+int __maybe_unused omap_pm_nop_init(void)
+{
+	return 0;
+}
+
+int (*omap_pm_soc_init)(void);
+
 int __init omap2_common_pm_late_init(void)
 {
+	int error;
+
+	if (!omap_pm_soc_init)
+		return 0;
+
 	/* Init the voltage layer */
 	omap3_twl_init();
 	omap4_twl_init();
@@ -244,5 +256,12 @@ int __init omap2_common_pm_late_init(void)
 	/* Smartreflex device init */
 	omap_devinit_smartreflex();
 
+	error = omap_pm_soc_init();
+	if (error)
+		pr_warn("%s: pm soc init failed: %i\n", __func__, error);
+
+	omap2_clk_enable_autoidle_all();
+
 	return 0;
 }
+omap_late_initcall(omap2_common_pm_late_init);
diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -173,7 +173,7 @@ static struct am33xx_pm_platform_data *am33xx_pm_get_pdata(void)
 		return NULL;
 }
 
-void __init amx3_common_pm_init(void)
+int __init amx3_common_pm_init(void)
 {
 	struct am33xx_pm_platform_data *pdata;
 	struct platform_device_info devinfo;
@@ -186,4 +186,6 @@ void __init amx3_common_pm_init(void)
 	devinfo.size_data = sizeof(*pdata);
 	devinfo.id = -1;
 	platform_device_register_full(&devinfo);
+
+	return 0;
 }
-- 
2.17.0
