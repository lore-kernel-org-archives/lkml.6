Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D45C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC65214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1KLd4EDn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC65214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbeKVDI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbeKVDI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:08:28 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9AA021479;
        Wed, 21 Nov 2018 16:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542817999;
        bh=e9kAvRDSgoEijAbzB5bzTfxCfww4at3b0vlYkbfp3ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1KLd4EDnGQE/8E0awBsvrIEFq3qPrsz5cwLqKXfWyspGx3IRKVkEQx91urFLVk1Ln
         dmWjFnkBtcvz9M7E0LAkQe2a0bLflrms9x1SEDyFNjjbCOgs0cj95dKQw1ui7nwokA
         KKOTepWR6wJzDurC2zBTqw45YZMJpc+hrDSousKg=
Date:   Wed, 21 Nov 2018 17:33:16 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 20/25] sched/kcpustat: Introduce vtime-aware kcpustat
 accessor
Message-ID: <20181121163314.GA1842@lerouge>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
 <1542163569-20047-21-git-send-email-frederic@kernel.org>
 <20181120142306.GX2131@hirez.programming.kicks-ass.net>
 <20181120224021.GB22332@lerouge>
 <20181121081819.GG2131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121081819.GG2131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 09:18:19AM +0100, Peter Zijlstra wrote:
> On Tue, Nov 20, 2018 at 11:40:22PM +0100, Frederic Weisbecker wrote:
> > On Tue, Nov 20, 2018 at 03:23:06PM +0100, Peter Zijlstra wrote:
> > > On Wed, Nov 14, 2018 at 03:46:04AM +0100, Frederic Weisbecker wrote:
> > > 
> > > > +void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
> > > > +		      u64 *user, u64 *nice, u64 *system,
> > > > +		      u64 *guest, u64 *guest_nice)
> > > > +{
> > > > +	struct task_struct *curr;
> > > > +	struct vtime *vtime;
> > > > +	int err;
> > > > +
> > > > +	if (!vtime_accounting_enabled()) {
> > > > +		kcpustat_cputime_raw(kcpustat, user, nice,
> > > > +				     system, guest, guest_nice);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	rcu_read_lock();
> > > > +
> > > > +	do {
> > > > +		curr = rcu_dereference(kcpustat->curr);
> > > 
> > > Like I explained earlier; I don't think the above is correct.
> > > task_struct is itself not RCU protected.
> > 
> > But there is at least one put_task_struct() that is enqueued as an RCU callback
> > on release_task(). That patchset (try to) make sure that kcpustat->curr can't
> > be assigned beyond that point.
> > 
> > Or did I misunderstand something?
> 
> Yeah; release_task() is not the normal exit path. Oleg can probably
> remember how all that works, because I always get lost there :-/
> 
> In any case, have a look at task_rcu_dereference(), but that still does
> not explain the rcu_assign_pointer() stuff you use to set
> kcpustat->curr.

So there are two reasons here.

One is the ordering. Here is the write side:


       schedule() {
           rq->curr = next;
	   context_switch() {
               vtime_task_switch() {
	           vtime_seqcount_write_lock(prev);
                   //flush pending vtime
                   vtime_seqcount_write_unlock(prev);

       	           vtime_seqcount_write_lock(next);
                   //Init vtime
                   vtime_seqcount_write_unlock(next);

                   rcu_assign_pointer(this_kcpustat->curr, next);
               }
           }
       }

So now from the read side, if I fetch the task from rq->curr, there is a risk
that I see the next task but I don't see the vtime flushed by prev task yet.
If the prev task has run 1 second without being interrupted, I'm going to miss
that whole time.

Assigning the next task after the prev task has flushed its vtime prevent from
that kind of race due to the barriers implied by seqcount and even rcu_assign_pointer.

The second reason is that I looked at task_rcu_dereference() and its guts are really
not appealing. The ordering guarantee is hard to parse there.

At least with kcpustat->curr I can make sure that the pointer is NULL before the
earliest opportunity for call_rcu(delayed_put_task_struct) to be queued (which is
exit_notify() in case of autoreap).
