Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeBWK4s convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:56:48 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:27233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751273AbeBWK4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:56:46 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, John Garry <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>
Subject: RE: [PATCH v4 5/6] vfio/type1: Add IOVA range capability support
Thread-Topic: [PATCH v4 5/6] vfio/type1: Add IOVA range capability support
Thread-Index: AQHTqw7LUAgD1VI07U6yKkWUSopA2aOw+U+AgADY6UA=
Date: Fri, 23 Feb 2018 10:56:35 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83865A8B0@FRAEML521-MBX.china.huawei.com>
References: <20180221122209.9292-1-shameerali.kolothum.thodi@huawei.com>
        <20180221122209.9292-6-shameerali.kolothum.thodi@huawei.com>
 <20180222155429.32e71de2@w520.home>
In-Reply-To: <20180222155429.32e71de2@w520.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson@redhat.com]
> Sent: Thursday, February 22, 2018 10:54 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: eric.auger@redhat.com; pmorel@linux.vnet.ibm.com;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; John Garry <john.garry@huawei.com>; xuwei (O)
> <xuwei5@huawei.com>
> Subject: Re: [PATCH v4 5/6] vfio/type1: Add IOVA range capability support
> 
> On Wed, 21 Feb 2018 12:22:08 +0000
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> 
> > This  allows the user-space to retrieve the supported IOVA
> > range(s), excluding any reserved regions. The implementation
> > is based on capability chains, added to VFIO_IOMMU_GET_INFO ioctl.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 88
> +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h       | 23 +++++++++++
> >  2 files changed, 111 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> > index 3049393..c08adb5 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -1917,6 +1917,68 @@ static int
> vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
> >  	return ret;
> >  }
> >
> > +static int vfio_iommu_iova_add_cap(struct vfio_info_cap *caps,
> > +		 struct vfio_iommu_type1_info_cap_iova_range *cap_iovas,
> > +		 size_t size)
> > +{
> > +	struct vfio_info_cap_header *header;
> > +	struct vfio_iommu_type1_info_cap_iova_range *iova_cap;
> > +
> > +	header = vfio_info_cap_add(caps, size,
> > +
> 	VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE, 1);
> > +	if (IS_ERR(header))
> > +		return PTR_ERR(header);
> > +
> > +	iova_cap = container_of(header,
> > +			struct vfio_iommu_type1_info_cap_iova_range,
> header);
> > +	iova_cap->nr_iovas = cap_iovas->nr_iovas;
> > +	memcpy(iova_cap->iova_ranges, cap_iovas->iova_ranges,
> > +		cap_iovas->nr_iovas * sizeof(*cap_iovas->iova_ranges));
> > +	return 0;
> > +}
> > +
> > +static int vfio_iommu_iova_build_caps(struct vfio_iommu *iommu,
> > +				struct vfio_info_cap *caps)
> > +{
> > +	struct vfio_iommu_type1_info_cap_iova_range *cap_iovas;
> > +	struct vfio_iova *iova;
> > +	size_t size;
> > +	int iovas = 0, i = 0, ret;
> > +
> > +	mutex_lock(&iommu->lock);
> > +
> > +	list_for_each_entry(iova, &iommu->iova_list, list)
> > +		iovas++;
> > +
> > +	if (!iovas) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	size = sizeof(*cap_iovas) + (iovas * sizeof(*cap_iovas->iova_ranges));
> > +
> > +	cap_iovas = kzalloc(size, GFP_KERNEL);
> > +	if (!cap_iovas) {
> > +		ret = -ENOMEM;
> > +		goto out_unlock;
> > +	}
> > +
> > +	cap_iovas->nr_iovas = iovas;
> > +
> > +	list_for_each_entry(iova, &iommu->iova_list, list) {
> > +		cap_iovas->iova_ranges[i].start = iova->start;
> > +		cap_iovas->iova_ranges[i].end = iova->end;
> > +		i++;
> > +	}
> > +
> > +	ret = vfio_iommu_iova_add_cap(caps, cap_iovas, size);
> > +
> > +	kfree(cap_iovas);
> > +out_unlock:
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)
> >  {
> > @@ -1938,6 +2000,8 @@ static long vfio_iommu_type1_ioctl(void
> *iommu_data,
> >  		}
> >  	} else if (cmd == VFIO_IOMMU_GET_INFO) {
> >  		struct vfio_iommu_type1_info info;
> > +		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> > +		int ret;
> >
> >  		minsz = offsetofend(struct vfio_iommu_type1_info,
> iova_pgsizes);
> >
> > @@ -1951,6 +2015,30 @@ static long vfio_iommu_type1_ioctl(void
> *iommu_data,
> >
> >  		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
> >
> > +		ret = vfio_iommu_iova_build_caps(iommu, &caps);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (caps.size) {
> > +			info.flags |= VFIO_IOMMU_INFO_CAPS;
> > +
> > +			if (info.argsz < sizeof(info) + caps.size) {
> > +				info.argsz = sizeof(info) + caps.size;
> 
> There's still a corner case here where the user could have provided an
> argsz including cap_offset, potentially including uninitialized user
> data, and it becomes more error prone not to zero that field for this
> case.  I'd suggest this:

Yes,  it is  error prone. Thanks for spotting this.

> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index a1ce8853caf1..d9ea69e62c46 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2105,16 +2105,25 @@ static long vfio_iommu_type1_ioctl(void
> *iommu_data,
>  	} else if (cmd == VFIO_IOMMU_GET_INFO) {
>  		struct vfio_iommu_type1_info info;
>  		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> +		unsigned long capsz;
>  		int ret;
> 
>  		minsz = offsetofend(struct vfio_iommu_type1_info,
> iova_pgsizes);
> 
> +		/* For backward compatibility, cannot require this */
> +		capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
> +
>  		if (copy_from_user(&info, (void __user *)arg, minsz))
>  			return -EFAULT;
> 
>  		if (info.argsz < minsz)
>  			return -EINVAL;
> 
> +		if (info.argsz >= capsz) {
> +			minsz = capsz;
> +			info.cap_offset = 0; /* output, no-recopy necessary */
> +		}
> +
>  		info.flags = VFIO_IOMMU_INFO_PGSIZES;
> 
>  		info.iova_pgsizes = vfio_pgsize_bitmap(iommu);
> @@ -2136,13 +2145,12 @@ static long vfio_iommu_type1_ioctl(void
> *iommu_data,
>  					kfree(caps.buf);
>  					return -EFAULT;
>  				}
> -				minsz = offsetofend(struct
> vfio_iommu_type1_info,
> -							   cap_offset);
>  				info.cap_offset = sizeof(info);
>  			}
> 
>  			kfree(caps.buf);
>  		}
> +
>  		return copy_to_user((void __user *)arg, &info, minsz) ?
>  			-EFAULT : 0;
> 
> 
> 
> If you approve and there are no other comments, I can roll that change
> into this patch as-is.  Thanks,

That looks fine to me.

Thanks,
Shameer

> 
> > +			} else {
> > +				vfio_info_cap_shift(&caps, sizeof(info));
> > +				if (copy_to_user((void __user *)arg +
> > +						sizeof(info), caps.buf,
> > +						caps.size)) {
> > +					kfree(caps.buf);
> > +					return -EFAULT;
> > +				}
> > +				minsz = offsetofend(struct
> vfio_iommu_type1_info,
> > +							   cap_offset);
> > +				info.cap_offset = sizeof(info);
> > +			}
> > +
> > +			kfree(caps.buf);
> > +		}
> >  		return copy_to_user((void __user *)arg, &info, minsz) ?
> >  			-EFAULT : 0;
> >
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index c743721..46b49e9 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -589,7 +589,30 @@ struct vfio_iommu_type1_info {
> >  	__u32	argsz;
> >  	__u32	flags;
> >  #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
> > +#define VFIO_IOMMU_INFO_CAPS	(1 << 1)	/* Info supports caps */
> >  	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
> > +	__u32   cap_offset;	/* Offset within info struct of first cap */
> > +};
> > +
> > +/*
> > + * The IOVA capability allows to report the valid IOVA range(s)
> > + * excluding any reserved regions associated with dev group. Any dma
> > + * map attempt outside the valid iova range will return error.
> > + *
> > + * The structures below define version 1 of this capability.
> > + */
> > +#define VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE  1
> > +
> > +struct vfio_iova_range {
> > +	__u64	start;
> > +	__u64	end;
> > +};
> > +
> > +struct vfio_iommu_type1_info_cap_iova_range {
> > +	struct vfio_info_cap_header header;
> > +	__u32	nr_iovas;
> > +	__u32	reserved;
> > +	struct vfio_iova_range iova_ranges[];
> >  };
> >
> >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
