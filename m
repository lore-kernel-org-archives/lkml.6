Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEE4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342392145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 10:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeLQKJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:09:59 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35841 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeLQKJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 05:09:58 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gYpqT-0000g7-PA; Mon, 17 Dec 2018 11:09:53 +0100
Message-ID: <1545041393.5874.1.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] irqchip: add driver for imx-irqsteer controller
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 17 Dec 2018 11:09:53 +0100
In-Reply-To: <86r2ejaztt.wl-marc.zyngier@arm.com>
References: <20181214102244.21509-1-l.stach@pengutronix.de>
         <20181214102244.21509-3-l.stach@pengutronix.de>
         <86r2ejaztt.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Am Samstag, den 15.12.2018, 09:45 +0000 schrieb Marc Zyngier:
> Hi Lucas,
> 
> On Fri, 14 Dec 2018 10:22:44 +0000,
> > Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > The irqsteer block is a interrupt multiplexer/remapper found on the
> > i.MX8 line of SoCs.
> > 
> > > > Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
> > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > v2:
> >  - use raw_spinlock
> >  - add proper clk error handling
> >  - align register offset calculation with reality
> >  - use correct SPDX identifier
> >  - simplify DT configuration
> > ---

[...]

> > +static const struct irq_domain_ops imx_irqsteer_domain_ops = {
> > > > > > +	.map		= imx_irqsteer_irq_map,
> > +	.xlate		= irq_domain_xlate_twocell,
> 
> I've tried to understand why you are using two cells, but couldn't
> find an explanation from the DT binding. As far as I can see, you only
> support LEVEL_HIGH signalling, meaning that you could perfectly
> encode this in a single cell. What am I missing?

Nothing. At this point I'm sure that the controller only support level-
high IRQs. Will switch to a single cell in the next spin.

[...]

> > +static int imx_irqsteer_probe(struct platform_device *pdev)
> > +{
> > > > +	struct device_node *np = pdev->dev.of_node;
> > > > +	struct irqsteer_data *data;
> > > > +	struct resource *res;
> > > > +	int ret;
> > +
> > > > +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> > > > +	if (!data)
> > > > +		return -ENOMEM;
> > +
> > > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > > +	data->regs = devm_ioremap_resource(&pdev->dev, res);
> > > > +	if (IS_ERR(data->regs)) {
> > > > +		dev_err(&pdev->dev, "failed to initialize reg\n");
> > > > +		return PTR_ERR(data->regs);
> > > > +	}
> > +
> > > > +	data->irq = platform_get_irq(pdev, 0);
> > > > +	if (data->irq <= 0) {
> > > > +		dev_err(&pdev->dev, "failed to get irq\n");
> > > > +		return -ENODEV;
> > > > +	}
> > +
> > > > +	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
> > > > +	if (IS_ERR(data->ipg_clk)) {
> > > > +		ret = PTR_ERR(data->ipg_clk);
> > > > +		if (ret != -EPROBE_DEFER)
> > > > +			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > +
> > > > +	raw_spin_lock_init(&data->lock);
> > +
> > > > +	of_property_read_u32(np, "fsl,irq-groups", &data->irq_groups);
> > > > +	of_property_read_u32(np, "fsl,channel", &data->channel);
> > +
> > > > +	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
> > > > +		data->saved_reg = devm_kzalloc(&pdev->dev,
> > > > +					sizeof(u32) * data->irq_groups * 2,
> > > > +					GFP_KERNEL);
> > > > +		if (!data->saved_reg)
> > > > +			return -ENOMEM;
> > > > +	}
> > +
> > > > +	ret = clk_prepare_enable(data->ipg_clk);
> > > > +	if (ret) {
> > > > +		dev_err(&pdev->dev, "failed to enable ipg clk: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > +
> > > > +	/* steer all IRQs into configured channel */
> > +	writel_relaxed(BIT(data->channel), data->regs + CHANCTRL);
> 
> Could you explain what this channel is exactly?

I've tired in the cover letter, but seems I still failed, so let me try
again. ;)

Each irqsteer instance can be connected to multiple upstream IRQ lines,
but only one of them can be used at runtime. This register controls
which output IRQ line will be used by this controller instance. With
multiple controller instances in the system it's a way to offload the
decision of the IRQ routing from the hardware to the software guys.

Let's try to add an example: Suppose there are 2 instances of the
irqsteer controller. Both are connected to upstream GIC IRQs 20 and 21.
The channel controls which of those IRQs are used by each instance, so
there are 2 valid DT configurations in this scenario:

This is valid:

irqsteer@0 {
	interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>
	fsl,channel = <0>;
};

irqsteer@1 {
	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>
	fsl,channel = <1>;
};

As well as this:

irqsteer@0 {
	interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>
	fsl,channel = <1>;
};

irqsteer@1 {
	interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>
	fsl,channel = <0>;
};
	
[...]
> > +#ifdef CONFIG_PM_SLEEP
> > +static void imx_irqsteer_save_regs(struct irqsteer_data *data)
> > +{
> > > > +	int num;
> > +
> > > > +	for (num = 0; num < data->irq_groups; num++)
> > > > +		data->saved_reg[num + 1] = readl_relaxed(data->regs +
> > +						CHANMASK(num, data->irq_groups));
> 
> You seem to only use one u32 per IRQ group. Yet, you've allocated
> twice as much memory to that effect. Why? Also, you're avoiding to use
> index 0, which I find rather odd.
> 
> Given that the DT binding states that each group manages 64
> interrupts, I have the feeling that you're missing some interrupt
> enable state.

And you are right with this observation. I failed to properly rework
this part of the code when switching to the irq-group indexing.

Regards,
Lucas
