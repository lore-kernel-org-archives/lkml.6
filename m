Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7890CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C6620656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfAOKWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:22:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41941 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfAOKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:22:42 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gjLrh-0002dt-CR; Tue, 15 Jan 2019 11:22:37 +0100
Date:   Tue, 15 Jan 2019 11:22:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Lubomir Rintel <lkundrak@v3.sk>
cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] irqchip/mmp: only touch the PJ4 & FIQ bits on
 enable/disable
In-Reply-To: <20181220215547.4813-1-lkundrak@v3.sk>
Message-ID: <alpine.DEB.2.21.1901151121071.1865@nanos.tec.linutronix.de>
References: <20181220215547.4813-1-lkundrak@v3.sk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018, Lubomir Rintel wrote:

> On an OLPC XO 1.75 machine, the "security processor" handles the GPIO 71
> and 72 interrupts. Don't reset the "route to SP" bit (4).
> 
> I'm just assuming the bit 4 is the "route to SP" bit -- it fixes the
> SP-based keyboard for me and <mach-mmp/regs-icu.h> defines
> ICU_INT_ROUTE_SP_IRQ to be 1 << 4. When asked for a data sheet, Marvell
> was not helpful.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> I'm not removing the defines from regs-icu.h at the moment.
> Of the MPP2 defines there, only MMP2_ICU_INT4_MASK ends up actually
> being used, in one place. That said, the header servers mostly as
> a documentation, because the documentation for the platform is lacking.
> 
> Changes since v3:
> - Use #defined instead of integer literals
> 
> Changes since v2:
> - Correct subsystem maintainers on Cc (irqchip)
> 
> Changes since v1:
> - Adjusted wording & ack from Pavel
> ---
>  drivers/irqchip/irq-mmp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> index 25f32e1d7764..65fa5a1d8310 100644
> --- a/drivers/irqchip/irq-mmp.c
> +++ b/drivers/irqchip/irq-mmp.c
> @@ -34,6 +34,10 @@
>  #define SEL_INT_PENDING		(1 << 6)
>  #define SEL_INT_NUM_MASK	0x3f
>  
> +#define MMP2_ICU_INT_ROUTE_SP_IRQ	(1 << 4)

Where is this used?

> +#define MMP2_ICU_INT_ROUTE_PJ4_IRQ	(1 << 5)
> +#define MMP2_ICU_INT_ROUTE_PJ4_FIQ	(1 << 6)
> +
>  struct icu_chip_data {
>  	int			nr_irqs;
>  	unsigned int		virq_base;
> @@ -190,7 +194,8 @@ static const struct mmp_intc_conf mmp_conf = {
>  static const struct mmp_intc_conf mmp2_conf = {
>  	.conf_enable	= 0x20,
>  	.conf_disable	= 0x0,
> -	.conf_mask	= 0x7f,
> +	.conf_mask	= MMP2_ICU_INT_ROUTE_PJ4_IRQ |
> +			  MMP2_ICU_INT_ROUTE_PJ4_FIQ,

So the mask changes from 0x7f to 0x60, but the changelog does not mention
any of this. It only talks about bit 4 ....

Thanks,

	tglx
