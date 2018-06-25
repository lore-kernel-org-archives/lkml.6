Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ACCC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C90255EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C90255EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeFYIam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:30:42 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:51815 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753218AbeFYIaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:30:39 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 25 Jun 2018 17:30:36 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id DA9BA6F606;
        Mon, 25 Jun 2018 17:30:36 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.51,269,1526310000"; 
   d="scan'208";a="284991628"
Received: from unknown (HELO be1yocto.ree.adwin.renesas.com) ([172.29.43.62])
  by relmlii2.idc.renesas.com with ESMTP; 25 Jun 2018 17:30:32 +0900
From:   Michel Pollet <michel.pollet@bp.renesas.com>
To:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>
Cc:     phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Carlo Caione <carlo@endlessm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
Date:   Mon, 25 Jun 2018 09:25:05 +0100
Message-Id: <1529915110-5867-3-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529915110-5867-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1529915110-5867-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time, it
requires a special enable method to get it started.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/smp-r9a06g032.c | 96 ++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/smp-r9a06g032.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 05ba728..d24d9c9 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_ARCH_R8A7793)	+= regulator-quirk-rcar-gen2.o
 smp-y				:= $(cpu-y)
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
+smp-$(CONFIG_ARCH_R9A06G032)	+= smp-r9a06g032.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # PM objects
diff --git a/arch/arm/mach-shmobile/smp-r9a06g032.c b/arch/arm/mach-shmobile/smp-r9a06g032.c
new file mode 100644
index 0000000..a1926e8
--- /dev/null
+++ b/arch/arm/mach-shmobile/smp-r9a06g032.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * R9A06G032 Second CA7 enabler.
+ *
+ * Copyright (C) 2018 Renesas Electronics Europe Limited
+ *
+ * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
+ * Derived from actions,s500-smp
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+
+/*
+ * The second CPU is parked in ROM at boot time. It requires waking it after
+ * writing an address into the BOOTADDR register of sysctrl.
+ *
+ * So the default value of the "cpu-release-addr" corresponds to BOOTADDR...
+ *
+ * *However* the BOOTADDR register is not available when the kernel
+ * starts in NONSEC mode.
+ *
+ * So for NONSEC mode, the bootloader re-parks the second CPU into a pen
+ * in SRAM, and changes the "cpu-release-addr" of linux's DT to a SRAM address,
+ * which is not restricted.
+ */
+
+static void __iomem *cpu_bootaddr;
+
+static DEFINE_SPINLOCK(cpu_lock);
+
+static int
+r9a06g032_smp_boot_secondary(unsigned int cpu,
+			     struct task_struct *idle)
+{
+	if (!cpu_bootaddr)
+		return -ENODEV;
+
+	spin_lock(&cpu_lock);
+
+	writel(__pa_symbol(secondary_startup), cpu_bootaddr);
+	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+
+	spin_unlock(&cpu_lock);
+
+	return 0;
+}
+
+static void __init r9a06g032_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *dn;
+	int ret = -EINVAL, dns;
+	u32 bootaddr;
+
+	dn = of_get_cpu_node(1, NULL);
+	if (!dn) {
+		pr_err("CPU#1: missing device tree node\n");
+		return;
+	}
+	/*
+	 * Determine the address from which the CPU is polling.
+	 * The bootloader *does* change this property.
+	 * Note: The property can be either 64 or 32 bits, so handle both cases
+	 */
+	if (of_find_property(dn, "cpu-release-addr", &dns)) {
+		if (dns == sizeof(u64)) {
+			u64 temp;
+
+			ret = of_property_read_u64(dn,
+						   "cpu-release-addr", &temp);
+			bootaddr = temp;
+		} else {
+			ret = of_property_read_u32(dn,
+						   "cpu-release-addr",
+						   &bootaddr);
+		}
+	}
+	of_node_put(dn);
+	if (ret) {
+		pr_err("CPU#1: invalid cpu-release-addr property\n");
+		return;
+	}
+	pr_info("CPU#1: cpu-release-addr %08x\n", bootaddr);
+
+	cpu_bootaddr = ioremap(bootaddr, sizeof(bootaddr));
+}
+
+static const struct smp_operations r9a06g032_smp_ops __initconst = {
+	.smp_prepare_cpus = r9a06g032_smp_prepare_cpus,
+	.smp_boot_secondary = r9a06g032_smp_boot_secondary,
+};
+
+CPU_METHOD_OF_DECLARE(r9a06g032_smp,
+		      "renesas,r9a06g032-smp", &r9a06g032_smp_ops);
-- 
2.7.4

