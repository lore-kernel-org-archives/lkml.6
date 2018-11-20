Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486B6C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095F820831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095F820831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbeKUDr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:47:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54701 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeKUDr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:47:58 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gP9eh-0006uK-Ff; Tue, 20 Nov 2018 18:17:43 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gP9eh-00005D-0Q; Tue, 20 Nov 2018 18:17:43 +0100
Date:   Tue, 20 Nov 2018 18:17:42 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] irq/irq_sim: provide irq_sim_fire_edge()
Message-ID: <20181120171742.gkwb4s4qbcqvnefj@pengutronix.de>
References: <20181120134032.31645-1-brgl@bgdev.pl>
 <20181120134032.31645-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120134032.31645-2-brgl@bgdev.pl>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 02:40:31PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The irq_sim irqchip doesn't allow to configure the sensitivity so every
> call to irq_sim_fire() fires a dummy interrupt. This used to not matter
> for gpio-mockup (one of the irq_sim users) until commit fa38869b0161
> ("gpiolib: Don't support irq sharing for userspace") which made it
> impossible for gpio-mockup to ignore certain events (e.g. only receive
> notifications about rising edge events).
> 
> Introduce a specialized variant of irq_sim_fire() which takes another
> argument called edge. allowing to specify the trigger type for the
> dummy interrupt.

I wonder if it's worth the effort to fix irq_sim. If you take a look in
my gpio-simulator patch, it is trivial to get it right without external
help with an amount of code that is usual for a driver that handles
irqs.

> @@ -161,12 +171,28 @@ EXPORT_SYMBOL_GPL(devm_irq_sim_init);
>   */
>  void irq_sim_fire(struct irq_sim *sim, unsigned int offset)
>  {
> -	if (sim->irqs[offset].enabled) {
> +	/* Don't care about the edge. */
> +	irq_sim_fire_edge(sim, offset, IRQ_TYPE_EDGE_BOTH);

Conceptually irq_sim_fire_edge should be defined above irq_sim_fire.

> +EXPORT_SYMBOL_GPL(irq_sim_fire);
> +
> +/**
> + * irq_sim_fire_edge - Enqueue an interrupt, specify the edge.
> + *
> + * @sim:        The interrupt simulator object.
> + * @offset:     Offset of the simulated interrupt which should be fired.
> + * edge:        Edge of the interrupt (IRQ_TYPE_EDGE_RISING/FALLING).
> + */
> +void irq_sim_fire_edge(struct irq_sim *sim, unsigned int offset, int edge)
> +{
> +	struct irq_sim_irq_ctx *irq = &sim->irqs[offset];
> +
> +	if (irq->enabled && (irq->edge & edge)) {
>  		set_bit(offset, sim->work_ctx.pending);
>  		irq_work_queue(&sim->work_ctx.work);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(irq_sim_fire);
> +EXPORT_SYMBOL_GPL(irq_sim_fire_edge);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
