Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4DFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2561A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ct3qv1jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2561A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeG3M4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:56:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeG3M4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qbw/rX667viIf+fMpzTgwUAxGJp2d2iCsvmEQX3QwNI=; b=ct3qv1jf7qrzn2jBUIy2P2ghf
        1b96iKgyW4FOAdrKTEbIKdVhN+fBvoP+5Lvf24t+wicKFb+CxHN5aDggpyAzBHkDxz3N6SkOdyLEk
        WHO55d7Z/pAxd0gL9MdX574w8lRskEmLVY1IltlPnw0MdqmaYYwVfiYgYPIuXK5Swb+mIhwDe1hH0
        8qt8LGeA4PZPOeLIZL9f3pV8mvPxsibPbdNM3wJHjb6EMYxYpf4owWm1IU2JTiv61CyIbbE1IDgrX
        uwR87hkiDAVY/E4HqbYRzHwdtisRkEBCaOC1IsC64GmDm+jMnTaP2bL7IyFTVupzKJv1YHrNARcr5
        0FuYXz/Zw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk6FD-0006yk-Ef; Mon, 30 Jul 2018 11:21:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D1C92029B0A0; Mon, 30 Jul 2018 13:21:41 +0200 (CEST)
Date:   Mon, 30 Jul 2018 13:21:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        isaacm@codeaurora.org, matt@codeblueprint.co.uk, mingo@kernel.org,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        gregkh@linuxfoundation.org, pkondeti@codeaurora.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] stop_machine: Disable preemption after queueing stopper
 threads
Message-ID: <20180730112140.GH2494@hirez.programming.kicks-ass.net>
References: <1531856129-9871-1-git-send-email-isaacm@codeaurora.org>
 <a30d1e147d3181fc7b294262e380a10c@codeaurora.org>
 <20180724062350.nlem2suuy5wlxpts@linutronix.de>
 <alpine.DEB.2.21.1807301220280.2518@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807301220280.2518@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 12:20:57PM +0200, Thomas Gleixner wrote:
> On Tue, 24 Jul 2018, Sebastian Andrzej Siewior wrote:
> > On 2018-07-23 18:13:48 [-0700], isaacm@codeaurora.org wrote:
> > > Hi all,
> > Hi,
> > 
> > > Are there any comments about this patch?
> > 
> > I haven't look in detail at this but your new preempt_disable() makes
> > things unbalanced for the err != 0 case.
> 
> It doesn't but that code is really an unreadable pile of ...

---
Subject: stop_machine: Reflow cpu_stop_queue_two_works()

The code flow in cpu_stop_queue_two_works() is a little arcane; fix
this by lifting the preempt_disable() to the top to create more natural
nesting wrt the spinlocks and make the wake_up_q() and preempt_enable()
unconditional at the end.

Furthermore, enable preemption in the -EDEADLK case, such that we
spin-wait with preemption enabled.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/stop_machine.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index e190d1ef3a23..34b6652e8677 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -236,13 +236,24 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 	struct cpu_stopper *stopper2 = per_cpu_ptr(&cpu_stopper, cpu2);
 	DEFINE_WAKE_Q(wakeq);
 	int err;
+
 retry:
+	/*
+	 * The waking up of stopper threads has to happen in the same
+	 * scheduling context as the queueing.  Otherwise, there is a
+	 * possibility of one of the above stoppers being woken up by another
+	 * CPU, and preempting us. This will cause us to not wake up the other
+	 * stopper forever.
+	 */
+	preempt_disable();
 	raw_spin_lock_irq(&stopper1->lock);
 	raw_spin_lock_nested(&stopper2->lock, SINGLE_DEPTH_NESTING);
 
-	err = -ENOENT;
-	if (!stopper1->enabled || !stopper2->enabled)
+	if (!stopper1->enabled || !stopper2->enabled) {
+		err = -ENOENT;
 		goto unlock;
+	}
+
 	/*
 	 * Ensure that if we race with __stop_cpus() the stoppers won't get
 	 * queued up in reverse order leading to system deadlock.
@@ -253,36 +264,30 @@ static int cpu_stop_queue_two_works(int cpu1, struct cpu_stop_work *work1,
 	 * It can be falsely true but it is safe to spin until it is cleared,
 	 * queue_stop_cpus_work() does everything under preempt_disable().
 	 */
-	err = -EDEADLK;
-	if (unlikely(stop_cpus_in_progress))
-			goto unlock;
+	if (unlikely(stop_cpus_in_progress)) {
+		err = -EDEADLK;
+		goto unlock;
+	}
 
 	err = 0;
 	__cpu_stop_queue_work(stopper1, work1, &wakeq);
 	__cpu_stop_queue_work(stopper2, work2, &wakeq);
-	/*
-	 * The waking up of stopper threads has to happen
-	 * in the same scheduling context as the queueing.
-	 * Otherwise, there is a possibility of one of the
-	 * above stoppers being woken up by another CPU,
-	 * and preempting us. This will cause us to n ot
-	 * wake up the other stopper forever.
-	 */
-	preempt_disable();
+
 unlock:
 	raw_spin_unlock(&stopper2->lock);
 	raw_spin_unlock_irq(&stopper1->lock);
 
 	if (unlikely(err == -EDEADLK)) {
+		preempt_enable();
+
 		while (stop_cpus_in_progress)
 			cpu_relax();
+
 		goto retry;
 	}
 
-	if (!err) {
-		wake_up_q(&wakeq);
-		preempt_enable();
-	}
+	wake_up_q(&wakeq);
+	preempt_enable();
 
 	return err;
 }
