Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeEVUz0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:55:26 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15751 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753081AbeEVUzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:55:24 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 May 2018 13:55:23 -0700
Subject: Re: [PATCH 8/9] PM / Domains: Add support for multi PM domains per
 device to genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
        <linux-tegra@vger.kernel.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
 <1526639490-12167-9-git-send-email-ulf.hansson@linaro.org>
 <f5589b88-acf8-b491-df79-e359e596c8d0@nvidia.com>
 <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <5a79d3a2-d090-645b-da69-524b7e7a4d90@nvidia.com>
Date: Tue, 22 May 2018 21:55:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFr_7hbs-MC1jQn5uAgSnb1UGufXZdEmUqNTM63KemTe1g@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/05/18 15:47, Ulf Hansson wrote:
> [...]
> 
>>>
>>> +/**
>>> + * genpd_dev_pm_attach_by_id() - Attach a device to one of its PM domain.
>>> + * @dev: Device to attach.
>>> + * @index: The index of the PM domain.
>>> + *
>>> + * Parse device's OF node to find a PM domain specifier at the provided @index.
>>> + * If such is found, allocates a new device and attaches it to retrieved
>>> + * pm_domain ops.
>>> + *
>>> + * Returns the allocated device if successfully attached PM domain, NULL when
>>> + * the device don't need a PM domain or have a single PM domain, else PTR_ERR()
>>> + * in case of failures. Note that if a power-domain exists for the device, but
>>> + * cannot be found or turned on, then return PTR_ERR(-EPROBE_DEFER) to ensure
>>> + * that the device is not probed and to re-try again later.
>>> + */
>>> +struct device *genpd_dev_pm_attach_by_id(struct device *dev,
>>> +                                      unsigned int index)
>>> +{
>>> +     struct device *genpd_dev;
>>> +     int num_domains;
>>> +     int ret;
>>> +
>>> +     if (!dev->of_node)
>>> +             return NULL;
>>> +
>>> +     /* Deal only with devices using multiple PM domains. */
>>> +     num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
>>> +                                              "#power-domain-cells");
>>> +     if (num_domains < 2 || index >= num_domains)
>>> +             return NULL;
>>> +
>>> +     /* Allocate and register device on the genpd bus. */
>>> +     genpd_dev = kzalloc(sizeof(*genpd_dev), GFP_KERNEL);
>>> +     if (!genpd_dev)
>>> +             return ERR_PTR(-ENOMEM);
>>> +
>>> +     dev_set_name(genpd_dev, "genpd:%u:%s", index, dev_name(dev));
>>> +     genpd_dev->bus = &genpd_bus_type;
>>> +     genpd_dev->release = genpd_release_dev;
>>> +
>>> +     ret = device_register(genpd_dev);
>>> +     if (ret) {
>>> +             kfree(genpd_dev);
>>> +             return ERR_PTR(ret);
>>> +     }
>>> +
>>> +     /* Try to attach the device to the PM domain at the specified index. */
>>> +     ret = __genpd_dev_pm_attach(genpd_dev, dev->of_node, index);
>>> +     if (ret < 1) {
>>> +             device_unregister(genpd_dev);
>>> +             return ret ? ERR_PTR(ret) : NULL;
>>> +     }
>>> +
>>> +     pm_runtime_set_active(genpd_dev);
>>> +     pm_runtime_enable(genpd_dev);
>>> +
>>> +     return genpd_dev;
>>> +}
>>> +EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
>>
>> Thanks for sending this. Believe it or not this has still been on my to-do list
>> and so we definitely need a solution for Tegra.
>>
>> Looking at the above it appears that additional power-domains exposed as devices
>> to the client device. So I assume that this means that the drivers for devices
>> with multiple power-domains will need to call RPM APIs for each of these
>> additional power-domains. Is that correct?
> 
> They can, but should not!
> 
> Instead, the driver shall use device_link_add() and device_link_del(),
> dynamically, depending on what PM domain that their original device
> needs for the current running use case.
> 
> In that way, they keep existing runtime PM deployment, operating on
> its original device.

OK, sounds good. Any reason why the linking cannot be handled by the 
above API? Is there a use-case where you would not want it linked?

Thanks
Jon

-- 
nvpublic
