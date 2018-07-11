Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0847C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6483F2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6483F2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbeGKMUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:20:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55027 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeGKMUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:20:42 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fdE2r-0004M3-J6; Wed, 11 Jul 2018 14:16:33 +0200
Message-ID: <1531311392.3163.47.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Date:   Wed, 11 Jul 2018 14:16:32 +0200
In-Reply-To: <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
References: <cover.1531310547.git.leonard.crestez@nxp.com>
         <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
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

Am Mittwoch, den 11.07.2018, 15:11 +0300 schrieb Leonard Crestez:
> The imx6sl chip errata document describes ERR006287 like this:
> 
> > Upon resuming from power gating, the modules in the display power domain
> 
> (eLCDIF, EPDC, PXP and SPDC) might fail to perform register reads
> correctly.
> 
> > When the modules listed above are used, do not use power gating on the
> 
> display power domain.
> 
> Link: https://www.nxp.com/docs/en/errata/IMX6SLCE.pdf#page=62
> 
> Handle this in the safest possible way by keeping the DISP domain
> always-on.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Can you send a follow on patch to switch the i.MX6QP errata workaround
to use GENPD_FLAG_ALWAYS_ON and remove the -EBUSY stuff in the power
down path?

Regards,
Lucas

> ---
>  drivers/soc/imx/gpc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 526f2d02dc78..f7960f773019 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -339,30 +339,35 @@ static struct imx_pm_domain imx_gpc_domains[] = {
>  };
>  
>  struct imx_gpc_dt_data {
> >  	int num_domains;
> >  	bool err009619_present;
> > +	bool err006287_present;
>  };
>  
>  static const struct imx_gpc_dt_data imx6q_dt_data = {
> >  	.num_domains = 2,
> >  	.err009619_present = false,
> > +	.err006287_present = false,
>  };
>  
>  static const struct imx_gpc_dt_data imx6qp_dt_data = {
> >  	.num_domains = 2,
> >  	.err009619_present = true,
> > +	.err006287_present = false,
>  };
>  
>  static const struct imx_gpc_dt_data imx6sl_dt_data = {
> >  	.num_domains = 3,
> >  	.err009619_present = false,
> > +	.err006287_present = true,
>  };
>  
>  static const struct imx_gpc_dt_data imx6sx_dt_data = {
> >  	.num_domains = 4,
> >  	.err009619_present = false,
> > +	.err006287_present = false,
>  };
>  
>  static const struct of_device_id imx_gpc_dt_ids[] = {
> >  	{ .compatible = "fsl,imx6q-gpc", .data = &imx6q_dt_data },
> >  	{ .compatible = "fsl,imx6qp-gpc", .data = &imx6qp_dt_data },
> @@ -467,10 +472,15 @@ static int imx_gpc_probe(struct platform_device *pdev)
> >  	/* Disable PU power down in normal operation if ERR009619 is present */
> >  	if (of_id_data->err009619_present)
> >  		imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
> >  				PGC_DOMAIN_FLAG_NO_PD;
>  
> > +	/* Keep DISP always on if ERR006287 is present */
> > +	if (of_id_data->err006287_present)
> > +		imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
> > +				GENPD_FLAG_ALWAYS_ON;
> +
> >  	if (!pgc_node) {
> >  		ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
> >  					  of_id_data->num_domains);
> >  		if (ret)
> >  			return ret;
