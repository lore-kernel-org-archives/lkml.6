Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0546C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6381320C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6381320C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbeGKQIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:08:38 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39388 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeGKQIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:08:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01F797A9;
        Wed, 11 Jul 2018 09:03:38 -0700 (PDT)
Received: from [10.1.210.23] (e110467-lin.cambridge.arm.com [10.1.210.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73EA33F5B1;
        Wed, 11 Jul 2018 09:03:35 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] Stop losing firmware-set DMA masks
To:     Rob Herring <rob.herring@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        hanjun.guo@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        joro@8bytes.org, x86@kernel.org
References: <cover.1531239284.git.robin.murphy@arm.com>
 <CABGGisxVqLMu3TUpbJGWnUFgzUor-8tdyV8KJeU0YT7y=BHrAQ@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9a54d956-927e-68f7-5c3b-af7cd0616dc2@arm.com>
Date:   Wed, 11 Jul 2018 17:03:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABGGisxVqLMu3TUpbJGWnUFgzUor-8tdyV8KJeU0YT7y=BHrAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/18 15:40, Rob Herring wrote:
> On Tue, Jul 10, 2018 at 12:43 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Whilst the common firmware code invoked by dma_configure() initialises
>> devices' DMA masks according to limitations described by the respective
>> properties ("dma-ranges" for OF and _DMA/IORT for ACPI), the nature of
>> the dma_set_mask() API leads to that information getting lost when
>> well-behaved drivers probe and set a 64-bit mask, since in general
>> there's no way to tell the difference between a firmware-described mask
>> (which should be respected) and whatever default may have come from the
>> bus code (which should be replaced outright). This can break DMA on
>> systems with certain IOMMU topologies (e.g. [1]) where the IOMMU driver
>> only knows its maximum supported address size, not how many of those
>> address bits might actually be wired up between any of its input
>> interfaces and the associated DMA master devices. Similarly, some PCIe
>> root complexes only have a 32-bit native interface on their host bridge,
>> which leads to the same DMA-address-truncation problem in systems with a
>> larger physical memory map and RAM above 4GB (e.g. [2]).
>>
>> These patches attempt to deal with this in the simplest way possible by
>> generalising the specific quirk for 32-bit bridges into an arbitrary
>> mask which can then also be plumbed into the firmware code. In the
>> interest of being minimally invasive, I've only included a point fix
>> for the IOMMU issue as seen on arm64 - there may be further tweaks
>> needed in DMA ops to catch all possible incarnations of this problem,
>> but this initial RFC is mostly about the impact beyond the dma-mapping
>> subsystem itself.
> 
> Couldn't you set and use the device's parent's dma_mask instead. At
> least for DT, we should always have a parent device representing the
> bus. That would avoid further bloating of struct device.

But then if the parent device did have a non-trivial driver which calls 
dma_set_mask(), we'd be back at square 1 :/

More realistically, I don't think that's viable for ACPI, at least with 
IORT, since the memory address size limit belongs to the endpoint 
itself, thus two devices with the same nominal parent in the Linux 
device model could still have different limits (where in DT you'd have 
to have to insert intermediate simple-bus nodes to model the same 
topology with dma-ranges). Plus either way it seems somewhat fragile for 
PCI where the host bridge may be some distance up the hierarchy.

Robin.
