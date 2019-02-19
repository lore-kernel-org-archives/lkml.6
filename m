Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C016FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE4C217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfBSMZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:25:42 -0500
Received: from foss.arm.com ([217.140.101.70]:44500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfBSMZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:25:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 288A7EBD;
        Tue, 19 Feb 2019 04:25:40 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 251A13F720;
        Tue, 19 Feb 2019 04:25:37 -0800 (PST)
Date:   Tue, 19 Feb 2019 12:25:24 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v5 1/7] irq/irq_sim: add irq_set_type() callback
Message-ID: <20190219122524.2e2b01db@why.wild-wind.fr.eu.org>
In-Reply-To: <20190218164138.24921-2-brgl@bgdev.pl>
References: <20190218164138.24921-1-brgl@bgdev.pl>
        <20190218164138.24921-2-brgl@bgdev.pl>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 17:41:32 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Implement the irq_set_type() callback and call irqd_set_trigger_type()
> internally so that users interested in the configured trigger type can
> later retrieve it using irqd_get_trigger_type().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  kernel/irq/irq_sim.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
> index 98a20e1594ce..83ecc65d8be2 100644
> --- a/kernel/irq/irq_sim.c
> +++ b/kernel/irq/irq_sim.c
> @@ -25,10 +25,18 @@ static void irq_sim_irqunmask(struct irq_data *data)
>  	irq_ctx->enabled = true;
>  }
>  
> +static int irq_sim_set_type(struct irq_data *data, unsigned int type)
> +{
> +	irqd_set_trigger_type(data, type);
> +
> +	return 0;

You keep ignoring the requirement for sanitization of the trigger type.
Frankly, I'm getting tired of fighting over 3 lines of incorrect code.

I guess that despite all the noise, you don't really want this code in
after all.

	M.
-- 
Without deviation from the norm, progress is not possible.
