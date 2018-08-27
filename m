Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D9C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B02C208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sbk8Cjzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B02C208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeH1CXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:23:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41223 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1CXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:23:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so237035pfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 15:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzVeIPpsLkbxjtBj6QAbwHTi3/dUO1i8WdVkudFXSFo=;
        b=Sbk8CjzovgZ1fdoYBEjCCI00LCruSOZ9jElym28kIO5bqAAZz8DOGRgyxW2ajqVA43
         T2+FWQH7Kky0QuWdRwn2T19mNvNn3Bq66vrtbQJV+5Vun9WqLVilytgsU7H5s3Xh5xMl
         nktJ4kXgwjBqECXJrmncmjjLgqxaS2txwHQoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzVeIPpsLkbxjtBj6QAbwHTi3/dUO1i8WdVkudFXSFo=;
        b=RfT/f0wmRRc+OTG7+X+LlAoBI3gWPZup4ZRenONUu70VwY6Vil/pCzgDIexo7FQhCO
         oUCpCYIRSTKyITOFAgWEK5nhHZQPpx3Y2Ch2glhT0NpVWDt4Pria4S3KjVc1ZlaWwNCF
         p87K1WLlkiOW4WBKABQPn/MnKOpzHjXywYso86HuFn7A6EbIKRhhM9SQNviuUPIM1KXP
         6Ut0h4RqG5rqC8116eitB++GaTD6jorlwXmKEcAytf0rZNrlleQtsF8BNPk+iQGj6Rbk
         0KSFHGf3NFw82tYdMbZbAWGnRTUdw/gCnAAfSIWZNkKdFtbYFQTTpqHJYnq/y7nn8f1+
         wAgA==
X-Gm-Message-State: APzg51DkHms7C9PmsrPYLFMaBIJ/tw8BwW4WadF08Y88iXUlIJ+TpTfV
        D/Us+JH7N/5yLFsQcBPJoi30Kg==
X-Google-Smtp-Source: ANB0VdZsQGIa54ZkpyY6/OjOPkKXWOBTswXXtYqQoa2uqTm3YfvychO4fl9paDkvy8J+1qVV8yL2Lw==
X-Received: by 2002:a63:2503:: with SMTP id l3-v6mr13630529pgl.237.1535409303561;
        Mon, 27 Aug 2018 15:35:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 1-v6sm460745pfk.134.2018.08.27.15.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 15:35:02 -0700 (PDT)
Date:   Mon, 27 Aug 2018 15:35:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: Re: [PATCH v2 1/5] drivers: pinctrl: qcom: add wakeup capability to
 GPIO
Message-ID: <20180827223502.GV160295@google.com>
References: <20180824200157.9993-1-ilina@codeaurora.org>
 <20180824200157.9993-2-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824200157.9993-2-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On Fri, Aug 24, 2018 at 02:01:53PM -0600, Lina Iyer wrote:
> QCOM SoC's that have Power Domain Controller (PDC) chip in the always-on
> domain can wakeup the SoC, when interrupts and GPIOs are routed to the
> its interrupt controller. Only select GPIOs that are deemed wakeup

wording nit: "are routed to the|its interrupt controller"

> capable are routed to specific PDC pins. During low power state, the
> pinmux interrupt controller may be non-functional but the PDC would be.
> The PDC can detect the wakeup GPIO is triggered and bring the TLMM to an
> operational state.
> 
> Interrupts that are level triggered will be detected at the TLMM when
> the controller becomes operational. Edge interrupts however need to be
> replayed again.
> 
> Request the corresponding PDC IRQ, when the GPIO is requested as an IRQ,
> but keep it disabled. During suspend, we can enable the PDC IRQ instead
> of the GPIO IRQ, which may or not be detected.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v2:
> 	- Remove IRQF_NO_SUSPEND and IRQF_ONE_SHOT from PDC IRQ
> Changes in v1:
> 	- Trigger GPIO in h/w from PDC IRQ handler
> 	- Avoid big tables for GPIO-PDC map, pick from DT instead
> 	- Use handler_data
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 96 ++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 0e22f52b2a19..b675ea56a4ff 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -687,11 +687,15 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  	const struct msm_pingroup *g;
>  	unsigned long flags;
>  	u32 val;
> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>  
>  	g = &pctrl->soc->groups[d->hwirq];
>  
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
> +	if (pdc_irqd)
> +		irq_set_irq_type(pdc_irqd->irq, type);
> +
>  	/*
>  	 * For hw without possibility of detecting both edges
>  	 */
> @@ -779,9 +783,13 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
>  	unsigned long flags;
> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
>  
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
> +	if (pdc_irqd)
> +		irq_set_irq_wake(pdc_irqd->irq, on);
> +
>  	irq_set_irq_wake(pctrl->irq, on);
>  
>  	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> @@ -863,6 +871,92 @@ static bool msm_gpio_needs_valid_mask(struct msm_pinctrl *pctrl)
>  	return device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0) > 0;
>  }
>  
> +static irqreturn_t wake_irq_gpio_handler(int irq, void *data)
> +{
> +	struct irq_data *irqd = data;
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> +	const struct msm_pingroup *g;
> +	unsigned long flags;
> +	u32 val;
> +
> +	if (!irqd_is_level_type(irqd)) {
> +		g = &pctrl->soc->groups[irqd->hwirq];
> +		raw_spin_lock_irqsave(&pctrl->lock, flags);
> +		val = BIT(g->intr_status_bit);
> +		writel(val, pctrl->regs + g->intr_status_reg);
> +		raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int msm_gpio_pdc_pin_request(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> +	struct platform_device *pdev = to_platform_device(pctrl->dev);
> +	const char *pin_name;
> +	int irq;
> +	int ret;
> +
> +	pin_name = kasprintf(GFP_KERNEL, "gpio%lu", d->hwirq);
> +	if (!pin_name)
> +		return -ENOMEM;
> +
> +	irq = platform_get_irq_byname(pdev, pin_name);
> +	if (irq < 0) {
> +		kfree(pin_name);
> +		return 0;

Do I understand correctly that this is the case where the pin isn't
routed to the PDC?

> +	}
> +
> +	ret = request_irq(irq, wake_irq_gpio_handler, irqd_get_trigger_type(d),
> +			  pin_name, d);
> +	if (ret) {
> +		pr_warn("GPIO-%lu could not be set up as wakeup", d->hwirq);

'\n' is missing

> +		kfree(pin_name);
> +		return ret;
> +	}
> +
> +	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
> +	disable_irq(irq);
> +
> +	return 0;
> +}
> +
> +static int msm_gpio_pdc_pin_release(struct irq_data *d)
> +{
> +	struct irq_data *pdc_irqd = irq_get_handler_data(d->irq);
> +
> +	if (pdc_irqd) {
> +		irq_set_handler_data(d->irq, NULL);
> +		free_irq(pdc_irqd->irq, d);

You need to free 'pin_name' allocated in msm_gpio_pdc_pin_request().
IIUC it should be available in irq_desc->action->name.

Cheers

Matthias

