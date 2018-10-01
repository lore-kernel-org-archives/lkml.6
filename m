Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71F0C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558C5208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+TXHUdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558C5208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbeJBEEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:04:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeJBEEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:04:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so9090713wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l5ojayymttZT3sOY4vZOYK2LIPBzIgvpAr+2nOeYT0w=;
        b=L+TXHUdDPtP4EyfcVFyev4zqUN1CDF2Vtq25oeFwxs0/ZRWVhjC9o9hlW+erhWXmEh
         feq1T2YbMhkKyyC4vugL9ewzvFoXgKrgJ1PolJFqDcVXfjKLOHAJQc5tR1hl8ohQSScG
         OSP2b6HYSR8Jr+DVOaAuNeXpnVEL9xln7g01A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l5ojayymttZT3sOY4vZOYK2LIPBzIgvpAr+2nOeYT0w=;
        b=n4xOhBvenog2HTd9rDzA5pfSnA1MwIUvvqxo8GTzLkVFkETDQDIXpYcK9nGvrASkCB
         LaXcmNR6B8LKSz7/S+gpJPo2ueCLVPrij2svivYwxRRlNRaMvw9jZt7a6E8N/1/FDKoY
         BUsIyOSnl1Hkyo6d1RS69bJn6V+Xe554Ys43ZE7GJ0GOWruXAH1hpAR4bD1BJtqMA6hv
         oY6Cu0c8wRYUNPlfolUS+wzJQ1wfFFp6VffHwUCNi8HY1mQsQRz9pCXhSn4oZhg0p2Tv
         Dg135TLX6jUbHpY+UC3BN5DjQgYM1ct38MyNb4bnIANizrg552UdkcXB0cRhWQpDy1xX
         aYxA==
X-Gm-Message-State: ABuFfoh5NGzGnzPGWruuEJr/TsuMXVNWw6S8d/YVjQJ1scDiUbDTpK28
        6mCxRQQhuWu22fTHPQioZOmHtH61IlU=
X-Google-Smtp-Source: ACcGV60YdWJlrEEuN77qxggpbvCqJmNR2QKfZo0dXSSGJYUmx1QnBp/2b1/PdjOa8mScgYIiat7xPQ==
X-Received: by 2002:adf:f2d0:: with SMTP id d16-v6mr8212425wrp.258.1538429053707;
        Mon, 01 Oct 2018 14:24:13 -0700 (PDT)
Received: from [192.168.0.41] (114.141.88.92.rev.sfr.net. [92.88.141.114])
        by smtp.googlemail.com with ESMTPSA id e64-v6sm7950408wmg.0.2018.10.01.14.24.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:24:12 -0700 (PDT)
Subject: Re: [PATCH v7 2/7] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180913113024.3571-1-alexandre.belloni@bootlin.com>
 <20180913113024.3571-3-alexandre.belloni@bootlin.com>
 <3ff4d71d-6a63-58ca-bdfd-79b9867fa477@linaro.org>
 <20180925211629.GE3112@piout.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7988ce42-fba9-db31-c1df-b78900192598@linaro.org>
Date:   Mon, 1 Oct 2018 23:24:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925211629.GE3112@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2018 23:16, Alexandre Belloni wrote:
> On 24/09/2018 03:59:55+0200, Daniel Lezcano wrote:
>> On 13/09/2018 13:30, Alexandre Belloni wrote:
>>> Add a driver for the Atmel Timer Counter Blocks. This driver provides a
>>> clocksource and two clockevent devices.
>>>
>>> One of the clockevent device is linked to the clocksource counter and so it
>>> will run at the same frequency. This will be used when there is only on TCB
>>> channel available for timers.
>>>
>>> The other clockevent device runs on a separate TCB channel when available.
>>>
>>> This driver uses regmap and syscon to be able to probe early in the boot
>>> and avoid having to switch on the TCB clocksource later. 
>>
>> Sorry, I don't get it. Can you elaborate?
>>
> 
> The current existing way of sharing TCB channels is getting probed to
> late in the boot process to be used as the clocksource so currently, the
> PIT is necessary to act as the clocksource until the TCB clocksource can
> be probed.
> 
> This is a big issue for SoCs without a PIT, they simply can't boot.

I'm still missing the point. The timer (clocksource + clocksource) is
probed very early with TIMER_OF_DECLARE.


