Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbeCHJEc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 04:04:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40391 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbeCHJE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 04:04:27 -0500
Date: Thu, 8 Mar 2018 01:04:15 -0800
From: tip-bot for Ivan Gorinov <tipbot@zytor.com>
Message-ID: <tip-0a5169add90e43ab45ab1ba34223b8583fcaf675@git.kernel.org>
Cc: robh+dt@kernel.org, ivan.gorinov@intel.com, hpa@zytor.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org
Reply-To: ivan.gorinov@intel.com, hpa@zytor.com, robh+dt@kernel.org,
        mingo@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <a234dee27ea60ce76141872da0d6bdb378b2a9ee.1520450752.git.ivan.gorinov@intel.com>
References: <a234dee27ea60ce76141872da0d6bdb378b2a9ee.1520450752.git.ivan.gorinov@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/devicetree: Fix device IRQ settings in DT
Git-Commit-ID: 0a5169add90e43ab45ab1ba34223b8583fcaf675
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0a5169add90e43ab45ab1ba34223b8583fcaf675
Gitweb:     https://git.kernel.org/tip/0a5169add90e43ab45ab1ba34223b8583fcaf675
Author:     Ivan Gorinov <ivan.gorinov@intel.com>
AuthorDate: Wed, 7 Mar 2018 11:46:53 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 09:59:53 +0100

x86/devicetree: Fix device IRQ settings in DT

IRQ parameters for the SoC devices connected directly to I/O APIC lines
(without PCI IRQ routing) may be specified in the Device Tree.

Called from DT IRQ parser, irq_create_fwspec_mapping() calls
irq_domain_alloc_irqs() with a pointer to irq_fwspec structure as @arg.

But x86-specific DT IRQ allocation code casts @arg to of_phandle_args
structure pointer and crashes trying to read the IRQ parameters. The
function was not converted when the mapping descriptor was changed to
irq_fwspec in the generic irqdomain code.

Fixes: 11e4438ee330 ("irqdomain: Introduce a firmware-specific IRQ specifier structure")
Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Link: https://lkml.kernel.org/r/a234dee27ea60ce76141872da0d6bdb378b2a9ee.1520450752.git.ivan.gorinov@intel.com

---
 arch/x86/kernel/devicetree.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 63d2ebc21825..5cd387fcc777 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -195,19 +195,22 @@ static struct of_ioapic_type of_ioapic_type[] =
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
