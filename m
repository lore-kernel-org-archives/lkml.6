Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx48VQbl2Yh9mgeKP045pYLhjliSVdFwkLQ2D038EU/gK2ja8rgKm8QuU/djE1CA97zFd33ry
ARC-Seal: i=1; a=rsa-sha256; t=1524263061; cv=none;
        d=google.com; s=arc-20160816;
        b=LxnJH+UJNW5gxsT/4YrGPPK+re9mqe2eW334nVJmUqsMr89DOJnz31CFEos/lbUAC/
         ziVbyQC1CPDSy4L2ntnjRIzL+fikt5lZZnOa4GxDKRGZqmH4OvkfPZIwnFb1j2NsPqh0
         h7e90SDb5QI3a8g373MMs2g8urpM7ENZG2lo9DrrcKbo9D149c1MIPTjASzjBAtc+Q4r
         787r9lPrmA/DBMQfcqPLt2jvrxKXExfNAgmjzetZxgMfgqBYkL4wrTZr7tKymPGv0lyV
         BMAk8ATRmoKnqq3oi1jKkAOPt/zBPWMfXea0hOzugrZpALy1BIp7qEdYzf0NVQW2Z3pS
         z29w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:in-reply-to:references:date:from:cc:to:subject
         :arc-authentication-results;
        bh=zybRJ2QBaNqFkhQXj7FW03lhL/l288qwee6QZSEmfak=;
        b=J0d3WVzTT03a8Hs7I63ZMA1TdkJCMZWoXWmd+dZmoIv+OM3nfMcD4rScGs1qKr9UDV
         cXEVahy0IfpgeSEqD5ihIhSSl36fAeth5fzBRwmTESpyGcS69ypqbnwNpOaG5i42HSCB
         ngMrT+KjP1omVR4fmAy8oI57vg4dYDs6SVZXsmffZ3xwV2XV+N3ABWOWCNKVJcN4fK4d
         INnZqJs3qFw6T8HJFPrMdBHhINMU08PvsdBATc6dBQCUFf+//2jq7vBgWYrX4d+hMoJV
         xmoABSZ4IBYi++DmQM048UMa9yDga6/eetQq17u2BLz6GhWymi/fAS7shjk4XawszS9x
         fEyg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="34144007"
Subject: [PATCH 5/5] x86, pti: filter at vma->vm_page_prot population
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,Dave Hansen <dave.hansen@linux.intel.com>,fengguang.wu@intel.com,aarcange@redhat.com,luto@kernel.org,arjan@linux.intel.com,bp@alien8.de,dan.j.williams@intel.com,dwmw2@infradead.org,gregkh@linuxfoundation.org,hughd@google.com,jpoimboe@redhat.com,jgross@suse.com,keescook@google.com,torvalds@linux-foundation.org,namit@vmware.com,peterz@infradead.org,tglx@linutronix.de,mingo@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Apr 2018 15:20:28 -0700
References: <20180420222018.E7646EE1@viggo.jf.intel.com>
In-Reply-To: <20180420222018.E7646EE1@viggo.jf.intel.com>
Message-Id: <20180420222028.99D72858@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598305663974065245?=
X-GMAIL-MSGID: =?utf-8?q?1598305663974065245?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

0day reported warnings at boot on 32-bit systems without NX support:

 [   12.349193] attempted to set unsupported pgprot: 8000000000000025 bits: 8000000000000000 supported: 7fffffffffffffff
 [   12.350792] WARNING: CPU: 0 PID: 1 at arch/x86/include/asm/pgtable.h:540 handle_mm_fault+0xfc1/0xfe0:
 						check_pgprot at arch/x86/include/asm/pgtable.h:535
 						 (inlined by) pfn_pte at arch/x86/include/asm/pgtable.h:549
 						 (inlined by) do_anonymous_page at mm/memory.c:3169
 						 (inlined by) handle_pte_fault at mm/memory.c:3961
 						 (inlined by) __handle_mm_fault at mm/memory.c:4087
 						 (inlined by) handle_mm_fault at mm/memory.c:4124

The problem was that we stopped massaging page permissions at PTE creation
time, so vma->vm_page_prot was passed unfiltered to PTE creation.

To fix it, filter the page protections before they are installed in
vma->vm_page_prot.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Fixes: fb43d6cb91 ("x86/mm: Do not auto-massage page protections")
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: Ingo Molnar <mingo@kernel.org>
---

 b/arch/x86/Kconfig               |    4 ++++
 b/arch/x86/include/asm/pgtable.h |    5 +++++
 b/mm/mmap.c                      |   11 ++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff -puN arch/x86/include/asm/pgtable.h~pti-glb-protection_map arch/x86/include/asm/pgtable.h
--- a/arch/x86/include/asm/pgtable.h~pti-glb-protection_map	2018-04-20 14:10:08.251749151 -0700
+++ b/arch/x86/include/asm/pgtable.h	2018-04-20 14:10:08.260749151 -0700
@@ -601,6 +601,11 @@ static inline pgprot_t pgprot_modify(pgp
 
 #define canon_pgprot(p) __pgprot(massage_pgprot(p))
 
+static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
+{
+	return canon_pgprot(prot);
+}
+
 static inline int is_new_memtype_allowed(u64 paddr, unsigned long size,
 					 enum page_cache_mode pcm,
 					 enum page_cache_mode new_pcm)
diff -puN arch/x86/Kconfig~pti-glb-protection_map arch/x86/Kconfig
--- a/arch/x86/Kconfig~pti-glb-protection_map	2018-04-20 14:10:08.253749151 -0700
+++ b/arch/x86/Kconfig	2018-04-20 14:10:08.260749151 -0700
@@ -52,6 +52,7 @@ config X86
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FAST_MULTIPLIER
+	select ARCH_HAS_FILTER_PGPROT
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
@@ -273,6 +274,9 @@ config ARCH_HAS_CPU_RELAX
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARCH_HAS_FILTER_PGPROT
+	def_bool y
+
 config HAVE_SETUP_PER_CPU_AREA
 	def_bool y
 
diff -puN mm/mmap.c~pti-glb-protection_map mm/mmap.c
--- a/mm/mmap.c~pti-glb-protection_map	2018-04-20 14:10:08.256749151 -0700
+++ b/mm/mmap.c	2018-04-20 14:10:08.261749151 -0700
@@ -100,11 +100,20 @@ pgprot_t protection_map[16] __ro_after_i
 	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
 };
 
+#ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
+static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
+{
+	return prot;
+}
+#endif
+
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	return __pgprot(pgprot_val(protection_map[vm_flags &
+	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
 				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
 			pgprot_val(arch_vm_get_page_prot(vm_flags)));
+
+	return arch_filter_pgprot(ret);
 }
 EXPORT_SYMBOL(vm_get_page_prot);
 
_
