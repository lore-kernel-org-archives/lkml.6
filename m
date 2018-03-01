Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163072AbeCAXOK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:14:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:30415 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162811AbeCAXOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:14:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="38605567"
Date: Thu, 1 Mar 2018 15:06:40 -0800
From: Ivan Gorinov <ivan.gorinov@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 2/3] x86: devicetree: enable multiprocessing in DT
Message-ID: <20180301230640.GA48521@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding code to register the processors described in Device Tree.
APIC ID is specified in 'intel-apic_id' propery as used in U-Boot.
First address specified in 'reg' is used as default APIC ID.

Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
---
 arch/x86/kernel/devicetree.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 44189ee..ef1cd85 100644
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
@@ -153,8 +176,6 @@ static void __init dtb_lapic_setup(void)
 	smp_found_config = 1;
 	pic_mode = 1;
 	register_lapic_address(r.start);
-	generic_processor_info(boot_cpu_physical_apicid,
-			       GET_APIC_VERSION(apic_read(APIC_LVR)));
 #endif
 }
 
@@ -256,6 +277,7 @@ static void __init dtb_ioapic_setup(void) {}
 static void __init dtb_apic_setup(void)
 {
 	dtb_lapic_setup();
+	dtb_cpu_setup();
 	dtb_ioapic_setup();
 }
 
-- 
2.7.4
