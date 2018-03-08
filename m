Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755912AbeCHPAc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:00:32 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47236 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeCHPA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:00:28 -0500
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Mylene Josserand <mylene.josserand@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/4] ARM: sunxi: mc-smp: Use DT enable-method for sun9i A80 SMP
Date: Thu,  8 Mar 2018 23:00:10 +0800
Message-Id: <20180308150012.19045-3-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180308150012.19045-1-wens@csie.org>
References: <20180308150012.19045-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having an early init function check the machine compatible
and installing multi-cluster SMP support for the A80 if it matches,
use a new cpu enable-method string. This makes the platform support
future proof in case anyone manages to add PSCI support.

The original init code for the SMP support is changed into the
.prepare_cpus callback in the smp_operations structure. Instead of
panicing when resources are missing like on some platforms, our code
merely guards against engaging SMP or CPU hotplug and returns an error.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/arm/cpus.txt |  1 +
 arch/arm/mach-sunxi/mc_smp.c                   | 21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
index f4a777039f03..76655d0d67c2 100644
--- a/Documentation/devicetree/bindings/arm/cpus.txt
+++ b/Documentation/devicetree/bindings/arm/cpus.txt
@@ -198,6 +198,7 @@ described below.
 			    "actions,s500-smp"
 			    "allwinner,sun6i-a31"
 			    "allwinner,sun8i-a23"
+			    "allwinner,sun9i-a80-smp"
 			    "amlogic,meson8-smp"
 			    "amlogic,meson8b-smp"
 			    "arm,realview-smp"
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 9db6c4ed5861..86e90b038555 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -690,7 +690,26 @@ static int __init sunxi_mc_smp_init(void)
 	struct resource res;
 	int ret;
 
-	if (!of_machine_is_compatible("allwinner,sun9i-a80"))
+	/*
+	 * Don't bother checking the "cpus" node, as an enable-method
+	 * property in that node is undocumented.
+	 */
+	node = of_cpu_device_node_get(0);
+	if (!node)
+		return -ENODEV;
+
+	/*
+	 * We can't actually use the enable-method magic in the kernel.
+	 * Our loopback / trampoline code uses the CPU suspend framework,
+	 * which requires the identity mapping be available. It would not
+	 * yet be available if we used the .init_cpus or .prepare_cpus
+	 * callbacks in smp_operations, which we would use if we were to
+	 * use CPU_METHOD_OF_DECLARE
+	 */
+	ret = of_property_match_string(node, "enable-method",
+				       "allwinner,sun9i-a80-smp");
+	of_node_put(node);
+	if (ret)
 		return -ENODEV;
 
 	if (!sunxi_mc_smp_cpu_table_init())
-- 
2.16.2
