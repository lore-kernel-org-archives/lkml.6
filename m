Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF67CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D96821A60
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 20:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D96821A60
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733048AbeHFWdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 18:33:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38165 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHFWdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 18:33:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w76KLpus985487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Aug 2018 13:21:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w76KLp0e985484;
        Mon, 6 Aug 2018 13:21:51 -0700
Date:   Mon, 6 Aug 2018 13:21:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-c40a56a7818cfe735fc93a69e1875f8bba834483@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, luto@kernel.org, bp@alien8.de,
        gregkh@linuxfoundation.org, dave.hansen@linux.intel.com,
        torvalds@linux-foundation.org, aarcange@redhat.com,
        hughd@google.com, jgross@suse.com, jpoimboe@redhat.com,
        mingo@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de, jroedel@suse.de,
        keescook@google.com
Reply-To: luto@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
          jgross@suse.com, dave.hansen@linux.intel.com,
          aarcange@redhat.com, torvalds@linux-foundation.org,
          hughd@google.com, gregkh@linuxfoundation.org, mingo@kernel.org,
          jpoimboe@redhat.com, keescook@google.com, jroedel@suse.de,
          peterz@infradead.org, tglx@linutronix.de, ak@linux.intel.com,
          hpa@zytor.com
In-Reply-To: <20180802225831.5F6A2BFC@viggo.jf.intel.com>
References: <20180802225831.5F6A2BFC@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti-urgent] x86/mm/init: Remove freed kernel image areas
 from alias mapping
Git-Commit-ID: c40a56a7818cfe735fc93a69e1875f8bba834483
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c40a56a7818cfe735fc93a69e1875f8bba834483
Gitweb:     https://git.kernel.org/tip/c40a56a7818cfe735fc93a69e1875f8bba834483
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Thu, 2 Aug 2018 15:58:31 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 6 Aug 2018 20:54:16 +0200

x86/mm/init: Remove freed kernel image areas from alias mapping

The kernel image is mapped into two places in the virtual address space
(addresses without KASLR, of course):

	1. The kernel direct map (0xffff880000000000)
	2. The "high kernel map" (0xffffffff81000000)

We actually execute out of #2.  If we get the address of a kernel symbol,
it points to #2, but almost all physical-to-virtual translations point to

Parts of the "high kernel map" alias are mapped in the userspace page
tables with the Global bit for performance reasons.  The parts that we map
to userspace do not (er, should not) have secrets. When PTI is enabled then
the global bit is usually not set in the high mapping and just used to
compensate for poor performance on systems which lack PCID.

This is fine, except that some areas in the kernel image that are adjacent
to the non-secret-containing areas are unused holes.  We free these holes
back into the normal page allocator and reuse them as normal kernel memory.
The memory will, of course, get *used* via the normal map, but the alias
mapping is kept.

This otherwise unused alias mapping of the holes will, by default keep the
Global bit, be mapped out to userspace, and be vulnerable to Meltdown.

Remove the alias mapping of these pages entirely.  This is likely to
fracture the 2M page mapping the kernel image near these areas, but this
should affect a minority of the area.

The pageattr code changes *all* aliases mapping the physical pages that it
operates on (by default).  We only want to modify a single alias, so we
need to tweak its behavior.

This unmapping behavior is currently dependent on PTI being in place.
Going forward, we should at least consider doing this for all
configurations.  Having an extra read-write alias for memory is not exactly
ideal for debugging things like random memory corruption and this does
undercut features like DEBUG_PAGEALLOC or future work like eXclusive Page
Frame Ownership (XPFO).

Before this patch:

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

After this patch:

current_kernel:---[ High Kernel Mapping ]---
current_kernel-0xffffffff80000000-0xffffffff81000000          16M                               pmd
current_kernel-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
current_kernel-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
current_kernel-0xffffffff81e11000-0xffffffff82000000        1980K                               pte
current_kernel-0xffffffff82000000-0xffffffff82400000           4M     ro         PSE     GLB NX pmd
current_kernel-0xffffffff82400000-0xffffffff82488000         544K     ro                     NX pte
current_kernel-0xffffffff82488000-0xffffffff82600000        1504K                               pte
current_kernel-0xffffffff82600000-0xffffffff82c00000           6M     RW         PSE         NX pmd
current_kernel-0xffffffff82c00000-0xffffffff82c0d000          52K     RW                     NX pte
current_kernel-0xffffffff82c0d000-0xffffffff82dc0000        1740K                               pte

  current_user:---[ High Kernel Mapping ]---
  current_user-0xffffffff80000000-0xffffffff81000000          16M                               pmd
  current_user-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
  current_user-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
  current_user-0xffffffff81e11000-0xffffffff82000000        1980K                               pte
  current_user-0xffffffff82000000-0xffffffff82400000           4M     ro         PSE     GLB NX pmd
  current_user-0xffffffff82400000-0xffffffff82488000         544K     ro                     NX pte
  current_user-0xffffffff82488000-0xffffffff82600000        1504K                               pte
  current_user-0xffffffff82600000-0xffffffffa0000000         474M                               pmd

