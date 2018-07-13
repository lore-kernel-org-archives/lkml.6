Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BD2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8D820870
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8D820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeGMKnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:43:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40395 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbeGMKni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:43:38 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fdvKK-0005Ti-Ko; Fri, 13 Jul 2018 12:29:28 +0200
Message-ID: <1531477766.3163.80.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx6qp: Use GENPD_FLAG_ALWAYS_ON for PU errata
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Date:   Fri, 13 Jul 2018 12:29:26 +0200
In-Reply-To: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
References: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
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

Am Freitag, den 13.07.2018, 13:01 +0300 schrieb Leonard Crestez:
> This is functionally identical but simpler and slightly faster.
> 
> The PU domain is turned on at boot time and never turned off. In the
> current implementation the pm core will repeatedly call power_off when
> the domain is unused and get -EBUSY back. If the domain is marked as
> "always on" instead the pm core won't even attempt to turn it off.
> 
> In theory on 6qp it is safe to turn PU off in suspend, however that is
> best accomplished with a new core flag.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/soc/imx/gpc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> Previous discussion:
> * https://lkml.org/lkml/2018/7/11/431
> * https://lkml.org/lkml/2018/7/10/103
> 
> Attempt at turning PU off in suspend:
> * https://lkml.org/lkml/2018/7/6/698
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index faf13a0b85d6..f31978e5af20 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -45,11 +45,10 @@ struct imx_pm_domain {
> >  	struct clk *clk[GPC_CLK_MAX];
> >  	int num_clks;
> >  	unsigned int reg_offs;
> >  	signed char cntr_pdn_bit;
> >  	unsigned int ipg_rate_mhz;
> > -	unsigned int flags;
>  };
>  
>  static inline struct imx_pm_domain *
>  to_imx_pm_domain(struct generic_pm_domain *genpd)
>  {
> @@ -60,13 +59,10 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
>  {
> >  	struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
> >  	int iso, iso2sw;
> >  	u32 val;
>  
> > -	if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
> > -		return -EBUSY;
> -
> >  	/* Read ISO and ISO2SW power down delays */
> >  	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
> >  	iso = val & 0x3f;
> >  	iso2sw = (val >> 8) & 0x3f;
>  
> @@ -419,12 +415,12 @@ static int imx_gpc_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
>  
> >  	/* Disable PU power down in normal operation if ERR009619 is present */
> >  	if (of_id_data->err009619_present)
> > -		imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
> > -				PGC_DOMAIN_FLAG_NO_PD;
> > +		imx_gpc_domains[GPC_PGC_DOMAIN_PU].base.flags |=
> > +				GENPD_FLAG_ALWAYS_ON;
>  
> >  	/* Keep DISP always on if ERR006287 is present */
> >  	if (of_id_data->err006287_present)
> >  		imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
> >  				GENPD_FLAG_ALWAYS_ON;
