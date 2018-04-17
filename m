Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeDQN6P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:58:15 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:10112 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753072AbeDQN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:58:13 -0400
Subject: Re: [RESEND PATCH v2 2/4] memory: aemif: add support for board files
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180417102917.7794-1-brgl@bgdev.pl>
 <20180417102917.7794-3-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <d3584cd9-904c-c737-8a06-92ed05f559ce@ti.com>
Date: Tue, 17 Apr 2018 19:27:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417102917.7794-3-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 April 2018 03:59 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Currently aemif is supported in two places separately. By the platform
> driver in drivers/memory and by a hand crafted driver in mach-davinci.
> 
> We want to drop the latter but also keep the legacy mode. Add support
> for board files to the aemif driver.
> 
> The new structure in platform data currently only contains the chip
> select number, since currently existing users don't require anything
> else, but it can be extended in the future.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/memory/ti-aemif.c              | 57 +++++++++++++++++---------
>  include/linux/platform_data/ti-aemif.h |  9 ++++
>  2 files changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
> index 588e58d40d1b..27d2b076f465 100644
> --- a/drivers/memory/ti-aemif.c
> +++ b/drivers/memory/ti-aemif.c

> @@ -394,14 +401,24 @@ static int aemif_probe(struct platform_device *pdev)
>  	}
>  
>  	/*
> -	 * Create a child devices explicitly from here to
> -	 * guarantee that the child will be probed after the AEMIF timing
> -	 * parameters are set.
> +	 * Create a child devices explicitly from here to guarantee that the
> +	 * child will be probed after the AEMIF timing parameters are set.
>  	 */
> -	for_each_available_child_of_node(np, child_np) {
> -		ret = of_platform_populate(child_np, NULL, dev_lookup, dev);
> -		if (ret < 0)
> -			goto error;
> +	if (np) {
> +		for_each_available_child_of_node(np, child_np) {
> +			ret = of_platform_populate(child_np, NULL,
> +						   dev_lookup, dev);
> +			if (ret < 0)
> +				goto error;
> +		}
> +	} else {
> +		for (i = 0; i < pdata->num_sub_devices; i++) {
> +			ret = platform_device_register(&pdata->sub_devices[i]);

Before doing this can we make aemif device the parent of the sub_device?

> +			if (ret) {
> +				dev_warn(dev, "Error register sub device %s\n",
> +					 pdata->sub_devices[i].name);
> +			}
> +		}
>  	}
>  
>  	return 0;
> diff --git a/include/linux/platform_data/ti-aemif.h b/include/linux/platform_data/ti-aemif.h
> index ac72e115093c..dfe8901128c9 100644
> --- a/include/linux/platform_data/ti-aemif.h
> +++ b/include/linux/platform_data/ti-aemif.h
> @@ -16,8 +16,17 @@
>  
>  #include <linux/of_platform.h>
>  
> +struct aemif_abus_data {
> +	u32 cs;
> +};
> +
>  struct aemif_platform_data {
>  	struct of_dev_auxdata *dev_lookup;
> +	u32 cs_offset;
> +	struct aemif_abus_data *abus_data;
> +	size_t num_abus_data;
> +	struct platform_device *sub_devices;
> +	size_t num_sub_devices;

It will be nice to add documentation for these members.

Thanks,
Sekhar
