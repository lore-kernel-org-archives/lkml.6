Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756539AbeDXIIo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:08:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35031 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756046AbeDXIId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:08:33 -0400
Date: Tue, 24 Apr 2018 01:07:28 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-231df823c4f04176f607afc4576c989895cff40e@git.kernel.org>
Cc: jgross@suse.com, dave.hansen@linux.intel.com, namit@vmware.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        hpa@zytor.com, aaro.koskinen@nokia.com, mingo@kernel.org,
        jpoimboe@redhat.com, torvalds@linux-foundation.org, mceier@gmail.com,
        dan.j.williams@intel.com, dwmw2@infradead.org, hughd@google.com,
        bp@alien8.de, tglx@linutronix.de, aarcange@redhat.com, luto@kernel.org,
        keescook@google.com, peterz@infradead.org, arjan@linux.intel.com
Reply-To: mingo@kernel.org, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        aaro.koskinen@nokia.com, hpa@zytor.com, torvalds@linux-foundation.org,
        jgross@suse.com, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, namit@vmware.com, luto@kernel.org,
        keescook@google.com, aarcange@redhat.com, tglx@linutronix.de,
        arjan@linux.intel.com, peterz@infradead.org, dan.j.williams@intel.com,
        mceier@gmail.com, bp@alien8.de, dwmw2@infradead.org, hughd@google.com
In-Reply-To: <20180420222021.1C7D2B3F@viggo.jf.intel.com>
References: <20180420222021.1C7D2B3F@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Fix boot warning from Global-bit setting
Git-Commit-ID: 231df823c4f04176f607afc4576c989895cff40e
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

Commit-ID:  231df823c4f04176f607afc4576c989895cff40e
Gitweb:     https://git.kernel.org/tip/231df823c4f04176f607afc4576c989895cff40e
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 20 Apr 2018 15:20:21 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 24 Apr 2018 09:50:53 +0200

x86/pti: Fix boot warning from Global-bit setting

The pageattr.c code attempts to process "faults" when it goes looking
for PTEs to change and finds non-present entries.  It allows these
faults in the linear map which is "expected to have holes", but
WARN()s about them elsewhere, like when called on the kernel image.

However, change_page_attr_clear() is now called on the kernel image in the
process of trying to clear the Global bit.

This trips the warning in __cpa_process_fault() if a non-present PTE is
encountered in the kernel image.  The "holes" in the kernel image result
from free_init_pages()'s use of set_memory_np().  These holes are totally
fine, and result from normal operation, just as they would be in the kernel
linear map.

Just silence the warning when holes in the kernel image are encountered.

Fixes: 39114b7a7 (x86/pti: Never implicitly clear _PAGE_GLOBAL for kernel image)
Reported-by: Mariusz Ceier <mceier@gmail.com>
Reported-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Kees Cook <keescook@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Link: https://lkml.kernel.org/r/20180420222021.1C7D2B3F@viggo.jf.intel.com

---
 arch/x86/mm/pageattr.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 4fadfd2b7017..3bded76e8d5c 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -93,6 +93,18 @@ void arch_report_meminfo(struct seq_file *m)
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
@@ -106,20 +118,25 @@ static inline unsigned long highmap_end_pfn(void)
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
+	return within_inclusive(pfn, highmap_start_pfn(), highmap_end_pfn());
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
@@ -1183,6 +1200,10 @@ static int __cpa_process_fault(struct cpa_data *cpa, unsigned long vaddr,
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
@@ -1335,8 +1356,7 @@ static int cpa_process_alias(struct cpa_data *cpa)
 	 * to touch the high mapped kernel as well:
 	 */
 	if (!within(vaddr, (unsigned long)_text, _brk_end) &&
-	    within_inclusive(cpa->pfn, highmap_start_pfn(),
-			     highmap_end_pfn())) {
+	    __cpa_pfn_in_highmap(cpa->pfn)) {
 		unsigned long temp_cpa_vaddr = (cpa->pfn << PAGE_SHIFT) +
 					       __START_KERNEL_map - phys_base;
 		alias_cpa = *cpa;
