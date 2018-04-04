Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755251AbeDDBOj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 21:14:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:26742 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754890AbeDDBMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 21:12:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,403,1517904000";
   d="scan'208";a="217321571"
Subject: [PATCH 04/11] x86/espfix: document use of _PAGE_GLOBAL
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        aarcange@redhat.com, luto@kernel.org, torvalds@linux-foundation.org,
        keescook@google.com, hughd@google.com, jgross@suse.com, x86@kernel.org,
        namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 03 Apr 2018 18:09:56 -0700
References: <20180404010946.6186729B@viggo.jf.intel.com>
In-Reply-To: <20180404010946.6186729B@viggo.jf.intel.com>
Message-Id: <20180404010956.32C1983F@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The "normal" kernel page table creation mechanisms using
PAGE_KERNEL_* page protections will never set _PAGE_GLOBAL with PTI.
The few places in the kernel that always want _PAGE_GLOBAL must
avoid using PAGE_KERNEL_*.

Document that we want it here and its use is not accidental.

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

 b/arch/x86/kernel/espfix_64.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN arch/x86/kernel/espfix_64.c~espfix-use-kern-defaults-not-supported arch/x86/kernel/espfix_64.c
--- a/arch/x86/kernel/espfix_64.c~espfix-use-kern-defaults-not-supported	2018-04-02 16:41:14.274605175 -0700
+++ b/arch/x86/kernel/espfix_64.c	2018-04-02 16:41:14.278605175 -0700
@@ -195,6 +195,10 @@ void init_espfix_ap(int cpu)
 
 	pte_p = pte_offset_kernel(&pmd, addr);
 	stack_page = page_address(alloc_pages_node(node, GFP_KERNEL, 0));
+	/*
+	 * __PAGE_KERNEL_* includes _PAGE_GLOBAL, which we want since
+	 * this is mapped to userspace.
+	 */
 	pte = __pte(__pa(stack_page) | ((__PAGE_KERNEL_RO | _PAGE_ENC) & ptemask));
 	for (n = 0; n < ESPFIX_PTE_CLONES; n++)
 		set_pte(&pte_p[n*PTE_STRIDE], pte);
_
