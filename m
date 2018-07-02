Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B214BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D6525293
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 19:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D6525293
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeGBTiv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 15:38:51 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40624 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbeGBTiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 15:38:50 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fa4es-0001lb-BC; Mon, 02 Jul 2018 21:38:46 +0200
Date:   Mon, 2 Jul 2018 21:38:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     gengdongjiu <gengdongjiu@huawei.com>
Cc:     "Ouyangzhaowei (Charles)" <ouyangzhaowei@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        anna-maria@linutronix.de, john.stultz@linaro.org,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        yangchuanlong@huawei.com,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        liupeifeng3@huawei.com
Subject: Re: hrtimer become inaccurate with RT patch
Message-ID: <20180702193845.6n3jrei35zdtfb7z@linutronix.de>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
 <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
 <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
 <75928d33-ade0-3bc7-33df-43abf5442c32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <75928d33-ade0-3bc7-33df-43abf5442c32@huawei.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-02 19:19:07 [+0800], gengdongjiu wrote:
> Hi Sebastian ,
Hi gengdongjiu,

> > the 4.1 series is no longer supported (neither RT wise nor non-RT,
> > https://www.kernel.org/category/releases.html). I suggest to move away.
> > If you notice this problem now it is hardly a long running project.
> yes, I Know, but we found the latest RT 4.14 series also has the same problem,
> so this is common issue.
This does not change what I wrote regarding the v4.1 series. Also you
could have mention v4.14 instead v4.1 if you really tested on v4.14.

> >> process will not be interrupt. But if the hrtimer is also runs in
> >> process context the timer is useless when it's inaccurate. so I want to
> >> consult you whether this is expected behavior? whether is reasonable to move the timer IRQ
> >> handling to a thread?
> > 
> > This depends on your expectations. The timer is defined not to fire
> > before the programmed time. So it fires as soon as possible _after_ the
> > programmed time.
> It is reasonable that the timer is defined not to fire before the programmed time.
> but we found it fires long _after_ the programmed time. For example, we define it to
> fire after 2s, but it will fire after 5s, so it is very later than the expectations. 

under normal circumstances I would expect to have a few µs delay due to
wakeup of the softirq thread. Not seconds. This is either broken HW or a
long running RT thread which blocks the expected execution.

> I think the reason may be
> that the timer handler thread is preempted by another higher priority thread. so from for this issue,
> the timer handler should be in IRQ context instead of the process context or increase the timer handler thread priority, right?

speculating on what is going on and acting based on speculation is one
way to handle situation. You could also enable tracing to see
- when does the timer fire
- when does the thread wake up
- when does is timer's function start / complete

and then you know what *really* causes the delay. The hrtimer and sched
tracepoints should provide enough information. Based on that you can
figure out if it is wise the toggle the irqsave flag or change something
else so that the system does not run ~3sec RT secs without a break.

Sebastian
