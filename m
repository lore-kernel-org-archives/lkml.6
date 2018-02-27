Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeB0RN4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:13:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750997AbeB0RNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:13:54 -0500
Date: Tue, 27 Feb 2018 10:13:48 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Auger Eric <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 4/6] vfio/type1: check dma map request is within a
 valid iova range
Message-ID: <20180227101348.162dd65e@w520.home>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83865CDE3@FRAEML521-MBX.china.huawei.com>
References: <20180221122209.9292-1-shameerali.kolothum.thodi@huawei.com>
        <20180221122209.9292-5-shameerali.kolothum.thodi@huawei.com>
        <818b3bc3-e2e1-e8df-8cca-17e6ecaf4ef9@redhat.com>
        <20180226161310.061ce3a8@w520.home>
        <aefca16f-570f-36d1-a493-f0a477736ef0@redhat.com>
        <5FC3163CFD30C246ABAA99954A238FA83865CDE3@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 09:57:16 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Auger Eric [mailto:eric.auger@redhat.com]
> > Sent: Tuesday, February 27, 2018 8:27 AM
> > To: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > pmorel@linux.vnet.ibm.com; kvm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; John Garry
> > <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Robin Murphy
> > <robin.murphy@arm.com>
> > Subject: Re: [PATCH v4 4/6] vfio/type1: check dma map request is within a valid
> > iova range
> > 
> > Hi,
> > On 27/02/18 00:13, Alex Williamson wrote:  
> > > On Mon, 26 Feb 2018 23:05:43 +0100
> > > Auger Eric <eric.auger@redhat.com> wrote:
> > >  
> > >> Hi Shameer,
> > >>
> > >> [Adding Robin in CC]
> > >> On 21/02/18 13:22, Shameer Kolothum wrote:  
> > >>> This checks and rejects any dma map request outside valid iova
> > >>> range.
> > >>>
> > >>> Signed-off-by: Shameer Kolothum  
> > <shameerali.kolothum.thodi@huawei.com>  
> > >>> ---
> > >>>  drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++++++
> > >>>  1 file changed, 22 insertions(+)
> > >>>
> > >>> diff --git a/drivers/vfio/vfio_iommu_type1.c  
> > b/drivers/vfio/vfio_iommu_type1.c  
> > >>> index a80884e..3049393 100644
> > >>> --- a/drivers/vfio/vfio_iommu_type1.c
> > >>> +++ b/drivers/vfio/vfio_iommu_type1.c
> > >>> @@ -970,6 +970,23 @@ static int vfio_pin_map_dma(struct vfio_iommu  
> > *iommu, struct vfio_dma *dma,  
> > >>>  	return ret;
> > >>>  }
> > >>>
> > >>> +/*
> > >>> + * Check dma map request is within a valid iova range
> > >>> + */
> > >>> +static bool vfio_iommu_iova_dma_valid(struct vfio_iommu *iommu,
> > >>> +				dma_addr_t start, dma_addr_t end)
> > >>> +{
> > >>> +	struct list_head *iova = &iommu->iova_list;
> > >>> +	struct vfio_iova *node;
> > >>> +
> > >>> +	list_for_each_entry(node, iova, list) {
> > >>> +		if ((start >= node->start) && (end <= node->end))
> > >>> +			return true;  
> > >> I am now confused by the fact this change will prevent existing QEMU
> > >> from working with this series on some platforms. For instance QEMU virt
> > >> machine GPA space collides with Seattle PCI host bridge windows. On ARM
> > >> the smmu and smmuv3 drivers report the PCI host bridge windows as
> > >> reserved regions which does not seem to be the case on other platforms.
> > >> The change happened in commit  
> > 273df9635385b2156851c7ee49f40658d7bcb29d  
> > >> (iommu/dma: Make PCI window reservation generic).
> > >>
> > >> For background, we already discussed the topic after LPC 2016. See
> > >> https://www.spinics.net/lists/kernel/msg2379607.html.
> > >>
> > >> So is it the right choice to expose PCI host bridge windows as reserved
> > >> regions? If yes shouldn't we make a difference between those and MSI
> > >> windows in this series and do not reject any user space DMA_MAP attempt
> > >> within PCI host bridge windows.  
> > >
> > > If the QEMU machine GPA collides with a reserved region today, then
> > > either:
> > >
> > > a) The mapping through the IOMMU works and the reserved region is wrong
> > >
> > > or
> > >
> > > b) The mapping doesn't actually work, QEMU is at risk of data loss by
> > > being told that it worked, and we're justified in changing that
> > > behavior.
> > >
> > > Without knowing the specifics of SMMU, it doesn't particularly make
> > > sense to me to mark the entire PCI hierarchy MMIO range as reserved,
> > > unless perhaps the IOMMU is incapable of translating those IOVAs.  
> > to me the limitation does not come from the smmu itself, which is a
> > separate HW block sitting between the root complex and the interconnect.
> > If ACS is not enforced by the PCIe subsystem, the transaction will never
> > reach the IOMMU.  
> 
> True. And we do have one such platform where ACS is not enforced but 
> reserving the regions and possibly creating holes while launching VM will
> make it secure. But I do wonder how we will solve the device grouping
> in such cases. 

"creating holes... will make it secure", that's worrisome.  The purpose
of an IOVA list is to inform the user which ranges are available to
them to use.  This is informative, not security.  A malicious user can
ask the device to perform DMA anywhere they choose, regardless of what
we report as reserved.  The hardware provides the security, if we're
relying on the user to honor holes, that's only cooperative security,
which is really no security at all.  If the IOMMU groups don't already
reflect this, they're incorrect.
 
> The Seattle PCI host bridge windows case you mentioned has any pci quirk 
> to claim that they support ACS?
>  
> > In the case of such overlap, shouldn't we just warn the end-user that
> > this situation is dangerous instead of forbidding the use case which
> > worked "in most cases" until now.  
> 
> Yes, may be something similar to the allow_unsafe_interrupts case, if
> that is acceptable.

"allow_unsafe_interrupts" is basically a statement that the user trusts
their user is not malicious and will not exploit potential DMA
attacks.  I'm having a little bit of trouble equating that to allowing
the user to ignore the list of valid IOVA ranges we've provided.  Why
provide a list at all if it's ignored?  If there's grey area in the
list for things the user can choose to ignore, then the list is
invalid.  Thanks,

Alex
