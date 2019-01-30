Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ED0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29992184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbfA3NRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:17:49 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52599 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3NRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:17:49 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gopkR-00048q-Kr; Wed, 30 Jan 2019 14:17:47 +0100
Message-ID: <1548854267.6869.21.camel@pengutronix.de>
Subject: Re: [PATCH V2 1/4] dt-binding: irq: imx-irqsteer: use irq number
 instead of group number
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
Date:   Wed, 30 Jan 2019 14:17:47 +0100
In-Reply-To: <1548853196-11447-2-git-send-email-aisheng.dong@nxp.com>
References: <1548853196-11447-1-git-send-email-aisheng.dong@nxp.com>
         <1548853196-11447-2-git-send-email-aisheng.dong@nxp.com>
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

Am Mittwoch, den 30.01.2019, 13:05 +0000 schrieb Aisheng Dong:
> Not all 64 interrupts may be used in one group. e.g. most irqsteer in
> imx8qxp and imx8qm subsystems supports only 32 interrupts.
> 
> As the IP integration parameters are Channel number and interrupts number,
> let's use fsl,num-irqs to represents how many interrupts supported
> by this irqsteer channel.
> 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

As the original fsl,irq-groups was born out of a misunderstanding of
the HW config options and I'm not aware of any users of the current
binding, I'm fine with merging this. I do think this warrants a
backport to stable though, so we don't end up with different bindings
in stable and current kernels.

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>


> ---
> ChangeLog:
>  v1->v2:
>   * change property name fsl,irqs-per-chan to fsl,num-irqs.
> ---
>  .../devicetree/bindings/interrupt-controller/fsl,irqsteer.txt       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> index 45790ce..6d0a41b 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
> @@ -16,8 +16,8 @@ Required properties:
>  - #interrupt-cells: Specifies the number of cells needed to encode an
>    interrupt source. The value must be 1.
>  - fsl,channel: The output channel that all input IRQs should be steered into.
> -- fsl,irq-groups: Number of IRQ groups managed by this controller instance.
> -  Each group manages 64 input interrupts.
> +- fsl,num-irqs: Number of input interrupts of this channel.
> +  Should be multiple of 32 input interrupts and up to 512 interrupts.
>  
>  Example:
>  
> @@ -28,7 +28,7 @@ Example:
> >  		clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>;
> >  		clock-names = "ipg";
> >  		fsl,channel = <0>;
> > -		fsl,irq-groups = <1>;
> > +		fsl,num-irqs = <64>;
> >  		interrupt-controller;
> >  		#interrupt-cells = <1>;
> >  	};
