Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751750AbeCOHSH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 03:18:07 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35249 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeCOHSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 03:18:04 -0400
X-Google-Smtp-Source: AG47ELuiQ8IFcOpDjQiF2+CYyqRv5jiUp8XsZkqmqHpfxw5qbCmcgngCQYt+u4nS3L6jd8DBbT3NHA==
MIME-Version: 1.0
In-Reply-To: <77ed3675-0af0-b36a-5f76-b920d7a4c8e0@arm.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-4-vivek.gautam@codeaurora.org> <77ed3675-0af0-b36a-5f76-b920d7a4c8e0@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 15 Mar 2018 16:17:40 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B547sHQJUhz+=7xSnM0s1hY-r3KUGBh86QzXqFhYJZFA@mail.gmail.com>
Message-ID: <CAAFQd5B547sHQJUhz+=7xSnM0s1hY-r3KUGBh86QzXqFhYJZFA@mail.gmail.com>
Subject: Re: [PATCH v9 3/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 2:46 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 13/03/18 08:55, Vivek Gautam wrote:
>>
>> From: Sricharan R <sricharan@codeaurora.org>
>>
>> The smmu device probe/remove and add/remove master device callbacks
>> gets called when the smmu is not linked to its master, that is without
>> the context of the master device. So calling runtime apis in those places
>> separately.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> [vivek: Cleanup pm runtime calls]
>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
>> ---
>>   drivers/iommu/arm-smmu.c | 95
>> ++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 87 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index d5873d545024..56a04ae80bf3 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -268,6 +268,20 @@ static struct arm_smmu_option_prop arm_smmu_options[]
>> = {
>>         { 0, NULL},
>>   };
>>   +static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>> +{
>> +       if (pm_runtime_enabled(smmu->dev))
>> +               return pm_runtime_get_sync(smmu->dev);
>> +
>> +       return 0;
>> +}
>> +
>> +static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>> +{
>> +       if (pm_runtime_enabled(smmu->dev))
>> +               pm_runtime_put(smmu->dev);
>> +}
>> +
>>   static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>>   {
>>         return container_of(dom, struct arm_smmu_domain, domain);
>> @@ -913,11 +927,15 @@ static void arm_smmu_destroy_domain_context(struct
>> iommu_domain *domain)
>>         struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>>         struct arm_smmu_device *smmu = smmu_domain->smmu;
>>         struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
>> -       int irq;
>> +       int ret, irq;
>>         if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>>                 return;
>>   +     ret = arm_smmu_rpm_get(smmu);
>> +       if (ret < 0)
>> +               return;
>> +
>>         /*
>>          * Disable the context bank and free the page tables before
>> freeing
>>          * it.
>> @@ -932,6 +950,8 @@ static void arm_smmu_destroy_domain_context(struct
>> iommu_domain *domain)
>>         free_io_pgtable_ops(smmu_domain->pgtbl_ops);
>>         __arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
>> +
>> +       arm_smmu_rpm_put(smmu);
>>   }
>>     static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>> @@ -1213,10 +1233,15 @@ static int arm_smmu_attach_dev(struct iommu_domain
>> *domain, struct device *dev)
>>                 return -ENODEV;
>>         smmu = fwspec_smmu(fwspec);
>> +
>> +       ret = arm_smmu_rpm_get(smmu);
>> +       if (ret < 0)
>> +               return ret;
>> +
>>         /* Ensure that the domain is finalised */
>>         ret = arm_smmu_init_domain_context(domain, smmu);
>>         if (ret < 0)
>> -               return ret;
>> +               goto rpm_put;
>>         /*
>>          * Sanity check the domain. We don't support domains across
>> @@ -1230,29 +1255,47 @@ static int arm_smmu_attach_dev(struct iommu_domain
>> *domain, struct device *dev)
>>         }
>>         /* Looks ok, so add the device to the domain */
>> -       return arm_smmu_domain_add_master(smmu_domain, fwspec);
>> +       ret = arm_smmu_domain_add_master(smmu_domain, fwspec);
>> +
>> +rpm_put:
>> +       arm_smmu_rpm_put(smmu);
>> +       return ret;
>>   }
>>     static int arm_smmu_map(struct iommu_domain *domain, unsigned long
>> iova,
>>                         phys_addr_t paddr, size_t size, int prot)
>>   {
>>         struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
>> +       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>
>
> Nit: please use arm_smmu_domain for ops as well (as it was before
> 523d7423e21b), or consistently elide it for smmu - the mixture of both
> methods is just a horrible mess (here and in unmap).
>
>
>> +       int ret;
>>         if (!ops)
>>                 return -ENODEV;
>>   -     return ops->map(ops, iova, paddr, size, prot);
>> +       arm_smmu_rpm_get(smmu);
>> +       ret = ops->map(ops, iova, paddr, size, prot);
>> +       arm_smmu_rpm_put(smmu);
>> +
>> +       return ret;
>>   }
>>     static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned
>> long iova,
>>                              size_t size)
>>   {
>>         struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
>> +       struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
>> +       size_t ret;
>>         if (!ops)
>>                 return 0;
>>   -     return ops->unmap(ops, iova, size);
>> +       arm_smmu_rpm_get(smmu);
>> +       ret = ops->unmap(ops, iova, size);
>> +       arm_smmu_rpm_put(smmu);
>> +
>> +       return ret;
>>   }
>>     static void arm_smmu_iotlb_sync(struct iommu_domain *domain)
>> @@ -1407,14 +1450,22 @@ static int arm_smmu_add_device(struct device *dev)
>>         while (i--)
>>                 cfg->smendx[i] = INVALID_SMENDX;
>>   +     ret = arm_smmu_rpm_get(smmu);
>> +       if (ret < 0)
>> +               goto out_cfg_free;
>> +
>>         ret = arm_smmu_master_alloc_smes(dev);
>
>
> Nit: it would be easier to just do the rpm_put here; then you don't need to
> mess with the cleanup path.
>
>
>>         if (ret)
>> -               goto out_cfg_free;
>> +               goto out_rpm_put;
>>         iommu_device_link(&smmu->iommu, dev);
>>   +     arm_smmu_rpm_put(smmu);
>> +
>>         return 0;
>>   +out_rpm_put:
>> +       arm_smmu_rpm_put(smmu);
>>   out_cfg_free:
>>         kfree(cfg);
>>   out_free:
>> @@ -1427,7 +1478,7 @@ static void arm_smmu_remove_device(struct device
>> *dev)
>>         struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>>         struct arm_smmu_master_cfg *cfg;
>>         struct arm_smmu_device *smmu;
>> -
>> +       int ret;
>>         if (!fwspec || fwspec->ops != &arm_smmu_ops)
>>                 return;
>> @@ -1435,8 +1486,15 @@ static void arm_smmu_remove_device(struct device
>> *dev)
>>         cfg  = fwspec->iommu_priv;
>>         smmu = cfg->smmu;
>>   +     ret = arm_smmu_rpm_get(smmu);
>> +       if (ret < 0)
>> +               return;
>> +
>>         iommu_device_unlink(&smmu->iommu, dev);
>>         arm_smmu_master_free_smes(fwspec);
>> +
>> +       arm_smmu_rpm_put(smmu);
>> +
>>         iommu_group_remove_device(dev);
>>         kfree(fwspec->iommu_priv);
>>         iommu_fwspec_free(dev);
>> @@ -2124,6 +2182,8 @@ static int arm_smmu_device_probe(struct
>> platform_device *pdev)
>>                 smmu->irqs[i] = irq;
>>         }
>>   +     platform_set_drvdata(pdev, smmu);
>> +
>>         err = devm_clk_bulk_get(smmu->dev, smmu->num_clks, smmu->clks);
>>         if (err)
>>                 return err;
>> @@ -2132,6 +2192,19 @@ static int arm_smmu_device_probe(struct
>> platform_device *pdev)
>>         if (err)
>>                 return err;
>>   +     /*
>> +        * We want to avoid touching dev->power.lock in fastpaths unless
>> +        * it's really going to do something useful - pm_runtime_enabled()
>> +        * can serve as an ideal proxy for that decision. So,
>> conditionally
>> +        * enable pm_runtime.
>> +        */
>> +       if (dev->pm_domain)
>> +               pm_runtime_enable(dev);
>> +
>> +       err = arm_smmu_rpm_get(smmu);
>> +       if (err < 0)
>> +               return err;
>> +
>>         err = arm_smmu_device_cfg_probe(smmu);
>>         if (err)
>>                 return err;
>> @@ -2173,10 +2246,11 @@ static int arm_smmu_device_probe(struct
>> platform_device *pdev)
>>                 return err;
>>         }
>>   -     platform_set_drvdata(pdev, smmu);
>>         arm_smmu_device_reset(smmu);
>>         arm_smmu_test_smr_masks(smmu);
>>   +     arm_smmu_rpm_put(smmu);
>> +
>>         /*
>>          * For ACPI and generic DT bindings, an SMMU will be probed before
>>          * any device which might need it, so we want the bus ops in place
>> @@ -2212,8 +2286,13 @@ static int arm_smmu_device_remove(struct
>> platform_device *pdev)
>>         if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
>>                 dev_err(&pdev->dev, "removing device with active
>> domains!\n");
>>   +     arm_smmu_rpm_get(smmu);
>>         /* Turn the thing off */
>>         writel(sCR0_CLIENTPD, ARM_SMMU_GR0_NS(smmu) + ARM_SMMU_GR0_sCR0);
>> +       arm_smmu_rpm_put(smmu);
>> +
>> +       if (pm_runtime_enabled(smmu->dev))
>> +               pm_runtime_disable(smmu->dev);
>>         clk_bulk_unprepare(smmu->num_clks, smmu->clks);
>>
>
>
> I don't know how runtime and system PM interact - does the reset in
> arm_smmu_pm_resume need special treatment as well, or is the device
> guaranteed to be powered up at that point by other means?

