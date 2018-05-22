Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbeEVObm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:31:42 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8176 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEVObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:31:37 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 22 May 2018 07:31:39 -0700
From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 8/9] PM / Domains: Add support for multi PM domains per
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
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
Message-ID: <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com>
Date: Tue, 22 May 2018 15:31:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On 18/05/18 11:31, Ulf Hansson wrote:
> To support devices being partitioned across multiple PM domains, let's
> start by extending genpd to cope with these configurations.
> 
> More precisely, add a new exported function, genpd_dev_pm_attach_by_id(),
> similar to genpd_dev_pm_attach(), but the new function also allows the
> caller to provide an index to what PM domain it wants to attach.
> 
> Furthermore, let genpd register a new virtual struct device via calling
> device_register() and attach it to the corresponding PM domain, which is
> looked up via calling the existing genpd OF functions. Note that the new
> device is needed, because only one PM domain can be attached per device. At
> successful attachment, genpd_dev_pm_attach_by_id() returns the new device,
> allowing the caller to operate on it to deal with power management.
> 
> To deal with detaching of a PM domain for multiple PM domain case, we can
> still re-use the existing genpd_dev_pm_detach() function, although we need
> to extend it to cover cleanup of the earlier registered device, via calling
> device_unregister().
> 
> An important note, genpd_dev_pm_attach_by_id() shall only be called by the
> driver core / PM core, similar to how genpd_dev_pm_attach() is used.
> Following changes deploys this.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/base/power/domain.c | 79 +++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pm_domain.h   |  8 +++++
>   2 files changed, 87 insertions(+)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index d538640..ffeb6ea 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2171,6 +2171,15 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>   }
>   EXPORT_SYMBOL_GPL(of_genpd_remove_last);
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
>   /**
>    * genpd_dev_pm_detach - Detach a device from its PM domain.
>    * @dev: Device to detach.
> @@ -2208,6 +2217,10 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>   
>   	/* Check if PM domain can be powered off after removing this device. */
>   	genpd_queue_power_off_work(pd);
> +
> +	/* Unregister the device if it was created by genpd. */
> +	if (dev->bus == &genpd_bus_type)
> +		device_unregister(dev);
>   }
>   
>   static void genpd_dev_pm_sync(struct device *dev)
> @@ -2298,6 +2311,66 @@ int genpd_dev_pm_attach(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>   
> +/**
> + * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
> + * @dev: Device to attach.
> + * @index: The index of the PM domain.
> + *
> + * Parse device's OF node to find a PM domain specifier at the provided @index.
> + * If such is found, allocates a new device and attaches it to retrieved
> + * pm_domain ops.
> + *
> + * Returns the allocated device if successfully attached PM domain, NULL when
> + * the device don't need a PM domain or have a single PM domain, else PTR_ERR()
> + * in case of failures. Note that if a power-domain exists for the device, but
> + * cannot be found or turned on, then return PTR_ERR(-EPROBE_DEFER) to ensure
> + * that the device is not probed and to re-try again later.
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

Thanks for sending this. Believe it or not this has still been on my to-do list
and so we definitely need a solution for Tegra.

Looking at the above it appears that additional power-domains exposed as devices
to the client device. So I assume that this means that the drivers for devices
with multiple power-domains will need to call RPM APIs for each of these
additional power-domains. Is that correct?

If so, I can see that that would work, but it does not seem to fit the RPM model
where currently for something like device clocks, the RPM callbacks can handle
all clocks at once.

I was wondering why we could not add a list of genpd domains to the
dev_pm_domain struct for the device? For example ...

diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78d8357..a11d6db3c077 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -659,6 +659,7 @@ extern void dev_pm_put_subsys_data(struct device *dev);
  * subsystem-level and driver-level callbacks.
  */
 struct dev_pm_domain {
+       struct list_head        genpd_list;
        struct dev_pm_ops       ops;
        void (*detach)(struct device *dev, bool power_off);
        int (*activate)(struct device *dev);
@@ -666,6 +667,11 @@ struct dev_pm_domain {
        void (*dismiss)(struct device *dev);
 };

+struct dev_pm_domain_link {
+       struct generic_pm_domain *genpd;
+       struct list_head node;
+};
+
 /*
  * The PM_EVENT_ messages are also used by drivers implementing the legacy
  * suspend framework, based on the ->suspend() and ->resume() callbacks common
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e61b5cd79fe2..019593804670 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -51,7 +51,6 @@ struct dev_pm_opp;

 struct generic_pm_domain {
        struct device dev;
-       struct dev_pm_domain domain;    /* PM domain operations */
        struct list_head gpd_list_node; /* Node in the global PM domains list */
        struct list_head master_links;  /* Links with PM domain as a master */
        struct list_head slave_links;   /* Links with PM domain as a slave */
@@ -99,11 +98,6 @@ struct generic_pm_domain {

 };

-static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
-{
-       return container_of(pd, struct generic_pm_domain, domain);
-}
-

Obviously the above will not compile but the intent would be to allocate a
dev_pm_domain_link struct per power-domain that the device needs and add
to the genpd_list for the device. It would be a much bigger change in
having to iterate through all the power-domains when turning devices on
and off, however, it would simplify the client driver. 

Cheers
Jon

-- 
nvpublic
