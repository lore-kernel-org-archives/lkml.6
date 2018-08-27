Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BDEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C27C208DA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpiQFLbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C27C208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbeH1CqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:46:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45763 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeH1CqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:46:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so247956pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 15:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=49l4K6cOEHOmyVrOorNQZt9lRjnkPomC3BgJI0sJPQc=;
        b=EpiQFLbBXmB1oxYnnrXlY2tFDeritQ2pBRAofcwgzvNs53z1syroM0kBBLkvsaa03Y
         r5Ee8//7eH5/k+3kBI0hlbp0hFClcQaUHcDb2NXp6deNZN9rNLhiU7KznNjXUBaOmDx9
         0yEzqvVknLU2bJ4bzcHd30RKScHumZP3l4QDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=49l4K6cOEHOmyVrOorNQZt9lRjnkPomC3BgJI0sJPQc=;
        b=IV74WdGtCPHf+njLSZUAQGs0vV0X4bZw8VOGlEl5gmpSUWul9jCMMnNE1RMnJtgQCo
         0LvyW/XBEFazMMuRW/xL12dnGOvuvs7xfdmIUC3cuWzPjK5oHMf67HsBQGJWd0rUK4Ou
         02k1cR/FLFuipRFykCHLJC8tAUILGVcgjUjDOuiAFt94gObYpApCi9kEdhzo/bT4lnG2
         eezOdQfwLOQluJZiCqdLXezuNT4r4+8er/NlNy2LNOSz0yWMvRpX2/xszWSEAvr2+GIs
         nxzoDTEmXGMwpTLtDn1onY2KvzSA3C7anF/OFXTvhojvAvn9l8G9WMTTAFAkmgvt7wHX
         Ng2A==
X-Gm-Message-State: APzg51DDxn8Aspb5OaLVhU8+ibOTw9kaVDvGH9E+Iv5cjtXLUXK+bqhM
        Xicz5CI00tpnm/GJ0bi+aGeRNQ==
X-Google-Smtp-Source: ANB0VdaGGcisZXUMjHy2dk8aAzVkgf/+jUMfiLMBQjT4Qr5XRzWM1wFcP05rmOvKPrEzic8EnsCtwA==
X-Received: by 2002:a63:1e63:: with SMTP id p35-v6mr14235954pgm.376.1535410645079;
        Mon, 27 Aug 2018 15:57:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id o62-v6sm375324pfb.0.2018.08.27.15.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 15:57:24 -0700 (PDT)
Date:   Mon, 27 Aug 2018 15:57:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, bjorn.andersson@linaro.org, sboyd@kernel.org,
        evgreen@chromium.org, linus.walleij@linaro.org,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org,
        dianders@chromium.org
Subject: Re: [PATCH v2 3/5] drivers: pinctrl: msm: enable PDC interrupt only
 during suspend
Message-ID: <20180827225723.GW160295@google.com>
References: <20180824200157.9993-1-ilina@codeaurora.org>
 <20180824200157.9993-4-ilina@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824200157.9993-4-ilina@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lina,

