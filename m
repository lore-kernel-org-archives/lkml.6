Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeCZV34 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 17:29:56 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:24598 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeCZV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 17:29:51 -0400
Subject: Re: [PATCH v4 7/8] remoteproc: da8xx: use the reset framework
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
 <20180323130455.11470-8-brgl@bgdev.pl>
From: Suman Anna <s-anna@ti.com>
Message-ID: <c09d4838-4938-4744-7ce9-4de99080cbe3@ti.com>
Date: Mon, 26 Mar 2018 16:28:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323130455.11470-8-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 03/23/2018 08:04 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Switch to using the reset framework instead of handcoded reset routines
> we used so far.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/remoteproc/da8xx_remoteproc.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
> index f134192922e0..3689473f8b49 100644
> --- a/drivers/remoteproc/da8xx_remoteproc.c
> +++ b/drivers/remoteproc/da8xx_remoteproc.c
> @@ -10,6 +10,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> +#include <linux/reset.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -20,8 +21,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  
> -#include <mach/clock.h>   /* for davinci_clk_reset_assert/deassert() */
> -
>  #include "remoteproc_internal.h"
>  
>  static char *da8xx_fw_name;
> @@ -72,6 +71,7 @@ struct da8xx_rproc {
>  	struct da8xx_rproc_mem *mem;
>  	int num_mems;
>  	struct clk *dsp_clk;
> +	struct reset_control *dsp_reset;
>  	void (*ack_fxn)(struct irq_data *data);
>  	struct irq_data *irq_data;
>  	void __iomem *chipsig;
> @@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  	struct device *dev = rproc->dev.parent;
>  	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>  	struct clk *dsp_clk = drproc->dsp_clk;
> +	struct reset_control *dsp_reset = drproc->dsp_reset;
>  	int ret;
>  
>  	/* hw requires the start (boot) address be on 1KB boundary */
> @@ -155,7 +156,11 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  		return ret;
>  	}
>  
> -	davinci_clk_reset_deassert(dsp_clk);
> +	ret = reset_control_deassert(dsp_reset);
> +	if (ret) {
> +		dev_err(dev, "reset_control_deassert() failed: %d\n", ret);
> +		return ret;

need to unwind the clk_prepare_enable() here.

> +	}
>  
>  	return 0;
>  }
> @@ -163,8 +168,15 @@ static int da8xx_rproc_start(struct rproc *rproc)
>  static int da8xx_rproc_stop(struct rproc *rproc)
>  {
>  	struct da8xx_rproc *drproc = rproc->priv;
> +	int ret;
> +
> +	ret = reset_control_assert(drproc->dsp_reset);
> +	if (ret) {
> +		dev_err(rproc->dev.parent,
> +			"reset_control_assert() failed: %d\n", ret);

prefer the trace statement to be on the same line as dev_err, you can
just keep the ret on the next line. I am fine with defining a local dev
variable as well (mirrors da8xx_rproc_start() to have the trace in a
single line).

> +		return ret;
> +	}
>  
> -	davinci_clk_reset_assert(drproc->dsp_clk);
>  	clk_disable_unprepare(drproc->dsp_clk);
>  
>  	return 0;
> @@ -232,6 +244,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	struct resource *bootreg_res;
>  	struct resource *chipsig_res;
>  	struct clk *dsp_clk;
> +	struct reset_control *dsp_reset;
>  	void __iomem *chipsig;
>  	void __iomem *bootreg;
>  	int irq;
> @@ -268,6 +281,15 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  		return PTR_ERR(dsp_clk);
>  	}
>  
> +	dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(dsp_reset)) {
> +		if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
> +			dev_err(dev, "unable to get reset control: %ld\n",
> +				PTR_ERR(dsp_reset));
> +
> +		return PTR_ERR(dsp_reset);
> +	}
> +
>  	if (dev->of_node) {
>  		ret = of_reserved_mem_device_init(dev);
>  		if (ret) {
> @@ -309,7 +331,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>  	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
>  	 * held in reset at the time it is called.
>  	 */
> -	ret = davinci_clk_reset_assert(drproc->dsp_clk);
> +	ret = reset_control_assert(dsp_reset);
>  	if (ret)
>  		goto free_rproc;
>  

The reset API usage changes themselves look good otherwise.

regards
Suman
