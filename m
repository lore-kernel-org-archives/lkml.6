Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeEVOrY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:47:24 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38348 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbeEVOrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:47:19 -0400
X-Google-Smtp-Source: AB8JxZqvTRGEyUCTom5XHPeIZxAelGYwggQwe1MTyjZUBcxCGhPlEJ+GGzYFRClg2Y08oiOdB+e7/uyIRRIXUAYJaw4=
MIME-Version: 1.0
In-Reply-To: <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org> <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 May 2018 16:47:17 +0200
Message-ID: <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
Subject: Re: [PATCH 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>
>> +/**
>> + * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
>> + * @dev: Device to attach.
>> + * @index: The index of the PM domain.
>> + *
>> + * Parse device's OF node to find a PM domain specifier at the provided @index.
>> + * If such is found, allocates a new device and attaches it to retrieved
>> + * pm_domain ops.
>> + *
>> + * Returns the allocated device if successfully attached PM domain, NULL when
>> + * the device don't need a PM domain or have a single PM domain, else PTR_ERR()
>> + * in case of failures. Note that if a power-domain exists for the device, but
>> + * cannot be found or turned on, then return PTR_ERR(-EPROBE_DEFER) to ensure
>> + * that the device is not probed and to re-try again later.
>> + */
>> +struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>> +                                      unsigned int index)
>> +{
>> +     struct device *genpd_dev;
>> +     int num_domains;
>> +     int ret;
>> +
>> +     if (!dev->of_node)
>> +             return NULL;
>> +
>> +     /* Deal only with devices using multiple PM domains. */
>> +     num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
>> +                                              "#power-domain-cells");
>> +     if (num_domains < 2 || index >= num_domains)
>> +             return NULL;
>> +
>> +     /* Allocate and register device on the genpd bus. */
>> +     genpd_dev = kzalloc(sizeof(*genpd_dev), GFP_KERNEL);
>> +     if (!genpd_dev)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     dev_set_name(genpd_dev, "genpd:%u:%s", index, dev_name(dev));
>> +     genpd_dev->bus = &genpd_bus_type;
>> +     genpd_dev->release = genpd_release_dev;
>> +
>> +     ret = device_register(genpd_dev);
>> +     if (ret) {
>> +             kfree(genpd_dev);
>> +             return ERR_PTR(ret);
>> +     }
>> +
>> +     /* Try to attach the device to the PM domain at the specified index. */
>> +     ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index);
>> +     if (ret < 1) {
>> +             device_unregister(genpd_dev);
>> +             return ret ? ERR_PTR(ret) : NULL;
>> +     }
>> +
>> +     pm_runtime_set_active(genpd_dev);
>> +     pm_runtime_enable(genpd_dev);
>> +
>> +     return genpd_dev;
>> +}
>> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>
> Thanks for sending this. Believe it or not this has still been on my to-do list
> and so we definitely need a solution for Tegra.
>
> Looking at the above it appears that additional power-domains exposed as devices
> to the client device. So I assume that this means that the drivers for devices
> with multiple power-domains will need to call RPM APIs for each of these
> additional power-domains. Is that correct?

They can, but should not!

Instead, the driver shall use device_link_add() and device_link_del(),
dynamically, depending on what PM domain that their original device
needs for the current running use case.

In that way, they keep existing runtime PM deployment, operating on
its original device.

>
> If so, I can see that that would work, but it does not seem to fit the RPM model
> where currently for something like device clocks, the RPM callbacks can handle
> all clocks at once.
>
> I was wondering why we could not add a list of genpd domains to the
> dev_pm_domain struct for the device? For example ...

See above answer, hopefully that explains it.

FYI, that's why I also discovered the bug around using device links
with runtime PM during probe.
https://patchwork.kernel.org/patch/10408825/

>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e723b78d8357..a11d6db3c077 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -659,6 +659,7 @@ extern void dev_pm_put_subsys_data(struct device *dev);
>   * subsystem-level and driver-level callbacks.
>   */
>  struct dev_pm_domain {
> +       struct list_head        genpd_list;
>         struct dev_pm_ops       ops;
>         void (*detach)(struct device *dev, bool power_off);
>         int (*activate)(struct device *dev);
> @@ -666,6 +667,11 @@ struct dev_pm_domain {
>         void (*dismiss)(struct device *dev);
>  };
>
> +struct dev_pm_domain_link {
> +       struct generic_pm_domain *genpd;
> +       struct list_head node;
> +};
> +
>  /*
>   * The PM_EVENT_ messages are also used by drivers implementing the legacy
>   * suspend framework, based on the ->suspend() and ->resume() callbacks common
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index e61b5cd79fe2..019593804670 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -51,7 +51,6 @@ struct dev_pm_opp;
>
>  struct generic_pm_domain {
>         struct device dev;
> -       struct dev_pm_domain domain;    /* PM domain operations */
>         struct list_head gpd_list_node; /* Node in the global PM domains list */
>         struct list_head master_links;  /* Links with PM domain as a master */
>         struct list_head slave_links;   /* Links with PM domain as a slave */
> @@ -99,11 +98,6 @@ struct generic_pm_domain {
>
>  };
>
> -static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
> -{
> -       return container_of(pd, struct generic_pm_domain, domain);
> -}
> -
>
> Obviously the above will not compile but the intent would be to allocate a
> dev_pm_domain_link struct per power-domain that the device needs and add
> to the genpd_list for the device. It would be a much bigger change in
> having to iterate through all the power-domains when turning devices on
> and off, however, it would simplify the client driver.
>
> Cheers
> Jon
>
> --
> nvpublic

Kind regards
Uffe
