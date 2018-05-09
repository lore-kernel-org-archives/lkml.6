Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965409AbeEIVbs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 17:31:48 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36645 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964953AbeEIVbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 17:31:46 -0400
X-Google-Smtp-Source: AB8JxZpny2kXR0GHzXV/862aSj7cnUMeDJH5i+oTdyfxOusytf7zmS7PvJ+wYgoxosDoHLz9lwsX1g==
Date: Wed, 9 May 2018 14:31:43 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Sekhar Nori <nsekhar@ti.com>,
        David Lechner <david@lechnology.com>, Suman Anna <s-anna@ti.com>,
        Aparna Balasubramanian <aparnab@ti.com>,
        Kevin Hilman <khilman@kernel.org>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/3] remoteproc/davinci: add the missing retval check for
 clk_enable()
Message-ID: <20180509213143.GA29093@builder>
References: <20180502095659.3626-1-brgl@bgdev.pl>
 <20180502095659.3626-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502095659.3626-2-brgl@bgdev.pl>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 02 May 02:56 PDT 2018, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The davinci platform is being switched to using the common clock
> framework, where clk_enable() can fail. Add the return value check.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Suman Anna <s-anna@ti.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Hi Bartosz,

All three patches applied to rproc-next.

Regards,
Bjorn

> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index bf3b9034c319..2b24291337b7 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  	struct device *dev = rproc->dev.parent;
>  	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>  	struct clk *dsp_clk = drproc->dsp_clk;
> +	int ret;
>  
>  	/* hw requires the start (boot) address be on 1KB boundary */
>  	if (rproc->bootaddr & 0x3ff) {
> @@ -148,7 +149,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  
>  	writel(rproc->bootaddr, drproc->bootreg);
>  
> -	clk_enable(dsp_clk);
> +	ret = clk_enable(dsp_clk);
> +	if (ret) {
> +		dev_err(dev, "clk_enable() failed: %d\n", ret);
> +		return ret;
> +	}
> +
>  	davinci_clk_reset_deassert(dsp_clk);
>  
>  	return 0;
> -- 
> 2.17.0
> 
