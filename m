Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946472AbeCBRQk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 12:16:40 -0500
Received: from foss.arm.com ([217.140.101.70]:58974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946081AbeCBRQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 12:16:39 -0500
Subject: Re: [PATCH v4 4/6] vfio/type1: check dma map request is within a
 valid iova range
To: Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi
        <shameerali.kolothum.thodi@huawei.com>
Cc: Auger Eric <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>
References: <20180221122209.9292-1-shameerali.kolothum.thodi@huawei.com>
 <20180221122209.9292-5-shameerali.kolothum.thodi@huawei.com>
 <818b3bc3-e2e1-e8df-8cca-17e6ecaf4ef9@redhat.com>
 <20180226161310.061ce3a8@w520.home>
 <aefca16f-570f-36d1-a493-f0a477736ef0@redhat.com>
 <5FC3163CFD30C246ABAA99954A238FA83865CDE3@FRAEML521-MBX.china.huawei.com>
 <238c74e1-dd3c-f626-0cda-82c6d840d772@redhat.com>
 <5FC3163CFD30C246ABAA99954A238FA83865DBD3@FRAEML521-MBX.china.huawei.com>
 <2056267c-dab1-fa71-5dcb-4db80266c568@redhat.com>
 <20180228082417.07c42a88@w520.home>
 <5FC3163CFD30C246ABAA99954A238FA838664702@FRAEML521-MBX.china.huawei.com>
 <20180302090417.05ade6df@t450s.home>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <22b61209-61b6-207d-9d70-1db6ae630fc1@arm.com>
Date: Fri, 2 Mar 2018 17:16:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302090417.05ade6df@t450s.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/18 16:04, Alex Williamson wrote:
[...]
>>> I still think you're overstretching the IOMMU reserved region interface
>>> by trying to report possible ACS conflicts.  Are we going to update the
>>> reserved list on device hotplug?  Are we going to update the list when
>>> MMIO is enabled or disabled for each device?  What if the BARs are
>>> reprogrammed or bridge apertures changed?  IMO, the IOMMU reserved list
>>> should account for specific IOVA exclusions that apply to transactions
>>> that actually reach the IOMMU, not aliasing that might occur in the
>>> downstream topology.  Additionally, the IOMMU group composition must be
>>> such that these sorts of aliasing issues can only occur within an IOMMU
>>> group.  If a transaction can be affected by the MMIO programming of
>>> another group, then the groups are drawn incorrectly for the isolation
>>> capabilities of the hardware.  Thanks,
>>
>> Agree that this is not a perfect thing to do covering all scenarios. As Robin
>> pointed out, the current code is playing safe by reserving the full windows.
>>
>> My suggestion will be to limit this reservation to non-ACS cases only.  This will
>> make sure that ACS ARM hardware is not broken by this series and nos-ACS
>> ones has a chance to run once Qemu is updated to take care of the reserved
>> regions (at least in some user scenarios).
>>
>> If you all are fine with this, I can include the ACS check I mentioned earlier in
>> iommu_dma_get_resv_regions() and sent out the revised  series.
>>
>> Please let me know your thoughts.
> 
> IMO, the IOMMU should be concerned with ACS as far as isolation is
> concerned and reporting reserved ranges that are imposed at the IOMMU
> and leave any aliasing or routing issues in the downstream topology to
> other layers, or perhaps to the user.  Unfortunately, enforcing the
> iova list in vfio is gated by some movement here since we can't break
> existing users.  Thanks,

FWIW, given the discussion we've had here I wouldn't object to pushing 
the PCI window reservation back into the DMA-specific path, such that it 
doesn't get exposed via the general IOMMU API interface. We *do* want to 
do it there where we are in total control of our own address space and 
it just avoids a whole class of problems (even with ACS I'm not sure the 
root complex can be guaranteed to send a "bad" IOVA out to the SMMU 
instead of just terminating it for looking like a peer-to-peer attempt).

I do agree that it's not scalable for the IOMMU layer to attempt to 
detect and describe upstream PCI limitations to userspace by itself - 
they are "reserved regions" rather than "may or may not work regions" 
after all. If there is a genuine integration issue between an IOMMU and 
an upstream PCI RC which restricts usable addresses on a given system, 
that probably needs to be explicitly communicated from firmware to the 
IOMMU driver anyway, at which point that driver can report the relevant 
region(s) directly from its own callback.

I suppose there's an in-between option of keeping generic window 
reservations but giving them a new "only reserve this if you're being 
super-cautious or don't know better" region type which we hide from 
userspace and ignore in VFIO, but maybe that leaves the lines a but too 
blurred still.

Robin.
