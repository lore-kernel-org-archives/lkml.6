Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeCLWaO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:30:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:33537 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932252AbeCLWaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:30:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,463,1515484800";
   d="scan'208";a="41375448"
Date: Mon, 12 Mar 2018 15:22:33 -0700
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 2/2] x86/devicetree: Use CPU description from Device Tree
Message-ID: <789dcb8b2c87d1e370dc68b7058ee4fe0e877b9d.1520891263.git.ivan.gorinov@intel.com>
References: <cover.1520891263.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520891263.git.ivan.gorinov@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current x86 Device Tree implementation does not support multiprocessing.
Use new DT bindings to describe the processors.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 arch/x86/kernel/devicetree.c | 42 +++++++++++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd387f..64671db 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -131,31 +131,49 @@ static void __init dtb_setup_hpet(void)
 #endif
 }
 
+static void __init dtb_cpu_setup(void)
+{
+	struct device_node *dn;
+	const void *prop;
+	int prop_bytes;
+	int apic_id, version;
+	int ret;
+
+	version = GET_APIC_VERSION(apic_read(APIC_LVR));
+	for_each_node_by_type(dn, "cpu") {
+		prop = of_get_property(dn, "reg", &prop_bytes);
+		if (!prop || prop_bytes < sizeof(u32)) {
+			pr_warn("%pOF: missing local APIC ID\n", dn);
+			continue;
+		}
+		apic_id = be32_to_cpup(prop);
+		generic_processor_info(apic_id, version);
+	}
+}
+
 static void __init dtb_lapic_setup(void)
 {
 #ifdef CONFIG_X86_LOCAL_APIC
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
-	smp_found_config = 1;
 	pic_mode = 1;
-	register_lapic_address(r.start);
-	generic_processor_info(boot_cpu_physical_apicid,
-			       GET_APIC_VERSION(apic_read(APIC_LVR)));
+	register_lapic_address(lapic_addr);
 #endif
 }
 
@@ -260,6 +278,7 @@ static void __init dtb_ioapic_setup(void) {}
 static void __init dtb_apic_setup(void)
 {
 	dtb_lapic_setup();
+	dtb_cpu_setup();
 	dtb_ioapic_setup();
 }
 
@@ -297,6 +316,7 @@ void __init x86_dtb_init(void)
 	if (!of_have_populated_dt())
 		return;
 
+	smp_found_config = 1;
 	dtb_setup_hpet();
 	dtb_apic_setup();
 }
-- 
2.7.4
