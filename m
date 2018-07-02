Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF1AC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B11120989
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B11120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753921AbeGBLUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:20:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S964936AbeGBLUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:20:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 494B36E274D31;
        Mon,  2 Jul 2018 19:19:45 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.382.0; Mon, 2 Jul 2018
 19:19:38 +0800
Subject: Re: hrtimer become inaccurate with RT patch
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Ouyangzhaowei (Charles)" <ouyangzhaowei@huawei.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <anna-maria@linutronix.de>, <john.stultz@linaro.org>,
        Hangaohuai <hangaohuai@huawei.com>,
        "zhangjianwei (D)" <zhangjianwei8@huawei.com>,
        <yangchuanlong@huawei.com>,
        "Zhangbin (EulerOS)" <zhangbin46@huawei.com>,
        <liupeifeng3@huawei.com>
References: <12e6da4e-7681-771f-38d3-3c1abf943c24@huawei.com>
 <43d78927-3955-acde-a2d1-d2b82932a7a6@huawei.com>
 <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
From:   gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <75928d33-ade0-3bc7-33df-43abf5442c32@huawei.com>
Date:   Mon, 2 Jul 2018 19:19:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180702101420.rskzwqrdyws5fl6m@breakpoint.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian ,
   Thanks for the answer.

On 2018/7/2 18:14, Sebastian Andrzej Siewior wrote:
> On 2018-07-02 17:34:34 [+0800], gengdongjiu wrote:
>>   The Linux kernel version is v4.1.46, and the preempt_rt patch is
>> patch-4.1.46-rt52.patch.
> 
> the 4.1 series is no longer supported (neither RT wise nor non-RT,
> https://www.kernel.org/category/releases.html). I suggest to move away.
> If you notice this problem now it is hardly a long running project.
yes, I Know, but we found the latest RT 4.14 series also has the same problem,
so this is common issue.

> 
>> process will not be interrupt. But if the hrtimer is also runs in
>> process context the timer is useless when it's inaccurate. so I want to
>> consult you whether this is expected behavior? whether is reasonable to move the timer IRQ
>> handling to a thread?
> 
> This depends on your expectations. The timer is defined not to fire
> before the programmed time. So it fires as soon as possible _after_ the
> programmed time.
It is reasonable that the timer is defined not to fire before the programmed time.
but we found it fires long _after_ the programmed time. For example, we define it to
fire after 2s, but it will fire after 5s, so it is very later than the expectations. I think the reason may be
that the timer handler thread is preempted by another higher priority thread. so from for this issue,
the timer handler should be in IRQ context instead of the process context or increase the timer handler thread priority, right?

> 
>> I think this is why hrtimer is run as a thread, I tried to set
>> hrtimer.irqsafe to 1, but the timer still seemed not right. Could anyone
>> give some advise? Thanks.
> 
> By setting irqsafe to 1 you ensure taht the timer will fire from the
> timer interrupt and before doing so you should ensure that the timer is
> indeed IRQ safe.
> Depending on what you do it is possible that the timer fires early but
> the application notices it later (the scheduler will first handle RT
> tasks according to their priorities followed by non RT tasks).

(I will continue check this comments, thanks)

> 
> Sebastian
> 
> .
> 

