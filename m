Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbeB0BnZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 20:43:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:25081 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeB0BnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 20:43:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="20578500"
Message-ID: <1519695367.58658.141.camel@intel.com>
Subject: [PATCH] x86: devicetree: enable multiprocessing and interrupt
 setting in DT
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Date: Mon, 26 Feb 2018 17:36:07 -0800
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86-specific Device Tree implementation only supported single CPU,
and IRQ allocation from DT parameters was broken in recent versions.

This change enables multiprocessing and fixes broken IRQ allocation.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 arch/x86/kernel/devicetree.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 25de5f6..f885eab 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -130,6 +130,29 @@ static void __init dtb_setup_hpet(void)
 #endif
 }
 
+static void __init dtb_cpu_setup(void)
+{
+	struct device_node *dn;
+	struct resource r;
+	const void *prop;
+	int apic_id, version;
+	int ret;
+
+	version = GET_APIC_VERSION(apic_read(APIC_LVR));
+	for_each_node_by_type(dn, "cpu") {
+		prop = of_get_property(dn, "intel,apic-id", NULL);
+		if (prop) {
+			apic_id = be32_to_cpup(prop);
+		} else {
+			ret = of_address_to_resource(dn, 0, &r);
+			if (WARN_ON(ret))
+				continue;
+			apic_id = r.start;
+		}
+		generic_processor_info(apic_id, version);
+	}
+}
+
 static void __init dtb_lapic_setup(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -153,8 +176,6 @@ static void __init dtb_lapic_setup(void)
 	smp_found_config = 1;
 	pic_mode = 1;
 	register_lapic_address(r.start);
-	generic_processor_info(boot_cpu_physical_apicid,
-			       GET_APIC_VERSION(apic_read(APIC_LVR)));
 #endif
 }
 
@@ -194,19 +215,22 @@ static struct of_ioapic_type of_ioapic_type[] =
 static int dt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 			      unsigned int nr_irqs, void *arg)
 {
-	struct of_phandle_args *irq_data = (void *)arg;
+	struct irq_fwspec *fwspec = (struct irq_fwspec *)arg;
 	struct of_ioapic_type *it;
 	struct irq_alloc_info tmp;
+	int type_index;
 
-	if (WARN_ON(irq_data->args_count < 2))
+	if (WARN_ON(fwspec->param_count < 2))
 		return -EINVAL;
-	if (irq_data->args[1] >= ARRAY_SIZE(of_ioapic_type))
+
+	type_index = fwspec->param[1];
+	if (type_index >= ARRAY_SIZE(of_ioapic_type))
 		return -EINVAL;
 
-	it = &of_ioapic_type[irq_data->args[1]];
+	it = &of_ioapic_type[type_index];
 	ioapic_set_alloc_attr(&tmp, NUMA_NO_NODE, it->trigger, it->polarity);
 	tmp.ioapic_id = mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));
-	tmp.ioapic_pin = irq_data->args[0];
+	tmp.ioapic_pin = fwspec->param[0];
 
 	return mp_irqdomain_alloc(domain, virq, nr_irqs, &tmp);
 }
@@ -256,6 +280,7 @@ static void __init dtb_ioapic_setup(void) {}
 static void __init dtb_apic_setup(void)
 {
 	dtb_lapic_setup();
+	dtb_cpu_setup();
 	dtb_ioapic_setup();
 }
 
@@ -278,6 +303,8 @@ static void __init x86_flattree_get_config(void)
 		map_len = size;
 	}
 
+	early_init_dt_verify(dt);
+
 	unflatten_and_copy_device_tree();
 	early_memunmap(dt, map_len);
 }
-- 
2.7.4
