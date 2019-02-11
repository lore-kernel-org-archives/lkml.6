Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8C7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD01020818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbfBKW2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:28:51 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57856 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfBKW2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:28:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46E9BEBD;
        Mon, 11 Feb 2019 14:28:50 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C64E23F675;
        Mon, 11 Feb 2019 14:28:43 -0800 (PST)
Date:   Mon, 11 Feb 2019 22:28:39 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 1/9] irq/irq_sim: don't share the irq_chip structure
 between simulators
Message-ID: <20190211222839.7a7ad87f@why.wild-wind.fr.eu.org>
In-Reply-To: <20190129084411.30495-2-brgl@bgdev.pl>
References: <20190129084411.30495-1-brgl@bgdev.pl>
        <20190129084411.30495-2-brgl@bgdev.pl>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 09:44:03 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We want to support multiple instances of irq_sim. Make struct irq_chip
> part of the irq_sim structure.

Why? There is nothing dynamic in an irqchip structure. It is all code
that is set in stone for the lifetime of the irqchip.

I've sure you have a use for such indirection, so why don't you explain
what you have in mind?

Thanks,

	M.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  include/linux/irq_sim.h |  2 ++
>  kernel/irq/irq_sim.c    | 12 +++++-------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> index 4500d453a63e..eda132c22b57 100644
> --- a/include/linux/irq_sim.h
> +++ b/include/linux/irq_sim.h
> @@ -6,6 +6,7 @@
>  #ifndef _LINUX_IRQ_SIM_H
>  #define _LINUX_IRQ_SIM_H
>  
> +#include <linux/irq.h>
>  #include <linux/irq_work.h>
>  #include <linux/device.h>
>  
> @@ -25,6 +26,7 @@ struct irq_sim_irq_ctx {
>  };
>  
>  struct irq_sim {
> +	struct irq_chip		chip;
>  	struct irq_sim_work_ctx	work_ctx;
>  	int			irq_base;
>  	unsigned int		irq_count;
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index 98a20e1594ce..b732e4e2e45b 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -25,12 +25,6 @@ static void irq_sim_irqunmask(struct irq_data *data)
>  	irq_ctx->enabled = true;
>  }
>  
> -static struct irq_chip irq_sim_irqchip = {
> -	.name		= "irq_sim",
> -	.irq_mask	= irq_sim_irqmask,
> -	.irq_unmask	= irq_sim_irqunmask,
> -};
> -
>  static void irq_sim_handle_irq(struct irq_work *work)
>  {
>  	struct irq_sim_work_ctx *work_ctx;
> @@ -74,6 +68,10 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
>  		return sim->irq_base;
>  	}
>  
> +	sim->chip.name = "irq_sim";
> +	sim->chip.irq_mask = irq_sim_irqmask;
> +	sim->chip.irq_unmask = irq_sim_irqunmask;
> +
>  	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
>  	if (!sim->work_ctx.pending) {
>  		kfree(sim->irqs);
> @@ -84,7 +82,7 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
>  	for (i = 0; i < num_irqs; i++) {
>  		sim->irqs[i].irqnum = sim->irq_base + i;
>  		sim->irqs[i].enabled = false;
> -		irq_set_chip(sim->irq_base + i, &irq_sim_irqchip);
> +		irq_set_chip(sim->irq_base + i, &sim->chip);
>  		irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
>  		irq_set_handler(sim->irq_base + i, &handle_simple_irq);
>  		irq_modify_status(sim->irq_base + i,



-- 
Without deviation from the norm, progress is not possible.
