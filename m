Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2DEC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4565C218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733251AbfAaPAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:00:05 -0500
Received: from foss.arm.com ([217.140.101.70]:45696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733166AbfAaPAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:00:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5175F165C;
        Thu, 31 Jan 2019 07:00:01 -0800 (PST)
Received: from e112298-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 19F183F59C;
        Thu, 31 Jan 2019 06:59:58 -0800 (PST)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v10 19/25] irqchip/gic-v3: Detect if GIC can support pseudo-NMIs
Date:   Thu, 31 Jan 2019 14:58:57 +0000
Message-Id: <1548946743-38979-20-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values non secure EL1 needs to use for PMR and RPR registers depends on
the value of SCR_EL3.FIQ.

The values non secure EL1 sees from the distributor and redistributor
depend on whether security is enabled for the GIC or not.

To avoid having to deal with two sets of values for PMR
masking/unmasking, only enable pseudo-NMIs when GIC has non-secure view
of priorities.

Also, add firmware requirements related to SCR_EL3.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/booting.txt |  5 ++++
 drivers/irqchip/irq-gic-v3.c    | 66 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 8df9f46..fbab7e2 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -188,6 +188,11 @@ Before jumping into the kernel, the following conditions must be met:
   the kernel image will be entered must be initialised by software at a
   higher exception level to prevent execution in an UNKNOWN state.
 
+  - SCR_EL3.FIQ must have the same value across all CPUs the kernel is
+    executing on.
+  - The value of SCR_EL3.FIQ must be the same as the one present at boot
+    time whenever the kernel is executing.
+
   For systems with a GICv3 interrupt controller to be used in v3 mode:
   - If EL3 is present:
     ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5a703ae..eb9d948 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -66,6 +66,31 @@ struct gic_chip_data {
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
+/*
+ * The behaviours of RPR and PMR registers differ depending on the value of
+ * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of the
+ * distributor and redistributors depends on whether security is enabled in the
+ * GIC.
+ *
+ * When security is enabled, non-secure priority values from the (re)distributor
+ * are presented to the GIC CPUIF as follow:
+ *     (GIC_(R)DIST_PRI[irq] >> 1) | 0x80;
+ *
+ * If SCR_EL3.FIQ == 1, the values writen to/read from PMR and RPR at non-secure
+ * EL1 are subject to a similar operation thus matching the priorities presented
+ * from the (re)distributor when security is enabled.
+ *
+ * see GICv3/GICv4 Architecture Specification (IHI0069D):
+ * - section 4.8.1 Non-secure accesses to register fields for Secure interrupt
+ *   priorities.
+ * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
+ *   interrupt.
+ *
+ * For now, we only support pseudo-NMIs if we have non-secure view of
+ * priorities.
+ */
+static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
+
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);
 
@@ -232,6 +257,12 @@ static void gic_unmask_irq(struct irq_data *d)
 	gic_poke_irq(d, GICD_ISENABLER);
 }
 
+static inline bool gic_supports_nmi(void)
+{
+	return IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) &&
+	       static_branch_likely(&supports_pseudo_nmis);
+}
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
@@ -573,6 +604,12 @@ static void gic_update_vlpi_properties(void)
 		!gic_data.rdists.has_direct_lpi ? "no " : "");
 }
 
+/* Check whether it's single security state view */
+static inline bool gic_dist_security_disabled(void)
+{
+	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
+}
+
 static void gic_cpu_sys_reg_init(void)
 {
 	int i, cpu = smp_processor_id();
@@ -596,8 +633,17 @@ static void gic_cpu_sys_reg_init(void)
 	group0 = gic_has_group0();
 
 	/* Set priority mask register */
-	if (!gic_prio_masking_enabled())
+	if (!gic_prio_masking_enabled()) {
 		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	} else {
+		/*
+		 * Mismatch configuration with boot CPU, the system is likely
+		 * to die as interrupt masking will not work properly on all
+		 * CPUs
+		 */
+		WARN_ON(gic_supports_nmi() && group0 &&
+			!gic_dist_security_disabled());
+	}
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
@@ -852,12 +898,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #endif
 
 #ifdef CONFIG_CPU_PM
-/* Check whether it's single security state view */
-static bool gic_dist_security_disabled(void)
-{
-	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
-}
-
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
@@ -1110,6 +1150,11 @@ static bool gic_enable_quirk_msm8996(void *data)
 	return true;
 }
 
+static void gic_enable_nmi_support(void)
+{
+	static_branch_enable(&supports_pseudo_nmis);
+}
+
 static int __init gic_init_bases(void __iomem *dist_base,
 				 struct redist_region *rdist_regs,
 				 u32 nr_redist_regions,
@@ -1179,6 +1224,13 @@ static int __init gic_init_bases(void __iomem *dist_base,
 		its_cpu_init();
 	}
 
+	if (gic_prio_masking_enabled()) {
+		if (!gic_has_group0() || gic_dist_security_disabled())
+			gic_enable_nmi_support();
+		else
+			pr_warn("SCR_EL3.FIQ is cleared, cannot enable use of pseudo-NMIs\n");
+	}
+
 	return 0;
 
 out_free:
-- 
1.9.1

