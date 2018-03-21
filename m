Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCURLP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 13:11:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeCURLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 13:11:14 -0400
Date: Wed, 21 Mar 2018 11:11:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
 management
Message-ID: <20180321111110.34258235@w520.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191089B15@SHSMSX101.ccr.corp.intel.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19108585F@SHSMSX101.ccr.corp.intel.com>
        <20180320165514.0f4cd556@t450s.home>
        <AADFC41AFE54684AB9EE6CBC0274A5D191089B15@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018 03:28:16 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Wednesday, March 21, 2018 6:55 AM
> > 
> > On Mon, 19 Mar 2018 08:28:32 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > > From: Shameer Kolothum
> > > > Sent: Friday, March 16, 2018 12:35 AM
> > > >
> > > > This series introduces an iova list associated with a vfio
> > > > iommu. The list is kept updated taking care of iommu apertures,
> > > > and reserved regions. Also this series adds checks for any conflict
> > > > with existing dma mappings whenever a new device group is attached  
> > to  
> > > > the domain.
> > > >
> > > > User-space can retrieve valid iova ranges using  
> > VFIO_IOMMU_GET_INFO  
> > > > ioctl capability chains. Any dma map request outside the valid iova
> > > > range will be rejected.  
> > >
> > > GET_INFO is done at initialization time which is good for cold attached
> > > devices. If a hotplugged device may cause change of valid iova ranges
> > > at run-time, then there could be potential problem (which however is
> > > difficult for user space or orchestration stack to figure out in advance)
> > > Can we do some extension like below to make hotplug case cleaner?  
> > 
> > Let's be clear what we mean by hotplug here, as I see it, the only
> > relevant hotplug would be a physical device, hot added to the host,
> > which becomes a member of an existing, in-use IOMMU group.  If, on the
> > other hand, we're talking about hotplug related to the user process,
> > there's nothing asynchronous about that.  For instance in the QEMU
> > case, QEMU must add the group to the container, at which point it can
> > evaluate the new iova list and remove the group from the container if
> > it doesn't like the result.  So what would be a case of the available
> > iova list for a group changing as a result of adding a device?  
> 
> My original thought was about the latter case. At that moment 
> I was not sure whether the window between adding/removing 
> the group may cause some issue if there are right some IOVA 
> allocations happening in parallel. But looks Qemu can anyway
> handle it well as long as such scenario is considered.

I believe the kernel patches here and the existing code are using
locking to prevent races between mapping changes and device changes, so
the acceptance of a new group into a container and the iova list for a
container should always be correct for the order these operations
arrive.  Beyond that, I don't believe it's the kernel's responsibility
to do anything more than block groups from being added if they conflict
with current mappings.  The user already has the minimum interfaces
they need to manage other scenarios.

> > > - An interface allowing user space to request VFIO rejecting further
> > > attach_group if doing so may cause iova range change. e.g. Qemu can
> > > do such request once completing initial GET_INFO;  
> > 
> > For the latter case above, it seems unnecessary, QEMU can revert the
> > attach, we're only promising that the attach won't interfere with
> > existing mappings.  For the host hotplug case, the user has no control,
> > the new device is a member of the iommu group and therefore necessarily
> > becomes a part of container.  I imagine there are plenty of other holes
> > in this scenario already.
> >   
> > > - or an event notification to user space upon change of valid iova
> > > ranges when attaching a new device at run-time. It goes one step
> > > further - even attach may cause iova range change, it may still
> > > succeed as long as Qemu hasn't allocated any iova in impacted
> > > range  
> > 
> > Same as above, in the QEMU hotplug case, the user is orchestrating the
> > adding of the group to the container, they can then check the iommu
> > info on their own and determine what, if any, changes are relevant to
> > them, knowing that the addition would not succeed if any current
> > mappings where affected.  In the host case, a notification would be
> > required, but we'd first need to identify exactly how the iova list can
> > change asynchronous to the user doing anything.  Thanks,  
> 
> for host hotplug, possibly notification could be an opt-in model.
> meaning if user space doesn't explicitly request receiving notification 
> on such event, the device is just left in unused state (vfio-pci still
> claims the device, assuming it assigned to the container owner, but
> the owner doesn't use it)

Currently, if a device is added to a live group, the kernel will print
a warning.  We have a todo to bind that device to a vfio-bus driver,
but I'm not sure that isn't an overreach into the system policy
decisions.  If system policy decides to bind to a vfio bus driver, all
is well, but we might be missing the iommu backend adding the device to
the iommu domain, so it probably won't work unless the requester ID is
actually aliased to the IOMMU (such as a conventional PCI device), a
standard PCIe device simply wouldn't be part of the IOMMU domain and
would generate IOMMU faults if the user attempts to use it (AFAICT).
OTOH, if system policy binds the device to a native host driver, then
the integrity of the group for userspace use is compromised, which is
terminated with prejudice via a BUG.  Obviously the user is never
obligated to listen to signals and we don't provide a signal here as
this scenario is mostly theoretical, though it would be relatively easy
with software hotplug to artificially induce such a condition.

However, I'm still not sure how adding a device to a group is
necessarily relevant to this series, particularly how it would change
the iova list.  When we add groups to a container, we're potentially
crossing boundaries between IOMMUs and may therefore pickup new
reserved resource requirements, but devices within a group seem like
reserved regions should already be accounted for in the existing group.
At least so long as we've decided reserved regions are only the IOMMU
imposed reserved regions and not routing within the group, which we've
hand waved as the user's problem already.  Thanks,

Alex
