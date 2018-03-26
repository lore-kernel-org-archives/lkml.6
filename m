Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeCZNUD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 09:20:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42753 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbeCZNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 09:20:01 -0400
Date: Mon, 26 Mar 2018 06:19:49 -0700
From: tip-bot for Ivan Gorinov <tipbot@zytor.com>
Message-ID: <tip-4e07db9c8db87e3b71be4c3cd626ddc9bacd5a1e@git.kernel.org>
Cc: andy.shevchenko@gmail.com, ivan.gorinov@intel.com, tglx@linutronix.de,
        frowand.list@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org
Reply-To: ivan.gorinov@intel.com, tglx@linutronix.de,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, hpa@zytor.com, mingo@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com
In-Reply-To: <c291fb2cef51b730b59916d7745be0eaa4378c6c.1521753738.git.ivan.gorinov@intel.com>
References: <c291fb2cef51b730b59916d7745be0eaa4378c6c.1521753738.git.ivan.gorinov@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/devicetree: Use CPU description from Device
 Tree
Git-Commit-ID: 4e07db9c8db87e3b71be4c3cd626ddc9bacd5a1e
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

Commit-ID:  4e07db9c8db87e3b71be4c3cd626ddc9bacd5a1e
Gitweb:     https://git.kernel.org/tip/4e07db9c8db87e3b71be4c3cd626ddc9bacd5a1e
Author:     Ivan Gorinov <ivan.gorinov@intel.com>
AuthorDate: Thu, 22 Mar 2018 14:35:47 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 26 Mar 2018 15:13:32 +0200

x86/devicetree: Use CPU description from Device Tree

Current x86 Device Tree implementation does not support multiprocessing.
Use new DT bindings to describe the processors.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Link: https://lkml.kernel.org/r/c291fb2cef51b730b59916d7745be0eaa4378c6c.1521753738.git.ivan.gorinov@intel.com

---
 arch/x86/kernel/devicetree.c | 45 ++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd387fcc777..c9d2b19749b8 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -131,34 +131,52 @@ static void __init dtb_setup_hpet(void)
 #endif
 }
 
+#ifdef CONFIG_X86_LOCAL_APIC
+
+static void __init dtb_cpu_setup(void)
+{
+	struct device_node *dn;
+	u32 apic_id, version;
+	int ret;
+
+	version = GET_APIC_VERSION(apic_read(APIC_LVR));
+	for_each_node_by_type(dn, "cpu") {
+		ret = of_property_read_u32(dn, "reg", &apic_id);
+		if (ret < 0) {
+			pr_warn("%pOF: missing local APIC ID\n", dn);
+			continue;
+		}
+		generic_processor_info(apic_id, version);
+	}
+}
+
 static void __init dtb_lapic_setup(void)
 {
-#ifdef CONFIG_X86_LOCAL_APIC
 	struct device_node *dn;
 	struct resource r;
+	unsigned long lapic_addr = APIC_DEFAULT_PHYS_BASE;
 	int ret;
 
 	dn = of_find_compatible_node(NULL, NULL, "intel,ce4100-lapic");
-	if (!dn)
-		return;
-
-	ret = of_address_to_resource(dn, 0, &r);
-	if (WARN_ON(ret))
-		return;
+	if (dn) {
+		ret = of_address_to_resource(dn, 0, &r);
+		if (WARN_ON(ret))
+			return;
+		lapic_addr = r.start;
+	}
 
 	/* Did the boot loader setup the local APIC ? */
 	if (!boot_cpu_has(X86_FEATURE_APIC)) {
-		if (apic_force_enable(r.start))
+		if (apic_force_enable(lapic_addr))
 			return;
 	}
 	smp_found_config = 1;
 	pic_mode = 1;
-	register_lapic_address(r.start);
-	generic_processor_info(boot_cpu_physical_apicid,
-			       GET_APIC_VERSION(apic_read(APIC_LVR)));
-#endif
+	register_lapic_address(lapic_addr);
 }
 
+#endif /* CONFIG_X86_LOCAL_APIC */
+
 #ifdef CONFIG_X86_IO_APIC
 static unsigned int ioapic_id;
 
@@ -259,7 +277,10 @@ static void __init dtb_ioapic_setup(void) {}
 
 static void __init dtb_apic_setup(void)
 {
+#ifdef CONFIG_X86_LOCAL_APIC
 	dtb_lapic_setup();
+	dtb_cpu_setup();
+#endif
 	dtb_ioapic_setup();
 }
 
