Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81221ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400CC2077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400CC2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeKICPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:15:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44690 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbeKICPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:15:12 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKnKV-0004EA-7Q; Thu, 08 Nov 2018 17:38:51 +0100
Date:   Thu, 8 Nov 2018 17:38:51 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: srcu: use cpu_online() instead custom check
Message-ID: <20181108163850.sjedoaom64tzvqgc@linutronix.de>
References: <20181101231228.GA9118@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181101231228.GA9118@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-01 16:12:28 [-0700], Paul E. McKenney wrote:
> > The current check via srcu_online is slightly racy because after looking
> > at srcu_online there could be an interrupt that interrupted us long
> > enough until the CPU we checked against went offline.
> 
> I don't see how this can happen, even in -rt.  The call to
> srcu_offline_cpu() happens very early in the CPU removal process,
> which means that the synchronize_rcu_mult(call_rcu, call_rcu_sched)
> in sched_cpu_deactivate() would wait for the interrupt to complete.
> And for the enclosing preempt_disable region to complete.

Is this again a hidden RCU detail that preempt_disable() on CPU4 is
enough to ensure that CPU2 does not get marked offline between?

> Or is getting rid of that preempt_disable region the real reason for
> this change?

Well, that preempt_disable() + queue_(delayed_)work() does not work -RT.
But looking further, that preempt_disable() while looking at online CPUs
didn't look good.

> > An alternative would be to hold the hotplug rwsem (so the CPUs don't
> > change their state) and then check based on cpu_online() if we queue it
> > on a specific CPU or not. queue_work_on() itself can handle if something
> > is enqueued on an offline CPU but a timer which is enqueued on an offline
> > CPU won't fire until the CPU is back online.
> > 
> > I am not sure if the removal in rcu_init() is okay or not. I assume that
> > SRCU won't enqueue a work item before SRCU is up and ready.
> 
> That was the case before the current merge window, but use of call_srcu()
> by tracing means that SRCU needs to be able to deal with call_srcu()
> long before any initialization has happened.  The actual callbacks
> won't be invoked until much later, after the scheduler and workqueues
> are completely up and running, but call_srcu() can be invoked very early.
> 
> But I am not seeing any removal in rcu_init() in this patch, so I might
> be missing something.

The description is not up-to-date. There was this hunk:
|@@ -4236,8 +4232,6 @@ void __init rcu_init(void)
|       for_each_online_cpu(cpu) {
|               rcutree_prepare_cpu(cpu);
|               rcu_cpu_starting(cpu);
|-              if (IS_ENABLED(CONFIG_TREE_SRCU))
|-                      srcu_online_cpu(cpu);
|       }
| }

which got removed in v4.16.

> 							Thanx, Paul

Sebastian
