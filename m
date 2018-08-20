Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FD4C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 793B72170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kM8cNkAv";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pGGM8/uS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 793B72170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeHTSmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:42:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38220 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeHTSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:42:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DB84E6147C; Mon, 20 Aug 2018 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534778791;
        bh=SLrqRcoL7Z8TSc4JyrhAUo/v/MPDYBIyxhmozphz8wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kM8cNkAvvgra4ccykUDG86ULfqYtkcpzN/Ueh5mp/mEW59CtINvnPBOVPsmciBaHe
         eZnuUzxXjfdf7iLKFSSKi/hvFCPxoZrI7CoiaOtJb+rB8uK9DSL6G+VBRwmLu/X3dH
         Vh0A/WwJguK65AMsR8RzJp8FEhZ7nkbWRPmoiVyw=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63F6161312;
        Mon, 20 Aug 2018 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534778790;
        bh=SLrqRcoL7Z8TSc4JyrhAUo/v/MPDYBIyxhmozphz8wk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pGGM8/uStfItxkBz0oNkONrpWujXjM4JmMBp4Toke25Sh24EQoIeBg07eWEkOXIXg
         rGgG9UAUluK1mOFYVdEcFvTmmrNpzOAQkwyiv5MiMep7XUa1hqNIb+rtwt7TtEwkXr
         UopXurH/Z0NTvjsXYl21mOMxcPPpeotlkf2v4V6w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63F6161312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Mon, 20 Aug 2018 09:26:29 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
Subject: Re: [PATCH RESEND v1 2/5] drivers: pinctrl: msm: enable PDC
 interrupt only during suspend
Message-ID: <20180820152629.GR5081@codeaurora.org>
References: <20180817191026.32245-1-ilina@codeaurora.org>
 <20180817191026.32245-3-ilina@codeaurora.org>
 <86a7pjq0l1.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86a7pjq0l1.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18 2018 at 07:13 -0600, Marc Zyngier wrote:
>Hi Lina,
>
>On Fri, 17 Aug 2018 20:10:23 +0100,
>Lina Iyer <ilina@codeaurora.org> wrote:
>>
>> During suspend the system may power down some of the system rails. As a
>> result, the TLMM hw block may not be operational anymore and wakeup
>> capable GPIOs will not be detected. The PDC however will be operational
>> and the GPIOs that are routed to the PDC as IRQs can wake the system up.
>>
>> To avoid being interrupted twice (for TLMM and once for PDC IRQ) when a
>> GPIO trips, use TLMM for active and switch to PDC for suspend. When
>> entering suspend, disable the TLMM wakeup interrupt and instead enable
>> the PDC IRQ and revert upon resume.
>>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> ---
>>  drivers/pinctrl/qcom/pinctrl-msm.c | 60 +++++++++++++++++++++++++++++-
>>  drivers/pinctrl/qcom/pinctrl-msm.h |  3 ++
>>  2 files changed, 62 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
>> index 03ef1d29d078..17e541f8f09d 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
>> @@ -37,6 +37,7 @@
>>  #include "../pinctrl-utils.h"
>>
>>  #define MAX_NR_GPIO 300
>> +#define MAX_PDC_IRQ 1024
>
>Where is this value coming from? Is it guaranteed to be an
>architectural maximum? Or something that is likely to vary in future
>implementations?
>
>>  #define PS_HOLD_OFFSET 0x820
>>
>>  /**
>> @@ -51,6 +52,7 @@
>>   * @enabled_irqs:   Bitmap of currently enabled irqs.
>>   * @dual_edge_irqs: Bitmap of irqs that need sw emulated dual edge
>>   *                  detection.
>> + * @pdc_irqs:       Bitmap of wakeup capable irqs.
>>   * @soc;            Reference to soc_data of platform specific data.
>>   * @regs:           Base address for the TLMM register map.
>>   */
>> @@ -68,11 +70,14 @@ struct msm_pinctrl {
>>
>>  	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
>>  	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
>> +	DECLARE_BITMAP(pdc_irqs, MAX_PDC_IRQ);
>>
>>  	const struct msm_pinctrl_soc_data *soc;
>>  	void __iomem *regs;
>>  };
>>
>> +static bool in_suspend;
>> +
>>  static int msm_get_groups_count(struct pinctrl_dev *pctldev)
>>  {
>>  	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
>> @@ -787,8 +792,11 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>>
>>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>>
>> -	if (pdc_irqd)
>> +	if (pdc_irqd && !in_suspend) {
>>  		irq_set_irq_wake(pdc_irqd->irq, on);
>> +		on ? set_bit(pdc_irqd->irq, pctrl->pdc_irqs) :
>> +		     clear_bit(pdc_irqd->irq, pctrl->pdc_irqs);
>
>I think we'll all survive the two extra lines if you write this as an
>'if' statement (unless you're competing for the next IOCCC, and then
>you need to up your game a bit).
>
>Also, are you indexing the bitmap using a Linux irq number? If so,
>that's an absolute NACK. Out of the box, a Linux IRQ can be up to
>NR_IRQS+8196 on arm64, and there are plans to push that to be a much
>larger space.
>
I didn't realize this. I have been using linux IRQ number on this
bitmask and I will need to fix this.

>> +	}
>>
>>  	irq_set_irq_wake(pctrl->irq, on);
>
>I'm a bit worried by the way you call into the irq subsystem with this
>spinlock held. Have you run that code with lockdep enabled?
>
I have not tried lockdep. Will try it.
This specific line is already part of the driver. I added a similar line
irq_set_irq_wake(pdc_irqd->irq) just above following the same pattern.

>>
>> @@ -920,6 +928,8 @@ static int msm_gpio_pdc_pin_request(struct irq_data *d)
>>  	}
>>
>>  	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
>> +	irq_set_handler_data(irq, d);
>> +	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
>
>Could you explain what this is trying to do? I'm trying to understand
>this code, but this function isn't in 4.18...
>
Oh, I have been able to test only on 4.14 so far. The flag does seem to
exist at least, I didn't get a compiler error.

