Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeCUQVH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:21:07 -0400
Received: from vern.gendns.com ([206.190.152.46]:35596 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbeCUQVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:21:04 -0400
Subject: Re: [PATCH 5/8] remoteproc: da8xx: add the missing checke for
 clk_enable()
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180321120807.18032-1-brgl@bgdev.pl>
 <20180321120807.18032-6-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <f528a120-d6e8-ff6f-243a-256ce4c392a9@lechnology.com>
Date: Wed, 21 Mar 2018 11:21:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321120807.18032-6-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2018 07:08 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The davinci platform is being switched to using the common clock
> framework, where clk_enable() can fail. Add the return value check.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/remoteproc/da8xx_remoteproc.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index bf3b9034c319..592bf0fc52e8 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
>   	struct device *dev = rproc->dev.parent;
>   	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>   	struct clk *dsp_clk = drproc->dsp_clk;
> +	int rv;

For style points, you could use ret instead of rv to be consistent with
the rest of this driver.

>   
>   	/* hw requires the start (boot) address be on 1KB boundary */
>   	if (rproc->bootaddr & 0x3ff) {
> @@ -148,7 +149,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
>   
>   	writel(rproc->bootaddr, drproc->bootreg);
>   
> -	clk_enable(dsp_clk);
> +	rv = clk_enable(dsp_clk);
> +	if (rv) {
> +		dev_err(dev, "clk_enable() failed: %d\n", rv);
> +		return rv;
> +	}
> +
>   	davinci_clk_reset_deassert(dsp_clk);
>   
>   	return 0;
> 
