Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754763AbeDPJoE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:44:04 -0400
Received: from 8bytes.org ([81.169.241.247]:53162 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754466AbeDPJoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:44:03 -0400
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/ldt: Fix support_pte_mask filtering in map_ldt_struct()
Date: Mon, 16 Apr 2018 11:43:57 +0200
Message-Id: <1523871837-8378-1-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The |= operator will let us end up with an invalid PTE. Use
the correct &= instead.

Fixes: fb43d6cb91ef ('x86/mm: Do not auto-massage page protections')
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/ldt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index d41d896481b8..c9b14020f4dd 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -166,7 +166,7 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 		 */
 		pte_prot = __pgprot(__PAGE_KERNEL_RO & ~_PAGE_GLOBAL);
 		/* Filter out unsuppored __PAGE_KERNEL* bits: */
-		pgprot_val(pte_prot) |= __supported_pte_mask;
+		pgprot_val(pte_prot) &= __supported_pte_mask;
 		pte = pfn_pte(pfn, pte_prot);
 		set_pte_at(mm, va, ptep, pte);
 		pte_unmap_unlock(ptep, ptl);
-- 
2.13.6
