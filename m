Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeB0Q5k (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:57:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751793AbeB0Q5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:57:38 -0500
Date: Tue, 27 Feb 2018 09:57:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        pmorel@linux.vnet.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        john.garry@huawei.com, xuwei5@hisilicon.com,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 4/6] vfio/type1: check dma map request is within a
 valid iova range
Message-ID: <20180227095733.62372ead@w520.home>
In-Reply-To: <aefca16f-570f-36d1-a493-f0a477736ef0@redhat.com>
References: <20180221122209.9292-1-shameerali.kolothum.thodi@huawei.com>
        <20180221122209.9292-5-shameerali.kolothum.thodi@huawei.com>
        <818b3bc3-e2e1-e8df-8cca-17e6ecaf4ef9@redhat.com>
        <20180226161310.061ce3a8@w520.home>
        <aefca16f-570f-36d1-a493-f0a477736ef0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 09:26:37 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi,
> On 27/02/18 00:13, Alex Williamson wrote:
> > On Mon, 26 Feb 2018 23:05:43 +0100
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> >> Hi Shameer,
> >>
> >> [Adding Robin in CC]
> >> On 21/02/18 13:22, Shameer Kolothum wrote:  
> >>> This checks and rejects any dma map request outside valid iova
> >>> range.
> >>>
> >>> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >>> ---
> >>>  drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++++++
> >>>  1 file changed, 22 insertions(+)
> >>>
> >>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >>> index a80884e..3049393 100644
> >>> --- a/drivers/vfio/vfio_iommu_type1.c
> >>> +++ b/drivers/vfio/vfio_iommu_type1.c
> >>> @@ -970,6 +970,23 @@ static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
> >>>  	return ret;
> >>>  }
> >>>  
> >>> +/*
> >>> + * Check dma map request is within a valid iova range
> >>> + */
> >>> +static bool vfio_iommu_iova_dma_valid(struct vfio_iommu *iommu,
> >>> +				dma_addr_t start, dma_addr_t end)
> >>> +{
> >>> +	struct list_head *iova = &iommu->iova_list;
> >>> +	struct vfio_iova *node;
> >>> +
> >>> +	list_for_each_entry(node, iova, list) {
> >>> +		if ((start >= node->start) && (end <= node->end))
> >>> +			return true;    
> >> I am now confused by the fact this change will prevent existing QEMU
> >> from working with this series on some platforms. For instance QEMU virt
> >> machine GPA space collides with Seattle PCI host bridge windows. On ARM
> >> the smmu and smmuv3 drivers report the PCI host bridge windows as
> >> reserved regions which does not seem to be the case on other platforms.
> >> The change happened in commit 273df9635385b2156851c7ee49f40658d7bcb29d
> >> (iommu/dma: Make PCI window reservation generic).
> >>
> >> For background, we already discussed the topic after LPC 2016. See
> >> https://www.spinics.net/lists/kernel/msg2379607.html.
> >>
> >> So is it the right choice to expose PCI host bridge windows as reserved
> >> regions? If yes shouldn't we make a difference between those and MSI
> >> windows in this series and do not reject any user space DMA_MAP attempt
> >> within PCI host bridge windows.  
> > 
> > If the QEMU machine GPA collides with a reserved region today, then
> > either:
> > 
> > a) The mapping through the IOMMU works and the reserved region is wrong
> > 
> > or
> > 
> > b) The mapping doesn't actually work, QEMU is at risk of data loss by
> > being told that it worked, and we're justified in changing that
> > behavior.
> > 
> > Without knowing the specifics of SMMU, it doesn't particularly make
> > sense to me to mark the entire PCI hierarchy MMIO range as reserved,
> > unless perhaps the IOMMU is incapable of translating those IOVAs.  
> to me the limitation does not come from the smmu itself, which is a
> separate HW block sitting between the root complex and the interconnect.
> If ACS is not enforced by the PCIe subsystem, the transaction will never
> reach the IOMMU.

If the limitation is not from the SMMU, then why is it being exposed
via the IOMMU API?  This seems like overreach, trying to compensate for
a limitation elsewhere by imposing a restriction at the IOMMU.

> In the case of such overlap, shouldn't we just warn the end-user that
> this situation is dangerous instead of forbidding the use case which
> worked "in most cases" until now.

How do we distinguish between reserved ranges that are really reserved
and those that are only an advisory?  This seems like it defeats the
whole purpose of the reserved ranges.  Furthermore, if our vfio IOVA
list to the user is only advisory, what's the point?

Peer-to-peer MMIO within an IOMMU group is a tough problem, and one
that we've mostly ignored as we strive towards singleton IOMMU groups,
which are more the normal case on "enterprise" x86 hardware.  The user
does have some ability to determine potential conflicts, so I don't
necessarily see this as exclusively a kernel issue to solve.  However,
if the user needs to account for potentially conflicting MMIO outside of
the IOMMU group which they're provided, then yeah, we have a bigger
issue.  Thanks,

Alex
