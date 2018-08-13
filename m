Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D32EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260CF2172A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ngu9sJlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260CF2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbeHNCiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:38:17 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34651 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbeHNCiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:38:16 -0400
Received: by mail-ua1-f66.google.com with SMTP id r15-v6so11222797uao.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ovG1bxIWfRXuFy1KArdL0QftkGQfpvQIvh0iR7LJufI=;
        b=Ngu9sJlVh8ZvHB0YXP7Sv751NbjELYfVcWXH326tb7UbzUoJ28uJJkraTe1YuvjTBn
         xSJRQm1yTSLR0FNSSlAbpnwfBMoskov9B+lyNqnFmEyVUyyV6XaDqYNc9mNiuF8qZ2ug
         g27o5v7KmWOE5XUOc0dvsH6bud2XjE1zKfhTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ovG1bxIWfRXuFy1KArdL0QftkGQfpvQIvh0iR7LJufI=;
        b=mP9kwN0OayciTCdMvzDC4A/JTm1Lf2PBq9RtSY5I2OFMVXpQmaikO57T9I50hUBVmg
         MrexdJ3rGvFpegG+46Od6A5qBEsj7Mk00z/eZ/eaxzNCpUjBztcZUePoJ2gJkmz9Wznl
         06Ic5P7gzAv1hsdwn8xsNb+TJBCMd+RV/ZfORrOLFcK01jeSQJeu6jj9fFHyakjBr2/h
         1zl3etISpRkoDkHZF7A8PeurROVpdGR+noyEboo9gzl5je0rHQkCsRpmnCQtvcLrkQr9
         2ZURv94FCXkk9U4VnvET8BTj1LehQ1X1CQzMIWAsuHY3Har+i4GGVu/7Tg7IdWN3bVy6
         17uQ==
X-Gm-Message-State: AOUpUlGWBp9SY9Yug0qi5T+XdwXcmLniDQ6IQ2qnjDXELEqfn36+bDZe
        ua7nXIDzc6osdBJsps7nFbxFyGkITwE=
X-Google-Smtp-Source: AA+uWPwwXiZQ3xMjpgCIcnOItVDSRfkHrGDpkYr0WVnf51v/Ci65oqJkK5Yn33a+D3yfpUEug6oz6g==
X-Received: by 2002:ab0:1af:: with SMTP id 44-v6mr12816641ual.173.1534204424383;
        Mon, 13 Aug 2018 16:53:44 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id r6-v6sm2760875uao.3.2018.08.13.16.53.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 16:53:43 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id i4-v6so11221465uak.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 16:53:43 -0700 (PDT)
X-Received: by 2002:a1f:c541:: with SMTP id v62-v6mr12013222vkf.99.1534204422682;
 Mon, 13 Aug 2018 16:53:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 16:53:42 -0700 (PDT)
In-Reply-To: <20180725222900.33231-2-swboyd@chromium.org>
References: <20180725222900.33231-1-swboyd@chromium.org> <20180725222900.33231-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 Aug 2018 16:53:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8ujNN-jxOm6a_OthyQFGucbv0-1Du3BjScVPKPz-Tsw@mail.gmail.com>
Message-ID: <CAD=FV=V8ujNN-jxOm6a_OthyQFGucbv0-1Du3BjScVPKPz-Tsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pinctrl: msm: Really mask level interrupts to
 prevent latching
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 25, 2018 at 3:28 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> The interrupt controller hardware in this pin controller has two status
> enable bits. The first "normal" status enable bit enables or disables
> the summary interrupt line being raised when a gpio interrupt triggers
> and the "raw" status enable bit allows or prevents the hardware from
> latching an interrupt into the status register for a gpio interrupt.
> Currently we just toggle the "normal" status enable bit in the mask and
> unmask ops so that the summary irq interrupt going to the CPU's
> interrupt controller doesn't trigger for the masked gpio interrupt.
>
> For a level triggered interrupt, the flow would be as follows: the pin
> controller sees the interrupt, latches the status into the status
> register, raises the summary irq to the CPU, summary irq handler runs
> and calls handle_level_irq(), handle_level_irq() masks and acks the gpio
> interrupt, the interrupt handler runs, and finally unmask the interrupt.
> When the interrupt handler completes, we expect that the interrupt line
> level will go back to the deasserted state so the genirq code can unmask
> the interrupt without it triggering again.
>
> If we only mask the interrupt by clearing the "normal" status enable bit
> then we'll ack the interrupt but it will continue to show up as pending
> in the status register because the raw status bit is enabled, the
> hardware hasn't deasserted the line, and thus the asserted state latches
> into the status register again. When the hardware deasserts the
> interrupt the pin controller still thinks there is a pending unserviced
> level interrupt because it latched it earlier. This behavior causes
> software to see an extra interrupt for level type interrupts each time
> the interrupt is handled.
>
> Let's fix this by clearing the raw status enable bit for level type
> interrupts so that the hardware stops latching the status of the
> interrupt after we ack it. We don't do this for edge type interrupts
> because it seems that toggling the raw status enable bit for edge type
> interrupts causes spurious edge interrupts.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  - Squashed raw_status_bit write into same write on unmask (Doug
>    Andersson)
>
>  drivers/pinctrl/qcom/pinctrl-msm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 2155a30c282b..3970dc599092 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -634,6 +634,19 @@ static void msm_gpio_irq_mask(struct irq_data *d)
>         raw_spin_lock_irqsave(&pctrl->lock, flags);
>
>         val = readl(pctrl->regs + g->intr_cfg_reg);
> +       /*
> +        * Leaving the RAW_STATUS_EN bit enabled causes level interrupts that
> +        * are still asserted to re-latch after we ack them. Clear the raw
> +        * status enable bit too so the interrupt can't even latch into the
> +        * hardware while it's masked, but only do this for level interrupts
> +        * because edge interrupts have a problem with the raw status bit
> +        * toggling and causing spurious interrupts.

This whole "spurious interrupts" explanation still seems dodgy.  Have
you experienced it yourself, or is this looking through some previous
commits?  As per my comments in v1, I'd still rather the comment state
the reason as: it's important to _not_ lose edge interrupts when
masked.


> +        */
> +       if (irqd_get_trigger_type(d) & IRQ_TYPE_LEVEL_MASK) {
> +               val &= ~BIT(g->intr_raw_status_bit);
> +               writel(val, pctrl->regs + g->intr_cfg_reg);
> +       }

In v1 you claimed you were going to combine this with the next write
(you said you'd combine things in both mask and unmask).  ...is there
a reason why you didn't?  As per my comments in v1 I believe it's
safer from a correctness point of view to combine them.


-Doug
