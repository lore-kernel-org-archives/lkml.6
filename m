Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A41C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEBE242C9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEBE242C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965306AbeGBKO1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:14:27 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:59538 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965036AbeGBKOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:14:24 -0400
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fZvqf-0003T1-IW; Mon, 02 Jul 2018 12:14:21 +0200
Date:   Mon, 2 Jul 2018 12:14:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     gengdongjiu <gengdongjiu@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        anna-maria@linutronix.de, john.stultz@linaro.org,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        yangchuanlong@huawei.com,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        liupeifeng3@huawei.com
Subject: Re: hrtimer become inaccurate with RT patch
Message-ID: <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
 <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-02 17:34:34 [+0800], gengdongjiu wrote:
>   The Linux kernel version is v4.1.46, and the preempt_rt patch is
> patch-4.1.46-rt52.patch.

the 4.1 series is no longer supported (neither RT wise nor non-RT,
https://www.kernel.org/category/releases.html). I suggest to move away.
If you notice this problem now it is hardly a long running project.

> process will not be interrupt. But if the hrtimer is also runs in
> process context the timer is useless when it's inaccurate. so I want to
> consult you whether this is expected behavior? whether is reasonable to move the timer IRQ
> handling to a thread?

This depends on your expectations. The timer is defined not to fire
before the programmed time. So it fires as soon as possible _after_ the
programmed time.

> I think this is why hrtimer is run as a thread, I tried to set
> hrtimer.irqsafe to 1, but the timer still seemed not right. Could anyone
> give some advise? Thanks.

By setting irqsafe to 1 you ensure taht the timer will fire from the
timer interrupt and before doing so you should ensure that the timer is
indeed IRQ safe.
Depending on what you do it is possible that the timer fires early but
the application notices it later (the scheduler will first handle RT
tasks according to their priorities followed by non RT tasks).

Sebastian
