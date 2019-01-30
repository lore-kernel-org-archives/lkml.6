Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91103C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6836B207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfA3QEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:04:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:16741 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfA3QEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:04:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 08:04:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,541,1539673200"; 
   d="scan'208";a="112355401"
Received: from unknown (HELO localhost.localdomain) ([10.10.37.145])
  by orsmga006.jf.intel.com with ESMTP; 30 Jan 2019 08:04:47 -0800
Message-ID: <1548865797.29684.47.camel@intel.com>
Subject: Re: [PATCH] mic: vop: Fix broken virtqueues
From:   Sudeep Dutt <sudeep.dutt@intel.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>, gregkh@linuxfoundation.org,
        arnd@arndb.de, ashutosh.dixit@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tiwei.bie@intel.com,
        luto@kernel.org, Vincent Whitchurch <rabinv@axis.com>
Date:   Wed, 30 Jan 2019 08:29:57 -0800
In-Reply-To: <20190129102207.9577-1-vincent.whitchurch@axis.com>
References: <20190129102207.9577-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset="us-ascii"
X-Mailer: Evolution 3.12.11 (3.12.11-15.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-29 at 11:22 +0100, Vincent Whitchurch wrote:
> VOP is broken in mainline since commit 1ce9e6055fa0a9043 ("virtio_ring:
> introduce packed ring support"); attempting to use the virtqueues leads
> to various kernel crashes.  I'm testing it with my not-yet-merged
> loopback patches, but even the in-tree MIC hardware cannot work.
> 
> The problem is not in the referenced commit per se, but is due to the
> following hack in vop_find_vq() which depends on the layout of private
> structures in other source files, which that commit happened to change:
> 
>   /*
>    * To reassign the used ring here we are directly accessing
>    * struct vring_virtqueue which is a private data structure
>    * in virtio_ring.c. At the minimum, a BUILD_BUG_ON() in
>    * vring_new_virtqueue() would ensure that
>    *  (&vq->vring == (struct vring *) (&vq->vq + 1));
>    */
>   vr = (struct vring *)(vq + 1);
>   vr->used = used;
> 
> Fix vop by using __vring_new_virtqueue() to create the needed vring
> layout from the start, instead of attempting to patch in the used ring
> later.  __vring_new_virtqueue() was added way back in commit
> 2a2d1382fe9dcc ("virtio: Add improved queue allocation API") in order to
> address mic's usecase, according to the commit message.
> 

Thank you for fixing this up Vincent.

Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/misc/mic/vop/vop_main.c | 60 +++++++++++++++++++--------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
> index d2b9782eee87..fef45bf6d519 100644
> --- a/drivers/misc/mic/vop/vop_main.c
> +++ b/drivers/misc/mic/vop/vop_main.c
> @@ -284,6 +284,26 @@ static void vop_del_vqs(struct virtio_device *dev)
>  		vop_del_vq(vq, idx++);
>  }
>  
> +static struct virtqueue *vop_new_virtqueue(unsigned int index,
> +				      unsigned int num,
> +				      struct virtio_device *vdev,
> +				      bool context,
> +				      void *pages,
> +				      bool (*notify)(struct virtqueue *vq),
> +				      void (*callback)(struct virtqueue *vq),
> +				      const char *name,
> +				      void *used)
> +{
> +	bool weak_barriers = false;
> +	struct vring vring;
> +
> +	vring_init(&vring, num, pages, MIC_VIRTIO_RING_ALIGN);
> +	vring.used = used;
> +
> +	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
> +				     notify, callback, name);
> +}
> +
>  /*
>   * This routine will assign vring's allocated in host/io memory. Code in
>   * virtio_ring.c however continues to access this io memory as if it were local
> @@ -303,7 +323,6 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  	struct _mic_vring_info __iomem *info;
>  	void *used;
>  	int vr_size, _vr_size, err, magic;
> -	struct vring *vr;
>  	u8 type = ioread8(&vdev->desc->type);
>  
>  	if (index >= ioread8(&vdev->desc->num_vq))
> @@ -322,17 +341,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  		return ERR_PTR(-ENOMEM);
>  	vdev->vr[index] = va;
>  	memset_io(va, 0x0, _vr_size);
> -	vq = vring_new_virtqueue(
> -				index,
> -				le16_to_cpu(config.num), MIC_VIRTIO_RING_ALIGN,
> -				dev,
> -				false,
> -				ctx,
> -				(void __force *)va, vop_notify, callback, name);
> -	if (!vq) {
> -		err = -ENOMEM;
> -		goto unmap;
> -	}
> +
>  	info = va + _vr_size;
>  	magic = ioread32(&info->magic);
>  
> @@ -341,7 +350,6 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  		goto unmap;
>  	}
>  
> -	/* Allocate and reassign used ring now */
>  	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
>  					     sizeof(struct vring_used_elem) *
>  					     le16_to_cpu(config.num));
> @@ -351,8 +359,17 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  		err = -ENOMEM;
>  		dev_err(_vop_dev(vdev), "%s %d err %d\n",
>  			__func__, __LINE__, err);
> -		goto del_vq;
> +		goto unmap;
> +	}
> +
> +	vq = vop_new_virtqueue(index, le16_to_cpu(config.num), dev, ctx,
> +			       (void __force *)va, vop_notify, callback,
> +			       name, used);
> +	if (!vq) {
> +		err = -ENOMEM;
> +		goto free_used;
>  	}
> +
>  	vdev->used[index] = dma_map_single(&vpdev->dev, used,
>  					    vdev->used_size[index],
>  					    DMA_BIDIRECTIONAL);
> @@ -360,26 +377,17 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  		err = -ENOMEM;
>  		dev_err(_vop_dev(vdev), "%s %d err %d\n",
>  			__func__, __LINE__, err);
> -		goto free_used;
> +		goto del_vq;
>  	}
>  	writeq(vdev->used[index], &vqconfig->used_address);
> -	/*
> -	 * To reassign the used ring here we are directly accessing
> -	 * struct vring_virtqueue which is a private data structure
> -	 * in virtio_ring.c. At the minimum, a BUILD_BUG_ON() in
> -	 * vring_new_virtqueue() would ensure that
> -	 *  (&vq->vring == (struct vring *) (&vq->vq + 1));
> -	 */
> -	vr = (struct vring *)(vq + 1);
> -	vr->used = used;
>  
>  	vq->priv = vdev;
>  	return vq;
> +del_vq:
> +	vring_del_virtqueue(vq);
>  free_used:
>  	free_pages((unsigned long)used,
>  		   get_order(vdev->used_size[index]));
> -del_vq:
> -	vring_del_virtqueue(vq);
>  unmap:
>  	vpdev->hw_ops->unmap(vpdev, vdev->vr[index]);
>  	return ERR_PTR(err);


