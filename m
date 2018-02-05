Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBEXlb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:41:31 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:39868 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeBEXlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:41:23 -0500
X-Google-Smtp-Source: AH8x227qA7000ICGvyjUJC/uGLNjpcZUcPlup702X9cjvIHALfmra3qSmcBBisdcJ39af+DrwxF74A==
Date: Mon, 5 Feb 2018 15:41:20 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Srinivas Ramana <sramana@codeaurora.org>
Cc: linus.walleij@linaro.org, timur@codeaurora.org, sboyd@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: Add irq_enable callback for msm gpio
Message-ID: <20180205234120.GG9465@builder>
References: <1516626208-5655-1-git-send-email-sramana@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516626208-5655-1-git-send-email-sramana@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 22 Jan 05:03 PST 2018, Srinivas Ramana wrote:
> +static void msm_gpio_irq_enable(struct irq_data *d)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> +	const struct msm_pingroup *g;
> +	unsigned long flags;
> +	u32 val;
> +
> +	g = &pctrl->soc->groups[d->hwirq];
> +
> +	raw_spin_lock_irqsave(&pctrl->lock, flags);
> +
> +	/*
> +	 * clear the interrupt status bit before unmask to avoid
> +	 * any erroneous interrupts that would have got latched
> +	 * when the intterupt is not in use.
> +	 */
> +	val = readl(pctrl->regs + g->intr_status_reg);
> +	val &= ~BIT(g->intr_status_bit);
> +	writel(val, pctrl->regs + g->intr_status_reg);
> +
> +	val = readl(pctrl->regs + g->intr_cfg_reg);
> +	val |= BIT(g->intr_enable_bit);
> +	writel(val, pctrl->regs + g->intr_cfg_reg);
> +
> +	set_bit(d->hwirq, pctrl->enabled_irqs);
> +
> +	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> +}


Hi Srinivas,

This makes sense, but I would prefer if you extract this code into a
common:

static void __msm_gpio_irq_unmask(struct msm_pinctrl *pctrl, bool status_clear)

which you call from the two callbacks.

Regards,
Bjorn
