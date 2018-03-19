Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932773AbeCSMMy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 08:12:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:38337 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932257AbeCSMMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 08:12:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="scan'208";a="25705832"
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuwei (O)" <xuwei5@huawei.com>, Linuxarm <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
 management
Thread-Topic: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
 management
Thread-Index: AQHTvHwRYozEvfc1wUWpRd1V/RZ8waPXOoPQ//+nxACAAJq+oA==
Date: Mon, 19 Mar 2018 12:12:47 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191085BED@SHSMSX101.ccr.corp.intel.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19108585F@SHSMSX101.ccr.corp.intel.com>
 <5FC3163CFD30C246ABAA99954A238FA838675F3C@FRAEML521-MBX.china.huawei.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA838675F3C@FRAEML521-MBX.china.huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjMzNTQxZjUtMDkzNC00MTM4LWI2MmEtMzRjZGJkODM2OGQ5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IkhsVzE4RVpOSFZ5ZHJUY3doY2Y1czMyb0QzcDZ5ZmZIQ0xpU3E2ajlvdG89In0=
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

> From: Shameerali Kolothum Thodi
> [mailto:shameerali.kolothum.thodi@huawei.com]
> 
> Hi Kevin,
> 
> Thanks for taking a look at this series.
> 
> > -----Original Message-----
> > From: Tian, Kevin [mailto:kevin.tian@intel.com]
> > Sent: Monday, March 19, 2018 8:29 AM
> > To: Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>;
> > alex.williamson@redhat.com; eric.auger@redhat.com;
> > pmorel@linux.vnet.ibm.com
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org; xuwei (O)
> > <xuwei5@huawei.com>; Linuxarm <linuxarm@huawei.com>;
> > iommu@lists.linux-foundation.org
> > Subject: RE: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
> > management
> >
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
> As I understand, in case a hotplugged device results in an update to the
> valid
> Iova ranges then the Qemu, vfio_connect_container() -->
> memory_listner_register()
> will fail if there is a conflict as patch #4 checks for invalid dma map requests.

OK, possibly Qemu can do another GET_INFO upon any dma map 
error to get latest ranges and then allocate a new valid iova to
redo the map. this should work if valid ranges shrink due to new
hotplugged device. But if hot-removing a device may result in
more valid ranges, so far there is no way for Qemu to pick up.
I'm not sure whether we want to go that far though...

> 
> Not sure, your concern is preventing hotplug much before this happens or
> not.
> 

yes, my earlier thought is more to catch the problem in attach phase.

Thanks
Kevin
