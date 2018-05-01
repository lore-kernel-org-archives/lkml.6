Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754478AbeEAKpI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:45:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeEAKpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:45:07 -0400
Date: Tue, 1 May 2018 12:44:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Kohli, Gaurav" <gkohli@codeaurora.org>
Cc: tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1] kthread/smpboot: Serialize kthread parking against
 wakeup
Message-ID: <20180501104459.GF12235@hirez.programming.kicks-ass.net>
References: <1524645199-5596-1-git-send-email-gkohli@codeaurora.org>
 <20180425200917.GZ4082@hirez.programming.kicks-ass.net>
 <20180426084131.GV4129@hirez.programming.kicks-ass.net>
 <20180426085719.GW4129@hirez.programming.kicks-ass.net>
 <4d3f68f8-e599-6b27-a2e8-9e96b401d57a@codeaurora.org>
 <20180430111744.GE4082@hirez.programming.kicks-ass.net>
 <3af3365b-4e3f-e388-8e90-45a3bd4120fd@codeaurora.org>
 <20180501101845.GE12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501101845.GE12217@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 12:18:45PM +0200, Peter Zijlstra wrote:
> Aaaah... I think I've spotted a problem there. We clear SHOULD_PARK
> before we rebind, so if the thread lost the first PARKED store,
> does the completion, gets migrated, cycles through the loop and now
> observes !SHOULD_PARK and bails the wait-loop, then __kthread_bind()
> will forever wait.


Something like so perhaps...

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -451,6 +451,21 @@ void kthread_unpark(struct task_struct *
 {
 	struct kthread *kthread = to_kthread(k);
 
+	if (test_bit(KTHREAD_IS_PARKED)) {
+		/*
+		 * Newly created kthread was parked when the CPU was offline.
+		 * The binding was lost and we need to set it again.
+		 */
+		if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
+			__kthread_bind(k, kthread->cpu, TASK_PARKED);
+	}
+
+	/*
+	 * Ensures the IS_PARKED load precedes the !SHOULD_PARK store.
+	 * matched by the smp_mb() from test_and_set_bit() in __kthread_parkme().
+	 */
+	smp_mb__before_atomic();
+
 	clear_bit(KTHREAD_SHOULD_PARK, &kthread->flags);
 	/*
 	 * We clear the IS_PARKED bit here as we don't wait
@@ -458,15 +473,8 @@ void kthread_unpark(struct task_struct *
 	 * park before that happens we'd see the IS_PARKED bit
 	 * which might be about to be cleared.
 	 */
-	if (test_and_clear_bit(KTHREAD_IS_PARKED, &kthread->flags)) {
-		/*
-		 * Newly created kthread was parked when the CPU was offline.
-		 * The binding was lost and we need to set it again.
-		 */
-		if (test_bit(KTHREAD_IS_PER_CPU, &kthread->flags))
-			__kthread_bind(k, kthread->cpu, TASK_PARKED);
+	if (test_and_clear_bit(KTHREAD_IS_PARKED, &kthread->flags))
 		wake_up_state(k, TASK_PARKED);
-	}
 }
 EXPORT_SYMBOL_GPL(kthread_unpark);
 
