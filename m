Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5826C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3ED20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391151AbfAPIy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:54:57 -0500
Received: from shell.v3.sk ([90.176.6.54]:55771 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390973AbfAPIyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:54:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9292D5262A;
        Wed, 16 Jan 2019 09:54:51 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VyRVX_8_EoMZ; Wed, 16 Jan 2019 09:54:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D4345527B1;
        Wed, 16 Jan 2019 09:54:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id A5XHpaZIudpR; Wed, 16 Jan 2019 09:54:48 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 22EF35262A;
        Wed, 16 Jan 2019 09:54:48 +0100 (CET)
Message-ID: <b26697f6fc9784b3f70dde22fc8ff6089bd13fa9.camel@v3.sk>
Subject: Re: [PATCH v4] irqchip/mmp: only touch the PJ4 & FIQ bits on
 enable/disable
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Date:   Wed, 16 Jan 2019 09:54:47 +0100
In-Reply-To: <alpine.DEB.2.21.1901151121071.1865@nanos.tec.linutronix.de>
References: <20181220215547.4813-1-lkundrak@v3.sk>
         <alpine.DEB.2.21.1901151121071.1865@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 11:22 +0100, Thomas Gleixner wrote:
> On Thu, 20 Dec 2018, Lubomir Rintel wrote:
> 
> > On an OLPC XO 1.75 machine, the "security processor" handles the GPIO 71
> > and 72 interrupts. Don't reset the "route to SP" bit (4).
> > 
> > I'm just assuming the bit 4 is the "route to SP" bit -- it fixes the
> > SP-based keyboard for me and <mach-mmp/regs-icu.h> defines
> > ICU_INT_ROUTE_SP_IRQ to be 1 << 4. When asked for a data sheet, Marvell
> > was not helpful.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> > I'm not removing the defines from regs-icu.h at the moment.
> > Of the MPP2 defines there, only MMP2_ICU_INT4_MASK ends up actually
> > being used, in one place. That said, the header servers mostly as
> > a documentation, because the documentation for the platform is lacking.
> > 
> > Changes since v3:
> > - Use #defined instead of integer literals
> > 
> > Changes since v2:
> > - Correct subsystem maintainers on Cc (irqchip)
> > 
> > Changes since v1:
> > - Adjusted wording & ack from Pavel
> > ---
> >  drivers/irqchip/irq-mmp.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> > index 25f32e1d7764..65fa5a1d8310 100644
> > --- a/drivers/irqchip/irq-mmp.c
> > +++ b/drivers/irqchip/irq-mmp.c
> > @@ -34,6 +34,10 @@
> >  #define SEL_INT_PENDING		(1 << 6)
> >  #define SEL_INT_NUM_MASK	0x3f
> >  
> > +#define MMP2_ICU_INT_ROUTE_SP_IRQ	(1 << 4)
> 
> Where is this used?

Nowhere really. I can remove it I guess.

> > +#define MMP2_ICU_INT_ROUTE_PJ4_IRQ	(1 << 5)
> > +#define MMP2_ICU_INT_ROUTE_PJ4_FIQ	(1 << 6)
> > +
> >  struct icu_chip_data {
> >  	int			nr_irqs;
> >  	unsigned int		virq_base;
> > @@ -190,7 +194,8 @@ static const struct mmp_intc_conf mmp_conf = {
> >  static const struct mmp_intc_conf mmp2_conf = {
> >  	.conf_enable	= 0x20,
> >  	.conf_disable	= 0x0,
> > -	.conf_mask	= 0x7f,
> > +	.conf_mask	= MMP2_ICU_INT_ROUTE_PJ4_IRQ |
> > +			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
> 
> So the mask changes from 0x7f to 0x60, but the changelog does not mention
> any of this. It only talks about bit 4 ....

The subject line was supposed to say that.

The point was in general not to touch the bit whose meanings are not
interesting or not known. I'll try to figure out better wording (and
I'm thankful for suggestions).

> 
> Thanks,
> 
> 	tglx

Thank you
Lubo

