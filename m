Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946754AbeCBQE2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:04:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1946722AbeCBQEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:04:21 -0500
Date: Fri, 2 Mar 2018 09:04:17 -0700
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
Message-ID: <20180302090417.05ade6df@t450s.home>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838664702@FRAEML521-MBX.china.huawei.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2018 13:19:58 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Wednesday, February 28, 2018 3:24 PM
> > To: Auger Eric <eric.auger@redhat.com>
> > Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > pmorel@linux.vnet.ibm.com; kvm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; John Garry
> > <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Robin Murphy
> > <robin.murphy@arm.com>
> > Subject: Re: [PATCH v4 4/6] vfio/type1: check dma map request is within a valid
> > iova range
> > 
> > On Wed, 28 Feb 2018 12:53:27 +0100
> > Auger Eric <eric.auger@redhat.com> wrote:
> >   
> > > Hi Shameer,
> > >
> > > On 28/02/18 10:25, Shameerali Kolothum Thodi wrote:  
> > > >
> > > >  
> > > >> -----Original Message-----
> > > >> From: Auger Eric [mailto:eric.auger@redhat.com]
> > > >> Sent: Wednesday, February 28, 2018 9:02 AM
> > > >> To: Shameerali Kolothum Thodi  
> > <shameerali.kolothum.thodi@huawei.com>;  
> > > >> Alex Williamson <alex.williamson@redhat.com>
> > > >> Cc: pmorel@linux.vnet.ibm.com; kvm@vger.kernel.org; linux-
> > > >> kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; John Garry
> > > >> <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Robin  
> > Murphy  
> > > >> <robin.murphy@arm.com>
> > > >> Subject: Re: [PATCH v4 4/6] vfio/type1: check dma map request is within a  
> > valid  
> > > >> iova range
> > > >>
> > > >> Hi Shameer,
> > > >>
> > > >> On 27/02/18 10:57, Shameerali Kolothum Thodi wrote:  
> > > >>>
> > > >>>  
> > > >>>> -----Original Message-----
> > > >>>> From: Auger Eric [mailto:eric.auger@redhat.com]
> > > >>>> Sent: Tuesday, February 27, 2018 8:27 AM
> > > >>>> To: Alex Williamson <alex.williamson@redhat.com>
> > > >>>> Cc: Shameerali Kolothum Thodi  
> > <shameerali.kolothum.thodi@huawei.com>;  
> > > >>>> pmorel@linux.vnet.ibm.com; kvm@vger.kernel.org; linux-
> > > >>>> kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; John  
> > Garry  
> > > >>>> <john.garry@huawei.com>; xuwei (O) <xuwei5@huawei.com>; Robin  
> > > >> Murphy  
> > > >>>> <robin.murphy@arm.com>
> > > >>>> Subject: Re: [PATCH v4 4/6] vfio/type1: check dma map request is within  
> > a  
> > > >> valid  
> > > >>>> iova range
> > > >>>>
> > > >>>> Hi,
> > > >>>> On 27/02/18 00:13, Alex Williamson wrote:  
> > > >>>>> On Mon, 26 Feb 2018 23:05:43 +0100
> > > >>>>> Auger Eric <eric.auger@redhat.com> wrote:
> > > >>>>>  
> > > >>>>>> Hi Shameer,
> > > >>>>>>
> > > >>>>>> [Adding Robin in CC]
> > > >>>>>> On 21/02/18 13:22, Shameer Kolothum wrote:  
> > > >>>>>>> This checks and rejects any dma map request outside valid iova
> > > >>>>>>> range.
> > > >>>>>>>
> > > >>>>>>> Signed-off-by: Shameer Kolothum  
> > > >>>> <shameerali.kolothum.thodi@huawei.com>  
> > > >>>>>>> ---
> > > >>>>>>>  drivers/vfio/vfio_iommu_type1.c | 22 ++++++++++++++++++++++
> > > >>>>>>>  1 file changed, 22 insertions(+)
> > > >>>>>>>
> > > >>>>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c  
> > > >>>> b/drivers/vfio/vfio_iommu_type1.c  
> > > >>>>>>> index a80884e..3049393 100644
> > > >>>>>>> --- a/drivers/vfio/vfio_iommu_type1.c
> > > >>>>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
> > > >>>>>>> @@ -970,6 +970,23 @@ static int vfio_pin_map_dma(struct  
> > vfio_iommu  
> > > >>>> *iommu, struct vfio_dma *dma,  
> > > >>>>>>>  	return ret;
> > > >>>>>>>  }
> > > >>>>>>>
> > > >>>>>>> +/*
> > > >>>>>>> + * Check dma map request is within a valid iova range
> > > >>>>>>> + */
> > > >>>>>>> +static bool vfio_iommu_iova_dma_valid(struct vfio_iommu  
> > *iommu,  
> > > >>>>>>> +				dma_addr_t start, dma_addr_t end)
> > > >>>>>>> +{
> > > >>>>>>> +	struct list_head *iova = &iommu->iova_list;
> > > >>>>>>> +	struct vfio_iova *node;
> > > >>>>>>> +
> > > >>>>>>> +	list_for_each_entry(node, iova, list) {
> > > >>>>>>> +		if ((start >= node->start) && (end <= node->end))
> > > >>>>>>> +			return true;  
> > > >>>>>> I am now confused by the fact this change will prevent existing QEMU
> > > >>>>>> from working with this series on some platforms. For instance QEMU  
> > virt  
> > > >>>>>> machine GPA space collides with Seattle PCI host bridge windows. On  
> > > >> ARM  
> > > >>>>>> the smmu and smmuv3 drivers report the PCI host bridge windows as
> > > >>>>>> reserved regions which does not seem to be the case on other  
> > platforms.  
> > > >>>>>> The change happened in commit  
> > > >>>> 273df9635385b2156851c7ee49f40658d7bcb29d  
> > > >>>>>> (iommu/dma: Make PCI window reservation generic).
> > > >>>>>>
> > > >>>>>> For background, we already discussed the topic after LPC 2016. See
> > > >>>>>> https://www.spinics.net/lists/kernel/msg2379607.html.
> > > >>>>>>
> > > >>>>>> So is it the right choice to expose PCI host bridge windows as reserved
> > > >>>>>> regions? If yes shouldn't we make a difference between those and  
> > MSI  
> > > >>>>>> windows in this series and do not reject any user space DMA_MAP  
> > > >> attempt  
> > > >>>>>> within PCI host bridge windows.  
> > > >>>>>
> > > >>>>> If the QEMU machine GPA collides with a reserved region today, then
> > > >>>>> either:
> > > >>>>>
> > > >>>>> a) The mapping through the IOMMU works and the reserved region is  
> > > >> wrong  
> > > >>>>>
> > > >>>>> or
> > > >>>>>
> > > >>>>> b) The mapping doesn't actually work, QEMU is at risk of data loss by
> > > >>>>> being told that it worked, and we're justified in changing that
> > > >>>>> behavior.
> > > >>>>>
> > > >>>>> Without knowing the specifics of SMMU, it doesn't particularly make
> > > >>>>> sense to me to mark the entire PCI hierarchy MMIO range as  
> > reserved,  
> > > >>>>> unless perhaps the IOMMU is incapable of translating those IOVAs.  
> > > >>>> to me the limitation does not come from the smmu itself, which is a
> > > >>>> separate HW block sitting between the root complex and the  
> > interconnect.  
> > > >>>> If ACS is not enforced by the PCIe subsystem, the transaction will never
> > > >>>> reach the IOMMU.  
> > > >>>
> > > >>> True. And we do have one such platform where ACS is not enforced but
> > > >>> reserving the regions and possibly creating holes while launching VM will
> > > >>> make it secure. But I do wonder how we will solve the device grouping
> > > >>> in such cases.
> > > >>>
> > > >>> The Seattle PCI host bridge windows case you mentioned has any pci  
> > quirk  
> > > >>> to claim that they support ACS?  
> > > >> No there is none to my knowledge. I am applying Alex' not upstream ACS
> > > >> overwrite patch.  
> > > >
> > > > Ok. But isn't that patch actually applicable to cases where ACS is really  
> > supported  
> > > > by hardware but the capability is not available?  
> > >
> > > My understanding is normally yes. If you apply the patch whereas the HW
> > > practically does not support ACS, then you fool the kernel pretending
> > > there is isolation whereas there is not. I don't know the exact
> > > capability of the HW on AMD Seattle and effectively I should have cared
> > > about it much earlier and if the HW capability were supported and not
> > > properly exposed we should have implemented a clean quirk for this  
> > platform.
> > 
> > Yes, there's a reason why the ACS override patch is not upstream, and
> > any downstream distribution that actually intends to support their
> > customers should not include it.  If we can verify with the hardware
> > vendor that ACS equivalent isolation exists, we should be putting
> > quirks into the kernel to enable it automatically.  Supporting users
> > using the ACS override patch is a non-goal.
> >   
> > >   I am just trying to see whether  
> > > > the argument that we should allow DMA MAP requests for this(non-ACS  
> > case)  
> > > > even if the Guest GPA conflict with reserved region holds good. The fact  
> > that may  
> > > > be it was working before is that the Guest never actually allocated any GPA  
> > from  
> > > > the reserved region or maybe I am missing something here.  
> > >
> > > If my understanding is correct, in ideal world we would report the PCI
> > > host bridge window as reserved only in case ACS is not supported. If you
> > > apply the patch and overrides the ACS, then the DMA_MAP  would be
> > > allowed. In case the HW does not support ACS, then you could face
> > > situations where one EP tries to access GPA that never reaches the IOMMU
> > > (because it corresponds to the BAR of another downstream EP). Same can
> > > happen at the moment.  
> > 
> > I still think you're overstretching the IOMMU reserved region interface
> > by trying to report possible ACS conflicts.  Are we going to update the
> > reserved list on device hotplug?  Are we going to update the list when
> > MMIO is enabled or disabled for each device?  What if the BARs are
> > reprogrammed or bridge apertures changed?  IMO, the IOMMU reserved list
> > should account for specific IOVA exclusions that apply to transactions
> > that actually reach the IOMMU, not aliasing that might occur in the
> > downstream topology.  Additionally, the IOMMU group composition must be
> > such that these sorts of aliasing issues can only occur within an IOMMU
> > group.  If a transaction can be affected by the MMIO programming of
> > another group, then the groups are drawn incorrectly for the isolation
> > capabilities of the hardware.  Thanks,  
> 
> Agree that this is not a perfect thing to do covering all scenarios. As Robin
> pointed out, the current code is playing safe by reserving the full windows.
> 
> My suggestion will be to limit this reservation to non-ACS cases only.  This will
> make sure that ACS ARM hardware is not broken by this series and nos-ACS
> ones has a chance to run once Qemu is updated to take care of the reserved
> regions (at least in some user scenarios).
> 
> If you all are fine with this, I can include the ACS check I mentioned earlier in
> iommu_dma_get_resv_regions() and sent out the revised  series.
> 
> Please let me know your thoughts.

IMO, the IOMMU should be concerned with ACS as far as isolation is
concerned and reporting reserved ranges that are imposed at the IOMMU
and leave any aliasing or routing issues in the downstream topology to
other layers, or perhaps to the user.  Unfortunately, enforcing the
iova list in vfio is gated by some movement here since we can't break
existing users.  Thanks,

Alex
