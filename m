Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426120AbeBOQg4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:36:56 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:37394 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1426083AbeBOQgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:36:19 -0500
From: Nadav Amit <namit@vmware.com>
To: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH RFC v2 3/6] x86: Switching page-table isolation
Date: Thu, 15 Feb 2018 08:35:59 -0800
Message-ID: <20180215163602.61162-4-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215163602.61162-1-namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On context switch, switch the page-table isolation according to the
new task. Accordingly, restore or remove CS64.

The different types of disabling are kept as a bitmap in order to
quickly check whether a certain type of disabling was switched, although
it is assumed only a single type is set at a given time. The code
prepares the facility for future disabling of PTI in other means
(prctl). To do so, the logic means that greater "disabling" value means
stronger disabling, and should override lower ones.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/pti.h      | 22 ++++++++++++++++++++++
 arch/x86/include/asm/tlbflush.h | 12 ++++++++++++
 arch/x86/mm/tlb.c               | 25 +++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 96a5fbfedf7a..78a333699874 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -3,6 +3,11 @@
 #define _ASM_X86_PTI_H
 #ifndef __ASSEMBLY__
 
+#include <asm/desc.h>
+
+#define PTI_DISABLE_OFF			(0)
+#define PTI_DISABLE_IA32		(1 << 0)
+
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 static inline unsigned short mm_pti_disable(struct mm_struct *mm)
 {
@@ -12,10 +17,27 @@ static inline unsigned short mm_pti_disable(struct mm_struct *mm)
 	return mm->context.pti_disable;
 }
 
+static inline void pti_update_user_cs64(unsigned short prev_pti_disable,
+					unsigned short next_pti_disable)
+{
+	struct desc_struct user_cs, *d;
+
+	if ((prev_pti_disable ^ next_pti_disable) & PTI_DISABLE_IA32)
+		return;
+
+	d = get_cpu_gdt_rw(smp_processor_id());
+	user_cs = d[GDT_ENTRY_DEFAULT_USER_CS];
+	user_cs.p = !(next_pti_disable & PTI_DISABLE_IA32);
+	write_gdt_entry(d, GDT_ENTRY_DEFAULT_USER_CS, &user_cs, DESCTYPE_S);
+}
+
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
 #else
 static inline unsigned short mm_pti_disable(struct mm_struct *mm) { return 0; }
+static inline unsigned short mm_pti_disable(struct mm_struct *mm);
+static inline void pti_update_user_cs64(unsigned short prev_pti_disable,
+					unsigned short next_pti_disable) { }
 static inline void pti_check_boottime_disable(void) { }
 #endif
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cf91a484bb41..ea65cf951c49 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -310,6 +310,18 @@ static inline unsigned short cpu_pti_disable(void)
 	return this_cpu_read(cpu_tlbstate.pti_disable);
 }
 
+static inline void set_cpu_pti_disable(unsigned short disable)
+{
+	/*
+	 * Enabling/disabling CS64 and updating the state must be done
+	 * atomically
+	 */
+	WARN_ON_ONCE(preemptible());
+
+	pti_update_user_cs64(cpu_pti_disable(), disable);
+	this_cpu_write(cpu_tlbstate.pti_disable, disable);
+}
+
 /*
  * Save some of cr4 feature set we're using (e.g.  Pentium 4MB
  * enable and PPro Global page enable), so that any CPU's that boot
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5bfe61a5e8e3..c67ef3fb4f35 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -178,6 +178,28 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
 		}
 	}
 }
+static void switch_pti_disable(struct mm_struct *mm)
+{
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	unsigned short prev_pti_disable, next_pti_disable;
+
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
+
+	prev_pti_disable = cpu_pti_disable();
+
+	/*
+	 * Avoid concurrent changes to mm_pti_disable()), since we need to
+	 * ensure both CS64 and the CPU indication are identical
+	 */
+	next_pti_disable = READ_ONCE(mm->context.pti_disable);
+
+	if (prev_pti_disable == next_pti_disable)
+		return;
+
+	set_cpu_pti_disable(next_pti_disable);
+#endif
+}
 
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
@@ -292,6 +314,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
 		}
 
+		/* Disable/reenable page-table isolation as needed */
+		switch_pti_disable(next);
+
 		this_cpu_write(cpu_tlbstate.loaded_mm, next);
 		this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 	}
-- 
2.14.1