> This also solves:
> 33d8c15559df Revert "clocksource/drivers/tcb_clksrc: Use 32 bit tcb as sched_clock"
> 7b9f1d16e6d1 clocksource/drivers/tcb_clksrc: Use 32 bit tcb as sched_clock
> 
> 
>>> Using regmap also
>>> means that unused TCB channels may be used by other drivers (PWM for
>>> example). read/writel are still used to access channel specific registers
>>> to avoid the performance impact of regmap (mainly locking).
>>
>> I don't get the regmap reasoning here.
> 
> Because there are 3 channels per TCB, some TCB can have channels handled
> by different drivers (say channel 0 for clocksource, channel 1 for
> clockevent and channel 2 for PWM). There are configuration registers that
> are shared for all the channels and so the access needs to be handled
> properly. But as we discussed on a previous version of the patch, we
> don't want to lock/unlock each time we read the clocksource so for the
> channel specific registers, readl/writel is used directly.

Can you point me to the code where we have racy access to the
ATMEL_TC_BMR register ?


>> My main concern with this driver is the 16bits chained support. See
>> below in the comments.
>>
>>
>>> +struct atmel_tcb_clksrc {
>>> +	struct clocksource clksrc;
>>> +	struct clock_event_device clkevt;
>>> +	struct regmap *regmap;
>>> +	void __iomem *base;
>>> +	struct clk *clk[2];
>>> +	char name[20];
>>
>> You can reasonably remove this field and use directly the ones in the
>> clocksrc/evt.
>>
> 
> name in struct clocksource is a pointer to a string, we still need a
> place to store that string.

Come on!

char *name = kasprintf(...);

tc.clkevt.name = name;
tc.clksrc.name = name;

no need to add a specific field for this.

Alternatively, you can make use of the
kbasename(node->parent->full_name) only without the channel numbering.

>>> +	int channels[2];
>>> +	int bits;
>>> +	int irq;
>>
>> After removing the request_irq/free_irq calls below (see comment), this
>> field can be removed.
>>
>>> +	struct {
>>> +		u32 cmr;
>>> +		u32 imr;
>>> +		u32 rc;
>>> +		bool clken;
>>
>> Not sure clken is needed, 16/32 is enough information.
>>
> 
> This as nothing to do with 16/32. We always need to now whether the
> timer was running or not.

Mmh, not sure why I said that. Anyway ...

>>> +	} cache[2];
>>> +	u32 bmr_cache;
>>
>> Are you sure you should save the bmr content ?
>>
> 
> We need to restore at least part of it. We may need to be more clever
> about it but this is the current behaviour and it has been working fine.
> 
>>> +	bool registered;
>>> +	bool clk_enabled;
>>
>> Not used.
>>
> 
> I guess they are use in the following patch.

Move them to the patch making use of it.

>>> +};
>>> +
>>> +static struct atmel_tcb_clksrc tc;
>>> +
>>> +static struct clk *tcb_clk_get(struct device_node *node, int channel)
>>> +{
>>> +	struct clk *clk;
>>> +	char clk_name[] = "t0_clk";
>>> +
>>> +	clk_name[1] += channel;
>>> +	clk = of_clk_get_by_name(node->parent, clk_name);
>>> +	if (!IS_ERR(clk))
>>> +		return clk;
>>> +
>>> +	return of_clk_get_by_name(node->parent, "t0_clk");
>>
>> Can you explain why returning "t0_clk" is better than returning an error?
>>
> 
> This is the current tclib behavior and doing otherwise would break the
> DT ABI.
> The reason for this behavior is that some TCB may have a clock
> per channel while others have one clock for the whole block.

What are the DT ABI? Can you point the snippets ?


>>> +}
>>> +
>>> +/*
>>> + * Clocksource and clockevent using the same channel(s)
>>> + */
>>> +static u64 tc_get_cycles(struct clocksource *cs)
>>> +{
>>> +	u32 lower, upper;
>>> +
>>> +	do {
>>> +		upper = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1]));
>>> +		lower = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[0]));
>>> +	} while (upper != readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1])));
>>> +
>>> +	return (upper << 16) | lower;
>>> +}
>>> +
>>> +static u64 tc_get_cycles32(struct clocksource *cs)
>>> +{
>>> +	return readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[0]));
>>> +}
>>> +
>>> +static u64 notrace tc_sched_clock_read(void)
>>> +{
>>> +	return tc_get_cycles(&tc.clksrc);
>>> +}
>>> +
>>> +static u64 notrace tc_sched_clock_read32(void)
>>> +{
>>> +	return tc_get_cycles32(&tc.clksrc);
>>> +}
>>> +
>>> +static int tcb_clkevt_next_event(unsigned long delta,
>>> +				 struct clock_event_device *d)
>>> +{
>>> +	u32 old, next, cur;
>>> +
>>> +	old = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
>>> +	next = old + delta;
>>> +	writel(next, tc.base + ATMEL_TC_RC(tc.channels[0]));
>>> +	cur = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
>>> +
>>> +	/* check whether the delta elapsed while setting the register */
>>> +	if ((next < old && cur < old && cur > next) ||
>>> +	    (next > old && (cur < old || cur > next))) {
>>> +		/*
>>> +		 * Clear the CPCS bit in the status register to avoid
>>> +		 * generating a spurious interrupt next time a valid
>>> +		 * timer event is configured.
>>> +		 */
>>> +		old = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
>>> +		return -ETIME;
>>> +	}
>>>> +	writel(ATMEL_TC_CPCS, tc.base + ATMEL_TC_IER(tc.channels[0]));
>>
>>
>> How this is compatible with 16bits as defined in the init function ?
>>
> 
> This is working fine because it is the lower bits channel and in that
> case, clockevents_config_and_register is call with the proper mask (16
> lower bits sets).
> 
>>> +	return 0;
>>> +}
>>> +
>>> +static irqreturn_t tc_clkevt_irq(int irq, void *handle)
>>> +{
>>> +	unsigned int sr;
>>> +
>>> +	sr = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
>>> +	if (sr & ATMEL_TC_CPCS) {
>>> +		tc.clkevt.event_handler(&tc.clkevt);
>>> +		return IRQ_HANDLED;
>>> +	}
>>> +
>>> +	return IRQ_NONE;
>>> +}
>>> +
>>> +static int tcb_clkevt_oneshot(struct clock_event_device *dev)
>>> +{
>>> +	if (clockevent_state_oneshot(dev))
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * Because both clockevent devices may share the same IRQ, we don't want
>>> +	 * the less likely one to stay requested
>>> +	 */
>>> +	return request_irq(tc.irq, tc_clkevt_irq, IRQF_TIMER | IRQF_SHARED,
>>> +			   tc.name, &tc);
>>> +}
>>> +
>>> +static int tcb_clkevt_shutdown(struct clock_event_device *dev)
>>> +{
>>> +	writel(0xff, tc.base + ATMEL_TC_IDR(tc.channels[0]));
>>> +	if (tc.bits == 16)
>>> +		writel(0xff, tc.base + ATMEL_TC_IDR(tc.channels[1]));
>>> +
>>> +	if (!clockevent_state_detached(dev))
>>> +		free_irq(tc.irq, &tc);
>>
>> Why are you requesting and freeing the irq instead of using the
>> disable/enable register operations ?
> 
> To avoid going through two interrupt handlers when we know that one is
> never used (that is when we have a separate channel for the clockevent,
> see following patch).

This explanation is not convincing. I will let you look at the
request_irq / free_irq internals (including __setup_irq) to figure out
why this is not possible.


>>> +	/* How fast will we be counting?  Pick something over 5 MHz.  */
>>> +	rate = (u32)clk_get_rate(tc.clk[0]);
>>> +	for (i = 0; i < 5; i++) {
>>> +		unsigned int divisor = atmel_tc_divisors[i];
>>> +		unsigned int tmp;
>>> +
>>> +		if (!divisor)
>>> +			continue;
>>
>> I suppose you meant here 'break' ? Use atmel_tc_divisors[] = { 2, 8, 32,
>> 128 }; And then the ARRAY_SIZE macro.
>>
>>> +		tmp = rate / divisor;
>>> +		pr_debug("TC: %u / %-3u [%d] --> %u\n", rate, divisor, i, tmp);
>>> +		if (best_divisor_idx > 0) {
>>> +			if (tmp < 5 * 1000 * 1000)
>>> +				continue;
>>> +		}
>>> +		divided_rate = tmp;
>>> +		best_divisor_idx = i;
>>
>> What is a best divisor ? The highest one or the one closer to 5MHz ?
>>
> 
> The whole divisor selection is coming for the previous driver and I'd
> rather not change it at this point, this is the topic of an other
> series.
> It chooses the first divisor that gives a counting rate over 5MHz

So why not stop the loop as soon as the rate / divisor is >= to 5MHz ?

>>> +	}
>>> +
>>> +	if (tc.bits == 32) {
>>> +		tc.clksrc.read = tc_get_cycles32;
>>> +		tcb_setup_single_chan(&tc, best_divisor_idx);
>>> +		tc_sched_clock = tc_sched_clock_read32;
>>> +		snprintf(tc.name, sizeof(tc.name), "%s:%d",
>>> +			 kbasename(node->parent->full_name), tc.channels[0]);
>>> +	} else {
>>> +		tc.clk[1] = tcb_clk_get(node, tc.channels[1]);
>>> +		if (IS_ERR(tc.clk[1]))
>>> +			goto err_disable_t0;
>>
>> This is very confusing. If the function tcb_clk_get() fails with this
>> channel, it will return "t0_clk" and will be used here ? Why ?
>>
> 
> See earlier explanation.
> 
>>> +		err = clk_prepare_enable(tc.clk[1]);
>>> +		if (err) {
>>> +			pr_debug("can't enable T1 clk\n");
>>> +			goto err_clk1;
>>> +		}
>>> +		tc.clksrc.read = tc_get_cycles,
>>> +		tcb_setup_dual_chan(&tc, best_divisor_idx);
>>> +		tc_sched_clock = tc_sched_clock_read;
>>> +		snprintf(tc.name, sizeof(tc.name), "%s:%d,%d",
>>> +			 kbasename(node->parent->full_name), tc.channels[0],
>>> +			 tc.channels[1]);
>>> +	}
>>> +
>>> +	pr_debug("%s at %d.%03d MHz\n", tc.name,
>>> +		 divided_rate / 1000000,
>>> +		 ((divided_rate + 500000) % 1000000) / 1000);
>>
>> Using two channels to emulate a 32bits timer has a significant cost,
>> especially in the sched_clock function which is part of the hot kernel
>> path. In addition it makes the code less maintainable and readable.
>>
>> Why don't you just stick to a specific rate with the prescalar value and
>> reduce the rating of the timer ? (example in the stm32 timer,
>> stm32_timer_set_prescaler and init function).
>>
>> It will be less precise (thus the lower rating) but will make the system
>> faster by preventing multiple register reads in the sched_clock.
>>
>> Is it an acceptable trade-off ?
>>
> 
> Not at this point, the goal is to not change the current behaviour.
> Some customer rely on the fast timer (they are bitbanging some RF
> protocols) and counting at more that 5MHz using a 16 bit timer is
> definitively too fast.

Not if you use the prescalar.

> This is something that could be changed once we implement timer rate
> selection (but I doubt it will make the code more readable).
> 
> I'm not saying we shouldn't question what was done 10 years ago but I'd
> rather not change it is this series.
> 
> Also, the goal is to get rid of the tcb_clksrc driver now that avr32 is
> gone. This will be done once the pwm driver is converted (I did that in
> v1).

You want to get rid of the tcb_clksrc by adding a new driver which is
very similar without taking into consideration to do a move to something
cleaner and putting in question what was already done.



>>> +	tcb_base = of_iomap(node->parent, 0);
>>> +	if (!tcb_base) {
>>> +		pr_err("%s +%d %s\n", __FILE__, __LINE__, __func__);
>>
>> Remove those debug information and replace them by a proper error message.
>>
> 
> My mistake, this will be simply removed.
> 
>>> +		return -ENXIO;
>>> +	}
>>> +
>>> +	match = of_match_node(atmel_tcb_dt_ids, node->parent);
>>> +	bits = (uintptr_t)match->data;
>>> +
>>> +	err = of_property_read_u32_index(node, "reg", 0, &channel);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	irq = of_irq_get(node->parent, channel);
>>> +	if (irq < 0) {
>>
>> if (irq <= 0) {
>>
>>> +		irq = of_irq_get(node->parent, 0);
>>
>> Why ?
>>
> 
> See the binding, 

Ok, can you point me to the code ?

> the timer is a child of the TCB and the TCB node has
> the irq info. So, the TCB is defined in the dtsi and the child nodes are
> in the board dts.
> 
>>> +		if (irq < 0)
>>
>> if (irq <= 0) {
>>
>>> +			return irq;
>>> +	}
>>> +
>>> +	if (bits == 16) {
>>> +		of_property_read_u32_index(node, "reg", 1, &chan1);
>>> +		if (chan1 == -1) {
>>> +			pr_err("%s: clocksource needs two channels\n",
>>> +			       node->parent->full_name);
>>
>> Think about it. The code is giving up at this point in the boot process.
>> So of two things, you consider there is an alternate clocksource /
>> clockevent or the system hangs:
>>
>>  - If there is an alternate clocksource why support 32bits by chaining
>> the channels with the cost it introduces instead of using the alternate
>> one ?
>>
> 
> The PIT is almost always the worse clocksource as it is very slow.

What is slow here ?

>>  - If there is no alternate clocksource why not support a 16bits less
>> precise timer and give up with the 32bits emulation and the complexity
>> it introduces in this driver ?
>>
> 
> If there is not alternate clocksource, the TCB is 32bit.





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

