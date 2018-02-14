Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162108AbeBNS3F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:29:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:48241 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161888AbeBNSZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:25:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="20041564"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/9] x86/mm: Initialize pgtable_l5_enabled at boot-time
Date: Wed, 14 Feb 2018 21:25:34 +0300
Message-Id: <20180214182542.69302-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214182542.69302-1-kirill.shutemov@linux.intel.com>
References: <20180214182542.69302-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgtable_l5_enabled indicates which paging mode we are using. We need to
initialize it at boot-time according to machine capability.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/kaslr.c |  8 +++++++-
 arch/x86/kernel/head64.c         | 24 +++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b18e8f9512de..d02a838c0ce4 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -47,7 +47,7 @@
 #include <linux/decompress/mm.h>
 
 #ifdef CONFIG_X86_5LEVEL
-unsigned int pgtable_l5_enabled __ro_after_init = 1;
+unsigned int pgtable_l5_enabled __ro_after_init;
 unsigned int pgdir_shift __ro_after_init = 48;
 unsigned int ptrs_per_p4d __ro_after_init = 512;
 #endif
@@ -729,6 +729,12 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
+#ifdef CONFIG_X86_5LEVEL
+	if (__read_cr4() & X86_CR4_LA57) {
+		pgtable_l5_enabled = 1;
+	}
+#endif
+
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
 	/* Prepare to add new identity pagetables on demand. */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 98b0ff49b220..ffb31c50d515 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -40,7 +40,7 @@ static unsigned int __initdata next_early_pgt;
 pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
-unsigned int pgtable_l5_enabled __ro_after_init = 1;
+unsigned int pgtable_l5_enabled __ro_after_init;
 EXPORT_SYMBOL(pgtable_l5_enabled);
 unsigned int pgdir_shift __ro_after_init = 48;
 EXPORT_SYMBOL(pgdir_shift);
@@ -64,6 +64,26 @@ static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 	return ptr - (void *)_text + (void *)physaddr;
 }
 
+#ifdef CONFIG_X86_5LEVEL
+static unsigned int __head *fixup_int(void *ptr, unsigned long physaddr)
+{
+	return fixup_pointer(ptr, physaddr);
+}
+
+static void __head check_la57_support(unsigned long physaddr)
+{
+	if (native_cpuid_eax(0) < 7)
+		return;
+
+	if (!(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+		return;
+
+	*fixup_int(&pgtable_l5_enabled, physaddr) = 1;
+}
+#else
+static void __head check_la57_support(unsigned long physaddr) {}
+#endif
+
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
@@ -76,6 +96,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	int i;
 	unsigned int *next_pgt_ptr;
 
+	check_la57_support(physaddr);
+
 	/* Is the address too large? */
 	if (physaddr >> MAX_PHYSMEM_BITS)
 		for (;;);
-- 
2.15.1
