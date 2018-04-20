Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx49rO0ykbcK6A8vE04xXSH39XXvx8KHJ5O65v0lB7H2N5y0Y025RJh1+TdtJ+zFuqgNrnFiA
ARC-Seal: i=1; a=rsa-sha256; t=1524263054; cv=none;
        d=google.com; s=arc-20160816;
        b=NE6kvAAtSgs/LuPf2GJ3snfyGYiDYl9KSURqhxJ0Cx133D6a6MQTIxZMtp3iTlpAAP
         wlpocgb+T9Xa72RPaqgRoe5RTfd1x5mCFQ8lUEuC2VEggnXDOnJiYb+ULp+1HWn3mZ3P
         6hw1KL2xNMhJTF2vx0+nfvoHOfgKnHq7ztIPvQMsCmBYMxDd2O7mIpzGiaZlvKbHRvda
         uwctBzRpw4sYFIUzzMFkkYOsgtTodTziDz0UzYH9/u+/skNALfY9k2jFm9fJbxl54viV
         ndhQO/f7spQ4do3EqeEF9sdsBezs0EgHYjnGownNzFJHzt9sz+iZoGXcVnh5UmY+iZdq
         v3Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:in-reply-to:references:date:from:cc:to:subject
         :arc-authentication-results;
        bh=ZoDlV98xxnhfdh+wkeXiDLhckcvHR8v7Y94WNfUUPxo=;
        b=TprsRzLMJGQgkehSXiOi3wfiFgXyWMo3e/PNbgynYVGIGTSgTlkbt0hF152qqfFBAU
         aAy2W8Dztwe1ESz/UTdYZb0t72vbMYVCQ7aMUA0Dc0gqAEJTSbkHTguVdlQ11TdBWXQd
         oS9+da+dwhyzkBV/Pf7cQkKkdqSoPPGbs6Rp0IF6rb6wqOY3BbnxKf4csxc3Dw5H50Ow
         Gr2VDYr0l4ykI7a1hdBwVToTiRPJhQfA9e6xse/Y76OvWN4mycQcA5QV0DMtbKo6DIPs
         0rv7oV0BLnj52N2ZkDuONGQILJdflfIssNdEXmXbZ9BNnh2zKE+OwWVxhdhNVshqFj8X
         B0Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="222137282"
Subject: [PATCH 2/5] x86, pti: fix boot warning from Global-bit setting
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,Dave Hansen <dave.hansen@linux.intel.com>,mceier@gmail.com,aaro.koskinen@nokia.com,aarcange@redhat.com,luto@kernel.org,arjan@linux.intel.com,bp@alien8.de,dan.j.williams@intel.com,dwmw2@infradead.org,gregkh@linuxfoundation.org,hughd@google.com,jpoimboe@redhat.com,jgross@suse.com,keescook@google.com,torvalds@linux-foundation.org,namit@vmware.com,peterz@infradead.org,tglx@linutronix.de
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Apr 2018 15:20:21 -0700
References: <20180420222018.E7646EE1@viggo.jf.intel.com>
In-Reply-To: <20180420222018.E7646EE1@viggo.jf.intel.com>
Message-Id: <20180420222021.1C7D2B3F@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598029619129049046?=
X-GMAIL-MSGID: =?utf-8?q?1598305656929946904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The pageattr.c code attempts to process "faults" when it goes looking
for PTEs to change and finds non-present entries.  It allows these
faults in the linear map which is "expected to have holes", but
WARN()s about them elsewhere, like when called on the kernel image.

However, we are now calling change_page_attr_clear() on the kernel
image in the process of trying to clear the Global bit.

This trips the warning in __cpa_process_fault() if a non-present PTE is
encountered in the kernel image.  The "holes" in the kernel image
result from free_init_pages()'s use of set_memory_np().  These holes
are totally fine, and result from normal operation, just as they would
be in the kernel linear map.

Just silence the warning when holes in the kernel image are encountered.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 39114b7a7 (x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image)
Reported-by: Mariusz Ceier <mceier@gmail.com>
Reported-by: Aaro Koskinen <aaro.koskinen@nokia.com>
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
---

 b/arch/x86/mm/pageattr.c |   41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff -puN arch/x86/mm/pageattr.c~pti-glb-warning-inpageattr arch/x86/mm/pageattr.c
--- a/arch/x86/mm/pageattr.c~pti-glb-warning-inpageattr	2018-04-20 14:10:01.619749168 -0700
+++ b/arch/x86/mm/pageattr.c	2018-04-20 14:10:01.623749168 -0700
@@ -93,6 +93,18 @@ void arch_report_meminfo(struct seq_file
 static inline void split_page_count(int level) { }
 #endif
 
+static inline int
+within(unsigned long addr, unsigned long start, unsigned long end)
+{
+	return addr >= start && addr < end;
+}
+
+static inline int
+within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
+{
+	return addr >= start && addr <= end;
+}
+
 #ifdef CONFIG_X86_64
 
 static inline unsigned long highmap_start_pfn(void)
@@ -106,20 +118,26 @@ static inline unsigned long highmap_end_
 	return __pa_symbol(roundup(_brk_end, PMD_SIZE) - 1) >> PAGE_SHIFT;
 }
 
-#endif
-
-static inline int
-within(unsigned long addr, unsigned long start, unsigned long end)
+static bool __cpa_pfn_in_highmap(unsigned long pfn)
 {
-	return addr >= start && addr < end;
+	/*
+	 * Kernel text has an alias mapping at a high address, known
+	 * here as "highmap".
+	 */
+	return within_inclusive(pfn, highmap_start_pfn(),
+			highmap_end_pfn());
 }
 
-static inline int
-within_inclusive(unsigned long addr, unsigned long start, unsigned long end)
+#else
+
+static bool __cpa_pfn_in_highmap(unsigned long pfn)
 {
-	return addr >= start && addr <= end;
+	/* There is no highmap on 32-bit */
+	return false;
 }
 
+#endif
+
 /*
  * Flushing functions
  */
@@ -1183,6 +1201,10 @@ static int __cpa_process_fault(struct cp
 		cpa->numpages = 1;
 		cpa->pfn = __pa(vaddr) >> PAGE_SHIFT;
 		return 0;
+
+	} else if (__cpa_pfn_in_highmap(cpa->pfn)) {
+		/* Faults in the highmap are OK, so do not warn: */
+		return -EFAULT;
 	} else {
 		WARN(1, KERN_WARNING "CPA: called for zero pte. "
 			"vaddr = %lx cpa->vaddr = %lx\n", vaddr,
@@ -1335,8 +1357,7 @@ static int cpa_process_alias(struct cpa_
 	 * to touch the high mapped kernel as well:
 	 */
 	if (!within(vaddr, (unsigned long)_text, _brk_end) &&
-	    within_inclusive(cpa->pfn, highmap_start_pfn(),
-			     highmap_end_pfn())) {
+	    __cpa_pfn_in_highmap(cpa->pfn)) {
 		unsigned long temp_cpa_vaddr = (cpa->pfn << PAGE_SHIFT) +
 					       __START_KERNEL_map - phys_base;
 		alias_cpa = *cpa;
_
