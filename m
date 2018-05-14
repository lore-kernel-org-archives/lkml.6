Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbeENSSV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:18:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbeENSSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:18:18 -0400
Subject: Re: [PATCH v1 7/9] iommu/tegra: gart: Provide single domain and group
 for all devices
To: Dmitry Osipenko <digetx@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20180508181700.5169-1-digetx@gmail.com>
 <20180508181700.5169-8-digetx@gmail.com>
 <dd440bff-5bbd-e0c6-5ebb-e36b9ab5e843@arm.com>
 <cd04abc4-cade-b8c9-bcde-9d18e4f32519@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <56d097b0-da3f-8635-9887-64e2df496d01@arm.com>
Date: Mon, 14 May 2018 19:18:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cd04abc4-cade-b8c9-bcde-9d18e4f32519@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/18 21:05, Dmitry Osipenko wrote:
> On 11.05.2018 15:32, Robin Murphy wrote:
>> On 08/05/18 19:16, Dmitry Osipenko wrote:
>>> GART aperture is shared by all devices, hence there is a single IOMMU
>>> domain and group shared by these devices. Allocation of a group per
>>> device only wastes resources and allowance of having more than one domain
>>> is simply wrong because IOMMU mappings made by the users of "different"
>>> domains will stomp on each other.
>>
>> Strictly, that reasoning is a bit backwards - allocating multiple groups is the
>> conceptually-wrong thing if the GART cannot differentiate between different
>> devices, whereas having multiple domains *exist* is no real problem, it's merely
>> that only one can be active at any point in time (which will inherently become
>> the case once all devices are grouped together).
> 
> IIUC, the IOMMU domain represents the address space. There is only one address
> space in a case of GART, the GART's aperture. So GART not only isn't
> differentiating between different devices, but also between different domains.

Right, but that's the same as many other IOMMUs (exynos, rockchip, mtk, 
etc.) - the point is that an IOMMU domain represents *an* address space, 
but if nothing is attached to that domain, it's just a set of logical 
mappings which doesn't need to be backed by real hardware. It's 
specifically *because* these IOMMUs also can't differentiate between 
devices that things work out neatly - there's only one group, which can 
only be attached to a single domain at once, so there is never a time 
when more than one domain needs to be backed by hardware. Think of the 
IOMMU+devices as a CPU and the domains as processes ;)

