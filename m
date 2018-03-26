Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeCZVVA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:21:00 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:24248 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeCZVUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:20:54 -0400
Subject: Re: [PATCH v4 6/8] remoteproc: da8xx: prepare and unprepare the clock
 where needed
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180323130455.11470-1-brgl@bgdev.pl>
 <20180323130455.11470-7-brgl@bgdev.pl>
From: Suman Anna <s-anna@ti.com>
Message-ID: <07c2258c-b4ca-5dd6-0a9b-47c5a3fac826@ti.com>
Date: Mon, 26 Mar 2018 16:19:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323130455.11470-7-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 08:04 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We're currently switching the platform to using the common clock
> framework. We need to explicitly prepare and unprepare the rproc
> clock.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

FWIW, I have been able to use this patch even without the CCF adaptation
as clk_prepare()/clk_unprepare() are stubs returning 0, and the
effective code would be same as before. Prefer "remoteproc/davinci: ..."
on the patch subject as was being done previously.

With that,
Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index 2b24291337b7..f134192922e0 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -149,9 +149,9 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  
>  	writel(rproc->bootaddr, drproc->bootreg);
>  
> -	ret = clk_enable(dsp_clk);
> +	ret = clk_prepare_enable(dsp_clk);
>  	if (ret) {
> -		dev_err(dev, "clk_enable() failed: %d\n", ret);
> +		dev_err(dev, "clk_prepare_enable() failed: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -165,7 +165,7 @@ static int da8xx_rproc_stop(struct rproc *rproc)
>  	struct da8xx_rproc *drproc = rproc->priv;
>  
>  	davinci_clk_reset_assert(drproc->dsp_clk);
> -	clk_disable(drproc->dsp_clk);
> +	clk_disable_unprepare(drproc->dsp_clk);
>  
>  	return 0;
>  }
> 
