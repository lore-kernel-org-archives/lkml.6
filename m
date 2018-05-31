Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754737AbeEaLkZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:40:25 -0400
Received: from ns.lynxeye.de ([87.118.118.114]:35873 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754522AbeEaLkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:40:21 -0400
Message-ID: <5fc1d3ee51c8dbc264fb21edf33a879c7db4056b.camel@lynxeye.de>
Subject: Re: [PATCH v3 4/5] PM / Domains: Add support for multi PM domains
 per device to genpd
From: Lucas Stach <dev@lynxeye.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Date: Thu, 31 May 2018 13:40:19 +0200
In-Reply-To: <20180531105959.14843-5-ulf.hansson@linaro.org>
References: <20180531105959.14843-1-ulf.hansson@linaro.org>
         <20180531105959.14843-5-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

Am Donnerstag, den 31.05.2018, 12:59 +0200 schrieb Ulf Hansson:
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

by_id() APIs are not really intuitive to use for driver writers. Other
subsystems have solved this by providing a "-names" property to give
the phandles a bit more meaning and then providing a by_name API. I
would really appreciate if PM domains could move in the same direction.

Regards,
Lucas

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
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/domain.c | 80 +++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   |  8 ++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index b1fcbf917974..4925af5c4cf0 100644
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
> + * genpd_dev_pm_attach_by_id - Associate a device with one of its PM domains.
> + * @dev: The device used to lookup the PM domain.
> + * @index: The index of the PM domain.
> + *
> + * Parse device's OF node to find a PM domain specifier at the provided @index.
> + * If such is found, creates a virtual device and attaches it to the retrieved
> + * pm_domain ops. To deal with detaching of the virtual device, the ->detach()
> + * callback in the struct dev_pm_domain are assigned to genpd_dev_pm_detach().
> + *
> + * Returns the created virtual device if successfully attached PM domain, NULL
> + * when the device don't need a PM domain, else an ERR_PTR() in case of
> + * failures. If a power-domain exists for the device, but cannot be found or
> + * turned on, then ERR_PTR(-EPROBE_DEFER) is returned to ensure that the device
> + * is not probed and to re-try again later.
> + */
> +struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> +					 unsigned int index)
> +{
> +	struct device *genpd_dev;
> +	int num_domains;
> +	int ret;
> +
> +	if (!dev->of_node)
> +		return NULL;
> +
> +	/* Deal only with devices using multiple PM domains. */
> +	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
> +						 "#power-domain-cells");
> +	if (num_domains < 2 || index >= num_domains)
> +		return NULL;
> +
> +	/* Allocate and register device on the genpd bus. */
> +	genpd_dev = kzalloc(sizeof(*genpd_dev), GFP_KERNEL);
> +	if (!genpd_dev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	dev_set_name(genpd_dev, "genpd:%u:%s", index, dev_name(dev));
> +	genpd_dev->bus = &genpd_bus_type;
> +	genpd_dev->release = genpd_release_dev;
> +
> +	ret = device_register(genpd_dev);
> +	if (ret) {
> +		kfree(genpd_dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	/* Try to attach the device to the PM domain at the specified index. */
> +	ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index);
> +	if (ret < 1) {
> +		device_unregister(genpd_dev);
> +		return ret ? ERR_PTR(ret) : NULL;
> +	}
> +
> +	pm_runtime_set_active(genpd_dev);
> +	pm_runtime_enable(genpd_dev);
> +
> +	return genpd_dev;
> +}
> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
> +
>  static const struct of_device_id idle_state_match[] = {
>  	{ .compatible = "domain-idle-state", },
>  	{ }
> @@ -2457,6 +2531,12 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_opp_to_performance_state);
>  
> +static int __init genpd_bus_init(void)
> +{
> +	return bus_register(&genpd_bus_type);
> +}
> +core_initcall(genpd_bus_init);
> +
>  #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
>  
>  
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 42e0d649e653..82458e8e2e01 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -237,6 +237,8 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
>  				struct device_node *opp_node);
>  
>  int genpd_dev_pm_attach(struct device *dev);
> +struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> +					 unsigned int index);
>  #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
>  static inline int of_genpd_add_provider_simple(struct device_node *np,
>  					struct generic_pm_domain *genpd)
> @@ -282,6 +284,12 @@ static inline int genpd_dev_pm_attach(struct device *dev)
>  	return 0;
>  }
>  
> +static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
> +						       unsigned int index)
> +{
> +	return NULL;
> +}
> +
>  static inline
>  struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>  {
