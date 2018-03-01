Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163078AbeCAXOa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:14:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:10146 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162811AbeCAXO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:14:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="208215639"
Date: Thu, 1 Mar 2018 15:07:07 -0800
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 3/3] x86: devicetree: fix device IRQ settings in DT
Message-ID: <20180301230707.GA48545@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ parameters for SoC devices connected directly to I/O APIC lines
(without PCI IRQ routing) may be specified in the Device Tree.
Called from DT IRQ parser, irq_create_fwspec_mapping() calls
irq_domain_alloc_irqs() with a pointer to irq_fwspec structure as @arg.
But x86-specific DT IRQ allocation code casts @arg to of_phandle_args
structure pointer and crashes trying to read IRQ parameters.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 arch/x86/kernel/devicetree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index ef1cd85..b8b5874 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -215,19 +215,22 @@ static struct of_ioapic_type of_ioapic_type[] =
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
-- 
2.7.4
