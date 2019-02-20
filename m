Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E8DC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D621F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfBTIWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:22:46 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52441 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBTIWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:22:45 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gwN9N-00069q-IH; Wed, 20 Feb 2019 09:22:42 +0100
Message-ID: <00169906c8509779a89dcd611098fbaea14bc7d8.camel@pengutronix.de>
Subject: Re: [PATCH] soc: imx: gpcv2: Make use of regmap_read_poll_timeout()
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Chris Healy <cphealy@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Feb 2019 09:22:39 +0100
In-Reply-To: <20190220021429.4910-1-andrew.smirnov@gmail.com>
References: <20190220021429.4910-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 19.02.2019, 18:14 -0800 schrieb Andrey Smirnov:
> Replace explicit polling loop with a call to
> regmap_read_poll_timeout() to avoid code repetition. Also fix
> misspelled "failed" while at it.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/soc/imx/gpcv2.c | 39 ++++++++++++++-------------------------
>  1 file changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 176f473127b6..e06bf12a1e4b 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -136,8 +136,8 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>  		GPC_PU_PGC_SW_PUP_REQ : GPC_PU_PGC_SW_PDN_REQ;
>  	const bool enable_power_control = !on;
>  	const bool has_regulator = !IS_ERR(domain->regulator);
> -	unsigned long deadline;
>  	int i, ret = 0;
> +	u32 pxx_req;
>  
>  	regmap_update_bits(domain->regmap, GPC_PGC_CPU_MAPPING,
>  			   domain->bits.map, domain->bits.map);
> @@ -169,30 +169,19 @@ static int imx_gpc_pu_pgc_sw_pxx_req(struct generic_pm_domain *genpd,
>  	 * As per "5.5.9.4 Example Code 4" in IMX7DRM.pdf wait
>  	 * for PUP_REQ/PDN_REQ bit to be cleared
>  	 */
> -	deadline = jiffies + msecs_to_jiffies(1);
> -	while (true) {
> -		u32 pxx_req;
> -
> -		regmap_read(domain->regmap, offset, &pxx_req);
> -
> -		if (!(pxx_req & domain->bits.pxx))
> -			break;
> -
> -		if (time_after(jiffies, deadline)) {
> -			dev_err(domain->dev, "falied to command PGC\n");
> -			ret = -ETIMEDOUT;
> -			/*
> -			 * If we were in a process of enabling a
> -			 * domain and failed we might as well disable
> -			 * the regulator we just enabled. And if it
> -			 * was the opposite situation and we failed to
> -			 * power down -- keep the regulator on
> -			 */
> -			on = !on;
> -			break;
> -		}
> -
> -		cpu_relax();
> +	ret = regmap_read_poll_timeout(domain->regmap, offset, pxx_req,
> +				       !(pxx_req & domain->bits.pxx),
> +				       0, USEC_PER_MSEC);
> +	if (ret) {
> +		dev_err(domain->dev, "failed to command PGC\n");
> +		/*
> +		 * If we were in a process of enabling a
> +		 * domain and failed we might as well disable
> +		 * the regulator we just enabled. And if it
> +		 * was the opposite situation and we failed to
> +		 * power down -- keep the regulator on
> +		 */
> +		on = !on;
>  	}
>  
>  	if (enable_power_control)

