Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934635AbeBMPjm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:39:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933479AbeBMPjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:39:40 -0500
Date: Tue, 13 Feb 2018 07:29:18 -0800
From: tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-515ab7c41306aad1f80a980e1936ef635c61570c@git.kernel.org>
Cc: luto@kernel.org, torvalds@linux-foundation.org,
        dave.hansen@linux.intel.com, nadav.amit@gmail.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
        namit@vmware.com, mingo@kernel.org, hpa@zytor.com
Reply-To: dave.hansen@linux.intel.com, nadav.amit@gmail.com,
        torvalds@linux-foundation.org, luto@kernel.org, namit@vmware.com,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20180131211912.52064-1-namit@vmware.com>
References: <20180131211912.52064-1-namit@vmware.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Align TLB invalidation info
Git-Commit-ID: 515ab7c41306aad1f80a980e1936ef635c61570c
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

Commit-ID:  515ab7c41306aad1f80a980e1936ef635c61570c
Gitweb:     https://git.kernel.org/tip/515ab7c41306aad1f80a980e1936ef635c61570c
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Wed, 31 Jan 2018 13:19:12 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 15:05:49 +0100

x86/mm: Align TLB invalidation info

The TLB invalidation info is allocated on the stack, which might cause
it to be unaligned. Since this information may be transferred to
different cores for TLB shootdown, this may cause an additional cache
line to become shared. While the overhead is likely to be small, the
fix is simple.

We do not use __cacheline_aligned() since it also defines the section,
which is inappropriate for stack variables.

Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180131211912.52064-1-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 8dcc060..6550d37 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -613,7 +613,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 {
 	int cpu;
 
-	struct flush_tlb_info info = {
+	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
 		.mm = mm,
 	};
 
