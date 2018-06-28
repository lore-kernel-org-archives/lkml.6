Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97217C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D15E277D5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D15E277D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030533AbeF1SeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:34:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58123 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933185AbeF1SeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:34:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2659B20787; Thu, 28 Jun 2018 20:34:09 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id E5415206ED;
        Thu, 28 Jun 2018 20:34:08 +0200 (CEST)
Date:   Thu, 28 Jun 2018 20:34:09 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexander Dahl <ada@thorsis.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] ARM: at91: add TCB registers definitions
Message-ID: <20180628183409.GS4207@piout.net>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-2-alexandre.belloni@bootlin.com>
 <1bc64ccb-1e22-364c-e08c-fa86692783ff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bc64ccb-1e22-364c-e08c-fa86692783ff@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2018 17:15:39+0200, Daniel Lezcano wrote:
> On 19/06/2018 23:19, Alexandre Belloni wrote:
> > Add registers and bits definitions for the timer counter blocks found on
> > Atmel ARM SoCs.
> > 
> > Tested-by: Alexander Dahl <ada@thorsis.com>
> > Tested-by: Andras Szemzo <szemzo.andras@gmail.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  include/soc/at91/atmel_tcb.h | 216 +++++++++++++++++++++++++++++++++++
> 
> Is the header necessary ? Can it be moved in the .c ?
> 

Ultimately, the clocksource driver will not be the only one to use it.
There is the pwm driver that will be converted (it was converted in the
first version of the series). and then there is a counter driver that
will be submitted once the subsystem is upstreamed.

> >  1 file changed, 216 insertions(+)
> >  create mode 100644 include/soc/at91/atmel_tcb.h
> > 
> > diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
> > new file mode 100644
> > index 000000000000..3ed66031fc76
> > --- /dev/null
> 
> [ ... ]
> 
> > +static inline struct clk *tcb_clk_get(struct device_node *node, int channel)
> > +{
> > +	struct clk *clk;
> > +	char clk_name[] = "t0_clk";
> > +
> > +	clk_name[1] += channel;
> 
> clever :)
> 
> > +	clk = of_clk_get_by_name(node->parent, clk_name);
> > +	if (!IS_ERR(clk))
> > +		return clk;
> > +
> > +	return of_clk_get_by_name(node->parent, "t0_clk");
> 
> Why do you want to return clk from t0_clk if another channel is
> requested ? This is prone to error.

The newer TCBs only have one peripheral clocks. The current DT binding only
have t0_clk in that case so whatever the channel, t0_clk is the correct
one.

> 
> I would clarify that at the caller level, if tcb_clk_get fails then try
> with channel zero.

This was hidden from the individual drivers by tclib but this can be
open coded in the drivers.

> 
> > +}
> > +
> > +static inline int tcb_irq_get(struct device_node *node, int channel)
> 
> no inline
> 

IIRC, removing the inline will make linking the kernel fail when there
is more than 2 drivers using the TCBs but I'll try again. Or I can
remove both those functions and open code as you suggest.

> > +{
> > +	int irq;
> > +
> > +	irq = of_irq_get(node->parent, channel);
> > +	if (irq > 0)
> > +		return irq;
> > +
> > +	return of_irq_get(node->parent, 0);
> 
> Same comment than above.
> 
> > +}
> > +
> > +static const u8 atmel_tc_divisors[5] = { 2, 8, 32, 128, 0, };
> > +
> > +struct atmel_tcb_info {
> > +	int bits;
> > +};
> > +
> > +static const struct atmel_tcb_info atmel_tcb_infos[] = {
> > +	{ .bits = 16 },
> > +	{ .bits = 32 },
> > +};
> 
> Structuring the code with structure is a good practice. However, this is
> too much :)
> 

I was going to add the divisor there but as AVR32 is gone, this is
indeed unnecessary.

> > +static const struct of_device_id atmel_tcb_dt_ids[] = {
> > +	{
> > +		.compatible = "atmel,at91rm9200-tcb",
> > +		.data = &atmel_tcb_infos[0],
> 
> 		.data = (void *)16;
> 
> > +	}, {
> > +		.compatible = "atmel,at91sam9x5-tcb",
> > +		.data = &atmel_tcb_infos[1],
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> > +
> 
> 
> 
> > +#endif /* __SOC_ATMEL_TCB_H */
> > 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
