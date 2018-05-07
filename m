Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeEGWPR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 18:15:17 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40241 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752726AbeEGWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 18:15:15 -0400
X-Google-Smtp-Source: AB8JxZp35avp5OzHtjV4o6iRh3y0OTAzJNuQh1fJLVnP+5VhvEbNQFi5AdBQsv5g1wYFwaN3oF//Vg==
Date: Mon, 7 May 2018 15:15:12 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when
 changing it's capability
Message-ID: <20180507221511.GA6448@rodete-desktop-imager.corp.google.com>
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503065553.7762-1-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Doug

Hi Jeffy,

On Thu, May 03, 2018 at 02:55:53PM +0800, Jeffy Chen wrote:
> We saw spurious irq when changing irq's trigger type, for example
> setting gpio-keys's wakeup irq trigger type.
> 
> And according to the TRM:
> "Programming the GPIO registers for interrupt capability, edge-sensitive
> or level-sensitive interrupts, and interrupt polarity should be
> completed prior to enabling the interrupts on Port A in order to prevent
> spurious glitches on the interrupt lines to the interrupt controller."
> 
> Reported-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  drivers/pinctrl/pinctrl-rockchip.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index 3924779f55785..7ff45ec8330d1 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -2727,9 +2727,19 @@ static int rockchip_irq_set_type(struct irq_data *d, unsigned int type)
>  		return -EINVAL;
>  	}
>  
> +	/**

The typical multiline comment style is to use only 1 asterisk -- 2
asterisks usually denote something more formal, like kerneldoc.

> +	 * According to the TRM, we should keep irq disabled during programming
> +	 * interrupt capability to prevent spurious glitches on the interrupt
> +	 * lines to the interrupt controller.
> +	 */

It's also worth noting that this case may come up in
rockchip_irq_demux() for EDGE_BOTH triggers:

		/*
		 * Triggering IRQ on both rising and falling edge
		 * needs manual intervention.
		 */
		if (bank->toggle_edge_mode & BIT(irq)) {
...
				polarity = readl_relaxed(bank->reg_base +
							 GPIO_INT_POLARITY);
				if (data & BIT(irq))
					polarity &= ~BIT(irq);
				else
					polarity |= BIT(irq);
				writel(polarity,
				       bank->reg_base + GPIO_INT_POLARITY);

AIUI, this case is not actually a problem, because this polarity
reconfiguration happens before we call generic_handle_irq(), so the
extra spurious interrupt is handled and cleared after this point. But it
seems like this should be noted somewhere in either the commit message,
the code comments, or both.

On the other hand...this also implies there may be a race condition
there, where we might lose an interrupt if there is an edge between the
re-configuration of the polarity in rockchip_irq_demux() and the
clearing/handling of the interrupt (handle_edge_irq() ->
chip->irq_ack()). If we have an edge between there, then we might ack
it, but leave the polarity such that we aren't ready for the next
(inverted) edge.

I'm not 100% sure about the above, so it might be good to verify it. But
I also expect this means there's really no way to 100% reliably
implement both-edge trigger types on hardware like this that doesn't
directly implement it. So I'm not sure what we'd do with that knowledge.

> +	data = readl(bank->reg_base + GPIO_INTEN);
> +	writel_relaxed(data & ~mask, gc->reg_base + GPIO_INTEN);

Not sure if this is a needless optimization: but couldn't you only
disable the interrupt (and make the level and polarity changes) only if
the level or polarity are actually changing? For example, it's possible
to end up here when changing from EDGE_BOTH to EDGE_RISING, but we might
not actually program a new value.

Brian

> +
>  	writel_relaxed(level, gc->reg_base + GPIO_INTTYPE_LEVEL);
>  	writel_relaxed(polarity, gc->reg_base + GPIO_INT_POLARITY);
>  
> +	writel_relaxed(data, gc->reg_base + GPIO_INTEN);
> +
>  	irq_gc_unlock(gc);
>  	raw_spin_unlock_irqrestore(&bank->slock, flags);
>  	clk_disable(bank->clk);
> -- 
> 2.11.0
> 
> 
