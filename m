Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163738AbeE1Kut (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163473AbeE1Kun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 180/496] ARC: setup cpu possible mask according to possible-cpus dts property
Date: Mon, 28 May 2018 11:59:25 +0200
Message-Id: <20180528100327.528488760@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

[ Upstream commit a29a25275452c97fe35815f1eb9564f2a07a1965 ]

As we have option in u-boot to set CPU mask for running linux,
we want to pass information to kernel about CPU cores should
be brought up. So we patch kernel dtb in u-boot to set
possible-cpus property.

This also allows us to have correctly setuped MCIP debug mask.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/kernel/smp.c |   50 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 10 deletions(-)

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
