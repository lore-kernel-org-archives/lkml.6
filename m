Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeFERDN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:03:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752271AbeFERDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:03:08 -0400
Date: Tue, 5 Jun 2018 11:03:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>, "John Garry" <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v6 0/7] vfio/type1: Add support for valid iova list
 management
Message-ID: <20180605110304.33e14b0d@w520.home>
In-Reply-To: <20180525145408.2938a9ec@w520.home>
References: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
        <20180524122032.724676b9@w520.home>
        <5FC3163CFD30C246ABAA99954A238FA8386EE591@FRAEML521-MBX.china.huawei.com>
        <20180525145408.2938a9ec@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc +dwmw2]

On Fri, 25 May 2018 14:54:08 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Fri, 25 May 2018 08:45:36 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
> 
> > Yes, the above changes related to list empty cases looks fine to me.   
> 
> Thanks Shameer, applied to my next branch with the discussed fixes for
> v4.18 (modulo patch 4/7 which Joerg already pushed for v4.17).  Thanks,

Hi Shameer,

We're still hitting issues with this.  VT-d marks reserved regions for
any RMRR ranges, which are IOVA ranges that the BIOS requests to be
identity mapped for a device.  These are indicated by these sorts of
log entries on boot:

 DMAR: Setting RMRR:
 DMAR: Setting identity map for device 0000:00:02.0 [0xbf800000 - 0xcf9fffff]
 DMAR: Setting identity map for device 0000:00:1a.0 [0xbe8d1000 - 0xbe8dffff]
 DMAR: Setting identity map for device 0000:00:1d.0 [0xbe8d1000 - 0xbe8dffff]

So while for an unaffected device, I see very usable ranges for QEMU,
such as:

	00: 0000000000000000 - 00000000fedfffff
	01: 00000000fef00000 - 01ffffffffffffff

If I try to assign the previously assignable 00:02.0 IGD graphics
device, I get:

	00: 0000000000000000 - 00000000bf7fffff
	01: 00000000cfa00000 - 00000000fedfffff
	02: 00000000fef00000 - 01ffffffffffffff

And we get a fault when QEMU tries the following mapping:

vfio_dma_map(0x55f790421a20, 0x100000, 0xbff00000, 0x7ff163f00000)

bff00000 clearly extends into the gap starting at bf800000.  VT-d is
rather split-brained about RMRRs, typically we'd exclude devices from
assignment at all for relying on RMRRs and these reserved ranges
would be a welcome mechanism to avoid conflicts with those ranges, but
for RMRR ranges covering IGD and USB devices we've decided that we
don't need to honor the RMRR (see device_is_rmrr_locked()), but it's
still listed as a reserved range and bites us here.

Unless we can get VT-d to exclude RMRRs from reserved regions where
we've already seen fit to allow the devices to participate in the IOMMU
API, this would introduce a functional regression for assignment of
these devices.  David, should we skip GFX and USB devices with RMRRs in
intel_iommu_get_resv_regions() just as we do in
device_is_rmrr_locked()?  Thanks,

Alex
