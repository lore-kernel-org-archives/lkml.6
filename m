Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932396AbeCIRgi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:36:38 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55714 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbeCIRgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:36:36 -0500
Subject: Re: [PATCH v8 3/5] iommu/arm-smmu: Invoke pm_runtime during probe,
 add/remove device
To: Tomasz Figa <tfiga@chromium.org>
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
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20180302101050.6191-1-vivek.gautam@codeaurora.org>
 <20180302101050.6191-4-vivek.gautam@codeaurora.org>
 <d0f2b3ed-136d-7704-2aef-1173a342a89c@arm.com>
 <CAAFQd5BTdF176x5ycatCmCHrMyVX2OZqdXd-JGq06RyDUb0N3g@mail.gmail.com>
 <30a2fa5e-3d8e-acb6-ab31-bec652f1be99@arm.com>
 <CAAFQd5BKkKc2binDe-MCDeP42b6O26Hu9nYjvYRE160EMvi1fA@mail.gmail.com>
 <6fe36177-a8a5-5f17-bf65-1a53538221a4@arm.com>
 <CAAFQd5BU+hU8aPyq6Rcaiwzu1sf7vcRNwnzt5LZZ+L01DnjqhA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <ae34ca46-8699-bdc7-7d5c-c402e75be97d@arm.com>
Date: Fri, 9 Mar 2018 17:36:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAAFQd5BU+hU8aPyq6Rcaiwzu1sf7vcRNwnzt5LZZ+L01DnjqhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ +Lorenzo ]

On 09/03/18 04:50, Tomasz Figa wrote:
[...]
>>> Now we need a way to do the check. Perhaps for the time being it would
>>> be enough to just check for the power-domains property in DT?
>>
>>
>> AFAICS, it might be as simple as arm_smmu_probe() doing this:
>>
>>          /*
>>           * We want to avoid touching dev->power.lock in fastpaths unless
>>           * it's really going to do something useful - pm_runtime_enabled()
>>           * can serve as an ideal proxy for that decision.
>>           */
>>          if (dev->pm_domain)
>>                  pm_runtime_enable(dev);
>>
>> or maybe even just gate all the calls with "if (smmu->dev.pm_domain)"
>> directly (like pcie-mediatek does), but I'm not sure which would be
>> conceptually cleaner.
> 
> Okay, that was easier than I expected. Thanks. :)
> 
> Actually, there is one more thing that might need rechecking. Are you
> sure that dev->pm_domain is NULL for the devices, for which we don't
> want runtime PM to be enabled? I think ACPI was mentioned and ACPI
> includes the concept of PM domains.

Thanks for pointing that out - thankfully, I've confirmed that the SMMUs 
on my Juno don't have dev->pm_domain set when booting with ACPI, and 
double-checking the ACPI code I think we're OK here. Since the SMMUs are 
only described in the static IORT table and not in the ACPI namespace, 
they won't have the ACPI companion device that acpi_dev_pm_attach() 
looks for, and thus should always be ignored. Lorenzo, do I have that right?

Robin.
