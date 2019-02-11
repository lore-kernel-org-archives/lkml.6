Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8ECC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059942184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfBKW0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:26:21 -0500
Received: from foss.arm.com ([217.140.101.70]:57830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfBKW0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:26:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97DD0EBD;
        Mon, 11 Feb 2019 14:26:20 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA9943F675;
        Mon, 11 Feb 2019 14:26:18 -0800 (PST)
Date:   Mon, 11 Feb 2019 22:26:14 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 2/9] irq/irq_sim: use irq domain
Message-ID: <20190211222610.42e9189b@why.wild-wind.fr.eu.org>
In-Reply-To: <20190129084411.30495-3-brgl@bgdev.pl>
References: <20190129084411.30495-1-brgl@bgdev.pl>
        <20190129084411.30495-3-brgl@bgdev.pl>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 09:44:04 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Delegate the offset to virq number mapping to the provided framework
> instead of handling it locally. Use the legacy domain as we want to
> preallocate the irq descriptors.

Why?

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  include/linux/irq_sim.h |  6 +--
>  kernel/irq/irq_sim.c    | 94 +++++++++++++++++++++++++++++------------
>  2 files changed, 71 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/irq_sim.h b/include/linux/irq_sim.h
> index eda132c22b57..b96c2f752320 100644
> --- a/include/linux/irq_sim.h
> +++ b/include/linux/irq_sim.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/irq.h>
>  #include <linux/irq_work.h>
> +#include <linux/irqdomain.h>
>  #include <linux/device.h>
>  
>  /*
> @@ -21,16 +22,15 @@ struct irq_sim_work_ctx {
>  };
>  
>  struct irq_sim_irq_ctx {
> -	int			irqnum;
>  	bool			enabled;
>  };
>  
>  struct irq_sim {
>  	struct irq_chip		chip;
> +	struct irq_domain	*domain;
>  	struct irq_sim_work_ctx	work_ctx;
> -	int			irq_base;
> +	int			virq_base;
>  	unsigned int		irq_count;
> -	struct irq_sim_irq_ctx	*irqs;
>  };
>  
>  int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs);
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index b732e4e2e45b..2bcdbab1bc5a 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -44,6 +44,43 @@ static void irq_sim_handle_irq(struct irq_work *work)
>  	}
>  }
>  
> +static int irq_sim_domain_map(struct irq_domain *domain,
> +			      unsigned int virq, irq_hw_number_t hw)
> +{
> +	struct irq_sim *sim = domain->host_data;
> +	struct irq_sim_irq_ctx *ctx;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	irq_set_chip(virq, &sim->chip);
> +	irq_set_chip_data(virq, ctx);
> +	irq_set_handler(virq, handle_simple_irq);

Consider using modern APIs such as irq_domain_set_info().

> +	irq_modify_status(virq, IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);

Where is this requirement coming from?

> +
> +	return 0;
> +}
> +
> +static void irq_sim_domain_free(struct irq_domain *domain,
> +				unsigned int virq, unsigned int num_irqs)
> +{
> +	struct irq_sim_irq_ctx *ctx;
> +	struct irq_data *irq;
> +	int i;
> +
> +	for (i = 0; i < num_irqs; i++) {
> +		irq = irq_domain_get_irq_data(domain, virq + i);
> +		ctx = irq_data_get_irq_chip_data(irq);
> +		kfree(ctx);
> +	}
> +}
> +
> +static const struct irq_domain_ops irq_sim_domain_ops = {
> +	.map = irq_sim_domain_map,
> +	.free = irq_sim_domain_free,

The intended use of the v2 API is to have alloc and free as a pair, and
no map. So please choose which version of the API you're using here.
The safest bet would be to move what you do on map into alloc.

> +};
> +
>  /**
>   * irq_sim_init - Initialize the interrupt simulator: allocate a range of
>   *                dummy interrupts.
> @@ -56,16 +93,15 @@ static void irq_sim_handle_irq(struct irq_work *work)
>   */
>  int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
>  {
> -	int i;
> -
> -	sim->irqs = kmalloc_array(num_irqs, sizeof(*sim->irqs), GFP_KERNEL);
> -	if (!sim->irqs)
> +	sim->virq_base = irq_alloc_descs(-1, 0, num_irqs, 0);
> +	if (sim->virq_base < 0)
> +		return sim->virq_base;
> +
> +	sim->domain = irq_domain_add_legacy(NULL, num_irqs, sim->virq_base,
> +					    0, &irq_sim_domain_ops, sim);

Why do you need a legacy domain? As far as I can tell, this is new
code, hence it has no legacy.

> +	if (!sim->domain) {
> +		irq_free_descs(sim->virq_base, num_irqs);
>  		return -ENOMEM;
> -
> -	sim->irq_base = irq_alloc_descs(-1, 0, num_irqs, 0);
> -	if (sim->irq_base < 0) {
> -		kfree(sim->irqs);
> -		return sim->irq_base;
>  	}
>  
>  	sim->chip.name = "irq_sim";
> @@ -74,25 +110,15 @@ int irq_sim_init(struct irq_sim *sim, unsigned int num_irqs)
>  
>  	sim->work_ctx.pending = bitmap_zalloc(num_irqs, GFP_KERNEL);
>  	if (!sim->work_ctx.pending) {
> -		kfree(sim->irqs);
> -		irq_free_descs(sim->irq_base, num_irqs);
> +		irq_domain_remove(sim->domain);
> +		irq_free_descs(sim->virq_base, num_irqs);
>  		return -ENOMEM;
>  	}
>  
> -	for (i = 0; i < num_irqs; i++) {
> -		sim->irqs[i].irqnum = sim->irq_base + i;
> -		sim->irqs[i].enabled = false;
> -		irq_set_chip(sim->irq_base + i, &sim->chip);
> -		irq_set_chip_data(sim->irq_base + i, &sim->irqs[i]);
> -		irq_set_handler(sim->irq_base + i, &handle_simple_irq);
> -		irq_modify_status(sim->irq_base + i,
> -				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
> -	}
> -
>  	init_irq_work(&sim->work_ctx.work, irq_sim_handle_irq);
>  	sim->irq_count = num_irqs;
>  
> -	return sim->irq_base;
> +	return sim->virq_base;
>  }
>  EXPORT_SYMBOL_GPL(irq_sim_init);
>  
> @@ -106,8 +132,8 @@ void irq_sim_fini(struct irq_sim *sim)
>  {
>  	irq_work_sync(&sim->work_ctx.work);
>  	bitmap_free(sim->work_ctx.pending);
> -	irq_free_descs(sim->irq_base, sim->irq_count);
> -	kfree(sim->irqs);
> +	irq_domain_free_irqs(sim->virq_base, sim->irq_count);
> +	irq_domain_remove(sim->domain);
>  }
>  EXPORT_SYMBOL_GPL(irq_sim_fini);
>  
> @@ -151,6 +177,20 @@ int devm_irq_sim_init(struct device *dev, struct irq_sim *sim,
>  }
>  EXPORT_SYMBOL_GPL(devm_irq_sim_init);
>  
> +static struct irq_sim_irq_ctx *
> +irq_sim_get_ctx(struct irq_sim *sim, unsigned int offset)
> +{
> +	struct irq_sim_irq_ctx *ctx;
> +	struct irq_data *irq;
> +	int virq;
> +
> +	virq = irq_find_mapping(sim->domain, offset);
> +	irq = irq_domain_get_irq_data(sim->domain, virq);
> +	ctx = irq_data_get_irq_chip_data(irq);
> +
> +	return ctx;
> +}
> +
>  /**
>   * irq_sim_fire - Enqueue an interrupt.
>   *
> @@ -159,7 +199,9 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
>   */
>  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
>  {
> -	if (sim->irqs[offset].enabled) {
> +	struct irq_sim_irq_ctx *ctx = irq_sim_get_ctx(sim, offset);
> +
> +	if (ctx->enabled) {
>  		set_bit(offset, sim->work_ctx.pending);
>  		irq_work_queue(&sim->work_ctx.work);
>  	}
> @@ -175,6 +217,6 @@ EXPORT_SYMBOL_GPL(irq_sim_fire);
>   */
>  int irq_sim_irqnum(struct irq_sim *sim, unsigned int offset)
>  {
> -	return sim->irqs[offset].irqnum;
> +	return irq_find_mapping(sim->domain, offset);
>  }
>  EXPORT_SYMBOL_GPL(irq_sim_irqnum);


Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
