Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225p0ew6rXEcYlU72DfI1txp2U3mydMg5p4dzpUIiFKgULqGaWb3ZS1tNIxB8nJnFv6hACBE
ARC-Seal: i=1; a=rsa-sha256; t=1517855153; cv=none;
        d=google.com; s=arc-20160816;
        b=LeYHKzxILIzQXpF9yPHMpPA7Q9QOcjC+nVticPTMtdDgrbvYGl8F31NXJg6TBHcerY
         m7mfwbDLku0GJqaw049bAWNU6GeS1rO/uOeUyfkYbQHgilizSYnxu6gcppuO6lA3adeh
         /w5sgxDKkUazEw62SklwwBfnyIpWTacBWNK9N0GM6bj59Tcb1aOOPSilv2bMm6WuENJw
         QsmaS9HNNXx/7dL58n1l4/NsAtUBM2d2ajBXQ7mVWrodggOlH0QM4e+63pCMlF23o5sV
         iJ+oFZ6KJhdWUEuB53WNO8FM+XbXQlJznVbfDf5PRI+xRjJZxnL031N4NUW2+BKcFa+K
         MY1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Uynekc8rWEvyjezLSQPi45h60/nYMql7ED2aHqtnNbs=;
        b=LNGRvzxpHf6QUzcFGhEsX1ooExMLwP7JmpBDFWAnUnLULYkrRl5FPNp7OsD/6ZmsUx
         9PpI04iLjsG+Ca7VQUM4p0M9CjKxcilpC5LiBoeTVj0xwIp14oXYUXSSt2iT0jJD2OiT
         MoFkXV1naljYz9qZHz91MX3mILxXOlIqEn38QC4KHNB+ZFA5LPt6dPOsrz3L3+6LCRNU
         crRSNELqRiT6Tpo26b2kC4wWV1ODXX07OXN+wGRSibFN4c5pk34Q5S5GaSoO8RtnQ4CV
         wwT3w4R7yXshUTFvWq7XPo44mSX7Myz2Lt/5DMI2uxNckXASq/hKB90fOOqVNKgH9rry
         +8WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tim Chen <tim.c.chen@linux.intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	ak@linux.intel.com,
	karahmed@amazon.de,
	arjan@linux.intel.com,
	torvalds@linux-foundation.org,
	linux@dominikbrodowski.net,
	peterz@infradead.org,
	bp@alien8.de,
	luto@kernel.org,
	pbonzini@redhat.com,
	gregkh@linux-foundation.org
Subject: [PATCH 4.15 46/60] x86/speculation: Use Indirect Branch Prediction Barrier in context switch
Date: Mon,  5 Feb 2018 10:23:19 -0800
Message-Id: <20180205182215.874232314@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586392620719805?=
X-GMAIL-MSGID: =?utf-8?q?1591586485428423249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Chen tim.c.chen@linux.intel.com

commit 18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/tlbflush.h |    2 ++
 arch/x86/mm/tlb.c               |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

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
@@ -247,6 +248,27 @@ void switch_mm_irqs_off(struct mm_struct
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
@@ -292,6 +314,14 @@ void switch_mm_irqs_off(struct mm_struct
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
