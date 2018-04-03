Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755182AbeDCGWc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:22:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34654 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754885AbeDCGVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:21:02 -0400
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>
To: linux@armlinux.org.uk, maxime.ripard@bootlin.com, wens@csie.org,
        marc.zyngier@arm.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, clabbe.montjoie@gmail.com,
        quentin.schulz@bootlin.com, thomas.petazzoni@bootlin.com,
        mylene.josserand@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/13] ARM: sunxi: Add initialization of CNTVOFF
Date: Tue,  3 Apr 2018 08:18:31 +0200
Message-Id: <20180403061836.3926-9-mylene.josserand@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180403061836.3926-1-mylene.josserand@bootlin.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the initialization of CNTVOFF for sun8i-a83t.

For boot CPU, Create a new machine that handles this
function's call in an "init_early" callback.
For secondary CPUs, add this function into secondary_startup
assembly entry.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/mach-sunxi/headsmp.S |  1 +
 arch/arm/mach-sunxi/sunxi.c   | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
index 79890fbe5613..b586b7cf803a 100644
--- a/arch/arm/mach-sunxi/headsmp.S
+++ b/arch/arm/mach-sunxi/headsmp.S
@@ -71,6 +71,7 @@ ENDPROC(sunxi_mc_smp_cluster_cache_enable)
 
 ENTRY(sunxi_mc_smp_secondary_startup)
 	bl	sunxi_mc_smp_cluster_cache_enable
+	bl	smp_init_cntvoff
 	b	secondary_startup
 ENDPROC(sunxi_mc_smp_secondary_startup)
 
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 5e9602ce1573..090784108c0a 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 
 #include <asm/mach/arch.h>
+#include <asm/smp_cntvoff.h>
 
 static const char * const sunxi_board_dt_compat[] = {
 	"allwinner,sun4i-a10",
@@ -62,7 +63,6 @@ MACHINE_END
 static const char * const sun8i_board_dt_compat[] = {
 	"allwinner,sun8i-a23",
 	"allwinner,sun8i-a33",
-	"allwinner,sun8i-a83t",
 	"allwinner,sun8i-h2-plus",
 	"allwinner,sun8i-h3",
 	"allwinner,sun8i-r40",
@@ -75,6 +75,22 @@ DT_MACHINE_START(SUN8I_DT, "Allwinner sun8i Family")
 	.dt_compat	= sun8i_board_dt_compat,
 MACHINE_END
 
+void __init sun8i_cntvoff_init(void)
+{
+	smp_init_cntvoff();
+}
+
+static const char * const sun8i_cntvoff_board_dt_compat[] = {
+	"allwinner,sun8i-a83t",
+	NULL,
+};
+
+DT_MACHINE_START(SUN8I_CNTVOFF_DT, "Allwinner sun8i boards needing cntvoff")
+	.init_early	= sun8i_cntvoff_init,
+	.init_time	= sun6i_timer_init,
+	.dt_compat	= sun8i_cntvoff_board_dt_compat,
+MACHINE_END
+
 static const char * const sun9i_board_dt_compat[] = {
 	"allwinner,sun9i-a80",
 	NULL,
-- 
2.11.0
