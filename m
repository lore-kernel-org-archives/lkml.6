Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218B2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C402420844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C402420844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732357AbeHATr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:47:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:56955 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbeHATr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:47:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 11:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="62549763"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2018 11:01:03 -0700
Subject: [PATCH 1/5] x86/mm/pti: clear Global bit more aggressively
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, hughd@google.com,
        keescook@google.com, tglx@linutronix.de, mingo@kernel.org,
        aarcange@redhat.com, jgross@suse.com, jpoimboe@redhat.com,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 01 Aug 2018 11:00:59 -0700
References: <20180801180058.EC46D963@viggo.jf.intel.com>
In-Reply-To: <20180801180058.EC46D963@viggo.jf.intel.com>
Message-Id: <20180801180059.0BD60329@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The kernel image starts out with the Global bit set across the entire
kernel image.  The bit is cleared with set_memory_nonglobal() in the
configurations with PCIDs where we do not need the performance
benefits of the Global bit.

However, this is fragile.  It means that we are stuck opting *out* of
the less-secure (Global bit set) configuration, which seems backwards.
Let's start more secure (Global bit clear) and then let things opt
back in if they want performance, or are truly mapping common data
between kernel and userspace.

This fixes a bug.  Before this patch, there are areas that are
unmapped from the user page tables (like like everything above
0xffffffff82600000 in the example below).  These have the hallmark of
being a wrong Global area: they are no identical in the
'current_kernel' and 'current_user' page table dumps.  They are also
read-write, which means they're much more likely to contain secrets.

Before this patch:

current_kernel:---[ High Kernel Mapping ]---
current_kernel-0xffffffff80000000-0xffffffff81000000          16M                               pmd
current_kernel-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
current_kernel-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
current_kernel-0xffffffff81e11000-0xffffffff82000000        1980K     RW                 GLB NX pte
current_kernel-0xffffffff82000000-0xffffffff82600000           6M     ro         PSE     GLB NX pmd
current_kernel-0xffffffff82600000-0xffffffff82c00000           6M     RW         PSE     GLB NX pmd
current_kernel-0xffffffff82c00000-0xffffffff82e00000           2M     RW                 GLB NX pte
current_kernel-0xffffffff82e00000-0xffffffff83200000           4M     RW         PSE     GLB NX pmd
current_kernel-0xffffffff83200000-0xffffffffa0000000         462M                               pmd

 current_user:---[ High Kernel Mapping ]---
 current_user-0xffffffff80000000-0xffffffff81000000          16M                               pmd
 current_user-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
 current_user-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
 current_user-0xffffffff81e11000-0xffffffff82000000        1980K     RW                 GLB NX pte
 current_user-0xffffffff82000000-0xffffffff82600000           6M     ro         PSE     GLB NX pmd
 current_user-0xffffffff82600000-0xffffffffa0000000         474M                               pmd

After this patch:

current_kernel:---[ High Kernel Mapping ]---
current_kernel-0xffffffff80000000-0xffffffff81000000          16M                               pmd
current_kernel-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
current_kernel-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
current_kernel-0xffffffff81e11000-0xffffffff82000000        1980K     RW                     NX pte
current_kernel-0xffffffff82000000-0xffffffff82600000           6M     ro         PSE     GLB NX pmd
current_kernel-0xffffffff82600000-0xffffffff82c00000           6M     RW         PSE         NX pmd
current_kernel-0xffffffff82c00000-0xffffffff82e00000           2M     RW                     NX pte
current_kernel-0xffffffff82e00000-0xffffffff83200000           4M     RW         PSE         NX pmd
current_kernel-0xffffffff83200000-0xffffffffa0000000         462M                               pmd

  current_user:---[ High Kernel Mapping ]---
  current_user-0xffffffff80000000-0xffffffff81000000          16M                               pmd
  current_user-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
  current_user-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
  current_user-0xffffffff81e11000-0xffffffff82000000        1980K     RW                     NX pte
  current_user-0xffffffff82000000-0xffffffff82600000           6M     ro         PSE     GLB NX pmd
  current_user-0xffffffff82600000-0xffffffffa0000000         474M                               pmd

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Hugh Dickins <hughd@google.com>
Cc: Kees Cook <keescook@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
---

 b/arch/x86/mm/pageattr.c |    6 ++++++
 b/arch/x86/mm/pti.c      |   34 ++++++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff -puN arch/x86/mm/pageattr.c~pti-non-pcid-clear-more-global-in-kernel-mapping arch/x86/mm/pageattr.c
