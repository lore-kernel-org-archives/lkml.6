Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6C1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EF420882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548877229;
	bh=ZwC5ug0fT89926ZSwrAbbsDI4Pz5kpEbJElNVUVBGjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QxbSXX/ULrCbkv6tjp7gyjd4Am858YHpvHWc0N8Hej9avyrjjgMRp37BvcXWfEyfr
	 hGC9lTA49XdFaG5+OlEkrAFD2hOOO4+Xt61r0p5NFt5/u1F6jW5GBj4IwXCZZsDnJk
	 FKF8AC6UJF7C3RTtNenjJ6DOx4oQRpHzf3buYvVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbfA3Tk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:40:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387587AbfA3Tk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:40:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5546220882;
        Wed, 30 Jan 2019 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548877225;
        bh=ZwC5ug0fT89926ZSwrAbbsDI4Pz5kpEbJElNVUVBGjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnNWqEdG5fQqo3rtgsCDajL/9MKsGnYzpwbosmZF3T5uBY22jVgSEAHubpIv7dGgF
         O1xkGvCnXgXQfJhvEQK4t/z1V9MYXK3pLwVe9+0hXBpkGT5RBGn6dbwwenONuoj7GF
         VJuB+DWEx0ydTKox5SqkSJm65MDzzPVcXsFGw5FM=
Date:   Wed, 30 Jan 2019 20:40:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     arnd@arndb.de, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tiwei.bie@intel.com,
        luto@kernel.org, Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH v2] mic: vop: Fix broken virtqueues
Message-ID: <20190130194023.GB21181@kroah.com>
References: <20190130162809.14620-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130162809.14620-1-vincent.whitchurch@axis.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 05:28:09PM +0100, Vincent Whitchurch wrote:
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
> The removal patch also has the hack and we need to save the used ring
> pointer separately to remove it.
> 
> Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> v2: fix removal path also
> 
>  drivers/misc/mic/vop/vop_main.c | 69 +++++++++++++++++++--------------
>  1 file changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
> index b60b5ec4a28a..c4517703dc1d 100644
> --- a/drivers/misc/mic/vop/vop_main.c
> +++ b/drivers/misc/mic/vop/vop_main.c
> @@ -48,7 +48,8 @@
>   * @dc: Virtio device control
>   * @vpdev: VOP device which is the parent for this virtio device
>   * @vr: Buffer for accessing the VRING
> - * @used: Buffer for used
> + * @used_virt: Virtual address of used ring
> + * @used: DMA address of used ring
>   * @used_size: Size of the used buffer
>   * @reset_done: Track whether VOP reset is complete
>   * @virtio_cookie: Cookie returned upon requesting a interrupt
> @@ -62,6 +63,7 @@ struct _vop_vdev {
>  	struct mic_device_ctrl __iomem *dc;
>  	struct vop_device *vpdev;
>  	void __iomem *vr[VOP_MAX_VRINGS];
> +	void *used_virt[VOP_MAX_VRINGS];
>  	dma_addr_t used[VOP_MAX_VRINGS];
>  	int used_size[VOP_MAX_VRINGS];
>  	struct completion reset_done;
> @@ -261,12 +263,12 @@ static bool vop_notify(struct virtqueue *vq)
>  static void vop_del_vq(struct virtqueue *vq, int n)
>  {
>  	struct _vop_vdev *vdev = to_vopvdev(vq->vdev);
> -	struct vring *vr = (struct vring *)(vq + 1);
>  	struct vop_device *vpdev = vdev->vpdev;
>  
>  	dma_unmap_single(&vpdev->dev, vdev->used[n],
>  			 vdev->used_size[n], DMA_BIDIRECTIONAL);
> -	free_pages((unsigned long)vr->used, get_order(vdev->used_size[n]));
> +	free_pages((unsigned long)vdev->used_virt[n],
> +		   get_order(vdev->used_size[n]));
>  	vring_del_virtqueue(vq);
>  	vpdev->hw_ops->unmap(vpdev, vdev->vr[n]);
>  	vdev->vr[n] = NULL;
> @@ -284,6 +286,26 @@ static void vop_del_vqs(struct virtio_device *dev)
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
> @@ -303,7 +325,6 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  	struct _mic_vring_info __iomem *info;
>  	void *used;
>  	int vr_size, _vr_size, err, magic;
> -	struct vring *vr;
>  	u8 type = ioread8(&vdev->desc->type);
>  
>  	if (index >= ioread8(&vdev->desc->num_vq))
> @@ -322,17 +343,7 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
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
> @@ -341,18 +352,27 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
>  		goto unmap;
>  	}
>  
> -	/* Allocate and reassign used ring now */
>  	vdev->used_size[index] = PAGE_ALIGN(sizeof(__u16) * 3 +
>  					     sizeof(struct vring_used_elem) *
>  					     le16_to_cpu(config.num));
>  	used = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>  					get_order(vdev->used_size[index]));
> +	vdev->used_virt[index] = used;
>  	if (!used) {
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
> @@ -360,26 +380,17 @@ static struct virtqueue *vop_find_vq(struct virtio_device *dev,
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
> -- 
> 2.20.0

This patch is already in my tree, can you just send a "fixup" patch
instead of me  having to revert the old one and then adding this one
again?

thanks,

greg k-h
