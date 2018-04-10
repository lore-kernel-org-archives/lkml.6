Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeDJOkW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:40:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752955AbeDJOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:40:20 -0400
Date: Tue, 10 Apr 2018 07:40:10 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-d94a155c59c98c19b98ee949eaab6a0312bbd6be@git.kernel.org>
Cc: kai.huang@linux.intel.com, mingo@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, dave.hansen@intel.com, thomas.lendacky@amd.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        kai.huang@linux.intel.com, kirill.shutemov@linux.intel.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com
In-Reply-To: <20180410092704.41106-1-kirill.shutemov@linux.intel.com>
References: <20180410092704.41106-1-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu: Prevent cpuinfo_x86::x86_phys_bits
 adjustment corruption
Git-Commit-ID: d94a155c59c98c19b98ee949eaab6a0312bbd6be
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

Commit-ID:  d94a155c59c98c19b98ee949eaab6a0312bbd6be
Gitweb:     https://git.kernel.org/tip/d94a155c59c98c19b98ee949eaab6a0312bbd6be
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Tue, 10 Apr 2018 12:27:04 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 10 Apr 2018 16:33:21 +0200

x86/cpu: Prevent cpuinfo_x86::x86_phys_bits adjustment corruption

Some features (Intel MKTME, AMD SME) reduce the number of effectively
available physical address bits. cpuinfo_x86::x86_phys_bits is adjusted
accordingly during the early cpu feature detection.

Though if get_cpu_cap() is called later again then this adjustement is
overwritten. That happens in setup_pku(), which is called after
detect_tme().

To address this, extract the address sizes enumeration into a separate
function, which is only called only from early_identify_cpu() and from
generic_identify().

This makes get_cpu_cap() safe to be called later during boot proccess
without overwriting cpuinfo_x86::x86_phys_bits.

[ tglx: Massaged changelog ]

Fixes: cb06d8e3d020 ("x86/tme: Detect if TME and MKTME is activated by BIOS")
Reported-by: Kai Huang <kai.huang@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lkml.kernel.org/r/20180410092704.41106-1-kirill.shutemov@linux.intel.com

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