--- a/arch/x86/mm/pageattr.c~pti-non-pcid-clear-more-global-in-kernel-mapping	2018-07-30 09:53:12.720915694 -0700
+++ b/arch/x86/mm/pageattr.c	2018-07-30 09:53:12.726915694 -0700
@@ -1784,6 +1784,12 @@ int set_memory_nonglobal(unsigned long a
 				      __pgprot(_PAGE_GLOBAL), 0);
 }
 
+int set_memory_global(unsigned long addr, int numpages)
+{
+	return change_page_attr_set(&addr, numpages,
+				    __pgprot(_PAGE_GLOBAL), 0);
+}
+
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
 	struct cpa_data cpa;
diff -puN arch/x86/mm/pti.c~pti-non-pcid-clear-more-global-in-kernel-mapping arch/x86/mm/pti.c
--- a/arch/x86/mm/pti.c~pti-non-pcid-clear-more-global-in-kernel-mapping	2018-07-30 09:53:12.722915694 -0700
+++ b/arch/x86/mm/pti.c	2018-07-30 09:53:12.726915694 -0700
@@ -435,6 +435,13 @@ static inline bool pti_kernel_image_glob
 }
 
 /*
+ * This is the only user for these and it is not arch-generic
+ * like the other set_memory.h functions.  Just extern them.
+ */
+extern int set_memory_nonglobal(unsigned long addr, int numpages);
+extern int set_memory_global(unsigned long addr, int numpages);
+
+/*
  * For some configurations, map all of kernel text into the user page
  * tables.  This reduces TLB misses, especially on non-PCID systems.
  */
@@ -446,7 +453,8 @@ void pti_clone_kernel_text(void)
 	 * clone the areas past rodata, they might contain secrets.
 	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = (unsigned long)__end_rodata_hpage_align;
+	unsigned long end_clone  = (unsigned long)__end_rodata_hpage_align;
+	unsigned long end_global = PFN_ALIGN((unsigned long)__stop___ex_table);
 
 	if (!pti_kernel_image_global_ok())
 		return;
@@ -458,14 +466,18 @@ void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pmds(start, end, _PAGE_RW);
+	pti_clone_pmds(start, end_clone, _PAGE_RW);
+
+	/*
+	 * pti_clone_pmds() will set the global bit in any PMDs
+	 * that it clones, but we also need to get any PTEs in
+	 * the last level for areas that are not huge-page-aligned.
+	 */
+
+	/* Set the global bit for normal non-__init kernel text: */
+	set_memory_global(start, (end_global - start) >> PAGE_SHIFT);
 }
 
-/*
- * This is the only user for it and it is not arch-generic like
- * the other set_memory.h functions.  Just extern it.
- */
-extern int set_memory_nonglobal(unsigned long addr, int numpages);
 void pti_set_kernel_image_nonglobal(void)
 {
 	/*
@@ -477,9 +489,11 @@ void pti_set_kernel_image_nonglobal(void
 	unsigned long start = PFN_ALIGN(_text);
 	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
 
-	if (pti_kernel_image_global_ok())
-		return;
-
+	/*
+	 * This clears _PAGE_GLOBAL from the entire kernel image.
+	 * pti_clone_kernel_text() map put _PAGE_GLOBAL back for
+	 * areas that are mapped to userspace.
+	 */
 	set_memory_nonglobal(start, (end - start) >> PAGE_SHIFT);
 }
 
_
