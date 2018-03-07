Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935103AbeCGTzP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:55:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:27658 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933780AbeCGTzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:55:14 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,437,1515484800";
   d="scan'208";a="26072201"
Date: Wed, 7 Mar 2018 11:47:43 -0800
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 4/4] x86/devicetree: Enable multiprocessing in DT
Message-ID: <6bffd6ac6e9c3467c9b535b5bc378a5688e46f73.1520450752.git.ivan.gorinov@intel.com>
References: <cover.1520450752.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520450752.git.ivan.gorinov@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current x86 Device Tree implementation does not support multiprocessing.
Use new DT bindings to describe the processors.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 arch/x86/kernel/devicetree.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 5cd387f..b28ac84 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -131,6 +131,30 @@ static void __init dtb_setup_hpet(void)
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
+			/* use the address field as APIC ID */
+			ret = of_address_to_resource(dn, 0, &r);
+			if (WARN_ON_ONCE(ret))
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
@@ -154,8 +178,6 @@ static void __init dtb_lapic_setup(void)
 	smp_found_config = 1;
 	pic_mode = 1;
 	register_lapic_address(r.start);
-	generic_processor_info(boot_cpu_physical_apicid,
-			       GET_APIC_VERSION(apic_read(APIC_LVR)));
 #endif
 }
 
@@ -260,6 +282,7 @@ static void __init dtb_ioapic_setup(void) {}
 static void __init dtb_apic_setup(void)
 {
 	dtb_lapic_setup();
+	dtb_cpu_setup();
 	dtb_ioapic_setup();
 }
 
-- 
2.7.4