I read this in kernel/irq/chip.c -

If the interrupt chip does not implement the irq_disable callback,
a driver can disable the lazy approach for a particular irq line by
calling 'irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY)'. This can
be used for devices which cannot disable the interrupt at the
device level under certain circumstances and have to use
disable_irq[_nosync] instead.

And interpreted this as something that this would prevent 'relaxed'
disable. I am enabling and disabling the IRQ in suspend path, that I
thought this would help avoid issues caused by late disable. Am I
mistaken?

>>  	disable_irq(irq);
>>
>>  	return 0;
>> @@ -1070,6 +1080,54 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
>>  		}
>>  }
>>
>> +int __maybe_unused msm_pinctrl_suspend_late(struct device *dev)
>> +{
>> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
>> +	struct irq_data *irqd;
>> +	int i;
>> +
>> +	in_suspend = true;
>> +	for_each_set_bit(i, pctrl->pdc_irqs, MAX_PDC_IRQ) {
>> +		irqd = irq_get_handler_data(i);
>
>So this is what I though. You're using the Linux IRQ, and not the pin
>number (or whatever HW-dependent index that would otherwise make
>sense). Please fix it.
>
Noted.

>> +		/*
>> +		 * We don't know if the TLMM will be functional
>> +		 * or not, during the suspend. If its functional,
>> +		 * we do not want duplicate interrupts from PDC.
>> +		 * Hence disable the GPIO IRQ and enable PDC IRQ.
>> +		 */
>> +		if (irqd_is_wakeup_set(irqd)) {
>> +			irq_set_irq_wake(irqd->irq, false);
>> +			disable_irq(irqd->irq);
>> +			enable_irq(i);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int __maybe_unused msm_pinctrl_resume_late(struct device *dev)
>> +{
>> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
>> +	struct irq_data *irqd;
>> +	int i;
>> +
>> +	for_each_set_bit(i, pctrl->pdc_irqs, MAX_PDC_IRQ) {
>> +		irqd = irq_get_handler_data(i);
>> +		/*
>> +		 * The TLMM will be operational now, so disable
>> +		 * the PDC IRQ.
>> +		 */
>> +		if (irqd_is_wakeup_set(irq_get_irq_data(i))) {
>> +			disable_irq_nosync(i);
>> +			irq_set_irq_wake(irqd->irq, true);
>> +			enable_irq(irqd->irq);
>> +		}
>> +	}
>> +	in_suspend = false;
>> +
>> +	return 0;
>> +}
>> +
>>  int msm_pinctrl_probe(struct platform_device *pdev,
>>  		      const struct msm_pinctrl_soc_data *soc_data)
>>  {
>> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
>> index 9b9feea540ff..21b56fb5dae9 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
>> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
>> @@ -123,4 +123,7 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>>  		      const struct msm_pinctrl_soc_data *soc_data);
>>  int msm_pinctrl_remove(struct platform_device *pdev);
>>
>> +int msm_pinctrl_suspend_late(struct device *dev);
>> +int msm_pinctrl_resume_late(struct device *dev);
>> +
>>  #endif
>
>I can't really review this code any further, as it seems that I'm
>missing some crucial dependencies. But there is a number of things
>that feel quite wrong in this code, and that need to be addressed
>anyway.
>
Thanks for reviewing Marc.

-- Lina

