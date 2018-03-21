Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeCUQB6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:01:58 -0400
Received: from vern.gendns.com ([206.190.152.46]:34809 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbeCUQBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:01:55 -0400
Subject: Re: [PATCH 4/8] clk: davinci: add a reset lookup table for psc0
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
 <20180321120807.18032-5-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <4b985ed2-0db0-b4ad-8a9f-b8804e6d4db4@lechnology.com>
Date: Wed, 21 Mar 2018 11:01:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321120807.18032-5-brgl@bgdev.pl>
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
> In order to be able to use the reset framework in legacy boot mode as
> well, add the reset lookup table to the psc driver for da850 variant.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/clk/davinci/psc-da850.c | 8 ++++++++
>   drivers/clk/davinci/psc.c       | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
> index ccc7eb17bf3a..395db4b2c0ee 100644
> --- a/drivers/clk/davinci/psc-da850.c
> +++ b/drivers/clk/davinci/psc-da850.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <linux/clk-provider.h>
> +#include <linux/reset-controller.h>
>   #include <linux/clk.h>
>   #include <linux/clkdev.h>
>   #include <linux/init.h>
> @@ -66,8 +67,15 @@ LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
>   				"fck",	"ecap.1",
>   				"fck",	"ecap.2");
>   
> +static struct reset_control_lookup da850_psc0_reset_lookup_table[] = {
> +	RESET_LOOKUP("davinci-rproc.0", NULL, 15),
> +};
> +
>   static int da850_psc0_init(struct device *dev, void __iomem *base)
>   {
> +	reset_controller_add_lookup("da850-psc0",
> +				    da850_psc0_reset_lookup_table,
> +				    ARRAY_SIZE(da850_psc0_reset_lookup_table));

Could there be a race condition here since you are adding the lookup *before*
you are adding the actual provider? It seems like reset_controller_add_lookup()
should be after davinci_psc_register_clocks().

>   	return davinci_psc_register_clocks(dev, da850_psc0_info, 16, base);
>   }
>   
> diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
> index 3b0e59dfbdd7..063df62381ea 100644
> --- a/drivers/clk/davinci/psc.c
> +++ b/drivers/clk/davinci/psc.c
> @@ -425,6 +425,7 @@ __davinci_psc_register_clocks(struct device *dev,
>   
>   	psc->rcdev.ops = &davinci_psc_reset_ops;
>   	psc->rcdev.owner = THIS_MODULE;
> +	psc->rcdev.dev = dev;
>   	psc->rcdev.of_node = dev->of_node;
>   	psc->rcdev.of_reset_n_cells = 1;
>   	psc->rcdev.of_xlate = davinci_psc_reset_of_xlate;
> 
