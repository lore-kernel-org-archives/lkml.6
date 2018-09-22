Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAC8C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 17:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9CE208A3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 17:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hBAP+jTp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GBldcit/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9CE208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeIVXD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 19:03:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbeIVXD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 19:03:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ED69560DDB; Sat, 22 Sep 2018 17:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537636151;
        bh=UEqw+e5ho7ZYCgWaGuTx8tudPCzWekYAeqdeB+DBuLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hBAP+jTpYau8bz4FTAIvS3M4ungNkcI6T/R4zgRusOrpC0mNasvibVlJBse4FcTWq
         l9qqOwyznE1GpCi/De2POGemPGZNyTP6Fe/NJL7Hy6wfckEikg8zXi8zndKVbTd860
         BULxmU1NSi9xrKHBBTVojqw95dxE4hqMd9ItUD+I=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AA2F60D9A;
        Sat, 22 Sep 2018 17:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537636150;
        bh=UEqw+e5ho7ZYCgWaGuTx8tudPCzWekYAeqdeB+DBuLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBldcit/o6ZdCDTF/ZCehDnU/LeSY9Hdlxj5xEdHC9QzJ0sxL+yian1/J5vAmEC2+
         TN+TZyKjzTA3vYWklaou52zgy/mCdMsuWuY8b40OtdzRg5oRhv9rlK6jzBTYAaLS3K
         wcRVuQPF55Dgy7j0D+R4E06QmRZP/FlKvtmPH8Jk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AA2F60D9A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Sat, 22 Sep 2018 11:09:09 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, evgreen@chromium.org,
        linus.walleij@linaro.org, rplsssn@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, devicetree@vger.kernel.org,
        andy.gross@linaro.org, dianders@chromium.org
Subject: Re: [PATCH v3 3/5] drivers: pinctrl: msm: enable PDC interrupt only
 during suspend
Message-ID: <20180922170909.GI17420@codeaurora.org>
References: <20180904211810.5506-1-ilina@codeaurora.org>
 <20180904211810.5506-4-ilina@codeaurora.org>
 <868t3twl64.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <868t3twl64.wl-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22 2018 at 10:29 -0600, Marc Zyngier wrote:
>Hi Lina,
>
>On Tue, 04 Sep 2018 22:18:08 +0100,
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
>> Changes in v3:
>> 	- Enable PDC-IRQ swap only for edge interrupts
>> Changes in v2:
>> 	- Fix PDC IRQ max port, 126 is the max supported in h/w
>> 	- Use PDC hwirq in bitmap, linux numbers could be large
>> 	- Setup DISABLE_UNLAZY for both TLMM and PDC IRQs
>> ---
[...]

>> +int __maybe_unused msm_pinctrl_suspend_late(struct device *dev)
>> +{
>> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
>> +	struct irq_data *irqd;
>> +	unsigned int irq;
>> +	int i;
>> +
>> +	in_suspend = true;
>> +	for_each_set_bit(i, pctrl->pdc_hwirqs, MAX_PDC_HWIRQ) {
>> +		irq = irq_find_mapping(pctrl->pdc_irq_domain, i);
>> +		irqd = irq_get_handler_data(irq);
>> +		/*
>> +		 * We don't know if the TLMM will be functional
>> +		 * or not, during the suspend. If its functional,
>> +		 * we do not want duplicate interrupts from PDC.
>> +		 * Hence disable the GPIO IRQ and enable PDC IRQ
>> +		 * for edge interrupt only.
>> +		 */
>> +		if (irqd_is_wakeup_set(irqd) && !irqd_is_level_type(irqd)) {
>> +			disable_irq_wake(irqd->irq);
>
>There is something I don't quite get here. If the PDC is used to wake
>up the platform, why is the TLMM interrupt configured as a wakeup
>source the first place? Or is it just to keep things simple and not
>have to track it in the TLMM driver itself?
>
True, it need not be. I could just avoid setting the wakeup on the TLMM
and just use the PDC interrupt as wakeup.

Also, I am exploring an option that was suggested by Stephen [1] to just
use the PDC interrupt as a parent of the GPIO IRQ and use a different
irqchip for the PDC interrupt. I ran into some issue with accessing
irqchip and irqdata of the PDC interrupt, since the irqchip was not in
hierarchy with the GPIO's irqchip. I haven't been able to find time to
resolve the issue that the set_parent_ functions, because of the
hierarchy.

Essentially, we have two different mechanisms for GPIO IRQs based on
whether they can be woken up by the PDC interrupt.

	GPIO-IRQ --> PDC --> GIC

	GPIO-IRQ --> TLMM SUMMARY --> GIC

Do you think the idea is feasible? It would avoid doing all this
enable/disable at every suspend and even during idle, when the TLMM
could be powered off.


>> +			disable_irq(irqd->irq);
>> +			enable_irq(irq);
>> +		}
>> +	}
>
>Given that you're changing in_suspend and parsing the bitmap,
>shouldn't take the pdc spinlock?
>
Since we are the the only CPU running and suspend/resume (and even idle)
would be serialized I didn't see a reason for needing a lock.

>> +
>> +	return 0;
>> +}
>> +
>> +int __maybe_unused msm_pinctrl_resume_late(struct device *dev)
>> +{
>> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
>> +	struct irq_data *irqd, *pdc_irqd;
>> +	unsigned int irq;
>> +	int i;
>> +
>> +	for_each_set_bit(i, pctrl->pdc_hwirqs, MAX_PDC_HWIRQ) {
>> +		irq = irq_find_mapping(pctrl->pdc_irq_domain, i);
>> +		irqd = irq_get_handler_data(irq);
>> +		pdc_irqd = irq_get_irq_data(irq);
>> +		/*
>> +		 * The TLMM will be operational now, so disable
>> +		 * the PDC IRQ for edge interrupts only.
>> +		 */
>> +		if (irqd_is_wakeup_set(pdc_irqd) &&
>> +		    !irqd_is_level_type(pdc_irqd)) {
>> +			disable_irq_nosync(irq);
>> +			enable_irq_wake(irqd->irq);
>> +			enable_irq(irqd->irq);
>> +		}
>> +	}
>> +	in_suspend = false;
>
>Same remark about the lock.
>

Thanks,
Lina

[1]. https://lore.kernel.org/patchwork/patch/975423/

