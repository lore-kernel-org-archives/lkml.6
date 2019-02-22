Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05910C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29832077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfBVI5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:57:23 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56040 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfBVI5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:57:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85C4280D;
        Fri, 22 Feb 2019 00:57:21 -0800 (PST)
Received: from why.wild-wind.fr.eu.org (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5A3E3F703;
        Fri, 22 Feb 2019 00:57:17 -0800 (PST)
Date:   Fri, 22 Feb 2019 08:57:13 +0000
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, lee.jones@linaro.org,
        linus.walleij@linaro.org, tglx@linutronix.de, shawnguo@kernel.org,
        dianders@chromium.org, linux-gpio@vger.kernel.org,
        nicolas.dechesne@linaro.org, niklas.cassel@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/11] mfd: pm8xxx: disassociate old virq if hwirq
 mapping already exists
Message-ID: <20190222085713.16f7822d@why.wild-wind.fr.eu.org>
In-Reply-To: <155077482380.77512.11109337732610217265@swboyd.mtv.corp.google.com>
References: <20190208021631.30252-1-masneyb@onstation.org>
        <20190208021631.30252-6-masneyb@onstation.org>
        <155020988635.115909.8353948296231202388@swboyd.mtv.corp.google.com>
        <20190215134733.GA21208@basecamp>
        <155026608236.115909.9007817366859489104@swboyd.mtv.corp.google.com>
        <20190216002359.GA24752@basecamp>
        <155077482380.77512.11109337732610217265@swboyd.mtv.corp.google.com>
Organization: ARM Ltd
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 10:47:03 -0800
Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Brian Masney (2019-02-15 16:23:59)
> > On Fri, Feb 15, 2019 at 01:28:02PM -0800, Stephen Boyd wrote:  
> > > Quoting Brian Masney (2019-02-15 05:47:33)  
> > > > On Thu, Feb 14, 2019 at 09:51:26PM -0800, Stephen Boyd wrote:  
> > > > > > diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
> > > > > > index 8eb2528793f9..2f99a98ccee5 100644
> > > > > > --- a/drivers/mfd/qcom-pm8xxx.c
> > > > > > +++ b/drivers/mfd/qcom-pm8xxx.c
> > > > > > @@ -380,6 +380,12 @@ static void pm8xxx_irq_domain_map(struct pm_irq_chip *chip,
> > > > > >                                   struct irq_domain *domain, unsigned int irq,
> > > > > >                                   irq_hw_number_t hwirq, unsigned int type)
> > > > > >  {
> > > > > > +       unsigned int old_virq;
> > > > > > +
> > > > > > +       old_virq = irq_find_mapping(domain, hwirq);
> > > > > > +       if (old_virq)
> > > > > > +               irq_domain_disassociate(domain, old_virq);  
> > > > > 
> > > > > Is it possible to pass 'true' for the 'realloc' argument to
> > > > > __irq_domain_alloc_irqs() and then this disassociate change isn't
> > > > > needed?  
> > > > 
> > > > The kernel doc for __irq_domain_alloc_irqs() says that the realloc
> > > > parameter is mainly to support legacy IRQs. I don't think its a good
> > > > idea to add new code that'll stay past the end of this patch series
> > > > on top of that legacy interface.
> > > >   
> > > 
> > > Ok. The other side of the argument is that this is the only user of
> > > irq_domain_disassociate(), which may also be some sort of legacy
> > > interface that isn't supposed to be used. Looking at the commit that
> > > exposed it, it seems to be that it's there for legacy reasons.
> > > 
> > > commit 43a775916d63d1c822107b39987192ca5ced445c
> > > Author: Jiang Liu <jiang.liu@linux.intel.com>
> > > Date:   Mon Jun 9 16:20:05 2014 +0800
> > > 
> > >     genirq: Export irq_domain_disassociate() to architecture interrupt drivers
> > >     
> > >     Export irq_domain_disassociate() to architecture interrupt drivers,
> > >     so it could be used to handle legacy IRQ descriptors on x86.
> > > 
> > > So maybe we should just use the realloc argument and bury the
> > > disassociate API in irqdomain.c because it's not supposed to be used?
> > > Or does the realloc path not work for some reason?  
> > 
> > I haven't tried the realloc path yet. Let's back up further so that we
> > are both starting with the same assumptions. Do you want to keep either
> > your proposed change (realloc argument) or the existing
> > irq_domain_disassociate change in mainline past the end of this patch
> > series? If it is going to continue to be a temporary shim that will be
> > reverted at the end of the patch series (like I did here), then I don't
> > see the point in this extra work since this patch is only here to keep
> > it bisectable and works. We're not using any legacy interfaces by the
> > end of this patch series.  
> 
> The main concern I have is that we're changing the binding to avoid a
> larger discussion we could have about whether or not the binding is
> wrong to list out the hierarchical irqs as part of an 'interrupts'
> property. We have one case where hardware irq numbers are remapped to
> other hardware irq number spaces and it seems perfectly valid to use the
> 'interrupts' property to indicate this, i.e. chained interrupt
> controllers.
> 
> Those controllers typically have a single 'interrupts' specifier for the
> chained irq of the parent interrupt controller, but when it comes to
> hierarchical interrupts we seem to have various different ways of
> expressing the mapping from one number space to another. I've seen
> approaches varying between hardcoding everything in the kernel to
> hardcoding everything in DT.
> 
> I'm mostly wondering if having an interrupts property listing all the
> parent interrupts in corresponding specifier slots for the interrupt
> controller's hardware irq space is wrong. It seems to describe the
> mapping between the two number spaces already, so maybe it would make
> sense to use the realloc argument and keep listing them as interrupts in
> DT. Obviously things are already moving forward with the new DT binding,
> so maybe I just need to be told that having an interrupts property there
> is wrong. If it is wrong, then nothing needs to be kept around and the
> binding can easily be changed.

The issue I've had in the past about the use of 'proper' interrupt
specifiers in DT for stuff that is represented as a hierarchy comes
mainly from the way Linux deals with those (unsurprisingly).

The DT parsing code will create a Linux interrupt each time it probes
an device that has these descriptors. That's all fine, except that for
a hierarchy, these output lines are not independent IRQs. We end-up
with double the interrupt descriptors at each level of the hierarchy,
which is both a waste of memory and a pain to debug. It also creates
all kind of bad problems as the interrupt is now registered in the
irqdomain, and I think this is what this patch is trying to work around.

Short of being able to tell the DT parser "don't map interrupts for this
device", we have two options: undo the mess when mapping a hierarchy,
or sidestep the issue altogether, which is what I've recommended in the
past (though Rob did disagree with me on that, and he has good
arguments too).

To be honest, I'd like to make progress on that too, if only to put
something in core code so that individual drivers don't have to play
that kind of game.

Thanks,

	M.
-- 
Without deviation from the norm, progress is not possible.
