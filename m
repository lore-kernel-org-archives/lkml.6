Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93259C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EDA208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EDA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732540AbeHATsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:48:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:1770 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbeHATsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:48:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 11:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="250882159"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2018 11:01:09 -0700
Subject: [PATCH 5/5] x86/mm/init: remove freed kernel image areas from alias mapping
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 01 Aug 2018 11:01:05 -0700
References: <20180801180058.EC46D963@viggo.jf.intel.com>
In-Reply-To: <20180801180058.EC46D963@viggo.jf.intel.com>
Message-Id: <20180801180105.5A40FA31@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The kernel image is mapped into two places in the virtual address
space (addresses without KASLR, of course):

	1. The kernel direct map (0xffff880000000000)
	2. The "high kernel map" (0xffffffff81000000)

We actually execute out of #2.  If we get the address of a kernel
symbol, it points to #2, but almost all physical-to-virtual
translations point to #1.

Parts of the "high kernel map" alias are mapped in the userspace
page tables with the Global bit for performance reasons.  The
parts that we map to userspace do not (er, should not) have
secrets.

This is fine, except that some areas in the kernel image that
are adjacent to the non-secret-containing areas are unused holes.
We free these holes back into the normal page allocator and
reuse them as normal kernel memory.  The memory will, of course,
get *used* via the normal map, but the alias mapping is kept.

This otherwise unused alias mapping of the holes will, by default
keep the Global bit, be mapped out to userspace, and be
vulnerable to Meltdown.

Remove the alias mapping of these pages entirely.  This is likely
to fracture the 2M page mapping the kernel image near these areas,
but this should affect a minority of the area.

This unmapping behavior is currently dependent on PTI being in
place.  Going forward, we should at least consider doing this for
all configurations.  Having an extra read-write alias for memory
is not exactly ideal for debugging things like random memory
corruption and this does undercut features like DEBUG_PAGEALLOC
or future work like eXclusive Page Frame Ownership (XPFO).

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

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
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
---

 b/arch/x86/mm/init.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff -puN arch/x86/mm/init.c~x86-unmap-freed-areas-from-kernel-image arch/x86/mm/init.c
--- a/arch/x86/mm/init.c~x86-unmap-freed-areas-from-kernel-image	2018-07-30 09:53:14.862915689 -0700
+++ b/arch/x86/mm/init.c	2018-07-30 09:53:14.866915689 -0700
@@ -778,8 +778,26 @@ void free_init_pages(char *what, unsigne
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
+	 * PTI maps some of the kernel into userspace.  For
+	 * performance, this includes some kernel areas that
+	 * do not contain secrets.  Those areas might be
+	 * adjacent to the parts of the kernel image being
+	 * freed, which may contain secrets.  Remove the
+	 * "high kernel image mapping" for these freed areas,
+	 * ensuring they are not even potentially vulnerable
+	 * to Meltdown regardless of the specific optimizations
+	 * PTI is currently using.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_PTI))
+		set_memory_np(begin_ul, len_pages);
 }
 
 void __ref free_initmem(void)
_
