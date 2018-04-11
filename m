Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753982AbeDKPmJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:42:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:20929 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753651AbeDKPmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:42:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,436,1517904000";
   d="scan'208";a="32893854"
From: "Zhang, Yulei" <yulei.zhang@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "quintela@redhat.com" <quintela@redhat.com>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>
Subject: RE: [RFC PATCH] vfio: Implement new Ioctl
 VFIO_IOMMU_GET_DIRTY_BITMAP
Thread-Topic: [RFC PATCH] vfio: Implement new Ioctl
 VFIO_IOMMU_GET_DIRTY_BITMAP
Thread-Index: AQHT0KO9XRbQ4UjvN0+q4eOdLuxyrKP5lzsAgAIYyDA=
Date: Wed, 11 Apr 2018 15:42:02 +0000
Message-ID: <01FDBDDE256B79498DC57789713132D46A155A20@SHSMSX101.ccr.corp.intel.com>
References: <1523348339-32258-1-git-send-email-yulei.zhang@intel.com>
 <20180410091926.59dffe40@w520.home>
In-Reply-To: <20180410091926.59dffe40@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmUyZDM2ZGUtYWJiZi00Yjc2LTljMWUtYzE1MDYwMTEzMWQzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJvWkR4RkVCUGhrWTE4QjQrSVlRUFZlUkZvZlhmSFc4V0YwM01lekNtZGxBSmUrRTJwdlRCZzRDOUtZeGJMekxZIn0=
x-ctpclassification: CTP_NT
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



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Tuesday, April 10, 2018 11:19 PM
> To: Zhang, Yulei <yulei.zhang@intel.com>
> Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Tian, Kevin
> <kevin.tian@intel.com>; joonas.lahtinen@linux.intel.com;
> zhenyuw@linux.intel.com; Wang, Zhi A <zhi.a.wang@intel.com>;
> dgilbert@redhat.com; quintela@redhat.com
> Subject: Re: [RFC PATCH] vfio: Implement new Ioctl
> VFIO_IOMMU_GET_DIRTY_BITMAP
> 
> On Tue, 10 Apr 2018 16:18:59 +0800
> Yulei Zhang <yulei.zhang@intel.com> wrote:
> 
> > Corresponding to the V4 migration patch set for vfio pci device, this
> > patch is to implement the new ioctl VFIO_IOMMU_GET_DIRTY_BITMAP to
> > fulfill the requirement for vfio-mdev device live migration, which
> > need copy the memory that has been pinned in iommu container to the
> > target VM for mdev device status restore.
> >
> > Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 42
> +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h       | 14 ++++++++++++++
> >  2 files changed, 56 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 5c212bf..6cd2142 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/notifier.h>
> >  #include <linux/dma-iommu.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/vmalloc.h>
> >
> >  #define DRIVER_VERSION  "0.2"
> >  #define DRIVER_AUTHOR   "Alex Williamson
> <alex.williamson@redhat.com>"
> > @@ -1658,6 +1659,23 @@ static int
> vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
> >  	return ret;
> >  }
> >
> > +static void vfio_dma_update_dirty_bitmap(struct vfio_iommu *iommu,
> > +				u64 start_addr, u64 npage, void *bitmap) {
> > +	u64 iova = start_addr;
> > +	struct vfio_dma *dma;
> > +	int i;
> > +
> > +	for (i = 0; i < npage; i++) {
> > +		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
> > +		if (dma)
> > +			if (vfio_find_vpfn(dma, iova))
> > +				set_bit(i, bitmap);
> 
> This seems to conflate the vendor driver working data set with the dirty
> data set, is that valid?
> 

https://patchwork.kernel.org/patch/9808857/
hi Alex, I am not sure what the working data set refers here, as in the former
discussion, due to the limitation of current architecture we can't tell the exact
dirty pages, in an alternative way, after all the vfio devices stop we will let
container select all the pages that have mapped and report as entire dirty bitmap
to qemu for final static copy. 

But giving another thought, this time we add pre-copy interface for vfio device
which will iteratively query the dirty bitmap from vendor driver, maybe we
can move this ioctl back to vendor driver and combined with pre-copy interface.

> > +
> > +		iova += PAGE_SIZE;
> > +	}
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)  { @@ -
> 1728,6 +1746,30 @@
> > static long vfio_iommu_type1_ioctl(void *iommu_data,
> >
> >  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> >  			-EFAULT : 0;
> > +	} else if (cmd == VFIO_IOMMU_GET_DIRTY_BITMAP) {
> > +		struct vfio_iommu_get_dirty_bitmap d;
> > +		unsigned long bitmap_sz;
> > +		unsigned int *bitmap;
> > +
> > +		minsz = offsetofend(struct vfio_iommu_get_dirty_bitmap,
> > +				    page_nr);
> > +
> > +		if (copy_from_user(&d, (void __user *)arg, minsz))
> > +			return -EFAULT;
> > +
> > +		bitmap_sz = (BITS_TO_LONGS(d.page_nr) + 1) *
> > +			    sizeof(unsigned long);
> > +		bitmap = vzalloc(bitmap_sz);
> 
> This is an exploit waiting to happen, a kernel allocation based on a user
> provided field with no limit or bounds checking.
> 
> > +		vfio_dma_update_dirty_bitmap(iommu, d.start_addr,
> > +					     d.page_nr, bitmap);
> > +
> > +		if (copy_to_user((void __user *)arg + minsz,
> > +				bitmap, bitmap_sz)) {
> > +			vfree(bitmap);
> > +			return -EFAULT;
> > +		}
> > +		vfree(bitmap);
> > +		return 0;
> >  	}
> >
> >  	return -ENOTTY;
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 1aa7b82..d4fd5af 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -665,6 +665,20 @@ struct vfio_iommu_type1_dma_unmap {
> >  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
> >  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
> >
> > +/**
> > + * VFIO_IOMMU_GET_DIRTY_BITMAP - _IOW(VFIO_TYPE, VFIO_BASE + 17,
> > + *				    struct vfio_iommu_get_dirty_bitmap)
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +struct vfio_iommu_get_dirty_bitmap {
> > +	__u64	       start_addr;
> > +	__u64	       page_nr;
> > +	__u8           dirty_bitmap[];
> > +};
> 
> This does not follow the vfio standard calling convention of argsz and flags.
> Do we even an ioctl here or could we use a region for exposing a dirty
> bitmap?
> 
> Juan, any input on better options than bitmaps?  Thanks,
> 
> Alex
> 
> > +
> > +#define VFIO_IOMMU_GET_DIRTY_BITMAP _IO(VFIO_TYPE, VFIO_BASE +
> 17)
> > +
> >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU
> > -------- */
> >
> >  /*
