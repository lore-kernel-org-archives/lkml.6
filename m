Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbeEWJCU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:02:20 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:51502 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932096AbeEWJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:02:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Wed, 23 May 2018 11:02:14 +0200
From: Stefan Agner <stefan@agner.ch>
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?=
        <sebastien.szymanski@armadeus.com>
Cc: linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
In-Reply-To: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
Message-ID: <19d8d6b10d09a7794d9d4bf401cf4b51@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-3.08 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.98)[99.93%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.05.2018 08:28, Sébastien Szymanski wrote:
> Check the max speed supported from the fuses for i.MX6ULL and update the
> operating points table accordingly.
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>

Tested with a 528MHz and 792MHz rated i.MX 6ULL, looks good!

Tested-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
> 
> Changes for v3:
>  - none
> 
> Changes for v2:
>  - none
> 
>  drivers/cpufreq/imx6q-cpufreq.c | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> index 83cf631fc9bc..f094687cae52 100644
> --- a/drivers/cpufreq/imx6q-cpufreq.c
> +++ b/drivers/cpufreq/imx6q-cpufreq.c
> @@ -266,6 +266,8 @@ static void imx6q_opp_check_speed_grading(struct
> device *dev)
>  }
>  
>  #define OCOTP_CFG3_6UL_SPEED_696MHZ	0x2
> +#define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
> +#define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
>  
>  static void imx6ul_opp_check_speed_grading(struct device *dev)
>  {
> @@ -287,16 +289,30 @@ static void
> imx6ul_opp_check_speed_grading(struct device *dev)
>  	 * Speed GRADING[1:0] defines the max speed of ARM:
>  	 * 2b'00: Reserved;
>  	 * 2b'01: 528000000Hz;
> -	 * 2b'10: 696000000Hz;
> -	 * 2b'11: Reserved;
> +	 * 2b'10: 696000000Hz on i.MX6UL, 792000000Hz on i.MX6ULL;
> +	 * 2b'11: 900000000Hz on i.MX6ULL only;
>  	 * We need to set the max speed of ARM according to fuse map.
>  	 */
>  	val = readl_relaxed(base + OCOTP_CFG3);
>  	val >>= OCOTP_CFG3_SPEED_SHIFT;
>  	val &= 0x3;
> -	if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
> -		if (dev_pm_opp_disable(dev, 696000000))
> -			dev_warn(dev, "failed to disable 696MHz OPP\n");
> +
> +	if (of_machine_is_compatible("fsl,imx6ul")) {
> +		if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
> +			if (dev_pm_opp_disable(dev, 696000000))
> +				dev_warn(dev, "failed to disable 696MHz OPP\n");
> +	}
> +
> +	if (of_machine_is_compatible("fsl,imx6ull")) {
> +		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
> +			if (dev_pm_opp_disable(dev, 792000000))
> +				dev_warn(dev, "failed to disable 792MHz OPP\n");
> +
> +		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
> +			if (dev_pm_opp_disable(dev, 900000000))
> +				dev_warn(dev, "failed to disable 900MHz OPP\n");
> +	}
> +
>  	iounmap(base);
>  put_node:
>  	of_node_put(np);
> @@ -356,7 +372,8 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
>  		goto put_reg;
>  	}
>  
> -	if (of_machine_is_compatible("fsl,imx6ul"))
> +	if (of_machine_is_compatible("fsl,imx6ul") ||
> +	    of_machine_is_compatible("fsl,imx6ull"))
>  		imx6ul_opp_check_speed_grading(cpu_dev);
>  	else
>  		imx6q_opp_check_speed_grading(cpu_dev);
