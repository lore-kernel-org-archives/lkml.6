Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FBDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711162083B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfBSRTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:19:08 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfBSRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:19:08 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gw92v-0003gc-DN; Tue, 19 Feb 2019 18:19:05 +0100
Date:   Tue, 19 Feb 2019 18:19:05 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com
Subject: Re: [RFC PATCH RT 0/2] Add PINNED_HARD mode to hrtimers
Message-ID: <20190219171905.qrpr5uurayfqbehp@linutronix.de>
References: <20190214133716.10187-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214133716.10187-1-juri.lelli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-14 14:37:14 [+0100], Juri Lelli wrote:
> Hi,
Hi,

> Now, I'm sending this and an RFC, as I'm wondering if the first behavior
> is actually what we want, and it is not odd at all for reasons that are
> not evident to me at the moment. In this case this posting might also
> function as a question: why we need things to work as they are today?

There is /proc/sys/kernel/timer_migration which should disable this but
I think you know that already.

So this is a NO_HZ feature. Basically try to move all the timers to a
designated CPU so all others can deep idle while one CPU does the work.
Ideally you have no timer which is pending / will expire if you go idle.
And then, once the timer fires the housekeeping CPU does the work so
chances are that the CPU, that programmed the timer, may remain idle.

In this case you prepare the wakeup and then wake the CPU anyway. There
should be no downside to this unless the housekeeping CPU is busy and in
irq-off regions which would increase the latency. Also in case of
	cyclictest -d0

the one CPU would have to process all timers. So the latency will be
worse compared to every CPU does its own wakeup. And on RT you probably
do not want to do deep idle anyway.

> Thanks!
> 
> - Juri

Sebastian
