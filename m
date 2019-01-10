Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A81C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A75208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfAJT4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:56:54 -0500
Received: from shell.v3.sk ([90.176.6.54]:59191 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbfAJT4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:56:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D5C461002DB;
        Thu, 10 Jan 2019 20:56:50 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tRc0oD2YMmue; Thu, 10 Jan 2019 20:56:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D2462100373;
        Thu, 10 Jan 2019 20:56:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CIjY_8aIHFQc; Thu, 10 Jan 2019 20:56:47 +0100 (CET)
Received: from belphegor (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id B73121002DB;
        Thu, 10 Jan 2019 20:56:46 +0100 (CET)
Message-ID: <9c3fdc02c8361b6d8c76a5621af0432707f6d7c2.camel@v3.sk>
Subject: Re: [PATCH v4] irqchip/mmp: only touch the PJ4 & FIQ bits on
 enable/disable
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Jan 2019 20:56:45 +0100
In-Reply-To: <20181220215547.4813-1-lkundrak@v3.sk>
References: <20181220215547.4813-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.3 (3.30.3-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-20 at 22:55 +0100, Lubomir Rintel wrote:
> On an OLPC XO 1.75 machine, the "security processor" handles the GPIO 71
> and 72 interrupts. Don't reset the "route to SP" bit (4).
> 
> I'm just assuming the bit 4 is the "route to SP" bit -- it fixes the
> SP-based keyboard for me and <mach-mmp/regs-icu.h> defines
> ICU_INT_ROUTE_SP_IRQ to be 1 << 4. When asked for a data sheet, Marvell
> was not helpful.

Marc,

I'm wondering if there's any chance this be applied and ideally
submitted for 5.0?

This fixes the keyboard on an OLPC XO 1.75 laptop, and, with the MMP
platform fixes that went into rc1 it is the last major obstacle to the
XO 1.75 machine being generally useful.

Thank you
Lubo

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
>  };
>  
>  static void __exception_irq_entry mmp_handle_irq(struct pt_regs *regs)

