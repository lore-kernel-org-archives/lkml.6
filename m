Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeAaVTP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:19:15 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:58266 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752098AbeAaVTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:19:14 -0500
From: Nadav Amit <namit@vmware.com>
To: <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v3] x86: Align TLB invalidation info
Date: Wed, 31 Jan 2018 13:19:12 -0800
Message-ID: <20180131211912.52064-1-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLB invalidation info is allocated on the stack, which might cause
it to be unaligned. Since this information may be transferred to
different cores for TLB shootdown, this may cause an additional cache
line to become shared. While the overhead is likely to be small, the
fix is simple.

We do not use __cacheline_aligned() since it also defines the section,
which is inappropriate for stack variables.

Signed-off-by: Nadav Amit <namit@vmware.com>
Acked-by: Andy Lutomirski <luto@kernel.org>

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

--
v2 -> v3: rewording the commit message (Andy)
v1 -> v2: use __aligned instead of all the mess (Andy)
---
 arch/x86/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5bfe61a5e8e3..9690112e3a82 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -576,7 +576,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 {
 	int cpu;
 
-	struct flush_tlb_info info = {
+	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
 		.mm = mm,
 	};
 
-- 
2.14.1
