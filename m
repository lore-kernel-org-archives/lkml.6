Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB800C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874C421486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874C421486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeHVTJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:09:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34724 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbeHVTJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:09:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B626280D;
        Wed, 22 Aug 2018 08:43:37 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F30083F2EA;
        Wed, 22 Aug 2018 08:43:33 -0700 (PDT)
Subject: Re: [PATCH v14 0/4] iommu/arm-smmu: Add runtime pm/sleep support
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, joro@8bytes.org,
        Rob Herring <robh+dt@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Clark <robdclark@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>, sboyd@kernel.org,
        jcrouse@codeaurora.org, Sricharan R <sricharan@codeaurora.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20180727070224.23966-1-vivek.gautam@codeaurora.org>
 <CAAFQd5C+ctVA-ynrWy=0=pjKZj0TGmHL+bWAu2yWWjYe4Oyf8w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <08965f23-5b97-3ea7-4bd5-4f36035fddf2@arm.com>
Date:   Wed, 22 Aug 2018 16:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAFQd5C+ctVA-ynrWy=0=pjKZj0TGmHL+bWAu2yWWjYe4Oyf8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/18 10:31, Tomasz Figa wrote:
> Hi Robin,
> 
> On Fri, Jul 27, 2018 at 4:02 PM Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
>>
>> This series provides the support for turning on the arm-smmu's
>> clocks/power domains using runtime pm. This is done using
>> device links between smmu and client devices. The device link
>> framework keeps the two devices in correct order for power-cycling
>> across runtime PM or across system-wide PM.
>>
>> With addition of a new device link flag DL_FLAG_AUTOREMOVE_SUPPLIER [8]
>> (available in linux-next of Rafael's linux-pm tree [9]), the device links
>> created between arm-smmu and its clients will be automatically purged
>> when arm-smmu driver unbinds from its device.
>>
>> As not all implementations support clock/power gating, we are checking
>> for a valid 'smmu->dev's pm_domain' to conditionally enable the runtime
>> power management for such smmu implementations that can support it.
>> Otherwise, the clocks are turned to be always on in .probe until .remove.
>> With conditional runtime pm now, we avoid touching dev->power.lock
>> in fastpaths for smmu implementations that don't need to do anything
>> useful with pm_runtime.
>> This lets us to use the much-argued pm_runtime_get_sync/put_sync()
>> calls in map/unmap callbacks so that the clients do not have to
>> worry about handling any of the arm-smmu's power.
>>
>> This series also adds support for Qcom's arm-smmu-v2 variant that
>> has different clocks and power requirements.
>>
>> Previous version of this patch series is @ [2].
>>
>> Tested this series on msm8996, and sdm845 after pulling in Rafael's linux-pm
>> linux-next[9] and Joerg's iommu next[10] branches, and related changes for
>> device tree, etc.
>>
>> Hi Robin, Will,
>> I have addressed the comments for v13. If there's still a chance
>> can you please consider pulling this for v4.19.
>> Thanks.
>>
>> [v14]
>>     * Moved arm_smmu_device_reset() from arm_smmu_pm_resume() to
>>       arm_smmu_runtime_resume() so that the pm_resume callback calls
>>       only runtime_resume to resume the device.
>>       This should take care of restoring the state of smmu in systems
>>       in which smmu lose register state on power-domain collapse.
> 
> It's been a while since this series was posted and no more comments
> seem to be left anymore. Would you have some time to take a look
> again? Thanks.

Other than the binding issue which turned up in the meantime, I *think* 
this is looking OK now in terms of being sufficiently safe for all the 
various awkward retention vs. state-loss combinations. There's almost 
certainly still ways to improve it in future, but what we have now seems 
like a reasonable starting point that isn't impossibly complicated to 
reason about.

Robin.
