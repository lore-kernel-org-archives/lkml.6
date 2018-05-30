Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbeE3QEp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:04:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10366 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753841AbeE3QEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:04:42 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 May 2018 09:04:42 -0700
Subject: Re: [PATCH v2 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-9-ulf.hansson@linaro.org>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a53f0970-22c4-444f-10e6-c115a21d05ea@nvidia.com>
Date: Wed, 30 May 2018 17:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529100421.31022-9-ulf.hansson@linaro.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/05/18 11:04, Ulf Hansson wrote:
> To support devices being partitioned across multiple PM domains, let's
> begin with extending genpd to cope with these kind of configurations.
> 
> Therefore, add a new exported function genpd_dev_pm_attach_by_id(), which
> is similar to the existing genpd_dev_pm_attach(), but with the difference
> that it allows its callers to provide an index to the PM domain that it
> wants to attach.
> 
> Note that, genpd_dev_pm_attach_by_id() shall only be called by the driver
> core / PM core, similar to how the existing dev_pm_domain_attach() makes
> use of genpd_dev_pm_attach(). However, this is implemented by following
> changes on top.
> 
> Because, only one PM domain can be attached per device, genpd needs to
> create a virtual device that it can attach/detach instead. More precisely,
> let the new function genpd_dev_pm_attach_by_id() register a virtual struct
> device via calling device_register(). Then let it attach this device to the
> corresponding PM domain, rather than the one that is provided by the
> caller. The actual attaching is done via re-using the existing genpd OF
> functions.
> 
> At successful attachment, genpd_dev_pm_attach_by_id() returns the created
> virtual device, which allows the caller to operate on it to deal with power
> management. Following changes on top, provides more details in this
> regards.
> 
> To deal with detaching of a PM domain for the multiple PM domains case,
> let's also extend the existing genpd_dev_pm_detach() function, to cover the
> cleanup of the created virtual device, via make it call device_unregister()
> on it. In this way, there is no need to introduce a new function to deal
> with detach for the multiple PM domain case, but instead the existing one
> is re-used.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> Changes in v2:
> 	- Fixed comments from Jon. Clarified function descriptions
> 	and changelog.
> 
> ---
>  drivers/base/power/domain.c | 80 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  8 ++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 2af99bfcbe3c..2b496d79159d 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2171,6 +2171,15 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_remove_last);
>  
> +static void genpd_release_dev(struct device *dev)
> +{
> +	kfree(dev);
> +}
> +
> +static struct bus_type genpd_bus_type = {
> +	.name		= "genpd",
> +};
> +
>  /**
>   * genpd_dev_pm_detach - Detach a device from its PM domain.
>   * @dev: Device to detach.
> @@ -2208,6 +2217,10 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>  
>  	/* Check if PM domain can be powered off after removing this device. */
>  	genpd_queue_power_off_work(pd);
> +
> +	/* Unregister the device if it was created by genpd. */
> +	if (dev->bus == &genpd_bus_type)
> +		device_unregister(dev);
>  }
>  
>  static void genpd_dev_pm_sync(struct device *dev)
> @@ -2298,6 +2311,67 @@ int genpd_dev_pm_attach(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>  
> +/**
> + * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
> + * @dev: Device to attach.

Can you update the description of the above as well?

Thanks
Jon

-- 
nvpublic
