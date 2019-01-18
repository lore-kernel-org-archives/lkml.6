Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF3AC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CB120883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547830934;
	bh=Ot5cdfyQMABjJwcJZHgUJM4MwtexVl6jjbIAr2zDRRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OlEp1t/MsDmqlfFTJwfkqcBnroS30JaGmdUJemlFl817h/bANGvSmldEUiSUjGHU2
	 cECydIhUGlKE4kG/WvnqiSRGtlI1VFse9u35sCsTEeCKzN5XjfUx+Vzkm8IpeY8vjW
	 N7tICH5fNjbFe+08SrYFK+oHzip2h+je/VjK9UWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfARRCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:02:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfARRCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:02:11 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A8F2086D;
        Fri, 18 Jan 2019 17:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547830930;
        bh=Ot5cdfyQMABjJwcJZHgUJM4MwtexVl6jjbIAr2zDRRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwGovXuSsWawVeBne2vP5Vqh9q26GYQU6KDrnZeYsgcg3/yK8Ufr7oAX33xDhVVB3
         3/OesJ834dsJtKd8WA1rCJz9HJ+Pn6LDpkNi2qZOq89ESONZqtEmViiwDF61bAMKTd
         nVK95OHCz+NV9the8WKR2IwMLo5WsLgjMnFEvCXs=
Date:   Sat, 19 Jan 2019 01:02:03 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH] irqchip/irq-csky-mpintc: Add triger type and priority
 setting
Message-ID: <20190118170203.GA22247@guoren-Inspiron-7460>
References: <1547570199-25944-1-git-send-email-guoren@kernel.org>
 <9c531bec-263c-070d-fed8-d953b42aa185@arm.com>
 <20190118062811.GA19835@guoren-Inspiron-7460>
 <bb80062f-28ac-b41c-5d56-90ede82037a2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb80062f-28ac-b41c-5d56-90ede82037a2@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 09:32:03AM +0000, Marc Zyngier wrote:
