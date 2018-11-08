Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0954ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C95B2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C95B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKIDXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:23:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44910 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKIDXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:23:32 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKoON-0005vA-9G; Thu, 08 Nov 2018 18:46:55 +0100
Date:   Thu, 8 Nov 2018 18:46:55 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>, tglx@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: srcu: use cpu_online() instead custom check
Message-ID: <20181108174655.mnm3cr4wn2hrrtep@linutronix.de>
References: <20181101231228.GA9118@linux.ibm.com>
 <20181108163850.sjedoaom64tzvqgc@linutronix.de>
 <20181108171024.GM4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181108171024.GM4170@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 09:10:24 [-0800], Paul E. McKenney wrote:
> > Is this again a hidden RCU detail that preempt_disable() on CPU4 is
> > enough to ensure that CPU2 does not get marked offline between?
> 
> The call_rcu_sched parameter to synchronize_rcu_mult() makes this work.
> This synchronize_rcu_mult() call is in sched_cpu_deactivate(), so it
> is a hidden sched/RCU detail, I guess.
> 
> Or am I missing the point of your question?

No, this answers it.

> > > Or is getting rid of that preempt_disable region the real reason for
> > > this change?
> > 
> > Well, that preempt_disable() + queue_(delayed_)work() does not work -RT.
> > But looking further, that preempt_disable() while looking at online CPUs
> > didn't look good.
> 
> That is why it is invoked from the very early CPU-hotplug notifier.  That
> early in the process, the preempt_disable() does prevent the current CPU
> from being taken offline twice:  Once due to synchronize_rcu_mult(), and
> once due to the stop-machine call.

:)
 
> > The description is not up-to-date. There was this hunk:
> > |@@ -4236,8 +4232,6 @@ void __init rcu_init(void)
> > |       for_each_online_cpu(cpu) {
> > |               rcutree_prepare_cpu(cpu);
> > |               rcu_cpu_starting(cpu);
> > |-              if (IS_ENABLED(CONFIG_TREE_SRCU))
> > |-                      srcu_online_cpu(cpu);
> > |       }
> > | }
> > 
> > which got removed in v4.16.
> 
> Ah!  Here is the current rcu_init() code:
> 
> 	for_each_online_cpu(cpu) {
> 		rcutree_prepare_cpu(cpu);
> 		rcu_cpu_starting(cpu);
> 		rcutree_online_cpu(cpu);
> 	}
> 
> And rcutree_online_cpu() calls srcu_online_cpu() when CONFIG_TREE_SRCU
> is enabled, so no need for the direct call from rcu_init().

So if a CPU goes down, the timer gets migrated to another CPU. If the
CPU is already offline the timer can be programmed and nothing happens.
If timer_add_on() would return an error we could have fallback code.
Looking at the users of queue_delayed_work_on() there are only two using
it really (the others are using smp_processor_id()) and one of them is
using get_online_cpus().
It does not look like there a lot of users affected. Would be reasonable
to avoid adding timers to offlined CPUs?

> 							Thanx, Paul

Sebastian
