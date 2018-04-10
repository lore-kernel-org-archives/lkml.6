Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeDJJ1P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:27:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:17268 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbeDJJ1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:27:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="219194983"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2, RESEND] x86/mm: Do not lose cpuinfo_x86::x86_phys_bits adjustment
Date: Tue, 10 Apr 2018 12:27:04 +0300
Message-Id: <20180410092704.41106-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some features (Intel MKTME, AMD SME) reduce number of effectively
available physical address bits. We adjust x86_phys_bits accordingly.

If get_cpu_cap() got called more than one time we lose this adjustement.

That's exactly what happens in setup_pku(): it gets called after
detect_tme() and cpuinfo_x86::x86_phys_bits gets overwritten.

Extract address sizes enumeration into a separate routine and get it
called only from early_identify_cpu() and from generic_identify().

It makes get_cpu_cap() safe to be called later during boot proccess
without risk to overwrite cpuinfo_x86::x86_phys_bits.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Kai Huang <kai.huang@linux.intel.com>
Fixes: cb06d8e3d020 ("x86/tme: Detect if TME and MKTME is activated by BIOS")
---
 arch/x86/kernel/cpu/common.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 348cf4821240..2981bf287ef5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -848,18 +848,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_power = edx;
 	}
 
-	if (c->extended_cpuid_level >= 0x80000008) {
-		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
-
-		c->x86_virt_bits = (eax >> 8) & 0xff;
-		c->x86_phys_bits = eax & 0xff;
-		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
-	}
-#ifdef CONFIG_X86_32
-	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
-		c->x86_phys_bits = 36;
-#endif
-
 	if (c->extended_cpuid_level >= 0x8000000a)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 
@@ -874,6 +862,23 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	apply_forced_caps(c);
 }
 
+static void get_cpu_address_sizes(struct cpuinfo_x86 *c)
+{
+	u32 eax, ebx, ecx, edx;
+
+	if (c->extended_cpuid_level >= 0x80000008) {
+		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
+
+		c->x86_virt_bits = (eax >> 8) & 0xff;
+		c->x86_phys_bits = eax & 0xff;
+		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
+	}
+#ifdef CONFIG_X86_32
+	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
+		c->x86_phys_bits = 36;
+#endif
+}
+
 static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -965,6 +970,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 		cpu_detect(c);
 		get_cpu_vendor(c);
 		get_cpu_cap(c);
+		get_cpu_address_sizes(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 
 		if (this_cpu->c_early_init)
@@ -1097,6 +1103,8 @@ static void generic_identify(struct cpuinfo_x86 *c)
 
 	get_cpu_cap(c);
 
+	get_cpu_address_sizes(c);
+
 	if (c->cpuid_level >= 0x00000001) {
 		c->initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
 #ifdef CONFIG_X86_32
-- 
2.16.3
