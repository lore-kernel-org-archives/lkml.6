Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938968AbeE1MrJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937615AbeE1K5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:57:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "David H. Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>, Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <llong@redhat.com>, Will Deacon <will.deacon@arm.com>,
        aliguori@amazon.com, daniel.gruss@iaik.tugraz.at, hughd@google.com,
        keescook@google.com, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 322/496] x86/pgtable: Dont set huge PUD/PMD on non-leaf entries
Date: Mon, 28 May 2018 12:01:47 +0200
Message-Id: <20180528100333.398599532@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joerg Roedel <joro@8bytes.org>

[ Upstream commit e3e288121408c3abeed5af60b87b95c847143845 ]

The pmd_set_huge() and pud_set_huge() functions are used from
the generic ioremap() code to establish large mappings where this
is possible.

But the generic ioremap() code does not check whether the
PMD/PUD entries are already populated with a non-leaf entry,
so that any page-table pages these entries point to will be
lost.

Further, on x86-32 with SHARED_KERNEL_PMD=0, this causes a
BUG_ON() in vmalloc_sync_one() when PMD entries are synced
from swapper_pg_dir to the current page-table. This happens
because the PMD entry from swapper_pg_dir was promoted to a
huge-page entry while the current PGD still contains the
non-leaf entry. Because both entries are present and point
to a different page, the BUG_ON() triggers.

This was actually triggered with pti-x32 enabled in a KVM
virtual machine by the graphics driver.

A real and better fix for that would be to improve the
page-table handling in the generic ioremap() code. But that is
out-of-scope for this patch-set and left for later work.

Reported-by: David H. Gutteridge <dhgutteridge@sympatico.ca>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <llong@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180411152437.GC15462@8bytes.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/mm/pgtable.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm.h>
 #include <linux/gfp.h>
+#include <linux/hugetlb.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/tlb.h>
@@ -636,6 +637,10 @@ int pud_set_huge(pud_t *pud, phys_addr_t
 	    (mtrr != MTRR_TYPE_WRBACK))
 		return 0;
 
+	/* Bail out if we are we on a populated non-leaf entry: */
+	if (pud_present(*pud) && !pud_huge(*pud))
+		return 0;
+
 	prot = pgprot_4k_2_large(prot);
 
 	set_pte((pte_t *)pud, pfn_pte(
@@ -664,6 +669,10 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t
 		return 0;
 	}
 
+	/* Bail out if we are we on a populated non-leaf entry: */
+	if (pmd_present(*pmd) && !pmd_huge(*pmd))
+		return 0;
+
 	prot = pgprot_4k_2_large(prot);
 
 	set_pte((pte_t *)pmd, pfn_pte(
