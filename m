Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C05C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D6220855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfARIsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:48:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37213 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfARIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:48:13 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gkPoy-0007kL-2d; Fri, 18 Jan 2019 09:48:12 +0100
Message-ID: <1547801291.2626.3.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] dt-binding: irq: imx-irqsteer: use irq number per
 channel instead of group number
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>
Date:   Fri, 18 Jan 2019 09:48:11 +0100
In-Reply-To: <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
References: <1547797668-30342-1-git-send-email-aisheng.dong@nxp.com>
         <1547797668-30342-2-git-send-email-aisheng.dong@nxp.com>
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

Am Freitag, den 18.01.2019, 07:53 +0000 schrieb Aisheng Dong:
> Not all 64 interrupts may be used in one group. e.g. most irqsteer in
> imx8qxp and imx8qm subsystems supports only 32 interrupts.
> 
> As the IP integration parameters are Channel number and interrupts number,
> let's use fsl,irqs-per-chan to represents how many interrupts supported
> by this irqsteer channel.

Sorry, but total NACK. I've got to great lengths with dumping the
actually implemented register layout on i.MX8M and AFAICS the IRQs are
always managed in groups of 64 IRQs, even if less than that are
connected as input IRQs. This is what the actually present register set
on i.MX8M tells us.

Regards,
Lucas

> Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> index 45790ce..eaabcda 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> @@ -16,8 +16,8 @@ Required properties:
>  - #interrupt-cells: Specifies the number of cells needed to encode an
>    interrupt source. The value must be 1.
>  - fsl,channel: The output channel that all input IRQs should be steered into.
> -- fsl,irq-groups: Number of IRQ groups managed by this controller instance.
> -  Each group manages 64 input interrupts.
> +- fsl,irqs-per-chan: Number of input interrupts per channel. Should be multiple of 32
> +  input interrupts and up to 512 interrupts.
>  
>  Example:
>  
> @@ -28,7 +28,7 @@ Example:
> >  		clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> >  		clock-names = "ipg";
> >  		fsl,channel = <0>;
> > -		fsl,irq-groups = <1>;
> > +		fsl,irqs-per-chan= <64>;
> >  		interrupt-controller;
> >  		#interrupt-cells = <1>;
> >  	};