>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>    drivers/iommu/tegra-gart.c | 107 +++++++++----------------------------
>>>    1 file changed, 24 insertions(+), 83 deletions(-)
>>>
>>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>>> index 5b2d27620350..ebc105c201bd 100644
>>> --- a/drivers/iommu/tegra-gart.c
>>> +++ b/drivers/iommu/tegra-gart.c
>>> @@ -19,7 +19,6 @@
>>>      #include <linux/io.h>
>>>    #include <linux/iommu.h>
>>> -#include <linux/list.h>
>>>    #include <linux/module.h>
>>>    #include <linux/of_device.h>
>>>    #include <linux/slab.h>
>>> @@ -44,22 +43,17 @@
>>>    #define GART_PAGE_MASK                        \
>>>        (~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
>>>    -struct gart_client {
>>> -    struct device        *dev;
>>> -    struct list_head    list;
>>> -};
>>> -
>>>    struct gart_device {
>>>        void __iomem        *regs;
>>>        u32            *savedata;
>>>        u32            page_count;    /* total remappable size */
>>>        dma_addr_t        iovmm_base;    /* offset to vmm_area */
>>>        spinlock_t        pte_lock;    /* for pagetable */
>>> -    struct list_head    client;
>>> -    spinlock_t        client_lock;    /* for client list */
>>>        struct device        *dev;
>>>          struct iommu_device    iommu;        /* IOMMU Core handle */
>>> +    struct iommu_group    *group;        /* Common IOMMU group */
>>> +    struct gart_domain    *domain;    /* Unique IOMMU domain */
>>>          struct tegra_mc_gart_handle mc_gart_handle;
>>>    };
>>> @@ -169,81 +163,31 @@ static inline bool gart_iova_range_valid(struct
>>> gart_device *gart,
>>>    static int gart_iommu_attach_dev(struct iommu_domain *domain,
>>>                     struct device *dev)
>>>    {
>>> -    struct gart_domain *gart_domain = to_gart_domain(domain);
>>> -    struct gart_device *gart = gart_domain->gart;
>>> -    struct gart_client *client, *c;
>>> -    int err = 0;
>>> -
>>> -    client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
>>> -    if (!client)
>>> -        return -ENOMEM;
>>> -    client->dev = dev;
>>> -
>>> -    spin_lock(&gart->client_lock);
>>> -    list_for_each_entry(c, &gart->client, list) {
>>> -        if (c->dev == dev) {
>>> -            dev_err(gart->dev,
>>> -                "%s is already attached\n", dev_name(dev));
>>> -            err = -EINVAL;
>>> -            goto fail;
>>> -        }
>>> -    }
>>> -    list_add(&client->list, &gart->client);
>>> -    spin_unlock(&gart->client_lock);
>>> -    dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
>>>        return 0;
>>> -
>>> -fail:
>>> -    devm_kfree(gart->dev, client);
>>> -    spin_unlock(&gart->client_lock);
>>> -    return err;
>>>    }
>>>      static void gart_iommu_detach_dev(struct iommu_domain *domain,
>>>                      struct device *dev)
>>>    {
>>> -    struct gart_domain *gart_domain = to_gart_domain(domain);
>>> -    struct gart_device *gart = gart_domain->gart;
>>> -    struct gart_client *c;
>>> -
>>> -    spin_lock(&gart->client_lock);
>>> -
>>> -    list_for_each_entry(c, &gart->client, list) {
>>> -        if (c->dev == dev) {
>>> -            list_del(&c->list);
>>> -            devm_kfree(gart->dev, c);
>>> -            dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
>>> -            goto out;
>>> -        }
>>> -    }
>>> -    dev_err(gart->dev, "Couldn't find\n");
>>> -out:
>>> -    spin_unlock(&gart->client_lock);
>>>    }
>>
>> The .detach_dev callback is optional in the core API now, so you can just remove
>> the whole thing.
> 
> Good catch, thanks!
> 
>>
>>>    static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>>>    {
>>> -    struct gart_domain *gart_domain;
>>> -    struct gart_device *gart;
>>> -
>>> -    if (type != IOMMU_DOMAIN_UNMANAGED)
>>> -        return NULL;
>>> +    struct gart_device *gart = gart_handle;
>>>    -    gart = gart_handle;
>>> -    if (!gart)
>>> +    if (type != IOMMU_DOMAIN_UNMANAGED || gart->domain)
>>
>> Singleton domains are a little unpleasant given the way the IOMMU API expects
>> things to work, but it looks fairly simple to avoid needing that at all. AFAICS
>> you could move gart->savedata to something like gart_domain->ptes and keep it
>> up-to-date in .map/.unmap, then in .attach_dev you just need to do something like:
>>
>>      if (gart_domain != gart->domain) {
>>          do_gart_setup(gart, gart_domain->ptes);
>>          gart->domain = gart_domain;
>>      }
>>
>> to context-switch the hardware state when moving the group from one domain to
>> another (and as a bonus you would no longer need to do anything for suspend,
>> since resume can just look at the current domain too). If in practice there's
>> only ever one domain allocated anyway, then there's no difference in memory
>> overhead, but you still have the benefit of the driver being more consistent
>> with others and allowing that flexibility if anyone ever did want to play with it.
> 
> For the starter we'll have a single domain solely used by GPU with all its
> sub-devices. Context switching will be handled by the Tegra's DRM driver. Later
> we may consider introducing IOMMU support for the video decoder, at least to
> provide memory isolation for the buffers to which decoder performs writing.
> 
> Cross-driver context switching isn't that straightforward and I think Tegra-GART
> driver shouldn't take care of context switching in any form and only perform
> mapping / unmapping operations. There are couple variants of how to deal with
> the context switching:
> 
> 1. A simple solution could be to logically split the GART's aperture space into
> different domains, but GART's aperture won't be utilized efficiently with this
> approach, wasting IOVA space quite a lot.
> 
> 2. In order to utilize aperture more efficiently, we are going to make DRM
> driver to cache IOMMU mappings such that graphics buffer will be moved to the
> cache-eviction list on unmapping and actually unmapped when that buffer isn't
> in-use and there is no IOVA space for another buffer or on the buffers
> destruction. We'll use DRM's MM scanning helper for that [0][1]. Maybe we could
> share access to that MM helper with the video decoder somehow. Seems IOMMU API
> isn't tailored for a such use-case, so probably having a custom
> platform-specific API on top of the IOMMU API would be fine and with that we
> could have cross-device/driver context switching handled by the custom API.

Yes, if the DRM driver has overall control of the domain, then drivers 
for other devices in the group are going to have to cooperate with it in 
terms of IOVA allocation. It might even make sense to have that 
inter-driver interface abstract things down to the map/unmap level, 
since with a limited aperture you really want to avoid mapping the same 
PA to two different IOVAs if at all possible.

> Please let me know if you have any other variants to suggest.
> 
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/drm/drm_mm.h
> [1]
> https://github.com/grate-driver/linux/commit/16e017efaa343e23e5a7d2d498915764cc806054
> 
>>
>>>            return NULL;
>>>    -    gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
>>> -    if (!gart_domain)
>>> -        return NULL;
>>> -
>>> -    gart_domain->gart = gart;
>>> -    gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
>>> -    gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
>>> +    gart->domain = kzalloc(sizeof(*gart->domain), GFP_KERNEL);
>>> +    if (gart->domain) {
>>> +        gart->domain->domain.geometry.aperture_start = gart->iovmm_base;
>>> +        gart->domain->domain.geometry.aperture_end = gart->iovmm_base +
>>>                        gart->page_count * GART_PAGE_SIZE - 1;
>>> -    gart_domain->domain.geometry.force_aperture = true;
>>> +        gart->domain->domain.geometry.force_aperture = true;
>>> +        gart->domain->gart = gart;
>>> +    }
>>>    -    return &gart_domain->domain;
>>> +    return &gart->domain->domain;
>>>    }
>>>      static void gart_iommu_domain_free(struct iommu_domain *domain)
>>> @@ -251,18 +195,7 @@ static void gart_iommu_domain_free(struct iommu_domain
>>> *domain)
>>>        struct gart_domain *gart_domain = to_gart_domain(domain);
>>>        struct gart_device *gart = gart_domain->gart;
>>>    -    if (gart) {
>>> -        spin_lock(&gart->client_lock);
>>> -        if (!list_empty(&gart->client)) {
>>> -            struct gart_client *c;
>>> -
>>> -            list_for_each_entry(c, &gart->client, list)
>>> -                gart_iommu_detach_dev(domain, c->dev);
>>> -        }
>>> -        spin_unlock(&gart->client_lock);
>>> -    }
>>> -
>>> -    kfree(gart_domain);
>>> +    kfree(gart->domain);
>>>    }
>>>      static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
>>> @@ -377,7 +310,7 @@ struct iommu_group *gart_iommu_device_group(struct device
>>> *dev)
>>>        if (err)
>>>            return ERR_PTR(err);
>>>    -    return generic_device_group(dev);
>>> +    return gart_handle->group;
>>
>> You should take a reference per device, i.e.:
>>
>>      return iommu_group_ref_get(gart_handle->group);
>>
>> otherwise removing devices could unbalance things and result in the group
>> getting freed prematurely.
> 
> Seems more correctly would be to remove iommu_group_put() from
> gart_iommu_add_device().

If you're confident that no bus code will ever result in add_device() 
getting called more than once for the same device, then you could get 
away with that. AFAIK it *shouldn't* happen, but I've never managed to 
convince myself that it *can't*.

Robin.

>>
>>>    }
>>>      static int gart_iommu_of_xlate(struct device *dev,
>>> @@ -502,8 +435,6 @@ static int tegra_gart_probe(struct platform_device *pdev)
>>>          gart->dev = &pdev->dev;
>>>        spin_lock_init(&gart->pte_lock);
>>> -    spin_lock_init(&gart->client_lock);
>>> -    INIT_LIST_HEAD(&gart->client);
>>>        gart->regs = gart_regs;
>>>        gart->iovmm_base = (dma_addr_t)res_remap->start;
>>>        gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
>>> @@ -517,6 +448,14 @@ static int tegra_gart_probe(struct platform_device *pdev)
>>>            goto iommu_unregister;
>>>        }
>>>    +    gart->group = iommu_group_alloc();
>>> +    if (IS_ERR(gart->group)) {
>>> +        ret = PTR_ERR(gart->group);
>>> +        goto free_savedata;
>>> +    }
>>> +
>>> +    iommu_group_ref_get(gart->group);
>>
>> You already hold the initial reference from iommu_group_alloc(), so there's no
>> need to take a second one at this point.
> 
> Yes, looks like this refcount-bump isn't needed here. I'll revisit the
> refcountings and correct them in v2 where necessary.
> 
> Thank you very much for the review.
> 
