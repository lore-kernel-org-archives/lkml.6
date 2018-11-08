Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9309AECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66EBC20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EBC20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeKIDxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:53:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:44989 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeKIDxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:53:15 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKor0-0006hU-NQ; Thu, 08 Nov 2018 19:16:30 +0100
Date:   Thu, 8 Nov 2018 19:16:30 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: srcu: use cpu_online() instead custom check
Message-ID: <20181108181630.nsr3cyjwsch2y2r5@linutronix.de>
References: <20181101231228.GA9118@linux.ibm.com>
 <20181108163850.sjedoaom64tzvqgc@linutronix.de>
 <20181108171024.GM4170@linux.ibm.com>
 <20181108174655.mnm3cr4wn2hrrtep@linutronix.de>
 <20181108180517.GR4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181108180517.GR4170@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-08 10:05:17 [-0800], Paul E. McKenney wrote:
> Just to make sure I understand, this is the call to queue_delayed_work_on()
> from srcu_queue_delayed_work_on(), right?

correct.

> And if I am guessing correctly, you would like to get rid of the
> constraint requiring CPUHP_RCUTREE_PREP to precede CPUHP_TIMERS_PREPARE?

no, my problem is the preempt_disable() around queue_delayed_work_on().
If the CPUs goes offline _after_ queue_delayed_work_on() then the timer
gets migrated and work item should show up on another CPU. 
If the CPU is offline at queue_delayed_work_on() time then the timer
gets enqueued and won't fire until the CPU is back online and I *think*
that is the reason behind this "is CPU online" check.

> If so, the swait_event_idle_timeout_exclusive() in rcu_gp_fqs_loop()
> in kernel/rcu/tree.c also requires this ordering.  There are probably
> other pieces of code needing this.
> 
> Plus the reason for running this on a specific CPU is that the workqueue
> item is processing that CPU's per-CPU variables, including invoking that
> CPU's callbacks.  The item is srcu_invoke_callbacks().

The SRCU callback is invoking per-CPU variables? Like this_cpu_ptr()?
But if the CPU is offline then you fallback to queue_delayed_work()?

> 							Thanx, Paul

Sebastian