On Fri, Aug 24, 2018 at 02:01:55PM -0600, Lina Iyer wrote:
> During suspend the system may power down some of the system rails. As a
> result, the TLMM hw block may not be operational anymore and wakeup
> capable GPIOs will not be detected. The PDC however will be operational
> and the GPIOs that are routed to the PDC as IRQs can wake the system up.
> 
> To avoid being interrupted twice (for TLMM and once for PDC IRQ) when a
> GPIO trips, use TLMM for active and switch to PDC for suspend. When
> entering suspend, disable the TLMM wakeup interrupt and instead enable
> the PDC IRQ and revert upon resume.
> 
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
> Changes in v2:
> 	- Fix PDC IRQ max port, 126 is the max supported in h/w
> 	- Use PDC hwirq in bitmap, linux numbers could be large
> 	- Setup DISABLE_UNLAZY for both TLMM and PDC IRQs
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 70 +++++++++++++++++++++++++++++-
>  drivers/pinctrl/qcom/pinctrl-msm.h |  3 ++
>  2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index b675ea56a4ff..a880cefbd248 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -37,6 +37,7 @@
>  #include "../pinctrl-utils.h"
>  
>  #define MAX_NR_GPIO 300
> +#define MAX_PDC_HWIRQ 126
>  #define PS_HOLD_OFFSET 0x820
>  
>  /**
> @@ -51,6 +52,7 @@
>   * @enabled_irqs:   Bitmap of currently enabled irqs.
>   * @dual_edge_irqs: Bitmap of irqs that need sw emulated dual edge
>   *                  detection.
> + * @pdc_hwirqs:     Bitmap of wakeup capable irqs.
>   * @soc;            Reference to soc_data of platform specific data.
>   * @regs:           Base address for the TLMM register map.
>   */
> @@ -68,11 +70,15 @@ struct msm_pinctrl {
>  
>  	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
>  	DECLARE_BITMAP(enabled_irqs, MAX_NR_GPIO);
> +	DECLARE_BITMAP(pdc_hwirqs, MAX_PDC_HWIRQ);
>  
>  	const struct msm_pinctrl_soc_data *soc;
>  	void __iomem *regs;
> +	struct irq_domain *pdc_irq_domain;
>  };
>  
> +static bool in_suspend;
> +
>  static int msm_get_groups_count(struct pinctrl_dev *pctldev)
>  {
>  	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
> @@ -787,8 +793,13 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
>  
>  	raw_spin_lock_irqsave(&pctrl->lock, flags);
>  
> -	if (pdc_irqd)
> +	if (pdc_irqd && !in_suspend) {
>  		irq_set_irq_wake(pdc_irqd->irq, on);
> +		if (on)
> +			set_bit(pdc_irqd->hwirq, pctrl->pdc_hwirqs);
> +		else
> +			clear_bit(pdc_irqd->hwirq, pctrl->pdc_hwirqs);
> +	}
>  
>  	irq_set_irq_wake(pctrl->irq, on);
>  
> @@ -919,7 +930,12 @@ static int msm_gpio_pdc_pin_request(struct irq_data *d)
>  	}
>  
>  	irq_set_handler_data(d->irq, irq_get_irq_data(irq));
> +	irq_set_handler_data(irq, d);
> +	irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
> +	irq_set_status_flags(d->irq, IRQ_DISABLE_UNLAZY);
>  	disable_irq(irq);
> +	if (!pctrl->pdc_irq_domain)
> +		pctrl->pdc_irq_domain = irq_get_irq_data(irq)->domain;
>  
>  	return 0;
>  }
> @@ -1069,6 +1085,58 @@ static void msm_pinctrl_setup_pm_reset(struct msm_pinctrl *pctrl)
>  		}
>  }
>  
> +int __maybe_unused msm_pinctrl_suspend_late(struct device *dev)
> +{
> +	struct msm_pinctrl *pctrl = dev_get_drvdata(dev);
> +	struct irq_data *irqd;
> +	unsigned int irq;
> +	int i;
> +
> +	in_suspend = true;
> +	for_each_set_bit(i, pctrl->pdc_hwirqs, MAX_PDC_HWIRQ) {
> +		irq = irq_find_mapping(pctrl->pdc_irq_domain, i);
> +		irqd = irq_get_handler_data(irq);
> +		/*
> +		 * We don't know if the TLMM will be functional
> +		 * or not, during the suspend. If its functional,
> +		 * we do not want duplicate interrupts from PDC.
> +		 * Hence disable the GPIO IRQ and enable PDC IRQ.
> +		 */
> +		if (irqd_is_wakeup_set(irqd)) {
> +			disable_irq_wake(irqd->irq);
> +			disable_irq(irqd->irq);
> +			enable_irq(irq);
> +		}

Would it make sense to limit this to edge triggered interrupts since
the interrupt handler does nothing for level triggered ones?

Cheers

Matthias
