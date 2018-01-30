Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753563AbeA3Wkx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:40:53 -0500
Received: from terminus.zytor.com ([65.50.211.136]:56789 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbeA3Wkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:40:51 -0500
Date: Tue, 30 Jan 2018 14:39:45 -0800
From: tip-bot for Tim Chen <tipbot@zytor.com>
Message-ID: <tip-18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7@git.kernel.org>
Cc: tim.c.chen@linux.intel.com, dwmw@amazon.co.uk, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, tim.c.chen@linux.intel.com,
        dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <1517263487-3708-1-git-send-email-dwmw@amazon.co.uk>
References: <1517263487-3708-1-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/speculation: Use Indirect Branch Prediction
 Barrier in context switch
Git-Commit-ID: 18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7
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

Commit-ID:  18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7
Gitweb:     https://git.kernel.org/tip/18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7
Author:     Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate: Mon, 29 Jan 2018 22:04:47 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 23:09:21 +0100

x86/speculation: Use Indirect Branch Prediction Barrier in context switch

Flush indirect branches when switching into a process that marked itself
non dumpable. This protects high value processes like gpg better,
without having too high performance overhead.

If done naïvely, we could switch to a kernel idle thread and then back
to the original process, such as:

    process A -> idle -> process A

In such scenario, we do not have to do IBPB here even though the process
is non-dumpable, as we are switching back to the same process after a
hiatus.

To avoid the redundant IBPB, which is expensive, we track the last mm
user context ID. The cost is to have an extra u64 mm context id to track
the last mm we were using before switching to the init_mm used by idle.
Avoiding the extra IBPB is probably worth the extra memory for this
common scenario.

For those cases where tlb_defer_switch_to_init_mm() returns true (non
PCID), lazy tlb will defer switch to init_mm, so we will not be changing
the mm for the process A -> idle -> process A switch. So IBPB will be
skipped for this case.

Thanks to the reviewers and Andy Lutomirski for the suggestion of
using ctx_id which got rid of the problem of mm pointer recycling.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: ak@linux.intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: linux@dominikbrodowski.net
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: luto@kernel.org
Cc: pbonzini@redhat.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1517263487-3708-1-git-send-email-dwmw@amazon.co.uk

---
 arch/x86/include/asm/tlbflush.h |  2 ++
 arch/x86/mm/tlb.c               | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index d33e4a2..2b8f18c 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -174,6 +174,8 @@ struct tlb_state {
 	struct mm_struct *loaded_mm;
 	u16 loaded_mm_asid;
 	u16 next_asid;
+	/* last user mm's ctx id */
+	u64 last_ctx_id;
 
 	/*
 	 * We can be in one of several states:
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 5bfe61a..012d026 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -6,13 +6,14 @@
 #include <linux/interrupt.h>
 #include <linux/export.h>
 #include <linux/cpu.h>
+#include <linux/debugfs.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
+#include <asm/nospec-branch.h>
 #include <asm/cache.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
-#include <linux/debugfs.h>
 
 /*
  *	TLB flushing, formerly SMP-only
@@ -247,6 +248,27 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	} else {
 		u16 new_asid;
 		bool need_flush;
+		u64 last_ctx_id = this_cpu_read(cpu_tlbstate.last_ctx_id);
+
+		/*
+		 * Avoid user/user BTB poisoning by flushing the branch
+		 * predictor when switching between processes. This stops
+		 * one process from doing Spectre-v2 attacks on another.
+		 *
+		 * As an optimization, flush indirect branches only when
+		 * switching into processes that disable dumping. This
+		 * protects high value processes like gpg, without having
+		 * too high performance overhead. IBPB is *expensive*!
+		 *
+		 * This will not flush branches when switching into kernel
+		 * threads. It will also not flush if we switch to idle
+		 * thread and back to the same process. It will flush if we
+		 * switch to a different non-dumpable process.
+		 */
+		if (tsk && tsk->mm &&
+		    tsk->mm->context.ctx_id != last_ctx_id &&
+		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
+			indirect_branch_prediction_barrier();
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
@@ -292,6 +314,14 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
 		}
 
+		/*
+		 * Record last user mm's context id, so we can avoid
+		 * flushing branch buffer with IBPB if we switch back
+		 * to the same user.
+		 */
+		if (next != &init_mm)
+			this_cpu_write(cpu_tlbstate.last_ctx_id, next->context.ctx_id);
+
 		this_cpu_write(cpu_tlbstate.loaded_mm, next);
 		this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
 	}
@@ -369,6 +399,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
+	this_cpu_write(cpu_tlbstate.last_ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
