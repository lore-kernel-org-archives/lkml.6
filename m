Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeDFU7u (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 16:59:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:45030 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752090AbeDFU6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 16:58:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,416,1517904000";
   d="scan'208";a="41307051"
Subject: [PATCH 07/11] x86/mm: comment _PAGE_GLOBAL mystery
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        aarcange@redhat.com, luto@kernel.org, torvalds@linux-foundation.org,
        keescook@google.com, hughd@google.com, jgross@suse.com, x86@kernel.org,
        namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 06 Apr 2018 13:55:13 -0700
References: <20180406205501.24A1A4E7@viggo.jf.intel.com>
In-Reply-To: <20180406205501.24A1A4E7@viggo.jf.intel.com>
Message-Id: <20180406205513.079BB265@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

I was mystified as to where the _PAGE_GLOBAL in the kernel page tables
for kernel text came from.  I audited all the places I could find, but
I missed one: head_64.S.

The page tables that we create in here live for a long time, and they
also have _PAGE_GLOBAL set, despite whether the processor supports it
or not.  It's harmless, and we got *lucky* that the pageattr code
accidentally clears it when we wipe it out of __supported_pte_mask and
then later try to mark kernel text read-only.

Comment some of these properties to make it easier to find and
understand in the future.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: Nadav Amit <namit@vmware.com>
---

 b/arch/x86/kernel/head_64.S |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff -puN arch/x86/kernel/head_64.S~comment-global-page arch/x86/kernel/head_64.S
--- a/arch/x86/kernel/head_64.S~comment-global-page	2018-04-06 10:47:57.176796121 -0700
+++ b/arch/x86/kernel/head_64.S	2018-04-06 10:47:57.179796121 -0700
@@ -399,8 +399,13 @@ NEXT_PAGE(level3_ident_pgt)
 	.quad	level2_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.fill	511, 8, 0
 NEXT_PAGE(level2_ident_pgt)
-	/* Since I easily can, map the first 1G.
+	/*
+	 * Since I easily can, map the first 1G.
 	 * Don't set NX because code runs from these pages.
+	 *
+	 * Note: This sets _PAGE_GLOBAL despite whether
+	 * the CPU supports it or it is enabled.  But,
+	 * the CPU should ignore the bit.
 	 */
 	PMDS(0, __PAGE_KERNEL_IDENT_LARGE_EXEC, PTRS_PER_PMD)
 #else
@@ -431,6 +436,10 @@ NEXT_PAGE(level2_kernel_pgt)
 	 * (NOTE: at +512MB starts the module area, see MODULES_VADDR.
 	 *  If you want to increase this then increase MODULES_VADDR
 	 *  too.)
+	 *
+	 *  This table is eventually used by the kernel during normal
+	 *  runtime.  Care must be taken to clear out undesired bits
+	 *  later, like _PAGE_RW or _PAGE_GLOBAL in some cases.
 	 */
 	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
_