[ tglx: Do not unmap on 32bit as there is only one mapping ]

Fixes: 0f561fce4d69 ("x86/pti: Enable global pages for shared areas")
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20180802225831.5F6A2BFC@viggo.jf.intel.com
---
 arch/x86/include/asm/set_memory.h |  1 +
 arch/x86/mm/init.c                | 26 ++++++++++++++++++++++++--
 arch/x86/mm/pageattr.c            | 13 +++++++++++++
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index bd090367236c..34cffcef7375 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -46,6 +46,7 @@ int set_memory_np(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+int set_memory_np_noalias(unsigned long addr, int numpages);
 
 int set_memory_array_uc(unsigned long *addr, int addrinarray);
 int set_memory_array_wc(unsigned long *addr, int addrinarray);
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index bc11dedffc45..74b157ac078d 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -780,8 +780,30 @@ void free_init_pages(char *what, unsigned long begin, unsigned long end)
  */
 void free_kernel_image_pages(void *begin, void *end)
 {
-	free_init_pages("unused kernel image",
-			(unsigned long)begin, (unsigned long)end);
+	unsigned long begin_ul = (unsigned long)begin;
+	unsigned long end_ul = (unsigned long)end;
+	unsigned long len_pages = (end_ul - begin_ul) >> PAGE_SHIFT;
+
+
+	free_init_pages("unused kernel image", begin_ul, end_ul);
+
+	/*
+	 * PTI maps some of the kernel into userspace.  For performance,
+	 * this includes some kernel areas that do not contain secrets.
+	 * Those areas might be adjacent to the parts of the kernel image
+	 * being freed, which may contain secrets.  Remove the "high kernel
+	 * image mapping" for these freed areas, ensuring they are not even
+	 * potentially vulnerable to Meltdown regardless of the specific
+	 * optimizations PTI is currently using.
+	 *
+	 * The "noalias" prevents unmapping the direct map alias which is
+	 * needed to access the freed pages.
+	 *
+	 * This is only valid for 64bit kernels. 32bit has only one mapping
+	 * which can't be treated in this way for obvious reasons.
+	 */
+	if (IS_ENABLED(CONFIG_X86_64) && cpu_feature_enabled(X86_FEATURE_PTI))
+		set_memory_np_noalias(begin_ul, len_pages);
 }
 
 void __ref free_initmem(void)
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index c04153796f61..0a74996a1149 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -53,6 +53,7 @@ static DEFINE_SPINLOCK(cpa_lock);
 #define CPA_FLUSHTLB 1
 #define CPA_ARRAY 2
 #define CPA_PAGES_ARRAY 4
+#define CPA_NO_CHECK_ALIAS 8 /* Do not search for aliases */
 
 #ifdef CONFIG_PROC_FS
 static unsigned long direct_pages_count[PG_LEVEL_NUM];
@@ -1486,6 +1487,9 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 
 	/* No alias checking for _NX bit modifications */
 	checkalias = (pgprot_val(mask_set) | pgprot_val(mask_clr)) != _PAGE_NX;
+	/* Has caller explicitly disabled alias checking? */
+	if (in_flag & CPA_NO_CHECK_ALIAS)
+		checkalias = 0;
 
 	ret = __change_page_attr_set_clr(&cpa, checkalias);
 
@@ -1772,6 +1776,15 @@ int set_memory_np(unsigned long addr, int numpages)
 	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_PRESENT), 0);
 }
 
+int set_memory_np_noalias(unsigned long addr, int numpages)
+{
+	int cpa_flags = CPA_NO_CHECK_ALIAS;
+
+	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
+					__pgprot(_PAGE_PRESENT), 0,
+					cpa_flags, NULL);
+}
+
 int set_memory_4k(unsigned long addr, int numpages)
 {
 	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
