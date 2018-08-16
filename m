Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17A8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD1021479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD1021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbeHPVro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:47:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57256 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbeHPVrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:47:43 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E08A2D2F;
        Thu, 16 Aug 2018 18:47:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, keescook@google.com,
        aarcange@redhat.com, jgross@suse.com, jpoimboe@redhat.com,
        peterz@infradead.org, torvalds@linux-foundation.org, bp@alien8.de,
        luto@kernel.org, ak@linux.intel.com
Subject: [PATCH 4.17 04/21] x86/mm/pti: Clear Global bit more aggressively
Date:   Thu, 16 Aug 2018 20:45:14 +0200
Message-Id: <20180816171612.495305834@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171612.136242278@linuxfoundation.org>
References: <20180816171612.136242278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit eac7073aa69aa1cac819aa712146284f53f642b1 upstream.

The kernel image starts out with the Global bit set across the entire
kernel image.  The bit is cleared with set_memory_nonglobal() in the
configurations with PCIDs where the performance benefits of the Global bit
are not needed.

However, this is fragile.  It means that we are stuck opting *out* of the
less-secure (Global bit set) configuration, which seems backwards.  Let's
start more secure (Global bit clear) and then let things opt back in if
they want performance, or are truly mapping common data between kernel and
userspace.

This fixes a bug.  Before this patch, there are areas that are unmapped
from the user page tables (like like everything above 0xffffffff82600000 in
the example below).  These have the hallmark of being a wrong Global area:
they are not identical in the 'current_kernel' and 'current_user' page
table dumps.  They are also read-write, which means they're much more
likely to contain secrets.

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

Fixes: 0f561fce4d69 ("x86/pti: Enable global pages for shared areas")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@google.com
Cc: aarcange@redhat.com
Cc: jgross@suse.com
Cc: jpoimboe@redhat.com
Cc: gregkh@linuxfoundation.org
Cc: peterz@infradead.org
Cc: torvalds@linux-foundation.org
Cc: bp@alien8.de
Cc: luto@kernel.org
Cc: ak@linux.intel.com
Cc: Kees Cook <keescook@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20180802225825.A100C071@viggo.jf.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/pageattr.c |    6 ++++++
 arch/x86/mm/pti.c      |   34 ++++++++++++++++++++++++----------
 2 files changed, 30 insertions(+), 10 deletions(-)

--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
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
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -436,6 +436,13 @@ static inline bool pti_kernel_image_glob
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
@@ -447,7 +454,8 @@ void pti_clone_kernel_text(void)
 	 * clone the areas past rodata, they might contain secrets.
 	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = (unsigned long)__end_rodata_hpage_align;
+	unsigned long end_clone  = (unsigned long)__end_rodata_hpage_align;
+	unsigned long end_global = PFN_ALIGN((unsigned long)__stop___ex_table);
 
 	if (!pti_kernel_image_global_ok())
 		return;
@@ -459,14 +467,18 @@ void pti_clone_kernel_text(void)
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
@@ -478,9 +490,11 @@ void pti_set_kernel_image_nonglobal(void
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
 


