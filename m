Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932599AbeBUJkv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:40:51 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39273 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932579AbeBUJkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:40:49 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 3/3] ARC: setup cpu possible mask according to possible-cpus dts property
Date: Wed, 21 Feb 2018 12:40:27 +0300
Message-Id: <20180221094027.12674-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180221094027.12674-1-Eugeniy.Paltsev@synopsys.com>
References: <20180221094027.12674-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have option in u-boot to set CPU mask for running linux,
we want to pass information to kernel about CPU cores should
be brought up. So we patch kernel dtb in u-boot to set
possible-cpus property.

This also allows us to have correctly setuped MCIP debug mask.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/smp.c | 50 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index efe8b42..21d86c3 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -24,6 +24,7 @@
 #include <linux/reboot.h>
 #include <linux/irqdomain.h>
 #include <linux/export.h>
+#include <linux/of_fdt.h>
 
 #include <asm/processor.h>
 #include <asm/setup.h>
@@ -47,6 +48,42 @@ void __init smp_prepare_boot_cpu(void)
 {
 }
 
+static int __init arc_get_cpu_map(const char *name, struct cpumask *cpumask)
+{
+	unsigned long dt_root = of_get_flat_dt_root();
+	const char *buf;
+
+	buf = of_get_flat_dt_prop(dt_root, name, NULL);
+	if (!buf)
+		return -EINVAL;
+
+	if (cpulist_parse(buf, cpumask))
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * Read from DeviceTree and setup cpu possible mask. If there is no
+ * "possible-cpus" property in DeviceTree pretend all [0..NR_CPUS-1] exist.
+ */
+static void __init arc_init_cpu_possible(void)
+{
+	struct cpumask cpumask;
+
+	if (arc_get_cpu_map("possible-cpus", &cpumask)) {
+		pr_warn("Failed to get possible-cpus from dtb, pretending all %u cpus exist\n",
+			NR_CPUS);
+
+		cpumask_setall(&cpumask);
+	}
+
+	if (!cpumask_test_cpu(0, &cpumask))
+		panic("Master cpu (cpu[0]) is missed in cpu possible mask!");
+
+	init_cpu_possible(&cpumask);
+}
+
 /*
  * Called from setup_arch() before calling setup_processor()
  *
@@ -58,10 +95,7 @@ void __init smp_prepare_boot_cpu(void)
  */
 void __init smp_init_cpus(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < NR_CPUS; i++)
-		set_cpu_possible(i, true);
+	arc_init_cpu_possible();
 
 	if (plat_smp_ops.init_early_smp)
 		plat_smp_ops.init_early_smp();
@@ -70,16 +104,12 @@ void __init smp_init_cpus(void)
 /* called from init ( ) =>  process 1 */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
-	int i;
-
 	/*
 	 * if platform didn't set the present map already, do it now
 	 * boot cpu is set to present already by init/main.c
 	 */
-	if (num_present_cpus() <= 1) {
-		for (i = 0; i < max_cpus; i++)
-			set_cpu_present(i, true);
-	}
+	if (num_present_cpus() <= 1)
+		init_cpu_present(cpu_possible_mask);
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
-- 
2.9.3
