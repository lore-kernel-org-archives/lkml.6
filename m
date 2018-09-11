Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3314AC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE57F20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE57F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeIKVVt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:21:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42018 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeIKVVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:21:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fzlQ6-0000rq-TB; Tue, 11 Sep 2018 18:21:42 +0200
Date:   Tue, 11 Sep 2018 18:21:42 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Message-ID: <20180911162142.cc3vgook2gctus4c@linutronix.de>
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
 <20180911160532.GJ4225@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180911160532.GJ4225@linux.vnet.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-11 09:05:32 [-0700], Paul E. McKenney wrote:
> On Mon, Sep 10, 2018 at 03:56:16PM +0200, Sebastian Andrzej Siewior wrote:
> > It was possible that sync_rcu_exp_select_cpus() enqueued something on
> > CPU0 while CPU0 was offline. Such a work item wouldn't be processed
> > until CPU0 gets back online. This problem was addressed in commit
> > fcc6354365015 ("rcu: Make expedited GPs handle CPU 0 being offline"). I
> > don't think the issue fully addressed.
> > 
> > Assume grplo = 0 and grphi = 7 and sync_rcu_exp_select_cpus() is invoked
> > on CPU1. The preempt_disable() section on CPU1 won't ensure that CPU0
> > remains online between looking at cpu_online_mask and invoking
> > queue_work_on() on CPU1.
> > 
> > Use cpus_read_lock() to ensure that `cpu' is not going down between
> > looking at cpu_online_mask at invoking queue_work_on() and waiting for
> > its completion. It is added around the loop + flush_work() which is
> > similar to work_on_cpu_safe() (and we can have multiple jobs running on
> > NUMA systems).
> 
> Is this experimental or theoretical?

theoretical. I saw that hunk on RT and I can't have queue_work() within
a preempt_disable() section here.

> If theoretical, the counter-theory
> is that the stop-machine processing prevents any of the cpu_online_mask
> bits from changing, though, yes, we would like to get rid of the
> stop-machine processing.  So either way, yes, the current state could
> use some improvement.
> 
> But one problem with the patch below is that sync_rcu_exp_select_cpus()
> can be called while the cpu_hotplug_lock is write-held.  Or is that
> somehow OK these days?  

depends. Is it okay to wait until the write-lock is dropped? If it is,
then it is okay. If not…

> Assuming not, how about the (untested) patch
> below?

Doesn't work for me because it is still within the preempt-disable
section :/.
Would it work to use WORK_CPU_UNBOUND? As far as I understand it, the
CPU number does not matter, you just want to spread it across multiple
CPUs in the NUMA case.

> 							Thanx, Paul
> 
> commit 5214cbbfe6a5d6b92c76c4e411a049fe57245d4a
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Tue Sep 11 08:57:48 2018 -0700
> 
>     rcu: Stop expedited grace periods from relying on stop-machine
>     
>     The CPU-selection code in sync_rcu_exp_select_cpus() disables preemption
>     to prevent the cpu_online_mask from changing.  However, this relies on
>     the stop-machine mechanism in the CPU-hotplug offline code, which is not
>     desirable (it would be good to someday remove the stop-machine mechanism).

not that I tested it, but I still don't understand how a
preempt_disable() section on CPU1 can ensure that CPU3 won't go down. Is
there some code that invokes stop_cpus() for each CPU or so?

Sebastian
