Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059DCC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9FD20E20
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 17:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9FD20E20
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeHPUWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 16:22:55 -0400
Received: from foss.arm.com ([217.140.101.70]:39336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbeHPUWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 16:22:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA5F27A9;
        Thu, 16 Aug 2018 10:23:08 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 951993F5B3;
        Thu, 16 Aug 2018 10:23:04 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
To:     Dmitry Osipenko <digetx@gmail.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-tegra@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180726231624.21084-1-digetx@gmail.com>
 <2887450.sPhIOOMKZK@dimapc> <2e7fab6e-0640-8f48-07b8-2d475538b8ae@arm.com>
 <12474499.22jeAM5LNA@dimapc>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <afecce46-96d2-9688-30b4-0a3f17a651d3@arm.com>
Date:   Thu, 16 Aug 2018 18:23:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <12474499.22jeAM5LNA@dimapc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/18 20:56, Dmitry Osipenko wrote:
> On Friday, 3 August 2018 18:43:41 MSK Robin Murphy wrote:
>> On 02/08/18 19:24, Dmitry Osipenko wrote:
>>> On Friday, 27 July 2018 20:16:53 MSK Dmitry Osipenko wrote:
>>>> On Friday, 27 July 2018 20:03:26 MSK Jordan Crouse wrote:
>>>>> On Fri, Jul 27, 2018 at 05:02:37PM +0100, Robin Murphy wrote:
>>>>>> On 27/07/18 15:10, Dmitry Osipenko wrote:
>>>>>>> On Friday, 27 July 2018 12:03:28 MSK Will Deacon wrote:
>>>>>>>> On Fri, Jul 27, 2018 at 10:25:13AM +0200, Joerg Roedel wrote:
>>>>>>>>> On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
>>>>>>>>>> The proposed solution adds a new option to the base device driver
>>>>>>>>>> structure that allows device drivers to explicitly convey to the
>>>>>>>>>> drivers
>>>>>>>>>> core that the implicit IOMMU backing for devices must not happen.
>>>>>>>>>
>>>>>>>>> Why is IOMMU mapping a problem for the Tegra GPU driver?
>>>>>>>>>
>>>>>>>>> If we add something like this then it should not be the choice of
>>>>>>>>> the
>>>>>>>>> device driver, but of the user and/or the firmware.
>>>>>>>>
>>>>>>>> Agreed, and it would still need somebody to configure an identity
>>>>>>>> domain
>>>>>>>> so
>>>>>>>> that transactions aren't aborted immediately. We currently allow the
>>>>>>>> identity domain to be used by default via a command-line option, so I
>>>>>>>> guess
>>>>>>>> we'd need a way for firmware to request that on a per-device basis.
>>>>>>>
>>>>>>> The IOMMU mapping itself is not a problem, the problem is the
>>>>>>> management
>>>>>>> of
>>>>>>> the IOMMU. For Tegra we don't want anything to intrude into the IOMMU
>>>>>>> activities because:
>>>>>>>
>>>>>>> 1) GPU HW require additional configuration for the IOMMU usage and
>>>>>>> dumb
>>>>>>> mapping of the allocations simply doesn't work.
>>>>>>
>>>>>> Generally, that's already handled by the DRM drivers allocating
>>>>>> their own unmanaged domains. The only problem we really need to
>>>>>> solve in that regard is that currently the device DMA ops don't get
>>>>>> updated when moving away from the managed domain. That's been OK for
>>>>>> the VFIO case where the device is bound to a different driver which
>>>>>> we know won't make any explicit DMA API calls, but for the more
>>>>>> general case of IOMMU-aware drivers we could certainly do with a bit
>>>>>> of cooperation between the IOMMU API, DMA API, and arch code to
>>>>>> update the DMA ops dynamically to cope with intermediate subsystems
>>>>>> making DMA API calls on behalf of devices they don't know the
>>>>>> intimate details of.
>>>>>>
>>>>>>> 2) Older Tegra generations have a limited resource and capabilities in
>>>>>>> regards to IOMMU usage, allocating IOMMU domain per-device is just
>>>>>>> impossible for example.
>>>>>>>
>>>>>>> 3) HW performs context switches and so particular allocations have to
>>>>>>> be
>>>>>>> assigned to a particular contexts IOMMU domain.
>>>>>>
>>>>>> I understand Qualcomm SoCs have a similar thing too, and AFAICS that
>>>>>> case just doesn't fit into the current API model at all. We need the
>>>>>> IOMMU driver to somehow know about the specific details of which
>>>>>> devices have magic associations with specific contexts, and we
>>>>>> almost certainly need a more expressive interface than
>>>>>> iommu_domain_alloc() to have any hope of reliable results.
>>>>>
>>>>> This is correct for Qualcomm GPUs - The GPU hardware context switching
>>>>> requires a specific context and there are some restrictions around
>>>>> secure contexts as well.
>>>>>
>>>>> We don't really care if the DMA attaches to a context just as long as it
>>>>> doesn't attach to the one(s) we care about. Perhaps a "valid context"
>>>>> mask
>>>>> would work in from the DT or the device struct to give the subsystems a
>>>>> clue as to which domains they were allowed to use. I recognize that
>>>>> there
>>>>> isn't a one-size-fits-all solution to this problem so I'm open to
>>>>> different
>>>>> ideas.
>>>>
>>>> Designating whether implicit IOMMU backing is appropriate for a device
>>>> via
>>>> device-tree property sounds a bit awkward because that will be a kinda
>>>> software description (of a custom Linux driver model), while device-tree
>>>> is
>>>> supposed to describe HW.
>>>>
>>>> What about to grant IOMMU drivers with ability to decide whether the
>>>> implicit backing for a device is appropriate? Like this:
>>>>
>>>> bool implicit_iommu_for_dma_is_allowed(struct device *dev)
>>>> {
>>>>
>>>> 	const struct iommu_ops *ops = dev->bus->iommu_ops;
>>>> 	struct iommu_group *group;
>>>> 	
>>>> 	group = iommu_group_get(dev);
>>>> 	if (!group)
>>>> 	
>>>> 		return NULL;
>>>> 	
>>>> 	iommu_group_put(group);
>>>> 	
>>>> 	if (!ops->implicit_iommu_for_dma_is_allowed)
>>>> 	
>>>> 		return true;
>>>> 	
>>>> 	return ops->implicit_iommu_for_dma_is_allowed(dev);
>>>>
>>>> }
>>>>
>>>> Then arch_setup_dma_ops() could have a clue whether implicit IOMMU
>>>> backing
>>>> for a device is appropriate.
>>>
>>> Guys, does it sound good to you or maybe you have something else on your
>>> mind? Even if it's not an ideal solution, it fixes the immediate problem
>>> and should be good enough for the starter.
>>
>> To me that looks like a step ion the wrong direction that won't help at
>> all in actually addressing the underlying issues.
>>
>> If the GPU driver wants to explicitly control IOMMU mappings instead of
>> relying on the IOMMU_DOMAIN_DMA abstraction, then it should use its own
>> unmanaged domain. At that point it shouldn't matter if a DMA ops domain
>> was allocated, since the GPU device will no longer be attached to it.
> 
> It is not obvious to me what solution you are proposing..
> 
> Are you saying that the detaching from the DMA IOMMU domain that is provided
> by dma_ops() implementer (ARM32 arch for example) should be generalized and
> hence there should be something like:
> 
> 	dma_detach_device_from_iommu_dma_domain(dev);
> 
> that drivers will have to invoke.

