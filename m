Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB58EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCDE21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfA1SmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:42:05 -0500
Received: from shell.v3.sk ([90.176.6.54]:53218 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfA1SmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:42:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 617CACC982;
        Mon, 28 Jan 2019 19:42:02 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6CsePdaiVvfe; Mon, 28 Jan 2019 19:41:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3DDA1CCB85;
        Mon, 28 Jan 2019 19:41:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sVG_ujkCVM6d; Mon, 28 Jan 2019 19:41:58 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 86F48CC982;
        Mon, 28 Jan 2019 19:41:58 +0100 (CET)
Message-ID: <96bfca4e61c1e3064fa803890f416384ee19e41a.camel@v3.sk>
Subject: Re: [PATCH v5] irqchip/mmp: only touch the PJ4 & FIQ bits on
 enable/disable
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, stable@kernel.org,
        Pavel Machek <pavel@ucw.cz>
Date:   Mon, 28 Jan 2019 19:41:57 +0100
In-Reply-To: <c0d15dd0-e27b-9aaa-b6c6-1c8dcaf97f72@arm.com>
References: <20190128155935.15479-1-lkundrak@v3.sk>
         <c0d15dd0-e27b-9aaa-b6c6-1c8dcaf97f72@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 18:35 +0000, Marc Zyngier wrote:
> I guess the subject is supposed to read: "only touch the PJ4 *IRQ* & FIQ
> bits on enable/disable", right?
> 
> If that's the case, let me know, and I'll fix it up when applying it.

Yes, that would make more sense.

Thank you
Lubo

> On 28/01/2019 15:59, Lubomir Rintel wrote:
> > Resetting the bit 4 disables the interrupt delivery to the "secure
> > processor" core. This breaks the keyboard on a OLPC XO 1.75 laptop,
> > where the firmware running on the "secure processor" bit-bangs the
> > PS/2 protocol over the GPIO lines.
> > 
> > It is not clear what the rest of the bits are and Marvel was unhelpful
> > when asked for documentation. Aside from the SP bit, there are probably
> > priority bits.
> > 
> > Leaving the unknown bits as the firmware set them up seems to be a wiser
> > course of action compared to just turning them off.
> > 
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > ---
> > Changes since v4:
> > - Remove unused ICU_INT_ROUTE_SP_IRQ define
> > - Try to further clarify the commit message
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
> >  drivers/irqchip/irq-mmp.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> > index 37a54797a137..fac8f1365f76 100644
> > --- a/drivers/irqchip/irq-mmp.c
> > +++ b/drivers/irqchip/irq-mmp.c
> > @@ -34,6 +34,9 @@
> >  #define SEL_INT_PENDING		(1 << 6)
> >  #define SEL_INT_NUM_MASK	0x3f
> >  
> > +#define MMP2_ICU_INT_ROUTE_PJ4_IRQ	(1 << 5)
> > +#define MMP2_ICU_INT_ROUTE_PJ4_FIQ	(1 << 6)
> > +
> >  struct icu_chip_data {
> >  	int			nr_irqs;
> >  	unsigned int		virq_base;
> > @@ -190,7 +193,8 @@ static const struct mmp_intc_conf mmp_conf = {
> >  static const struct mmp_intc_conf mmp2_conf = {
> >  	.conf_enable	= 0x20,
> >  	.conf_disable	= 0x0,
> > -	.conf_mask	= 0x7f,
> > +	.conf_mask	= MMP2_ICU_INT_ROUTE_PJ4_IRQ |
> > +			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,
> >  };
> >  
> >  static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)
> > 
> 
> Thanks,
> 
> 	M.

