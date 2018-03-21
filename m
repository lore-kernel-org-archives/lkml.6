Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCUD2W convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:28:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:63536 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751521AbeCUD2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:28:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,338,1517904000";
   d="scan'208";a="213220386"
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
 management
Thread-Topic: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
 management
Thread-Index: AQHTvHwRYozEvfc1wUWpRd1V/RZ8waPXOoPQgAIDbACAAM9S8A==
Date: Wed, 21 Mar 2018 03:28:16 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191089B15@SHSMSX101.ccr.corp.intel.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19108585F@SHSMSX101.ccr.corp.intel.com>
 <20180320165514.0f4cd556@t450s.home>
In-Reply-To: <20180320165514.0f4cd556@t450s.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2U5OTU4ZjktMDBjNy00ZjkzLTljOGMtZWZlOWE3MWE1ZjI5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6Ilk3M2FzTE1RU3hCUm5YVEdRVjloWitwcEdpdTlJaTN3TDE3em1UejRRUnM9In0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Wednesday, March 21, 2018 6:55 AM
> 
> On Mon, 19 Mar 2018 08:28:32 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > From: Shameer Kolothum
> > > Sent: Friday, March 16, 2018 12:35 AM
> > >
> > > This series introduces an iova list associated with a vfio
> > > iommu. The list is kept updated taking care of iommu apertures,
> > > and reserved regions. Also this series adds checks for any conflict
> > > with existing dma mappings whenever a new device group is attached
> to
> > > the domain.
> > >
> > > User-space can retrieve valid iova ranges using
> VFIO_IOMMU_GET_INFO
> > > ioctl capability chains. Any dma map request outside the valid iova
> > > range will be rejected.
> >
> > GET_INFO is done at initialization time which is good for cold attached
> > devices. If a hotplugged device may cause change of valid iova ranges
> > at run-time, then there could be potential problem (which however is
> > difficult for user space or orchestration stack to figure out in advance)
> > Can we do some extension like below to make hotplug case cleaner?
> 
> Let's be clear what we mean by hotplug here, as I see it, the only
> relevant hotplug would be a physical device, hot added to the host,
> which becomes a member of an existing, in-use IOMMU group.  If, on the
> other hand, we're talking about hotplug related to the user process,
> there's nothing asynchronous about that.  For instance in the QEMU
> case, QEMU must add the group to the container, at which point it can
> evaluate the new iova list and remove the group from the container if
> it doesn't like the result.  So what would be a case of the available
> iova list for a group changing as a result of adding a device?

My original thought was about the latter case. At that moment 
I was not sure whether the window between adding/removing 
the group may cause some issue if there are right some IOVA 
allocations happening in parallel. But looks Qemu can anyway
handle it well as long as such scenario is considered.

> 
> > - An interface allowing user space to request VFIO rejecting further
> > attach_group if doing so may cause iova range change. e.g. Qemu can
> > do such request once completing initial GET_INFO;
> 
> For the latter case above, it seems unnecessary, QEMU can revert the
> attach, we're only promising that the attach won't interfere with
> existing mappings.  For the host hotplug case, the user has no control,
> the new device is a member of the iommu group and therefore necessarily
> becomes a part of container.  I imagine there are plenty of other holes
> in this scenario already.
> 
> > - or an event notification to user space upon change of valid iova
> > ranges when attaching a new device at run-time. It goes one step
> > further - even attach may cause iova range change, it may still
> > succeed as long as Qemu hasn't allocated any iova in impacted
> > range
> 
> Same as above, in the QEMU hotplug case, the user is orchestrating the
> adding of the group to the container, they can then check the iommu
> info on their own and determine what, if any, changes are relevant to
> them, knowing that the addition would not succeed if any current
> mappings where affected.  In the host case, a notification would be
> required, but we'd first need to identify exactly how the iova list can
> change asynchronous to the user doing anything.  Thanks,

for host hotplug, possibly notification could be an opt-in model.
meaning if user space doesn't explicitly request receiving notification 
on such event, the device is just left in unused state (vfio-pci still
claims the device, assuming it assigned to the container owner, but
the owner doesn't use it)

Thanks
Kevin