> On 18/01/2019 06:28, Guo Ren wrote:
> > Thx Marc,
> > 
> > On Thu, Jan 17, 2019 at 05:17:45PM +0000, Marc Zyngier wrote:
> >> Hi Guo,
> >>
> >> On 15/01/2019 16:36, guoren@kernel.org wrote:
> >>> From: Guo Ren <ren_guo@c-sky.com>
> >>>
> >>> Support 4 triger types:
> >>>  - IRQ_TYPE_LEVEL_HIGH
> >>>  - IRQ_TYPE_LEVEL_LOW
> >>>  - IRQ_TYPE_EDGE_RISING
> >>>  - IRQ_TYPE_EDGE_FALLING
> >>>
> >>> Support 0-255 priority setting for each irq.
> >>>
> >>> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> >>> ---
> >>>  .../bindings/interrupt-controller/csky,mpintc.txt  | 24 ++++++-
> >>>  drivers/irqchip/irq-csky-mpintc.c                  | 78 +++++++++++++++++++++-
> >>>  2 files changed, 99 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> >>> index ab921f1..364b789 100644
> >>> --- a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> >>> +++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
> >>> @@ -11,6 +11,14 @@ Interrupt number definition:
> >>>   16-31  : private  irq, and we use 16 as the co-processor timer.
> >>>   31-1024: common irq for soc ip.
> >>>  
> >>> +Interrupt triger mode:
> >>> +  IRQ_TYPE_LEVEL_HIGH (default)
> >>> +  IRQ_TYPE_LEVEL_LOW
> >>> +  IRQ_TYPE_EDGE_RISING
> >>> +  IRQ_TYPE_EDGE_FALLING
> >>> +
> >>> +Interrupt priority range: 0-255
> >>> +
> >>>  =============================
> >>>  intc node bindings definition
> >>>  =============================
> >>> @@ -26,7 +34,7 @@ intc node bindings definition
> >>>  	- #interrupt-cells
> >>>  		Usage: required
> >>>  		Value type: <u32>
> >>> -		Definition: must be <1>
> >>> +		Definition: could be <1> or <2>
> >>>  	- interrupt-controller:
> >>>  		Usage: required
> >>>  
> >>> @@ -35,6 +43,18 @@ Examples:
> >>>  
> >>>  	intc: interrupt-controller {
> >>>  		compatible = "csky,mpintc";
> >>> -		#interrupt-cells = <1>;
> >>> +		#interrupt-cells = <2>;
> >>>  		interrupt-controller;
> >>>  	};
> >>> +
> >>> +	0: device-example {
> >>> +		...
> >>> +		interrupts = <33 IRQ_TYPE_EDGE_RISING>;
> >>> +		interrupt-parent = <&intc>;
> >>> +	};
> >>> +
> >>> +	1: device-example {
> >>> +		...
> >>> +		interrupts = <34 ((priority << 4) | IRQ_TYPE_EDGE_RISING)>;
> >>> +		interrupt-parent = <&intc>;
> >>> +	};
> >>> diff --git a/drivers/irqchip/irq-csky-mpintc.c b/drivers/irqchip/irq-csky-mpintc.c
> >>> index c67c961..9edc6d3 100644
> >>> --- a/drivers/irqchip/irq-csky-mpintc.c
> >>> +++ b/drivers/irqchip/irq-csky-mpintc.c
> >>> @@ -29,9 +29,12 @@ static void __iomem *INTCL_base;
> >>>  
> >>>  #define INTCG_ICTLR	0x0
> >>>  #define INTCG_CICFGR	0x100
> >>> +#define INTCG_CIPRTR	0x200
> >>>  #define INTCG_CIDSTR	0x1000
> >>>  
> >>>  #define INTCL_PICTLR	0x0
> >>> +#define INTCL_CFGR	0x14
> >>> +#define INTCL_PRTR	0x20
> >>>  #define INTCL_SIGR	0x60
> >>>  #define INTCL_HPPIR	0x68
> >>>  #define INTCL_RDYIR	0x6c
> >>> @@ -73,6 +76,78 @@ static void csky_mpintc_eoi(struct irq_data *d)
> >>>  	writel_relaxed(d->hwirq, reg_base + INTCL_CACR);
> >>>  }
> >>>  
> >>> +static int csky_mpintc_set_type(struct irq_data *d, unsigned int type)
> >>> +{
> >>> +	unsigned int priority, triger;
> >>
> >> nit: s/triger/trigger/ everywhere.
> > Ok
> > 
> >>
> >>> +	unsigned int offset, bit_offset;
> >>> +	void __iomem *reg_base;
> >>> +
> >>> +	/*
> >>> +	 * type Bit field: | 32 - 12  |  11 - 4  |   3 - 0    |
> >>> +	 *                   reserved   priority   triger type
> >>> +	 */
> >>> +	triger	 = type & IRQ_TYPE_SENSE_MASK;
> >>> +	priority = (type >> 4) & 0xff;
> >>
> >> Definitely not. The Linux API to set the trigger does not carry any
> >> priority information, nor should it. Priorities should be set
> >> statically, and no driver should ever be able to change it.
> > Currently priority in dts is:
> > 
> > 	interrupts = <34 ((priority << 4) | IRQ_TYPE_EDGE_RISING)>;
> > 
> > change it to:
> > 
> > 	interrupts = <34 IRQ_TYPE_EDGE_RISING priority>;
> > 
> 
> I don't think you need to change the DT format, as this is quite painful
> for users.
I'll keep this style and I think it's good place to set priority.

> 
> > Implement csky own csky_irq_domain_xlate_cells() ...
> > 
> > int csky_irq_domain_xlate_cells(struct irq_domain *d, struct device_node *ctrlr,
> > 			const u32 *intspec, unsigned int intsize,
> > 			irq_hw_number_t *out_hwirq, unsigned int *out_type)
> > {
> > 	if (WARN_ON(intsize < 1))
> > 		return -EINVAL;
> > 	*out_hwirq = intspec[0];
> > 	if (intsize > 1)
> > 		*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
> > 	else
> > 		*out_type = IRQ_TYPE_NONE;
> > 
> > 	if (intsize > 2)
> > 		setup_priority(d->hwirq, intspec[2]);
> 
> That's still a problem. Linux doesn't expect interrupts to have
> different priorities. All interrupts are equal in that respect, and
> interrupt nesting is not something we expect.
> 
> I'd be more confident if you programmed a default priority at boot time,
> and completely ignored the DT information.
The priority for us is to setup a watchdog or NMI style interrupt.
Mostly users don't need care about priority setting and just keep as
default 0. See my "PATCH V2", we can continue talk there.

> 
> > 
> > 	return 0;
> > }
> > Hmm?
> > 
> >>
> >>> +
> >>> +	switch (triger) {
> >>> +	case IRQ_TYPE_LEVEL_HIGH:
> >>> +		triger = 0;
> >>> +		break;
> >>> +	case IRQ_TYPE_LEVEL_LOW:
> >>> +		triger = 1;
> >>> +		break;
> >>> +	case IRQ_TYPE_EDGE_RISING:
> >>> +		triger = 2;
> >>> +		break;
> >>> +	case IRQ_TYPE_EDGE_FALLING:
> >>> +		triger = 3;
> >>
> >> Can you define some macros that represent these magic values?
> > OK.
> >>
> >>> +		break;
> >>> +	default:
> >>> +		triger = 0;
> >>> +		break;
> >>
> >> If you get an invalid combination, you shouldn't blindly accept it, but
> >> instead return an error.
> > OK.
> > 
> >>
> >>> +	}
> >>> +
> >>> +	if (d->hwirq < COMM_IRQ_BASE) {
> >>> +		reg_base = this_cpu_read(intcl_reg);
> >>
> >> Are you guaranteed to be in a non-preemptible section here? I can see
> >> things going wrong if not.
> > 
> > ???
> > In percpu-def.h, I see this_cpu_read is safe() for preemption or
> > interrupt.
> 
> Sorry, I wasn't clear, see below.
> 
> > What's the wrong with preemption?
> 
> The problem is that if the driver calls irq_set_type() on a per-CPU
> interrupt without preemption being disabled, it can be preempted at any
> point and migrated anywhere before the call to this_cpu_read() takes
> place. This means you can never know which CPU you've programmed.
> 
> One possible approach is to mandate these interrupts to be only changed
> in non-preemptible context, which is what the various ARM GICs do for
> their per-CPU interrupts.
Wow... Thank you for reminding! In "PATCH V2", I set them in irq_enable.
Please have a look.

> 
> > 
> >>> +
> >>> +		if (triger) {
> >>> +			offset = ((d->hwirq * 2) / 32) * 4;
> >>> +			bit_offset = (d->hwirq * 2) % 32;
> >>
> >> This needs to be turned into a set of macros so that the non-percpu code
> >> can reuse it.
> > 
> > 
> > #define IRQ_OFFSET(irq) \
> > 	((irq < COMM_IRQ_BASE) ? irq : irq - COMM_IRQ_BASE) 
> > 
> > #define TRIG_VAL(trigger, irq) \
> > 	(trigger << ((IRQ_OFFSET(irq) * 2) % 32))
> > 
> > #define TRIG_VAL_MSK(irq) \
> > 	(3 << ((IRQ_OFFSET(irq) * 2) % 32))
> > 
> > #define TRIG_BASE(irq) \
> > 	((((IRQ_OFFSET(irq) * 2) / 32) * 4) + \
> > 	((irq < COMM_IRQ_BASE) ? this_cpu_read(intcl_reg) : INTCG_base))
> > 
> > tmp = readl_relaxed(TRIG_BASE(d->hwirq)) & (~TRIG_VAL_MSK(d->hwirq));
> > writel_relaxed(tmp | TRIG_VAL(triger, d->hwirq), TRIG_BASE(d->hwirq));
> > 
> > Hmm?
> 
> I was only looking for something that abstract the offsets, such as:
> 
> #define BYTE_OFFSET(i) (((i) * 2) / 32) * 4)
> #define BIT_OFFSET(i)  ((i) * 2) % 32)
> 
> and keep the rest of the structure as is.
Ok.

Best Regards
 Guo Ren
