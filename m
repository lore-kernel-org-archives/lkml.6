Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB52C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92E5218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfA3OLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:11:31 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45549 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfA3OLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:11:31 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1goqaO-0002Hf-7t; Wed, 30 Jan 2019 15:11:28 +0100
Message-ID: <1548857486.6869.31.camel@pengutronix.de>
Subject: Re: [PATCH V2 4/4] irq: imx: irqsteer: add multi output interrupts
 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Dong Aisheng <dongas86@gmail.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Wed, 30 Jan 2019 15:11:26 +0100
In-Reply-To: <CAA+hA=Q79RcUk=epBighR_jZCLxaNzRvc9Lukzrzby_Av6d9wQ@mail.gmail.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
         <1548853196-11447-5-git-send-email-aisheng.dong@nxp.com>
         <1548855138.6869.27.camel@pengutronix.de>
         <CAA+hA=Q79RcUk=epBighR_jZCLxaNzRvc9Lukzrzby_Av6d9wQ@mail.gmail.com>
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

Am Mittwoch, den 30.01.2019, 22:03 +0800 schrieb Dong Aisheng:
> > On Wed, Jan 30, 2019 at 9:33 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > Am Mittwoch, den 30.01.2019, 13:06 +0000 schrieb Aisheng Dong:
> > > One irqsteer channel can support up to 8 output interrupts.
> > > 
> > > > > > > > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > > > > > > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > > > > > > Cc: Shawn Guo <shawnguo@kernel.org>
> > > > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > > 
> > > ---
> > > ChangeLog:
> > > v1->v2:
> > >  * calculate irq_count by fsl,num-irqs instead of parsing interrupts
> > >    property from devicetree to match the input interrupts and outputs
> > >  * improve output interrupt handler by searching only two registers
> > >    withint the same group
> > > ---
> > >  drivers/irqchip/irq-imx-irqsteer.c | 76 +++++++++++++++++++++++++++++---------
> > >  1 file changed, 59 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> > > index 67ed862..cc40039 100644
> > > --- a/drivers/irqchip/irq-imx-irqsteer.c
> > > +++ b/drivers/irqchip/irq-imx-irqsteer.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/irqchip/chained_irq.h>
> > >  #include <linux/irqdomain.h>
> > >  #include <linux/kernel.h>
> > > +#include <linux/of_irq.h>
> > >  #include <linux/of_platform.h>
> > >  #include <linux/spinlock.h>
> > > 
> > > @@ -21,10 +22,13 @@
> > > >  #define CHAN_MINTDIS(t)            (CTRL_STRIDE_OFF(t, 3) + 0x4)
> > > >  #define CHAN_MASTRSTAT(t)  (CTRL_STRIDE_OFF(t, 3) + 0x8)
> > > > +#define CHAN_MAX_OUTPUT_INT        0x8
> > > 
> > > +
> > >  struct irqsteer_data {
> > > > >   void __iomem            *regs;
> > > > >   struct clk              *ipg_clk;
> > > > > - int                     irq;
> > > > > + int                     irq[CHAN_MAX_OUTPUT_INT];
> > > > > + int                     irq_count;
> > > > >   raw_spinlock_t          lock;
> > > > >   int                     reg_num;
> > > > >   int                     channel;
> > > 
> > > @@ -87,26 +91,45 @@ static const struct irq_domain_ops imx_irqsteer_domain_ops = {
> > > > >   .xlate          = irq_domain_xlate_onecell,
> > > 
> > >  };
> > > 
> > > +static int imx_irqsteer_get_hwirq_base(struct irqsteer_data *data, u32 irq)
> > > +{
> > > > +   int i;
> > > 
> > > +
> > > > +   for (i = 0; i < data->irq_count; i++) {
> > > > +           if (data->irq[i] == irq)
> > > 
> > > +                     break;
> > 
> > return i * 64; here...
> > > +     }
> > > +
> > > +     return i * 64;
> > 
> > ... and -EINVAL or something here, so we don't return a out of bounds
> > hwirq base if the loop ever doesn't match something?
> > 
> 
> Good suggestion, will add it.
> 
> > > +}
> > > +
> > >  static void imx_irqsteer_irq_handler(struct irq_desc *desc)
> > >  {
> > > >     struct irqsteer_data *data = irq_desc_get_handler_data(desc);
> > > > +   int hwirq;
> > > >     int i;
> > > >     chained_irq_enter(irq_desc_get_chip(desc), desc);
> > > > -   for (i = 0; i < data->reg_num * 32; i += 32) {
> > > > -           int idx = imx_irqsteer_get_reg_index(data, i);
> > > > +   hwirq = imx_irqsteer_get_hwirq_base(data, irq_desc_get_irq(desc));
> > > 
> > > +
> > > > +   for (i = 0; i < 2; i++) {
> > > > +           int idx = imx_irqsteer_get_reg_index(data, hwirq);
> > > >             unsigned long irqmap;
> > > >             int pos, virq;
> > > > +           if (hwirq >= data->reg_num * 32)
> > > > +                   break;
> > > 
> > > +
> > > >             irqmap = readl_relaxed(data->regs +
> > > >                                    CHANSTATUS(idx, data->reg_num));
> > > >             for_each_set_bit(pos, &irqmap, 32) {
> > > > -                   virq = irq_find_mapping(data->domain, pos + i);
> > > 
> > > +                     virq = irq_find_mapping(data->domain, pos + hwirq);
> > 
> > The irq index calculation need to be "pos + i * 32 + hwirq", otherwise
> > this will map to the wrong virqs for the second register in each group.
> > 
> 
> For second register map, hwirq will plus 32 in next round.
> So i can't see this will map a wrong virqs.
> And it looks to me ""pos + i * 32 + hwirq" is equal to "hwirq + 32".
> Am i missed something?

You are right, I forgot about the hwirq being incremented in the loop
when writing this comment.

> > >                       if (virq)
> > > >                             generic_handle_irq(virq);
> > > >             }
> > > 
> > > +             hwirq += 32;
> > 
> > Could be folded into the loop head.
> > 
> 
> You mean “for (i = 0; i < 2; i++, hwirq +=32)” ?
> I feel that's not quite necessary.

I personally find that quite a bit clearer than incrementing the loop
variables at different spots. And I probably wouldn't have missed hwirq
being incremented in the loop if I had seen it in the head.

Regards,
Lucas
