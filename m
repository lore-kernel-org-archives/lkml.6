Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeAaULf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:11:35 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:44946 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751296AbeAaULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:11:34 -0500
From: Nadav Amit <namit@vmware.com>
To: <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>, Nadav Amit <namit@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86: Align TLB invalidation info
Date: Wed, 31 Jan 2018 12:11:18 -0800
Message-ID: <20180131201118.1694-1-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLB invalidation info is allocated on the stack, which might cause
it to be unaligned. Since this information may be transferred to
different cores for TLB shootdown, this might result in an additional
cache-line bouncing between the cores.

GCC provides a way to deal with it by using
__builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.

Signed-off-by: Nadav Amit <namit@vmware.com>

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/mm/tlb.c              | 21 +++++++++++----------
 include/linux/compiler-gcc.h   |  5 +++++
 include/linux/compiler_types.h |  4 ++++
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5bfe61a5e8e3..bab7bb5d982f 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -574,37 +574,38 @@ static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned long vmflag)
 {
+	struct flush_tlb_info *info;
 	int cpu;
 
-	struct flush_tlb_info info = {
-		.mm = mm,
-	};
+	info = __alloca_with_align(sizeof(*info),
+				   SMP_CACHE_BYTES * BITS_PER_BYTE);
+	info->mm = mm;
 
 	cpu = get_cpu();
 
 	/* This is also a barrier that synchronizes with switch_mm(). */
-	info.new_tlb_gen = inc_mm_tlb_gen(mm);
+	info->new_tlb_gen = inc_mm_tlb_gen(mm);
 
 	/* Should we flush just the requested range? */
 	if ((end != TLB_FLUSH_ALL) &&
 	    !(vmflag & VM_HUGETLB) &&
 	    ((end - start) >> PAGE_SHIFT) <= tlb_single_page_flush_ceiling) {
-		info.start = start;
-		info.end = end;
+		info->start = start;
+		info->end = end;
 	} else {
-		info.start = 0UL;
-		info.end = TLB_FLUSH_ALL;
+		info->start = 0UL;
+		info->end = TLB_FLUSH_ALL;
 	}
 
 	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
 		VM_WARN_ON(irqs_disabled());
 		local_irq_disable();
-		flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
+		flush_tlb_func_local(info, TLB_LOCAL_MM_SHOOTDOWN);
 		local_irq_enable();
 	}
 
 	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
-		flush_tlb_others(mm_cpumask(mm), &info);
+		flush_tlb_others(mm_cpumask(mm), info);
 
 	put_cpu();
 }
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 631354acfa72..aea9a2e69417 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -314,6 +314,11 @@
 #define __designated_init __attribute__((designated_init))
 #endif
 
+#if GCC_VERSION >= 60100
+#define __alloca_with_align(size, alignment)				\
+	__builtin_alloca_with_align(size, alignment)
+#endif
+
 #endif	/* gcc version >= 40000 specific checks */
 
 #if !defined(__noclone)
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6b79a9bba9a7..c71297d95c74 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -271,4 +271,8 @@ struct ftrace_likely_data {
 # define __native_word(t) (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 #endif
 
+#ifndef __alloca_with_align
+#define __alloca_with_align(size, alignment) __builtin_alloca(size)
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.14.1
