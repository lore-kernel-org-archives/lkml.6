Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A76C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0F7217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 18:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbeLSSiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 13:38:01 -0500
Received: from shell.v3.sk ([90.176.6.54]:51268 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727694AbeLSSiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 13:38:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 98DAB68BAD;
        Wed, 19 Dec 2018 19:37:58 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mNC7j0Wbdafd; Wed, 19 Dec 2018 19:37:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 549F768BD7;
        Wed, 19 Dec 2018 19:37:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Sj_mKgAFoNGx; Wed, 19 Dec 2018 19:37:54 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 940A868BAD;
        Wed, 19 Dec 2018 19:37:54 +0100 (CET)
Message-ID: <10639e018803dd2b7efa0a99ca78df1a533fdb4c.camel@v3.sk>
Subject: Re: [PATCH v3] irqchip/mmp: only touch the PJ4 & FIQ bits on
 enable/disable
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
Date:   Wed, 19 Dec 2018 19:37:53 +0100
In-Reply-To: <fc85f7e6-fc78-9e7c-258e-a0a60d195686@arm.com>
References: <20181219172822.18349-1-lkundrak@v3.sk>
         <fc85f7e6-fc78-9e7c-258e-a0a60d195686@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 18:29 +0000, Marc Zyngier wrote:
> On 19/12/2018 17:28, Lubomir Rintel wrote:
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
> > Changes since v2:
> > - Correct subsystem maintainers on Cc (irqchip)
> > 
> > Changes since v1:
> > - Adjusted wording & ack from Pavel
> > 
> >  drivers/irqchip/irq-mmp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> > index 25f32e1d7764..1ed38f9f1d0a 100644
> > --- a/drivers/irqchip/irq-mmp.c
> > +++ b/drivers/irqchip/irq-mmp.c
> > @@ -190,7 +190,7 @@ static const struct mmp_intc_conf mmp_conf = {
> >  static const struct mmp_intc_conf mmp2_conf = {
> >  	.conf_enable	= 0x20,
> >  	.conf_disable	= 0x0,
> > -	.conf_mask	= 0x7f,
> > +	.conf_mask	= 0x60,
> 
> You seem to have identified that ICU_INT_ROUTE_PJ4_IRQ and
> ICU_INT_ROUTE_PJ4_FIQ bits are the only ones to be touched. So why don't
> you use these constants? This number soup is quite unhealthy.

Yeah, but those #defines live in mach-mmp, so some moving would be
necessary. If you indeed prefer that then I can follow up with a patch
that does that.

> It'd be good to Cc some of the folks who initially wrote this code
> (Haojian Zhuang, Eric Miao -- assuming they are still around) and get
> some testing on a non OLPC platform, just to make sure there is no
> regression due to this. I have the nagging feeling that this could be a
> platform specific thing rather than a universal setting.

They've been Cc'd on previous spins of the patch (and tens of other
mmp-related patches that were in circulation lately), but they never
returned a response. It is safe to assume they're AWOL.

> 
> Thanks,
> 
> 	M.

Thanks
Lubo

