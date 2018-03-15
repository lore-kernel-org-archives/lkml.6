Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeCOMgJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:36:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49196 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbeCOMfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:45 -0400
Message-Id: <20180315123202.787477034@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:11 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 09/11] sched/wait,mips: Fix and replace wait_on_atomic_t usage
References: <20180315121902.942902000@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-wait_var-9.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the wait_on_atomic_t() usage to the new wait_var_event() API.

And while there, add the missing wakeup...

Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/kernel/process.c |    2 ++
 arch/mips/kernel/traps.c   |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -781,6 +781,8 @@ int mips_set_process_fp_mode(struct task
 	atomic_set(&task->mm->context.fp_mode_switching, 0);
 	preempt_enable();
 
+	wake_up_var(&task->mm->context.fp_mode_switching);
+
 	return 0;
 }
 
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1248,8 +1248,8 @@ static int enable_restore_fp_context(int
 	 * If an FP mode switch is currently underway, wait for it to
 	 * complete before proceeding.
 	 */
-	wait_on_atomic_t(&current->mm->context.fp_mode_switching,
-			 atomic_t_wait, TASK_KILLABLE);
+	wait_var_event(&current->mm->context.fp_mode_switching,
+		       !atomic_read(&current->mm->context.fp_mode_switching));
 
 	if (!used_math()) {
 		/* First time FP context user. */
