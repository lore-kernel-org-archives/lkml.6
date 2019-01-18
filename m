Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6F4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0C20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547792900;
	bh=eLJyu28gXRw68ufVP13qCEYhoFA/FZ1EgqP3TJY67JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WkcyUa4DAxxOHIZet1sfbn/zjF0nMixMeeBPU2Cfbd2m+/mdjj/rmBtCo8YMsItuN
	 5TmymmkBuVUUmrrX1c0dzaJNb0xNz5zmcS/y5YrzRL0bb8cdTRzHPJhbm1wtdTDeQu
	 EGQOtKxr6h9uEBsuZhO6OHyL5Y80UbBULCuA+2Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfARG2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 01:28:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfARG2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 01:28:18 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B25020855;
        Fri, 18 Jan 2019 06:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547792897;
        bh=eLJyu28gXRw68ufVP13qCEYhoFA/FZ1EgqP3TJY67JA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EPq6I45NxrXOb1NUKSrZX7WYaYkq5hvUWrrMl4TErBRgCamcv4Xf2j9StAm6nXv6E
         22Xrc5WcGO/NxIJ5OREtEav696GIVPb+QrgbPuS+YZQcKXMRqQmuLZ00QbyDcqj5Jl
         y2DU9emMiaFakoxkziNJYT26EIK4ZLGARPR0givI=
Date:   Fri, 18 Jan 2019 14:28:11 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH] irqchip/irq-csky-mpintc: Add triger type and priority
 setting
Message-ID: <20190118062811.GA19835@guoren-Inspiron-7460>
References: <1547570199-25944-1-git-send-email-guoren@kernel.org>
 <9c531bec-263c-070d-fed8-d953b42aa185@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c531bec-263c-070d-fed8-d953b42aa185@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Marc,

On Thu, Jan 17, 2019 at 05:17:45PM +0000, Marc Zyngier wrote:
> Hi Guo,
> 
> On 15/01/2019 16:36, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> > 
> > Support 4 triger types:
> >  - IRQ_TYPE_LEVEL_HIGH
> >  - IRQ_TYPE_LEVEL_LOW
> >  - IRQ_TYPE_EDGE_RISING
> >  - IRQ_TYPE_EDGE_FALLING
> > 
> > Support 0-255 priority setting for each irq.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  .../bindings/interrupt-controller/csky,mpintc.txt  | 24 ++++++-
> >  drivers/irqchip/irq-csky-mpintc.c                  | 78 +++++++++++++++++++++-
> >  2 files changed, 99 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > index ab921f1..364b789 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> > @@ -11,6 +11,14 @@ Interrupt number definition:
> >   16-31  : private  irq, and we use 16 as the co-processor timer.
> >   31-1024: common irq for soc ip.
> >  
> > +Interrupt triger mode:
> > +  IRQ_TYPE_LEVEL_HIGH (default)
> > +  IRQ_TYPE_LEVEL_LOW
> > +  IRQ_TYPE_EDGE_RISING
> > +  IRQ_TYPE_EDGE_FALLING
> > +
> > +Interrupt priority range: 0-255
> > +
> >  =============================
> >  intc node bindings definition
> >  =============================
> > @@ -26,7 +34,7 @@ intc node bindings definition
> >  	- #interrupt-cells
> >  		Usage: required
> >  		Value type: <u32>
> > -		Definition: must be <1>
> > +		Definition: could be <1> or <2>
> >  	- interrupt-controller:
> >  		Usage: required
> >  
> > @@ -35,6 +43,18 @@ Examples:
> >  
> >  	intc: interrupt-controller {
> >  		compatible = "csky,mpintc";
> > -		#interrupt-cells = <1>;
> > +		#interrupt-cells = <2>;
> >  		interrupt-controller;
> >  	};
> > +
> > +	0: device-example {
> > +		...
> > +		interrupts = <33 IRQ_TYPE_EDGE_RISING>;
> > +		interrupt-parent = <&intc>;
> > +	};
> > +
> > +	1: device-example {
> > +		...
> > +		interrupts = <34 ((priority << 4) | IRQ_TYPE_EDGE_RISING)>;
> > +		interrupt-parent = <&intc>;
> > +	};
> > diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
> > index c67c961..9edc6d3 100644
> > --- a/drivers/irqchip/irq-csky-mpintc.c
> > +++ b/drivers/irqchip/irq-csky-mpintc.c
> > @@ -29,9 +29,12 @@ static void __iomem *INTCL_base;
> >  
> >  #define INTCG_ICTLR	0x0
> >  #define INTCG_CICFGR	0x100
> > +#define INTCG_CIPRTR	0x200
> >  #define INTCG_CIDSTR	0x1000
> >  
> >  #define INTCL_PICTLR	0x0
> > +#define INTCL_CFGR	0x14
> > +#define INTCL_PRTR	0x20
> >  #define INTCL_SIGR	0x60
> >  #define INTCL_HPPIR	0x68
> >  #define INTCL_RDYIR	0x6c
> > @@ -73,6 +76,78 @@ static void csky_mpintc_eoi(struct irq_data *d)
> >  	writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
> >  }
> >  
> > +static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +	unsigned int priority, triger;
> 
> nit: s/triger/trigger/ everywhere.
Ok

