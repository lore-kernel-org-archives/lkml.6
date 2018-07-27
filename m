Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B69C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB44B2089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB44B2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbeG0RZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:25:15 -0400
Received: from foss.arm.com ([217.140.101.70]:45546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388156AbeG0RZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:25:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5068AED1;
        Fri, 27 Jul 2018 09:02:42 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31CEF3F6A8;
        Fri, 27 Jul 2018 09:02:39 -0700 (PDT)
Subject: Re: [RFC PATCH v1 0/6] Resolve unwanted DMA backing with IOMMU
To:     Dmitry Osipenko <digetx@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     devicetree@vger.kernel.org, Mikko Perttunen <cyndis@kapsi.fi>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        nouveau@lists.freedesktop.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180726231624.21084-1-digetx@gmail.com>
 <20180727082512.lpvmeuvxnw3mpeym@8bytes.org> <20180727090328.GH28088@arm.com>
 <4164951.xGHfcFJ9uZ@dimapc>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <daadd395-dcb7-9505-f171-0fcc28570301@arm.com>
Date:   Fri, 27 Jul 2018 17:02:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4164951.xGHfcFJ9uZ@dimapc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/18 15:10, Dmitry Osipenko wrote:
> On Friday, 27 July 2018 12:03:28 MSK Will Deacon wrote:
>> On Fri, Jul 27, 2018 at 10:25:13AM +0200, Joerg Roedel wrote:
>>> On Fri, Jul 27, 2018 at 02:16:18AM +0300, Dmitry Osipenko wrote:
>>>> The proposed solution adds a new option to the base device driver
>>>> structure that allows device drivers to explicitly convey to the drivers
>>>> core that the implicit IOMMU backing for devices must not happen.
>>>
>>> Why is IOMMU mapping a problem for the Tegra GPU driver?
>>>
>>> If we add something like this then it should not be the choice of the
>>> device driver, but of the user and/or the firmware.
>>
>> Agreed, and it would still need somebody to configure an identity domain so
>> that transactions aren't aborted immediately. We currently allow the
>> identity domain to be used by default via a command-line option, so I guess
>> we'd need a way for firmware to request that on a per-device basis.
> 
> The IOMMU mapping itself is not a problem, the problem is the management of
> the IOMMU. For Tegra we don't want anything to intrude into the IOMMU
> activities because:
> 
> 1) GPU HW require additional configuration for the IOMMU usage and dumb
> mapping of the allocations simply doesn't work.

Generally, that's already handled by the DRM drivers allocating their 
own unmanaged domains. The only problem we really need to solve in that 
regard is that currently the device DMA ops don't get updated when 
moving away from the managed domain. That's been OK for the VFIO case 
where the device is bound to a different driver which we know won't make 
any explicit DMA API calls, but for the more general case of IOMMU-aware 
drivers we could certainly do with a bit of cooperation between the 
IOMMU API, DMA API, and arch code to update the DMA ops dynamically to 
cope with intermediate subsystems making DMA API calls on behalf of 
devices they don't know the intimate details of.

> 2) Older Tegra generations have a limited resource and capabilities in regards
> to IOMMU usage, allocating IOMMU domain per-device is just impossible for
> example.
> 
> 3) HW performs context switches and so particular allocations have to be
> assigned to a particular contexts IOMMU domain.

I understand Qualcomm SoCs have a similar thing too, and AFAICS that 
case just doesn't fit into the current API model at all. We need the 
IOMMU driver to somehow know about the specific details of which devices 
have magic associations with specific contexts, and we almost certainly 
need a more expressive interface than iommu_domain_alloc() to have any 
hope of reliable results.

Robin.

> Some of the above is due to a SW driver model (and its work-in-progress
> status), other is due to a HW model. So essentially we need a way for a driver
> to tell the core not to mess with IOMMU stuff of drivers device behind the
> drivers back.
> 
> I'm not sure what you guys are meaning by the "firmware", could you elaborate
> please? Do you mean the Open Firmware and hence the devicetree or what?
> 
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
