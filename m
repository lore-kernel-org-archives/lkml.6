Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeBVUhM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 15:37:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:49853 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751411AbeBVUhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 15:37:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="19605599"
Subject: [RFC][PATCH 04/10] x86/espfix: use kernel-default PTE mask
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, aarcange@redhat.com,
        luto@kernel.org, torvalds@linux-foundation.org, keescook@google.com,
        hughd@google.com, jgross@suse.com, x86@kernel.org, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2018 12:36:58 -0800
References: <20180222203651.B776810C@viggo.jf.intel.com>
In-Reply-To: <20180222203651.B776810C@viggo.jf.intel.com>
Message-Id: <20180222203658.80705136@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

In creating its page tables, the espfix code masks its PGTABLE_PROT
value with the supported mask: __supported_pte_mask.  This ensures
that unsupported bits are not set in the final PTE.  But, it also
sets _PAGE_GLOBAL which we do not want for PTE.  Use
__default_kernel_pte_mask instead which clears _PAGE_GLOBAL for PTI.

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

 b/arch/x86/kernel/espfix_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86/kernel/espfix_64.c~espfix-use-kern-defaults-not-supported arch/x86/kernel/espfix_64.c
--- a/arch/x86/kernel/espfix_64.c~espfix-use-kern-defaults-not-supported	2018-02-22 12:36:19.217036552 -0800
+++ b/arch/x86/kernel/espfix_64.c	2018-02-22 12:36:19.221036552 -0800
@@ -167,7 +167,7 @@ void init_espfix_ap(int cpu)
 		goto unlock_done;
 
 	node = cpu_to_node(cpu);
-	ptemask = __supported_pte_mask;
+	ptemask = __default_kernel_pte_mask;
 
 	pud_p = &espfix_pud_page[pud_index(addr)];
 	pud = *pud_p;
_
