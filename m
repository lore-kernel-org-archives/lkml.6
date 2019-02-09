Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518AC282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4B62177B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBIArf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:47:35 -0500
Received: from foss.arm.com ([217.140.101.70]:58588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfBIArb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:47:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8060A1650;
        Fri,  8 Feb 2019 16:47:31 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EAFD43F719;
        Fri,  8 Feb 2019 16:47:30 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, robert.moore@intel.com,
        erik.schmauss@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Date:   Fri,  8 Feb 2019 18:47:17 -0600
Message-Id: <20190209004718.3292087-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190209004718.3292087-1-jeremy.linton@arm.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI 6.3 adds additional fields to the MADT GICC
structure to describe SPE PPI's. We pick these out
of the cached reference to the madt_gicc structure
similarly to the core PMU code. We then create a platform
device referring to the IRQ and let the user/module loader
decide whether to load the SPE driver.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/acpi.h |  3 ++
 drivers/perf/arm_pmu_acpi.c   | 67 +++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 2def77ec14be..f9f9f2eb5d54 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -40,6 +40,9 @@
 	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
 	(unsigned long)(entry) + (entry)->header.length > (end))
 
+#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
+	spe_overflow_interrupt) + sizeof(u16))
+
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 0f197516d708..725d413b47dc 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -74,6 +74,71 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
 	acpi_unregister_gsi(gsi);
 }
 
+static struct resource spe_resources[] = {
+	{
+		/* irq */
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device spe_dev = {
+	.name = "arm,spe-v1",
+	.id = -1,
+	.resource = spe_resources,
+	.num_resources = ARRAY_SIZE(spe_resources)
+};
+
+/*
+ * For lack of a better place, hook the normal PMU MADT walk
+ * and create a SPE device if we detect a recent MADT with
+ * a homogeneous PPI mapping.
+ */
+static int arm_spe_acpi_parse_irqs(void)
+{
+	int cpu, ret, irq;
+	u16 gsi = 0;
+	bool first = true;
+
+	struct acpi_madt_generic_interrupt *gicc;
+
+	/*
+	 * sanity check all the GICC tables for the same interrupt number
+	 * for now we only support homogeneous ACPI/SPE machines.
+	 */
+	for_each_possible_cpu(cpu) {
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+
+		if (gicc->header.length < ACPI_MADT_GICC_SPE)
+			return -ENODEV;
+
+		if (first) {
+			gsi = gicc->spe_overflow_interrupt;
+			if (!gsi)
+				return -ENODEV;
+			first = false;
+		} else if (gsi != gicc->spe_overflow_interrupt) {
+			pr_warn("ACPI: SPE must have homogeneous interrupts\n");
+			return -EINVAL;
+		}
+	}
+
+	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
+				ACPI_ACTIVE_HIGH);
+	if (irq < 0) {
+		pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
+		return irq;
+	}
+
+	spe_resources[0].start = irq;
+	ret = platform_device_register(&spe_dev);
+	if (ret < 0) {
+		pr_warn("ACPI: SPE: Unable to register device\n");
+		acpi_unregister_gsi(gsi);
+	}
+
+	return ret;
+}
+
 static int arm_pmu_acpi_parse_irqs(void)
 {
 	int irq, cpu, irq_cpu, err;
@@ -279,6 +344,8 @@ static int arm_pmu_acpi_init(void)
 	if (acpi_disabled)
 		return 0;
 
+	arm_spe_acpi_parse_irqs(); /* failures are expected */
+
 	ret = arm_pmu_acpi_parse_irqs();
 	if (ret)
 		return ret;
-- 
2.17.2

