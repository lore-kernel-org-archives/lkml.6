Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE1C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF57208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF57208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeFTIkl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:40:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47013 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932699AbeFTIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:40:37 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fVYIG-0001YH-W9; Wed, 20 Jun 2018 10:16:44 +0200
Message-ID: <1529482602.7211.32.camel@pengutronix.de>
Subject: Re: [PATCH v3 2/3] pinctrl: imx: allow to configure SION with
 generic pinconf
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>
Date:   Wed, 20 Jun 2018 10:16:42 +0200
In-Reply-To: <1529479463-26961-3-git-send-email-abel.vesa@nxp.com>
References: <1529479463-26961-1-git-send-email-abel.vesa@nxp.com>
         <1529479463-26961-3-git-send-email-abel.vesa@nxp.com>
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

Hi Abel,

as this series switches back to using the raw padcfg values in DT
instead of generic pinconf (which I think is the right move), we can
drop this patch from the series.

Regards,
Lucas

Am Mittwoch, den 20.06.2018, 10:24 +0300 schrieb Abel Vesa:
> > From: Lucas Stach <l.stach@pengutronix.de>
> 
> The SION bit force enables the input buffer, overriding the configuration
> driven by the muxed module. It is not located in the pad config register,
> but in the mux register and thus needs special handling.
> 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  drivers/pinctrl/freescale/pinctrl-imx.c | 19 +++++++------------
>  drivers/pinctrl/freescale/pinctrl-imx.h |  4 ++++
>  2 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 1c6bb15..335edc9 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -26,10 +26,6 @@
>  #include "../pinmux.h"
>  #include "pinctrl-imx.h"
>  
> -/* The bits in CONFIG cell defined in binding doc*/
> > > -#define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
> > -#define IMX_PAD_SION 0x40000000		/* set SION */
> -
>  static inline const struct group_desc *imx_pinctrl_find_group_by_name(
> >  				struct pinctrl_dev *pctldev,
> >  				const char *name)
> @@ -514,18 +510,17 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
> >  		pin->mux_mode = be32_to_cpu(*list++);
> >  		pin->input_val = be32_to_cpu(*list++);
>  
> > -		if (info->generic_pinconf) {
> > +		if (info->generic_pinconf)
> >  			/* generic pin config decoded */
> >  			pin->config = config;
> > -		} else {
> > +		else
> >  			/* legacy pin config read from devicetree */
> > -			config = be32_to_cpu(*list++);
> > +			pin->config = be32_to_cpu(*list++);
>  
> > -			/* SION bit is in mux register */
> > -			if (config & IMX_PAD_SION)
> > -				pin->mux_mode |= IOMUXC_CONFIG_SION;
> > -			pin->config = config & ~IMX_PAD_SION;
> > -		}
> > +		/* SION bit is in mux register */
> > +		if (pin->config & IMX_PAD_SION)
> > +			pin->mux_mode |= IOMUXC_CONFIG_SION;
> > +		pin->config = pin->config & ~IMX_PAD_SION;
>  
> >  		dev_dbg(ipctl->dev, "%s: 0x%x 0x%08lx", info->pins[pin_id].name,
> >  				pin->mux_mode, pin->config);
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
> index 4b8225c..44567a6 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.h
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.h
> @@ -14,6 +14,10 @@
>  #include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/pinctrl/pinmux.h>
>  
> +/* The bits in CONFIG cell defined in binding doc*/
> > > +#define IMX_NO_PAD_CTL	0x80000000	/* no pin config need */
> > +#define IMX_PAD_SION 0x40000000		/* set SION */
> +
>  struct platform_device;
>  
>  extern struct pinmux_ops imx_pmx_ops;