No, I mean that drivers should not have to care at all. If the device 
has been given a set of DMA ops which rely on it being attached to a 
default DMA domain, that's not the driver's fault and it's not something 
the driver should have deal with. Either the DMA ops themselves should 
be robust and provide a non-IOMMU fallback if they detect that the 
device is currently attached to a different domain, or the attach 
operation (ideally in the IOMMU core, but at worst in the IOMMU driver's 
.attach_dev callback) should automatically tell the arch code to update 
the device's DMA ops appropriately for the target domain. There are 
already examples of both approaches dotted around arch-specific code, so 
the question is which particular solution is most appropriate to 
standardise on in what is intended to be generic code.

> And hence there will be dma_map_ops.iommu_detach_device() that dma_ops()
> provider will have to implement. Thereby provider will detach device from DMA
> domain, destroy the domain and update the DMA ops of the device.
> 
>> Yes, there may be some improvements to make like having unused domains
>> not consume hardware contexts, but that's internal to the relevant IOMMU
>> drivers. If moving in and out of DMA ops domains leaves the actual
>> dma_ops broken, that's already a problem between the IOMMU API and the
>> arch DMA code as I've mentioned before.
>>
>> Furthermore, given what the example above is trying to do,
>> arch_setup_dma_ops() is way too late to do it - the default domain was
>> already set up in iommu_group_get_for_dev() when the IOMMU driver first
>> saw that device. An "opt-out" mechanism that doesn't actually opt out
>> and just bodges around being opted-in after the fact doesn't strike me
>> as something which can grow to be robust and maintainable.
>>
>> For the case where  a device has some special hardware relationship with
>> a particular IOMMU context, the IOMMU driver *has* to be completely
>> aware of that, i.e. it needs to be described in DT/ACPI, either via some
>> explicit binding or at least inferred from some SoC/instance-specific
>> IOMMU compatible. Then the IOMMU driver needs to know when the driver
>> for that device is requesting its special domain so that it provide the
>> correct context (and *not* allocate that context for other uses).
>> Anything which just relies on the order in which things currently happen
>> to be allocated is far too fragile long-term.
> 
> If hardware has some restrictions, then that should be reflected in the
> hardware description. But that's not what we are trying to solve, at least
> there is no such problem right now for NVIDIA Tegra.

OK, maybe I misunderstood "HW performs context switches and so 
particular allocations have to be assigned to a particular contexts 
IOMMU domain." - is it that the domain can be backed by any hardware 
context and the Tegra GPU driver only needs to know *which* one, rather 
then needing a specific hard-wired context to be allocated as in the 
Qcom case?

Robin.
