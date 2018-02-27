Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932132AbeB0Mkn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:40:43 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34928 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932111AbeB0Mkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:40:40 -0500
Subject: Re: [PATCH v4 4/6] vfio/type1: check dma map request is within a
 valid iova range
To: Alex Williamson <alex.williamson@redhat.com>,
        Auger Eric <eric.auger@redhat.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        pmorel@linux.vnet.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        john.garry@huawei.com, xuwei5@hisilicon.com
References: <20180221122209.9292-1-shameerali.kolothum.thodi@huawei.com>
 <20180221122209.9292-5-shameerali.kolothum.thodi@huawei.com>
 <818b3bc3-e2e1-e8df-8cca-17e6ecaf4ef9@redhat.com>
 <20180226161310.061ce3a8@w520.home>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0689e5fd-5938-5fbc-1c38-00c21bf3128b@arm.com>
Date: Tue, 27 Feb 2018 12:40:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226161310.061ce3a8@w520.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 26/02/18 23:13, Alex Williamson wrote:
> On Mon, 26 Feb 2018 23:05:43 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
> 
>> Hi Shameer,
>>
>> [Adding Robin in CC]
>> On 21/02/18 13:22, Shameer Kolothum wrote:
>>> This checks and rejects any dma map request outside valid iova
>>> range.
>>>
>>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>   drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>> index a80884e..3049393 100644
>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>> @@ -970,6 +970,23 @@ static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
>>>   	return ret;
>>>   }
>>>   
>>> +/*
>>> + * Check dma map request is within a valid iova range
>>> + */
>>> +static bool vfio_iommu_iova_dma_valid(struct vfio_iommu *iommu,
>>> +				dma_addr_t start, dma_addr_t end)
>>> +{
>>> +	struct list_head *iova = &iommu->iova_list;
>>> +	struct vfio_iova *node;
>>> +
>>> +	list_for_each_entry(node, iova, list) {
>>> +		if ((start >= node->start) && (end <= node->end))
>>> +			return true;
>> I am now confused by the fact this change will prevent existing QEMU
>> from working with this series on some platforms. For instance QEMU virt
>> machine GPA space collides with Seattle PCI host bridge windows. On ARM
>> the smmu and smmuv3 drivers report the PCI host bridge windows as
>> reserved regions which does not seem to be the case on other platforms.
>> The change happened in commit 273df9635385b2156851c7ee49f40658d7bcb29d
>> (iommu/dma: Make PCI window reservation generic).
>>
>> For background, we already discussed the topic after LPC 2016. See
>> https://www.spinics.net/lists/kernel/msg2379607.html.
>>
>> So is it the right choice to expose PCI host bridge windows as reserved
>> regions? If yes shouldn't we make a difference between those and MSI
>> windows in this series and do not reject any user space DMA_MAP attempt
>> within PCI host bridge windows.
> 
> If the QEMU machine GPA collides with a reserved region today, then
> either:
> 
> a) The mapping through the IOMMU works and the reserved region is wrong
> 
> or
> 
> b) The mapping doesn't actually work, QEMU is at risk of data loss by
> being told that it worked, and we're justified in changing that
> behavior.
> 
> Without knowing the specifics of SMMU, it doesn't particularly make
> sense to me to mark the entire PCI hierarchy MMIO range as reserved,
> unless perhaps the IOMMU is incapable of translating those IOVAs.

Yes, the problem in general is that the SMMU *might* be incapable of 
making any use of IOVAs shadowed by PCI p2p addresses, depending on the 
behaviour and/or integration of the root complex/host bridge.

By way of example, the machine on which I developed iommu-dma (Arm Juno) 
has a PCIe RC which doesn't support p2p at all, and happens to have its 
32-bit bridge window placed exactly where qemu-arm starts guest RAM - I 
can plug in a graphics card which claims a nice big BAR from that 
window, assign the whole PCI group to a VM, and watch the NIC blow up in 
the guest as its (IPA) DMA addresses cause the RC to send an abort back 
to the endpoint before the transactions ever get out to the SMMU.

The SMMU itself doesn't know anything about this (e.g. it's the exact 
same IP block as used in AMD Seattle, where AFAIK the AMD root complex 
doesn't suffer the same issue).

> Are we trying to prevent untranslated p2p with this reserved range?
> That's not necessarily a terrible idea, but it seems that doing it for
> that purpose would need to be a lot smarter, taking into account ACS
> and precisely selecting ranges within the peer address space that would
> be untranslated.  Perhaps only populated MMIO within non-ACS
> hierarchies.  Thanks,

The current code is just playing it as safe as it can by always 
reserving the full windows - IIRC there was some debate about whether 
the "only populated MMIO" approach as used by the x86 IOMMUs is really 
safe, given that hotplug and/or BAR reassignment could happen after the 
domain is created. I agree there probably is room to be a bit cleverer 
with respect to ACS, though.

Robin.
