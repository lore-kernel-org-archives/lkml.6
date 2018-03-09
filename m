Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeCIEu6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 23:50:58 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:42209 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeCIEu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 23:50:56 -0500
X-Google-Smtp-Source: AG47ELtzw8ZEQOPU6JDPQxqV7wToy28HocJSBSHZ2EvaK5m3TTtO3LAXcW+7s0h5tfXkpQnQekHv1A==
MIME-Version: 1.0
In-Reply-To: <6fe36177-a8a5-5f17-bf65-1a53538221a4@arm.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
 <20180302101050.6191-4-vivek.gautam@codeaurora.org> <d0f2b3ed-136d-7704-2aef-1173a342a89c@arm.com>
 <CAAFQd5BTdF176x5ycatCmCHrMyVX2OZqdXd-JGq06RyDUb0N3g@mail.gmail.com>
 <30a2fa5e-3d8e-acb6-ab31-bec652f1be99@arm.com> <CAAFQd5BKkKc2binDe-MCDeP42b6O26Hu9nYjvYRE160EMvi1fA@mail.gmail.com>
 <6fe36177-a8a5-5f17-bf65-1a53538221a4@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 9 Mar 2018 13:50:32 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BU+hU8aPyq6Rcaiwzu1sf7vcRNwnzt5LZZ+L01DnjqhA@mail.gmail.com>
