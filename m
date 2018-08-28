Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419CDC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044E62084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 044E62084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbeH1TpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:45:02 -0400
Received: from foss.arm.com ([217.140.101.70]:41184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbeH1TpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:45:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13A7115BF;
        Tue, 28 Aug 2018 08:52:45 -0700 (PDT)
Received: from e112298-lin.Emea.Arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D2A483F557;
        Tue, 28 Aug 2018 08:52:42 -0700 (PDT)
From:   Julien Thierry <julien.thierry@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, daniel.thompson@linaro.org,
        joel@joelfernandes.org, marc.zyngier@arm.com, mark.rutland@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Julien Thierry <julien.thierry@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v5 24/27] irqchip/gic-v3: Detect current view of GIC priorities
Date:   Tue, 28 Aug 2018 16:51:34 +0100
Message-Id: <1535471497-38854-25-git-send-email-julien.thierry@arm.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
References: <1535471497-38854-1-git-send-email-julien.thierry@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values non secure EL1 needs to use for PMR and RPR registers depends on
the value of SCR_EL3.FIQ.

The values non secure EL1 sees from the distributor and redistributor
depend on whether security is enabled for the GIC or not.

Figure out what values we are dealing with to know if the values we use for
PMR and RPR match the priority values that have been configured in the
distributor and redistributors.

Also, add firmware requirements related to SCR_EL3.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/booting.txt |  5 +++++
 drivers/irqchip/irq-gic-v3.c    | 42 +++++++++++++++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 8d0df62..e387938 100644
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
index 56d1fb9..ffe98e8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -63,6 +63,28 @@ struct gic_chip_data {
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
+ */
+DEFINE_STATIC_KEY_FALSE(have_non_secure_prio_view);
+
 static struct gic_kvm_info gic_v3_kvm_info;
 static DEFINE_PER_CPU(bool, has_rss);
 
@@ -568,6 +590,12 @@ static void gic_update_vlpi_properties(void)
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
@@ -593,6 +621,9 @@ static void gic_cpu_sys_reg_init(void)
 	/* Set priority mask register */
 	if (!gic_prio_masking_enabled())
 		write_gicreg(DEFAULT_PMR_VALUE, ICC_PMR_EL1);
+	else if (static_branch_likely(&have_non_secure_prio_view) && group0)
+		/* Mismatch configuration with boot CPU */
+		WARN_ON(group0 && !gic_dist_security_disabled());
 
 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
@@ -845,12 +876,6 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
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
@@ -1161,6 +1186,11 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_cpu_init();
 	gic_cpu_pm_init();
 
+	if (gic_prio_masking_enabled()) {
+		if (!gic_has_group0() || gic_dist_security_disabled())
+			static_branch_enable(&have_non_secure_prio_view);
+	}
+
 	return 0;
 
 out_free:
-- 
1.9.1

