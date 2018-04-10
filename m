Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754418AbeDJPTg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:19:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754050AbeDJPTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:19:35 -0400
Date: Tue, 10 Apr 2018 09:19:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yulei Zhang <yulei.zhang@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kevin.tian@intel.com, joonas.lahtinen@linux.intel.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, dgilbert@redhat.com,
        quintela@redhat.com
Subject: Re: [RFC PATCH] vfio: Implement new Ioctl
 VFIO_IOMMU_GET_DIRTY_BITMAP
Message-ID: <20180410091926.59dffe40@w520.home>
In-Reply-To: <1523348339-32258-1-git-send-email-yulei.zhang@intel.com>
References: <1523348339-32258-1-git-send-email-yulei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2018 16:18:59 +0800
Yulei Zhang <yulei.zhang@intel.com> wrote:

> Corresponding to the V4 migration patch set for vfio pci device,
> this patch is to implement the new ioctl VFIO_IOMMU_GET_DIRTY_BITMAP
> to fulfill the requirement for vfio-mdev device live migration, which
> need copy the memory that has been pinned in iommu container to the
> target VM for mdev device status restore.
> 
> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 42 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       | 14 ++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 5c212bf..6cd2142 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -41,6 +41,7 @@
>  #include <linux/notifier.h>
>  #include <linux/dma-iommu.h>
>  #include <linux/irqdomain.h>
> +#include <linux/vmalloc.h>
>  
>  #define DRIVER_VERSION  "0.2"
>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
> @@ -1658,6 +1659,23 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>  	return ret;
>  }
>  
> +static void vfio_dma_update_dirty_bitmap(struct vfio_iommu *iommu,
> +				u64 start_addr, u64 npage, void *bitmap)
> +{
> +	u64 iova = start_addr;
> +	struct vfio_dma *dma;
> +	int i;
> +
> +	for (i = 0; i < npage; i++) {
> +		dma = vfio_find_dma(iommu, iova, PAGE_SIZE);
> +		if (dma)
> +			if (vfio_find_vpfn(dma, iova))
> +				set_bit(i, bitmap);

This seems to conflate the vendor driver working data set with the
dirty data set, is that valid?

> +
> +		iova += PAGE_SIZE;
> +	}
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -1728,6 +1746,30 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  
>  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>  			-EFAULT : 0;
> +	} else if (cmd == VFIO_IOMMU_GET_DIRTY_BITMAP) {
> +		struct vfio_iommu_get_dirty_bitmap d;
> +		unsigned long bitmap_sz;
> +		unsigned int *bitmap;
> +
> +		minsz = offsetofend(struct vfio_iommu_get_dirty_bitmap,
> +				    page_nr);
> +
> +		if (copy_from_user(&d, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		bitmap_sz = (BITS_TO_LONGS(d.page_nr) + 1) *
> +			    sizeof(unsigned long);
> +		bitmap = vzalloc(bitmap_sz);

This is an exploit waiting to happen, a kernel allocation based on a
user provided field with no limit or bounds checking.

> +		vfio_dma_update_dirty_bitmap(iommu, d.start_addr,
> +					     d.page_nr, bitmap);
> +
> +		if (copy_to_user((void __user *)arg + minsz,
> +				bitmap, bitmap_sz)) {
> +			vfree(bitmap);
> +			return -EFAULT;
> +		}
> +		vfree(bitmap);
> +		return 0;
>  	}
>  
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 1aa7b82..d4fd5af 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -665,6 +665,20 @@ struct vfio_iommu_type1_dma_unmap {
>  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
>  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
>  
> +/**
> + * VFIO_IOMMU_GET_DIRTY_BITMAP - _IOW(VFIO_TYPE, VFIO_BASE + 17,
> + *				    struct vfio_iommu_get_dirty_bitmap)
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vfio_iommu_get_dirty_bitmap {
> +	__u64	       start_addr;
> +	__u64	       page_nr;
> +	__u8           dirty_bitmap[];
> +};

This does not follow the vfio standard calling convention of argsz and
flags.  Do we even an ioctl here or could we use a region for exposing
a dirty bitmap?

Juan, any input on better options than bitmaps?  Thanks,

Alex

> +
> +#define VFIO_IOMMU_GET_DIRTY_BITMAP _IO(VFIO_TYPE, VFIO_BASE + 17)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*