Actually, it's quite complicated...

1) device_prepare(), prevents suspending active devices by getting a
runtime enable count [1] and then, depending on whether there is a
prepare callback that could be called for this device [2] or the
device doesn't have any PM callbacks [3], it might set the
"direct_complete" flag [4].

2) Later, when device_suspend() is called, if "direct_complete" is set
(and disabling runtime PM ends up with the device still
runtime-suspended) [5], the .suspend callback will be skipped. If
"direct_complete" is not set (or direct complete fails), the suspend
callback (if one exists) would be called regardless of runtime PM
state of the device [6].

3) During system resume, if "direct_complete" was set, the resume
callback would be completely skipped [7]. Otherwise it would be called
without any special conditions [8].

4) At the end of the whole process, device_complete() would put the
remaining reference count and potentially trigger a runtime idle and
suspend, if the device was active. [9]

Now, the behavior of what happens past 2) and before 3) is affected by
PM domain callbacks, namely prepare, suspend_noirq and resume_noirq.
For genpd, genpd_prepare() never returns a positive value, so
"direct_complete" would never happen [10]. genpd_finish_suspend()
[11], called from genpd_suspend_noirq(), attempts to cut off the
power, while genpd_resume_noirq() restore it [12], so it looks like
the power would be on during the SMMU resume callback.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L1671
[2] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L1688
[3] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L1683
[4] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L1719
[5] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L1492
[6] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L1506
[7] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L833
[8] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L888
[9] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/main.c#L1012
[10] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/domain.c#L1019
[11] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/domain.c#L1032
[12] https://elixir.bootlin.com/linux/latest/source/drivers/base/power/domain.c#L1085

Phew. This is still with skipped wake up capability handling, since
SMMU doesn't have such.

Best regards,
Tomasz