Message-ID: <CAAFQd5BU+hU8aPyq6Rcaiwzu1sf7vcRNwnzt5LZZ+L01DnjqhA@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jcrouse@codeaurora.org, Stephen Boyd <sboyd@codeaurora.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 9:12 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 08/03/18 04:33, Tomasz Figa wrote:
>>
>> On Thu, Mar 8, 2018 at 1:58 AM, Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>> On 07/03/18 13:52, Tomasz Figa wrote:
>>>>
>>>>
>>>> On Wed, Mar 7, 2018 at 9:38 PM, Robin Murphy <robin.murphy@arm.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> On 02/03/18 10:10, Vivek Gautam wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>>
>>>>>> The smmu device probe/remove and add/remove master device callbacks
>>>>>> gets called when the smmu is not linked to its master, that is without
>>>>>> the context of the master device. So calling runtime apis in those
>>>>>> places
>>>>>> separately.
>>>>>>
>>>>>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>>>>>> [vivek: Cleanup pm runtime calls]
>>>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
>>>>>> ---
>>>>>>     drivers/iommu/arm-smmu.c | 96
>>>>>> ++++++++++++++++++++++++++++++++++++++++++++----
>>>>>>     1 file changed, 88 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>>>>> index c8b16f53f597..3d6a1875431f 100644
>>>>>> --- a/drivers/iommu/arm-smmu.c
>>>>>> +++ b/drivers/iommu/arm-smmu.c
>>>>>> @@ -209,6 +209,8 @@ struct arm_smmu_device {
>>>>>>           struct clk_bulk_data            *clks;
>>>>>>           int                             num_clks;
>>>>>>     +     bool                            rpm_supported;
>>>>>> +
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> Can we not automatically infer this from whether clocks and/or power
>>>>> domains
>>>>> are specified or not, then just use pm_runtime_enabled() as the
>>>>> fast-path
>>>>> check as Tomasz originally proposed?
>>>>
>>>>
>>>>
>>>> I wouldn't tie this to presence of clocks, since as a next step we
>>>> would want to actually control the clocks separately. (As far as I
>>>> understand, on QCom SoCs we might want to have runtime PM active for
>>>> the translation to work, but clocks gated whenever access to SMMU
>>>> registers is not needed.) Moreover, you might still have some super
>>>> high scale thousand-core systems that require clocks to be
>>>> prepare-enabled, but runtime PM would be undesirable for the reasons
>>>> we discussed before.
>>>>
>>>>>
>>>>> I worry that relying on statically-defined matchdata is just going to
>>>>> blow
>>>>> up the driver and DT binding into a maintenance nightmare; I really
>>>>> don't
>>>>> want to start needing separate definitions for e.g.
>>>>> "arm,juno-etr-mmu-401"
>>>>> and "arm,juno-hdlcd-mmu-401" just because one otherwise-identical
>>>>> instance
>>>>> within the SoC is in a separate controllable power domain while the
>>>>> others
>>>>> aren't.
>>>>
>>>>
>>>>
>>>> I don't see a reason why both couldn't just have RPM supported
>>>> regardless of whether there is a real power domain. It would
>>>> effectively be just a no-op for those that don't have one.
>>>
>>>
>>>
>>> Because you're then effectively defining "compatible" values for the sake
>>> of
>>> attaching software policy to them, rather than actually describing
>>> different
>>> hardware implementations.
>>>
>>> The fact that RPM can't do anything meaningful unless relevant
>>> clock/power
>>> aspects *are* described, however, means that we shouldn't need additional
>>> information redundant with that. Much like the fact that we don't
>>> *already*
>>> have an "arm,juno-hdlcd-mmu-401" compatible to account for those being
>>> integrated such that IDR0.CTTW has the wrong value, since the presence or
>>> not of the "dma-coherent" property already describes the truth in that
>>> regard.
>>
>>
>> Fair enough.
>>
>>>
>>>> IMHO the
>>>> only reason to avoid having the RPM enabled is the scalability issue
>>>> we discussed before.
>>>
>>>
>>>
>>> Yes, but that's kind of my point; in reality high throughput/minimal
>>> latency
>>> and aggressive power management are more or less mutually exclusive.
>>> Mobile
>>> SoCs with fine-grained clock trees and power domains won't have multiple
>>> 40GBe/NVMf/whatever links running flat out in parallel; conversely
>>> networking/infrastructure/server SoCs aren't designed around saving every
>>> last microamp of leakage current - even in the (fairly unlikely) case of
>>> the
>>> interconnect clocks being software-gateable at all I would be very
>>> surprised
>>> if that were ever exposed directly to Linux (FWIW I believe ACPI
>>> essentially
>>> *requires* clocks to be abstracted behind firmware).
>>>
>>> Realistically then, explicit clocks are only expected on systems which
>>> care
>>> about power management. We can always revisit that assumption if anything
>>> crazy where it isn't the case ever becomes non-theoretical, but for now
>>> it's
>>> one I'm entirely comfortable with. If on the other hand it turns out that
>>> we
>>> can rely on just a power domain being present wherever we want RPM,
>>> making
>>> clocks moot, then all the better.
>>
>>
>> Alright. Since Qcom would be the only user of clock and power handling
>> for the time being, I think checking power domain presence could work
>> for us. +/- the fact that clocks need to be handled even if power
>> domain is not present, but we should normally always have both.
>
>
> Great! (the issue of Qcom-specific clock handling is a separate argument
> which I don't feel like reigniting just now...)
>
>> Now we need a way to do the check. Perhaps for the time being it would
>> be enough to just check for the power-domains property in DT?
>
>
> AFAICS, it might be as simple as arm_smmu_probe() doing this:
>
>         /*
>          * We want to avoid touching dev->power.lock in fastpaths unless
>          * it's really going to do something useful - pm_runtime_enabled()
>          * can serve as an ideal proxy for that decision.
>          */
>         if (dev->pm_domain)
>                 pm_runtime_enable(dev);
>
> or maybe even just gate all the calls with "if (smmu->dev.pm_domain)"
> directly (like pcie-mediatek does), but I'm not sure which would be
> conceptually cleaner.

Okay, that was easier than I expected. Thanks. :)

Actually, there is one more thing that might need rechecking. Are you
sure that dev->pm_domain is NULL for the devices, for which we don't
want runtime PM to be enabled? I think ACPI was mentioned and ACPI
includes the concept of PM domains.

Best regards,
Tomasz
