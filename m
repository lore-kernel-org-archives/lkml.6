Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932078AbeE3Oaq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:30:46 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1050 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeE3Oao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:30:44 -0400
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 May 2018 07:30:43 -0700
Subject: Re: [PATCH v2 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to
 manage multi PM domains
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
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-10-ulf.hansson@linaro.org>
 <cc6f36ce-32b7-4b69-f9a9-98cf0b12a9d1@nvidia.com>
 <CAPDyKFoiEctBuyw1nVS6ruQ92-jOsMMSAUsWKew42dkmk64_8A@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <f214cf2b-49ee-2f7c-babd-1cee7dcae927@nvidia.com>
Date: Wed, 30 May 2018 15:30:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoiEctBuyw1nVS6ruQ92-jOsMMSAUsWKew42dkmk64_8A@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/05/18 12:31, Ulf Hansson wrote:
> On 30 May 2018 at 11:19, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Hi Ulf,
>>
>> On 29/05/18 11:04, Ulf Hansson wrote:
>>> The existing dev_pm_domain_attach() function, allows a single PM domain to
>>> be attached per device. To be able to support devices that are partitioned
>>> across multiple PM domains, let's introduce a new interface,
>>> dev_pm_domain_attach_by_id().
>>>
>>> The dev_pm_domain_attach_by_id() returns a new allocated struct device with
>>> the corresponding attached PM domain. This enables for example a driver to
>>> operate on the new device from a power management point of view. The driver
>>> may then also benefit from using the received device, to set up so called
>>> device-links towards its original device. Depending on the situation, these
>>> links may then be dynamically changed.
>>
>> I have given this series a go with Tegra updating the XHCI driver to make
>> use of these new APIs. Good news it does appear to work fine for Tegra,
>> however, initially when looking at the device_link_add() API ...
>>
>> /**
>>  * device_link_add - Create a link between two devices.
>>  * @consumer: Consumer end of the link.
>>  * @supplier: Supplier end of the link.
>>  * @flags: Link flags.
>>
>>  ... I had assumed that the 'consumer' device would be the actual XHCI
>> device (in the case of Tegra) and the 'supplier' device would be the new
>> genpd device. However, this did not work and I got the following WARN on
>> boot ...
>>
>> [    2.050929] ---[ end trace eff0b5265e530c92 ]---
>> [    2.055567] WARNING: CPU: 2 PID: 1 at drivers/base/core.c:446 device_links_driver_bound+0xc0/0xd0
>> [    2.064422] Modules linked in:
>> [    2.067471] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W         4.17.0-rc7-next-20180529-00011-g4faf0dc0ebf3-dirty #32
>> [    2.078667] Hardware name: Google Pixel C (DT)
>> [    2.083101] pstate: 80000005 (Nzcv daif -PAN -UAO)
>> [    2.087881] pc : device_links_driver_bound+0xc0/0xd0
>> [    2.092832] lr : device_links_driver_bound+0x20/0xd0
>>
>> Switching the Tegra XHCI device to be the 'supplier' and genpd device to
>> be the 'consumer' does work, but is this correct? Seems to be opposite to
> 
> It shall be the opposite. The Tegra XHCI device shall be the consumer.
> 
>> what I expected. Maybe I am missing something?
> 
> The problem you get is because the device returned from
> dev_pm_domain_attach_by_id(), let's call it genpd_dev, doesn't have
> the a driver.
> 
> You need to use a couple of device links flag, something like this:
> 
> link = device_link_add(dev, genpd_dev, DL_FLAG_STATELESS |
> DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE);

Thanks, adding the DL_FLAG_STATELESS flag resolved the issue. I already added
the DL_FLAG_PM_RUNTIME but I did not bother with the DL_FLAG_RPM_ACTIVE as
from the description it appears that this will always keep it on? Seems to
work fine without it.

> Moreover, you also need these commits, depending if you are running on
> something else than Rafael's tree.
> 
> a0504aecba76 PM / runtime: Drop usage count for suppliers at device link removal
> 1e8378619841 PM / runtime: Fixup reference counting of device link
> suppliers at probe

Yes these are currently in -next and so I have these.
 
>>
>>> The new interface is typically called by drivers during their probe phase,
>>> in case they manages devices which uses multiple PM domains. If that is the
>>> case, the driver also becomes responsible of managing the detaching of the
>>> PM domains, which typically should be done at the remove phase. Detaching
>>> is done by calling the existing dev_pm_domain_detach() function and for
>>> each of the received devices from dev_pm_domain_attach_by_id().
>>>
>>> Note, currently its only genpd that supports multiple PM domains per
>>> device, but dev_pm_domain_attach_by_id() can easily by extended to cover
>>> other PM domain types, if/when needed.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>
>>> Changes in v2:
>>>       - Fixed comments from Jon. Clarified function descriptions/changelog and
>>>       return ERR_PTR(-EEXIST) in case a PM domain is already assigned.
>>>       - Fix build error when CONFIG_PM is unset.
>>>
>>> ---
>>>  drivers/base/power/common.c | 43 ++++++++++++++++++++++++++++++++++---
>>>  include/linux/pm_domain.h   |  7 ++++++
>>>  2 files changed, 47 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
>>> index 7ae62b6355b8..5e5ea0c239de 100644
>>> --- a/drivers/base/power/common.c
>>> +++ b/drivers/base/power/common.c
>>> @@ -116,14 +116,51 @@ int dev_pm_domain_attach(struct device *dev, bool power_on)
>>>  }
>>>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
>>>
>>> +/**
>>> + * dev_pm_domain_attach_by_id - Attach a device to one of its PM domains.
>>> + * @dev: Device to attach.
>>
>> Nit ... I still don't think this is the device we are attaching to, but the
>> device the PM domains are associated with. IOW we are using this device to
>> lookup the PM domains.
> 
> Right. I forgot to update that part of the description.
> 
> What about:
> 
> dev_pm_domain_attach_by_id - Associate a device with one of its PM domains.
> @dev: The device used to lookup the PM domain.

Perfect.
 
>>
>>> + * @index: The index of the PM domain.
>>> + *
>>> + * As @dev may only be attached to a single PM domain, the backend PM domain
>>> + * provider creates a virtual device to attach instead. If attachment succeeds,
>>> + * the ->detach() callback in the struct dev_pm_domain are assigned by the
>>> + * corresponding backend attach function, as to deal with detaching of the
>>> + * created virtual device.
>>> + *
>>> + * This function should typically be invoked by a driver during the probe phase,
>>> + * in case its device requires power management through multiple PM domains. The
>>> + * driver may benefit from using the received device, to configure device-links
>>> + * towards its original device. Depending on the use-case and if needed, the
>>> + * links may be dynamically changed by the driver, which allows it to control
>>> + * the power to the PM domains independently from each other.
>>> + *
>>> + * Callers must ensure proper synchronization of this function with power
>>> + * management callbacks.
>>> + *
>>> + * Returns the virtual created device when successfully attached to its PM
>>> + * domain, NULL in case @dev don't need a PM domain, else an ERR_PTR().
>>> + * Note that, to detach the returned virtual device, the driver shall call
>>> + * dev_pm_domain_detach() on it, typically during the remove phase.
>>> + */
>>> +struct device *dev_pm_domain_attach_by_id(struct device *dev,
>>> +                                       unsigned int index)
>>> +{
>>> +     if (dev->pm_domain)
>>> +             return ERR_PTR(-EEXIST);
>>> +
>>> +     return genpd_dev_pm_attach_by_id(dev, index);
>>> +}
>>> +EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_id);
>>> +
>>>  /**
>>>   * dev_pm_domain_detach - Detach a device from its PM domain.
>>>   * @dev: Device to detach.
>>>   * @power_off: Used to indicate whether we should power off the device.
>>>   *
>>> - * This functions will reverse the actions from dev_pm_domain_attach() and thus
>>> - * try to detach the @dev from its PM domain. Typically it should be invoked
>>> - * from subsystem level code during the remove phase.
>>> + * This functions will reverse the actions from dev_pm_domain_attach() and
>>> + * dev_pm_domain_attach_by_id(), thus it detaches @dev from its PM domain.
>>> + * Typically it should be invoked during the remove phase, either from
>>> + * subsystem level code or from drivers.
>>>   *
>>>   * Callers must ensure proper synchronization of this function with power
>>>   * management callbacks.
>>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>>> index 82458e8e2e01..9206a4fef9ac 100644
>>> --- a/include/linux/pm_domain.h
>>> +++ b/include/linux/pm_domain.h
>>> @@ -299,6 +299,8 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
>>>
>>>  #ifdef CONFIG_PM
>>>  int dev_pm_domain_attach(struct device *dev, bool power_on);
>>> +struct device *dev_pm_domain_attach_by_id(struct device *dev,
>>> +                                       unsigned int index);
>>>  void dev_pm_domain_detach(struct device *dev, bool power_off);
>>>  void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
>>>  #else
>>> @@ -306,6 +308,11 @@ static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
>>>  {
>>>       return 0;
>>>  }
>>> +static inline struct device *dev_pm_domain_attach_by_id(struct device *dev,
>>> +                                                     unsigned int index)
>>> +{
>>> +     return NULL;
>>> +}
>>>  static inline void dev_pm_domain_detach(struct device *dev, bool power_off) {}
>>>  static inline void dev_pm_domain_set(struct device *dev,
>>>                                    struct dev_pm_domain *pd) {}
>>>
>>
>> My only other comments on this series are ...
>>
>> 1. I think it would be nice to have an dev_pm_domain_attach_by_name() and
>>    that the DT binding has a 'power-domain-names' property.
> 
> I think it makes sense, but my plan was to do that as second step on
> top. Are you okay with that as well?

Yes that is fine with me.

>> 2. I am wondering if there could be value in having a
>>    dev_pm_domain_attach_link_all() helper which would attach and link all
>>    PM domains at once.
> 
> Perhaps it can be useful, yes! However, maybe we can postpone that to
> after this series. I want to keep the series as simple as possible,
> then we can build upon it.

That's fine too and I can always add these if you prefer.

Cheers
Jon

-- 
nvpublic
