Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA41C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357B621502
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357B621502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeJJQT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:19:59 -0400
Received: from foss.arm.com ([217.140.101.70]:48622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbeJJQT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:19:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 333F080D;
        Wed, 10 Oct 2018 01:58:48 -0700 (PDT)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AEFC3F5D3;
        Wed, 10 Oct 2018 01:58:46 -0700 (PDT)
Subject: Re: [PATCH v3 1/5] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
To:     Lina Iyer <ilina@codeaurora.org>, bjorn.andersson@linaro.org,
        sboyd@kernel.org, evgreen@chromium.org, linus.walleij@linaro.org
Cc:     rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
References: <20180904211810.5506-1-ilina@codeaurora.org>
 <20180904211810.5506-2-ilina@codeaurora.org>
 <20181002170622.GK11144@codeaurora.org>
 <20181009170701.GS11144@codeaurora.org>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <d3ae0124-fa15-dd5c-cfe0-0c6701dad73e@arm.com>
Date:   Wed, 10 Oct 2018 09:58:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009170701.GS11144@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/18 18:07, Lina Iyer wrote:
> On Tue, Oct 02 2018 at 11:06 -0600, Lina Iyer wrote:
>> Marc,
>>
>> I am exploring an option where we don't do this enable/disable every
>> suspend/resume and in that process, I was able to just use the PDC
>> interrupt instead of the TLMM for triggering the GPIO. The PDC interrupt
>> (which takes over for the GPIO) has an handler like this -
>>
>> On Tue, Sep 04 2018 at 15:18 -0600, Lina Iyer wrote:
>>> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
>>> domain can wakeup the SoC, when interrupts and GPIOs are routed to its
>>> interrupt controller. Only select GPIOs that are deemed wakeup capable
>>> are routed to specific PDC pins. During low power state, the pinmux
>>> interrupt controller may be non-functional but the PDC would be. The PDC
>>> can detect the wakeup GPIO is triggered and bring the TLMM to an
>>> operational state.
>>>
>>> Interrupts that are level triggered will be detected at the TLMM when
>>> the controller becomes operational. Edge interrupts however need to be
>>> replayed again.
>>>
>>> Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
>>> but keep it disabled. During suspend, we can enable the PDC IRQ instead
>>> of the GPIO IRQ, which may or not be detected.
>>>
>>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>> ---
>>> Changes in v3:
>>> 	- free action->name
>>> Changes in v2:
>>> 	- Remove IRQF_NO_SUSPEND and IRQF_ONE_SHOT from PDC IRQ
>>> Changes in v1:
>>> 	- Trigger GPIO in h/w from PDC IRQ handler
>>> 	- Avoid big tables for GPIO-PDC map, pick from DT instead
>>> 	- Use handler_data
>>> ---
>>> drivers/pinctrl/qcom/pinctrl-msm.c | 98 ++++++++++++++++++++++++++++++
>>> 1 file changed, 98 insertions(+)
>>>
>>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>>> index 0e22f52b2a19..6527a0a9edd1 100644
>>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>>> @@ -687,11 +687,15 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>>> 	const struct msm_pingroup *g;
>>> 	unsigned long flags;
>>> 	u32 val;
>>> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>>>
>>> 	g = &pctrl->soc->groups[d->hwirq];
>>>
>>> 	raw_spin_lock_irqsave(&pctrl->lock, flags);
>>>
>>> +	if (pdc_irqd)
>>> +		irq_set_irq_type(pdc_irqd->irq, type);
>>> +
>> I skip over the TLMM configuration for the GPIO interrupt and just set
>> the IRQ handler for the GPIO interrupt here..
>>
>>> 	/*
>>> 	 * For hw without possibility of detecting both edges
>>> 	 */
>>> @@ -779,9 +783,13 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>>> 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>>> 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>>> 	unsigned long flags;
>>> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>>>
>>> 	raw_spin_lock_irqsave(&pctrl->lock, flags);
>>>
>>> +	if (pdc_irqd)
>>> +		irq_set_irq_wake(pdc_irqd->irq, on);
>>> +
>>> 	irq_set_irq_wake(pctrl->irq, on);
>>>
>>> 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>>> @@ -863,6 +871,94 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
>>> 	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
>>> }
>>>
>>> +static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
>>> +{
>>> +	struct irq_data *irqd = data;
>>> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
>>> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>>> +	const struct msm_pingroup *g;
>>> +	unsigned long flags;
>>> +	u32 val;
>>> +
>>> +	if (!irqd_is_level_type(irqd)) {
>>> +		g = &pctrl->soc->groups[irqd->hwirq];
>>> +		raw_spin_lock_irqsave(&pctrl->lock, flags);
>>> +		val = BIT(g->intr_status_bit);
>>> +		writel(val, pctrl->regs + g->intr_status_reg);
>>> +		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
>>> +	}
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>
>> Then ...
>>
>> static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
>> {
>>       struct irq_data *irqd = data;
>>       struct irq_desc *desc = irq_to_desc(irqd->irq);
>>
>>       desc->handle_irq(desc);
>>
>>       return IRQ_HANDLED;
>> }
>>
>> I am following check_irq_resend() but I need to call the handler for
>> both level and edge interrupts. Firstly, is it okay to call the
>> handler_irq() directly?
>>
>> My other question is check_irq_resend() indicates that it should be
>> called with desc->lock held. Since we are invoking the handler directly
>> and not modifying any core state of the irq_desc, is it safe here? (Also
>> the locking API are not exposed, I am sure there must be a reason for it).
>>
>> Thoughts?
>>
> Would it help if I submit a RFC patch based on this idea?

Yes please. At this stage, I've completely lost track of the various 
ideas, and I'd like to restart with a clean slate.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
