Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbeESLgB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 07:36:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55971 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeESLgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 07:36:00 -0400
Date: Sat, 19 May 2018 04:35:40 -0700
From: "tip-bot for Kirill A. Shutemov" <tipbot@zytor.com>
Message-ID: <tip-1ea66554d3b09ce09c42e6a871899c84a276bb39@git.kernel.org>
Cc: mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hughd@google.com, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hughd@google.com, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com
In-Reply-To: <20180518103528.59260-7-kirill.shutemov@linux.intel.com>
References: <20180518103528.59260-7-kirill.shutemov@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/mm: Mark p4d_offset() __always_inline
Git-Commit-ID: 1ea66554d3b09ce09c42e6a871899c84a276bb39
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

Commit-ID:  1ea66554d3b09ce09c42e6a871899c84a276bb39
Gitweb:     https://git.kernel.org/tip/1ea66554d3b09ce09c42e6a871899c84a276bb39
Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate: Fri, 18 May 2018 13:35:27 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 19 May 2018 11:56:57 +0200

x86/mm: Mark p4d_offset() __always_inline

__pgtable_l5_enabled shouldn't be needed after system has booted, we can
mark it as __initdata, but it requires preparation.

KASAN initialization code is a user of USE_EARLY_PGTABLE_L5, so all
pgtable_l5_enabled() translated to __pgtable_l5_enabled there, including
the one in p4d_offset().

It may lead to section mismatch, if a compiler would not inline
p4d_offset(), but leave it as a standalone function: p4d_offset() is not
marked as __init.

Marking p4d_offset() as __always_inline fixes the issue.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180518103528.59260-7-kirill.shutemov@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5715647fc4fe..99ecde23c3ec 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -898,7 +898,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
 #define pgd_page(pgd)	pfn_to_page(pgd_pfn(pgd))
 
 /* to find an entry in a page-table-directory. */
-static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
+static __always_inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 {
 	if (!pgtable_l5_enabled())
 		return (p4d_t *)pgd;
