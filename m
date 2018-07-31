Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B8AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CB620841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CB620841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732250AbeGaORn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:17:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732150AbeGaORn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:17:43 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E495A17720F38;
        Tue, 31 Jul 2018 20:37:27 +0800 (CST)
Received: from [127.0.0.1] (10.121.91.26) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Tue, 31 Jul 2018
 20:37:27 +0800
Subject: Re: [PATCH] timers: fix offset calculation when the expires align
 with LVL_GRAN
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <john.stultz@linaro.org>, <sboyd@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1532669610-103892-1-git-send-email-xuyiping@hisilicon.com>
 <alpine.DEB.2.21.1807301234310.2518@nanos.tec.linutronix.de>
From:   Xu YiPing <xuyiping@hisilicon.com>
Message-ID: <4738717a-0ca7-8fc4-567d-8bd669f9eaf6@hisilicon.com>
Date:   Tue, 31 Jul 2018 20:37:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807301234310.2518@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.121.91.26]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/7/30 19:03, Thomas Gleixner wrote:
> On Fri, 27 Jul 2018, Xu YiPing wrote:
> 
>> when the expires of timer is align with LVL_GRAN(n), it will be trigged
>> in 'expires + LVL_GRAN(n)'.
>>
>> Some drivers like power runtime use the timer to start a power down
>> of device, it could saves power if the timer is triggerd in time,
>> especially when LEVEL=0 with low expires.
> 
>>From the above I have no idea what you are trying to 'fix', but see below.
> 
>> Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
>> ---
>>  kernel/time/timer.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
>> index cc2d23e..76655e2 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -487,7 +487,8 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
>>   */
>>  static inline unsigned calc_index(unsigned expires, unsigned lvl)
>>  {
>> -	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
>> +	expires = (expires + LVL_GRAN(lvl) - 1) >> LVL_SHIFT(lvl);
>> +
>>  	return LVL_OFFS(lvl) + (expires & LVL_MASK);
> 
> This is fundamentally wrong.
> 
> Assume the following scenario:
> 
>     base->clk = 1;
>     timer->expires = 1;
> 
> __internal_add_timer(base, timer)
> {  
>    idx = calc_wheel_index(timer->expires, base->clk)
>        {
>            delta = expires - clk;
> 
>            if (delta < LVL_START(1))
>                idx = calc_index(expires, 0)
>                     {
>                         expires = (expires + LVL_GRAN(0) - 1) >> LVL_SHIFT(0);
> 			return LVL_OFFS(0) + (expires & LVL_MASK);
> 
> Now lets use real numbers:
> 
> __internal_add_timer(base, timer)
> {  
>    idx = calc_wheel_index(1, 1)
>        {
>            delta = 1 - 1;	<-   0
> 
>            if (0 < LVL_START(1))
>                idx = calc_index(1, 0)
>                     {
>                         expires = (1 + LVL_GRAN(0) - 1) >> LVL_SHIFT(0);
> 			----> expires = 0
> 			return LVL_OFFS(0) + (0 & LVL_MASK);
> 			----> 0
> 
> So the returned index is 0, which means that the timer will expire in
> LVL_SIZE - 1 == 63 ticks.
> 
	yes, i missed this case.

> The above example is the worst case, but you broke other assumptions as
> well. The timer wheel guarantees that a timer armed with:
> 
>       mod_timer(timer, jiffies + 1)
> 
> will not fire before aty least one jiffy has elapsed. Let's look at the
> time line:
> 
>    |-------------------|-------------------|----------------|
>   tick               tick                tick
>  jiffies	   jiffies + 1        jiffies + 2
> 
>    |                   |
>    |  Any timer armed  |                   ^
>    |  here must be     |                   |
>    |  queued here -------------------------|
> 
> in order to guarantee that. Timer wheel timers are not accurate and never
> can be.
> 
	understand, thanks.

> Thanks,
> 
> 	tglx
> 
> .
> 