> 
> > +	unsigned int offset, bit_offset;
> > +	void __iomem *reg_base;
> > +
> > +	/*
> > +	 * type Bit field: | 32 - 12  |  11 - 4  |   3 - 0    |
> > +	 *                   reserved   priority   triger type
> > +	 */
> > +	triger	 = type & IRQ_TYPE_SENSE_MASK;
> > +	priority = (type >> 4) & 0xff;
> 
> Definitely not. The Linux API to set the trigger does not carry any
> priority information, nor should it. Priorities should be set
> statically, and no driver should ever be able to change it.
Currently priority in dts is:

	interrupts = <34 ((priority << 4) | IRQ_TYPE_EDGE_RISING)>;

change it to:

	interrupts = <34 IRQ_TYPE_EDGE_RISING priority>;

Implement csky own csky_irq_domain_xlate_cells() ...

int csky_irq_domain_xlate_cells(struct irq_domain *d, struct device_node *ctrlr,
			const u32 *intspec, unsigned int intsize,
			irq_hw_number_t *out_hwirq, unsigned int *out_type)
{
	if (WARN_ON(intsize < 1))
		return -EINVAL;
	*out_hwirq = intspec[0];
	if (intsize > 1)
		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
	else
		*out_type = IRQ_TYPE_NONE;

	if (intsize > 2)
		setup_priority(d->hwirq, intspec[2]);

	return 0;
}
Hmm?

> 
> > +
> > +	switch (triger) {
> > +	case IRQ_TYPE_LEVEL_HIGH:
> > +		triger = 0;
> > +		break;
> > +	case IRQ_TYPE_LEVEL_LOW:
> > +		triger = 1;
> > +		break;
> > +	case IRQ_TYPE_EDGE_RISING:
> > +		triger = 2;
> > +		break;
> > +	case IRQ_TYPE_EDGE_FALLING:
> > +		triger = 3;
> 
> Can you define some macros that represent these magic values?
OK.
> 
> > +		break;
> > +	default:
> > +		triger = 0;
> > +		break;
> 
> If you get an invalid combination, you shouldn't blindly accept it, but
> instead return an error.
OK.

> 
> > +	}
> > +
> > +	if (d->hwirq < COMM_IRQ_BASE) {
> > +		reg_base = this_cpu_read(intcl_reg);
> 
> Are you guaranteed to be in a non-preemptible section here? I can see
> things going wrong if not.

???
In percpu-def.h, I see this_cpu_read is safe() for preemption or
interrupt.

/*
 * Operations with implied preemption/interrupt protection. These
 * operations can be used without worrying about preemption or interrupt.
 */
#define this_cpu_read(pcp)		__pcpu_size_call_return(this_cpu_read_, pcp)

And:
#define __pcpu_size_call_return(stem, variable)				\
({									\
	typeof(variable) pscr_ret__;					\
	__verify_pcpu_ptr(&(variable));					\
	switch(sizeof(variable)) {					\
	case 1: pscr_ret__ = stem##1(variable); break;			\
	case 2: pscr_ret__ = stem##2(variable); break;			\
	case 4: pscr_ret__ = stem##4(variable); break;			\
	case 8: pscr_ret__ = stem##8(variable); break;			\
	default:							\
		__bad_size_call_parameter(); break;			\
	}								\
	pscr_ret__;							\
})

What's the wrong with preemption?

> > +
> > +		if (triger) {
> > +			offset = ((d->hwirq * 2) / 32) * 4;
> > +			bit_offset = (d->hwirq * 2) % 32;
> 
> This needs to be turned into a set of macros so that the non-percpu code
> can reuse it.


#define IRQ_OFFSET(irq) \
	((irq < COMM_IRQ_BASE) ? irq : irq - COMM_IRQ_BASE) 

#define TRIG_VAL(trigger, irq) \
	(trigger << ((IRQ_OFFSET(irq) * 2) % 32))

#define TRIG_VAL_MSK(irq) \
	(3 << ((IRQ_OFFSET(irq) * 2) % 32))

#define TRIG_BASE(irq) \
	((((IRQ_OFFSET(irq) * 2) / 32) * 4) + \
	((irq < COMM_IRQ_BASE) ? this_cpu_read(intcl_reg) : INTCG_base))

tmp = readl_relaxed(TRIG_BASE(d->hwirq)) & (~TRIG_VAL_MSK(d->hwirq));
writel_relaxed(tmp | TRIG_VAL(triger, d->hwirq), TRIG_BASE(d->hwirq));

Hmm?

> 
> > +
> > +			writel_relaxed(triger << bit_offset,
> > +				reg_base + INTCL_CFGR + offset);
> > +		}
> > +
> > +		if (priority) {
> > +			offset = ((d->hwirq * 8) / 32) * 4;
> > +			bit_offset = (d->hwirq * 8) % 32;
> > +
> > +			writel_relaxed(priority << bit_offset,
> > +				reg_base + INTCL_PRTR + offset);
> > +		}
> 
> And this should only be set at boot time.
The same with above reply.

Best Regards
 Guo Ren
