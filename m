Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbeCGNwv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:52:51 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:41760 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeCGNwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:52:47 -0500
X-Google-Smtp-Source: AG47ELu1HwkHkz9HgLbAVttPMFlhaAtYJEfLy87OwjxjtBk2LVKVkGl9+KjjFcF1TMfzXKNlYThp3Q==
MIME-Version: 1.0
In-Reply-To: <d0f2b3ed-136d-7704-2aef-1173a342a89c@arm.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
 <20180302101050.6191-4-vivek.gautam@codeaurora.org> <d0f2b3ed-136d-7704-2aef-1173a342a89c@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 7 Mar 2018 22:52:22 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BTdF176x5ycatCmCHrMyVX2OZqdXd-JGq06RyDUb0N3g@mail.gmail.com>
Message-ID: <CAAFQd5BTdF176x5ycatCmCHrMyVX2OZqdXd-JGq06RyDUb0N3g@mail.gmail.com>
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

On Wed, Mar 7, 2018 at 9:38 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 02/03/18 10:10, Vivek Gautam wrote:
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
>> ---
>>   drivers/iommu/arm-smmu.c | 96
>> ++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 88 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> index c8b16f53f597..3d6a1875431f 100644
>> --- a/drivers/iommu/arm-smmu.c
>> +++ b/drivers/iommu/arm-smmu.c
>> @@ -209,6 +209,8 @@ struct arm_smmu_device {
>>         struct clk_bulk_data            *clks;
>>         int                             num_clks;
>>   +     bool                            rpm_supported;
>> +
>
>
> Can we not automatically infer this from whether clocks and/or power domains
> are specified or not, then just use pm_runtime_enabled() as the fast-path
> check as Tomasz originally proposed?

I wouldn't tie this to presence of clocks, since as a next step we
would want to actually control the clocks separately. (As far as I
understand, on QCom SoCs we might want to have runtime PM active for
the translation to work, but clocks gated whenever access to SMMU
registers is not needed.) Moreover, you might still have some super
high scale thousand-core systems that require clocks to be
prepare-enabled, but runtime PM would be undesirable for the reasons
we discussed before.

>
> I worry that relying on statically-defined matchdata is just going to blow
> up the driver and DT binding into a maintenance nightmare; I really don't
> want to start needing separate definitions for e.g. "arm,juno-etr-mmu-401"
> and "arm,juno-hdlcd-mmu-401" just because one otherwise-identical instance
> within the SoC is in a separate controllable power domain while the others
> aren't.

I don't see a reason why both couldn't just have RPM supported
regardless of whether there is a real power domain. It would
effectively be just a no-op for those that don't have one. IMHO the
only reason to avoid having the RPM enabled is the scalability issue
we discussed before.

Best regards,
Tomasz
