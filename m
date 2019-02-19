Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2ABC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0490B21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfBSQO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:14:56 -0500
Received: from foss.arm.com ([217.140.101.70]:46988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfBSQO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:14:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52D50EBD;
        Tue, 19 Feb 2019 08:14:55 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EC773F690;
        Tue, 19 Feb 2019 08:14:53 -0800 (PST)
Date:   Tue, 19 Feb 2019 16:14:49 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v6 1/7] irq/irq_sim: add irq_set_type() callback
Message-ID: <20190219161449.26e99a2b@why.wild-wind.fr.eu.org>
In-Reply-To: <20190219160650.9614-2-brgl@bgdev.pl>
References: <20190219160650.9614-1-brgl@bgdev.pl>
        <20190219160650.9614-2-brgl@bgdev.pl>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 17:06:44 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Implement the irq_set_type() callback and call irqd_set_trigger_type()
> internally so that users interested in the configured trigger type can
> later retrieve it using irqd_get_trigger_type(). We only support edge
> trigger types.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  kernel/irq/irq_sim.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index 98a20e1594ce..b992f88c5613 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -25,10 +25,22 @@ static void irq_sim_irqunmask(struct irq_data *data)
>  	irq_ctx->enabled = true;
>  }
>  
> +static int irq_sim_set_type(struct irq_data *data, unsigned int type)
> +{
> +	/* We only support rising and falling edge trigger types. */
> +	if (type & ~IRQ_TYPE_EDGE_BOTH)
> +		return -EINVAL;
> +
> +	irqd_set_trigger_type(data, type);
> +
> +	return 0;
> +}
> +
>  static struct irq_chip irq_sim_irqchip = {
>  	.name		= "irq_sim",
>  	.irq_mask	= irq_sim_irqmask,
>  	.irq_unmask	= irq_sim_irqunmask,
> +	.irq_set_type	= irq_sim_set_type,
>  };
>  
>  static void irq_sim_handle_irq(struct irq_work *work)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.
