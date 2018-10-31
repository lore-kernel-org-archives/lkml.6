Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD73FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7773120821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wC4hxliy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7773120821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbeJaXJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:09:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38206 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbeJaXJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+1gaQhkWsZvYGq8K6A73FwqGpSZvRTDUrGRM7O1511o=; b=wC4hxliyPQgRZWc5kJhXJGtY6
        Kr41xPKVk+s9uym78W0aKoPxVkgNMWG6fkt4GF4j3Md+vY7bKMy+tPFjF04MfKAvH4iE/PPN0bE7c
        OvmuZxwsAfV8xFznXBTy8kKsiF/caSvux7fUyXOYS8Yqr/zrSZRKs5Mzw2XjLhKFND9eew2UBbTa+
        hP2A8lJ9XxBWBCECgsX+coO83dSU0/W4s+1hb0+XYananBSJCsQc6T6lnfqqtlHac8TDSNsknyEUx
        /ONAN1clkI7J4FNkWEoAyepnrLkjoaRCHiQrR6zE05eKAXtxXo5fA4ACFTcrMj5eN35vsOtlrve/+
        9LNN9xU9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHrCa-0003r4-VF; Wed, 31 Oct 2018 14:10:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1B812029F87F; Wed, 31 Oct 2018 15:10:30 +0100 (CET)
Date:   Wed, 31 Oct 2018 15:10:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yi Sun <yi.y.sun@linux.intel.com>
Cc:     Waiman Long <longman@redhat.com>, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        chao.p.peng@intel.com, chao.gao@intel.com,
        isaku.yamahata@intel.com, michael.h.kelley@microsoft.com,
        tianyu.lan@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v1 2/2] x86/hyperv: make HvNotifyLongSpinWait hypercall
Message-ID: <20181031141030.GB13219@hirez.programming.kicks-ass.net>
References: <1539954835-34035-3-git-send-email-yi.y.sun@linux.intel.com>
 <bab010e9-a122-95f1-d8cc-790e56c72716@suse.com>
 <20181022015342.GK11769@yi.y.sun>
 <2e0d62cb-b706-a5b4-65f7-982a913fb32b@suse.com>
 <ba75b994-c1a6-6e91-6499-b9af90636fcf@redhat.com>
 <20181022171516.GH3117@worktop.programming.kicks-ass.net>
 <20181023025740.GL11769@yi.y.sun>
 <20181023085127.GG3109@worktop.c.hoisthospitality.com>
 <20181023093328.GA15378@yi.y.sun>
 <20181031015417.GC15378@yi.y.sun>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031015417.GC15378@yi.y.sun>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:54:17AM +0800, Yi Sun wrote:
> On 18-10-23 17:33:28, Yi Sun wrote:
> > On 18-10-23 10:51:27, Peter Zijlstra wrote:

> > > Can you try and explain why vcpu_is_preempted() doesn't work for you?
> > 
> > I thought HvSpinWaitInfo is used to notify hypervisor the spin number
> > which is different with vcpu_is_preempted. So I did not consider
> > vcpu_is_preempted.
> > 
> > But HvSpinWaitInfo is a quite simple function and could be combined
> > with vcpu_is_preempted together. So I think it is OK to use
> > vcpu_is_preempted to make codes clean. I will have a try.
> 
> After checking codes, there is one issue to call vcpu_is_preempted.
> There are two spin loops in qspinlock_paravirt.h. One loop in
> 'pv_wait_node' calls vcpu_is_preempted. But another loop in
> 'pv_wait_head_or_lock' does not call vcpu_is_preempted. It also does
> not call any other ops of 'pv_lock_ops' in the loop. So I am afraid
> we have to add one more ops in 'pv_lock_ops' to do this.

Why? Would not something like the below cure that? Waiman, can you have
a look at this; I always forget how that paravirt crud works.

---
 kernel/locking/qspinlock.c          | 5 +++--
 kernel/locking/qspinlock_paravirt.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8a8c3c208c5e..a4ab80f95176 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -286,7 +286,8 @@ static __always_inline void __pv_wait_node(struct mcs_spinlock *node,
 static __always_inline void __pv_kick_node(struct qspinlock *lock,
 					   struct mcs_spinlock *node) { }
 static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock,
-						   struct mcs_spinlock *node)
+						   struct mcs_spinlock *node,
+						   struct mcs_spinlock *prev)
 						   { return 0; }
 
 #define pv_enabled()		false
@@ -500,7 +501,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * If PV isn't active, 0 will be returned instead.
 	 *
 	 */
-	if ((val = pv_wait_head_or_lock(lock, node)))
+	if ((val = pv_wait_head_or_lock(lock, node, prev)))
 		goto locked;
 
 	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 0130e488ebfe..531dadc955fb 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -399,9 +399,10 @@ static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *node)
  * The current value of the lock will be returned for additional processing.
  */
 static u32
-pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
+pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node, struct mcs_spinlock *prev)
 {
 	struct pv_node *pn = (struct pv_node *)node;
+	struct pv_node *pp = (struct pv_node *)prev;
 	struct qspinlock **lp = NULL;
 	int waitcnt = 0;
 	int loop;
@@ -430,7 +431,7 @@ pv_wait_head_or_lock(struct qspinlock *lock, struct mcs_spinlock *node)
 		 * disable lock stealing before attempting to acquire the lock.
 		 */
 		set_pending(lock);
-		for (loop = SPIN_THRESHOLD; loop; loop--) {
+		for (loop = SPIN_THRESHOLD; loop && !vcpu_is_preempted(prev->cpu); loop--) {
 			if (trylock_clear_pending(lock))
 				goto gotlock;
 			cpu_relax();

