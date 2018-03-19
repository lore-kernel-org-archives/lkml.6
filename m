Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932689AbeCSI2m convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:28:42 -0400
Received: from mga18.intel.com ([134.134.136.126]:51232 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932418AbeCSI2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:28:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,329,1517904000";
   d="scan'208";a="25662011"
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei5@hisilicon.com" <xuwei5@hisilicon.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
 management
Thread-Topic: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
 management
Thread-Index: AQHTvHwRYozEvfc1wUWpRd1V/RZ8waPXOoPQ
Date: Mon, 19 Mar 2018 08:28:32 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19108585F@SHSMSX101.ccr.corp.intel.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzkyOGM3MTktMTg4YS00MmU0LTllMDgtZDEzODQwNTk1NTcxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IkxHRWZNc2JEUmNMUnhPUVN0N25yaUdicnpORVpkaTIrZ0wwSHdxQnEyT1k9In0=
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

> From: Shameer Kolothum
> Sent: Friday, March 16, 2018 12:35 AM
> 
> This series introduces an iova list associated with a vfio
> iommu. The list is kept updated taking care of iommu apertures,
> and reserved regions. Also this series adds checks for any conflict
> with existing dma mappings whenever a new device group is attached to
> the domain.
> 
> User-space can retrieve valid iova ranges using VFIO_IOMMU_GET_INFO
> ioctl capability chains. Any dma map request outside the valid iova
> range will be rejected.

GET_INFO is done at initialization time which is good for cold attached
devices. If a hotplugged device may cause change of valid iova ranges
at run-time, then there could be potential problem (which however is
difficult for user space or orchestration stack to figure out in advance)
Can we do some extension like below to make hotplug case cleaner?

- An interface allowing user space to request VFIO rejecting further 
attach_group if doing so may cause iova range change. e.g. Qemu can 
do such request once completing initial GET_INFO;

- or an event notification to user space upon change of valid iova
ranges when attaching a new device at run-time. It goes one step 
further - even attach may cause iova range change, it may still
succeed as long as Qemu hasn't allocated any iova in impacted 
range

Thanks
Kevin

> 
> 
> v4 --> v5
> Rebased to next-20180315.
> 
>  -Incorporated the corner case bug fix suggested by Alex to patch #5.
>  -Based on suggestions by Alex and Robin, added patch#7. This
>   moves the PCI window  reservation back in to DMA specific path.
>   This is to fix the issue reported by Eric[1].
> 
> Note:
> The patch #7 has dependency with [2][3]
> 
> 1. https://patchwork.kernel.org/patch/10232043/
> 2. https://patchwork.kernel.org/patch/10216553/
> 3. https://patchwork.kernel.org/patch/10216555/
> 
> v3 --> v4
>  Addressed comments received for v3.
>  -dma_addr_t instead of phys_addr_t
>  -LIST_HEAD() usage.
>  -Free up iova_copy list in case of error.
>  -updated logic in filling the iova caps info(patch #5)
> 
> RFCv2 --> v3
>  Removed RFC tag.
>  Addressed comments from Alex and Eric:
>  - Added comments to make iova list management logic more clear.
>  - Use of iova list copy so that original is not altered in
>    case of failure.
> 
> RFCv1 --> RFCv2
>  Addressed comments from Alex:
> -Introduced IOVA list management and added checks for conflicts with
>  existing dma map entries during attach/detach.
> 
> Shameer Kolothum (2):
>   vfio/type1: Add IOVA range capability support
>   iommu/dma: Move PCI window region reservation back into dma specific
>     path.
> 
> Shameerali Kolothum Thodi (5):
>   vfio/type1: Introduce iova list and add iommu aperture validity check
>   vfio/type1: Check reserve region conflict and update iova list
>   vfio/type1: Update iova list on detach
>   vfio/type1: check dma map request is within a valid iova range
>   vfio/type1: remove duplicate retrieval of reserved regions
> 
>  drivers/iommu/dma-iommu.c       |  54 ++---
>  drivers/vfio/vfio_iommu_type1.c | 497
> +++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/vfio.h       |  23 ++
>  3 files changed, 533 insertions(+), 41 deletions(-)
> 
> --
> 2.7.4
> 
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
