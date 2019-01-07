Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96C0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997562089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AHx7Wb80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfAGKbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:31:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfAGKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gqRNZw5UHmp0XAtAGcu+0zMFwvqpaGJUlBTrm2kHs40=; b=AHx7Wb80Mb3sHZJQOvZwrdvE9J
        N3/DlKAK1k9639j5xrRwUZF2yau38K6NgqbziSksrWAF45wdpoTlasowGENWLEWJ8me50Rx2+S9p5
        1IJqGSagUWKCEulx7kv4mvuSLgdmfwKgB0fI4Qxypxg7kAv+IEanT3xVFM69HJGMss2tSfJSqaNVt
        GtXqoBzDcoMd2VbhbdeEnM6T8LRE7rSgd12SV26wRzWR1t8QBGnszCa8IvrCWOShbYFqYcxKwOuAg
        FsgCzotzfGyteXdMZFvy8N7xZR7ESnvMILHolEt/EMyKta3k4ExlMSAiULpqUyxW24izmpo5W5VMS
        5l0MD5dA==;
Received: from [185.88.64.153] (helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ggSC5-0007Md-4K; Mon, 07 Jan 2019 10:31:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 78B6E983877; Mon,  7 Jan 2019 11:26:13 +0100 (CET)
Date:   Mon, 7 Jan 2019 11:26:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tom Putzeys <tom.putzeys@be.atlascopco.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: CFS scheduler: spin_lock usage causes dead lock when
 smp_apic_timer_interrupt occurs
Message-ID: <20190107102613.GC2861@worktop.programming.kicks-ass.net>
References: <AM0PR03MB480425D5999E0D08DAB30204BB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
 <AM0PR03MB4804FA468B7A006AEEA8592ABB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR03MB4804FA468B7A006AEEA8592ABB8E0@AM0PR03MB4804.eurprd03.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 12:42:27PM +0000, Tom Putzeys wrote:
> Dear Ingo and Peter,
> 
> I would like to report a possible bug in the CFS scheduler causing a
> dead lock. 
> 
> We suspect this bug to have caused intermittent yet highly-persistent
> system freezes on our quad-core SMP systems.
> 
> We noticed the problem on 4.1.17 preempt-rt but we suspect the
> problematic code is not linked to the preempt-rt patch and is also
> present in the latest 4.20 kernel.
> 
> The problem concerns the use of spin_lock to lock cfs_b in a situation
> where the spin lock is used in an interrupt handler:

> -  __run_hrtimer (in kernel/time/hrtimer.c) calls fn(timer) with IRQ's
> enabled. This can call sched_cfs_period_timer() (in
> kernel/sched/fair.c) which locks cfs_b. 

Hurmph, that's the softirq timer handling. And that is a nasty subtle
difference in context between softirq and hardirq timers.

Also, upstream doesn't use HRTIMER_MODE_SOFT here, but I suppose -rt
forces everything !HARD into SOFT.

> - the hard IRQ smp_apic_timer_interrupt can then occur. It can call
> ttwu_queue() which grabs the spin lock for its CPU run queue and can
> then try to enqueue a task via the CFS scheduler.

> - this can call check_enqueue_throttle() which can call
> assign_cfs_rq_runtime() which tries to obtain the cfs_b lock. It is
> now blocked.
> 
> The cfs_b lock uses spin_lock and so was not intended for use inside a
> hard irq but the CFS scheduler does just that when it uses a
> hrtimer_interrupt to wake up and enqueue work. Our initial impression
> is that  the cfs_b needs to be locked using spin_lock_irqsave.

I would expect lockdep you also complain about this, but yes, something
like that. I was very much expecting this to run with IRQs disabled (and
it does on mainline afaict).
