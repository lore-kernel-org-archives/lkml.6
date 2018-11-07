Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC9AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE59220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE59220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbeKHDUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:20:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbeKHDUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:20:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AB3481DEA;
        Wed,  7 Nov 2018 17:48:50 +0000 (UTC)
Received: from redhat.com (ovpn-121-251.rdu2.redhat.com [10.10.121.251])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2D15D607BE;
        Wed,  7 Nov 2018 17:48:47 +0000 (UTC)
Date:   Wed, 7 Nov 2018 12:48:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
Message-ID: <20181107123933-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711022711.7090-4-tiwei.bie@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 07 Nov 2018 17:48:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:27:09AM +0800, Tiwei Bie wrote:
> This commit introduces the support (without EVENT_IDX) for
> packed ring.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  drivers/virtio/virtio_ring.c | 495 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 487 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c4f8abc7445a..f317b485ba54 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -55,12 +55,21 @@
>  #define END_USE(vq)
>  #endif
>  
> +#define _VRING_DESC_F_AVAIL(b)	((__u16)(b) << 7)
> +#define _VRING_DESC_F_USED(b)	((__u16)(b) << 15)
> +
>  struct vring_desc_state {
>  	void *data;			/* Data for callback. */
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
>  };
>  
>  struct vring_desc_state_packed {
> +	void *data;			/* Data for callback. */
> +	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> +	int num;			/* Descriptor list length. */
> +	dma_addr_t addr;		/* Buffer DMA addr. */
> +	u32 len;			/* Buffer length. */
> +	u16 flags;			/* Descriptor flags. */
>  	int next;			/* The next desc state. */
>  };
>  
> @@ -660,7 +669,6 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned last_used_idx)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	virtio_mb(vq->weak_barriers);
>  	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev, vq->vring.used->idx);
>  }
>  
> @@ -757,6 +765,72 @@ static inline unsigned vring_size_packed(unsigned int num, unsigned long align)
>  		& ~(align - 1)) + sizeof(struct vring_packed_desc_event) * 2;
>  }
>  
> +static void vring_unmap_state_packed(const struct vring_virtqueue *vq,
> +				     struct vring_desc_state_packed *state)
> +{
> +	u16 flags;
> +
> +	if (!vring_use_dma_api(vq->vq.vdev))
> +		return;
> +
> +	flags = state->flags;
> +
> +	if (flags & VRING_DESC_F_INDIRECT) {
> +		dma_unmap_single(vring_dma_dev(vq),
> +				 state->addr, state->len,
> +				 (flags & VRING_DESC_F_WRITE) ?
> +				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	} else {
> +		dma_unmap_page(vring_dma_dev(vq),
> +			       state->addr, state->len,
> +			       (flags & VRING_DESC_F_WRITE) ?
> +			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	}
> +}
> +
> +static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> +				   struct vring_packed_desc *desc)
> +{
> +	u16 flags;
> +
> +	if (!vring_use_dma_api(vq->vq.vdev))
> +		return;
> +
> +	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);

BTW this stuff is only used on error etc. Is there a way to
reuse vring_unmap_state_packed?

> +
> +	if (flags & VRING_DESC_F_INDIRECT) {
> +		dma_unmap_single(vring_dma_dev(vq),
> +				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
> +				 virtio32_to_cpu(vq->vq.vdev, desc->len),
> +				 (flags & VRING_DESC_F_WRITE) ?
> +				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	} else {
> +		dma_unmap_page(vring_dma_dev(vq),
> +			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
> +			       virtio32_to_cpu(vq->vq.vdev, desc->len),
> +			       (flags & VRING_DESC_F_WRITE) ?
> +			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	}
> +}
> +
> +static struct vring_packed_desc *alloc_indirect_packed(struct virtqueue *_vq,
> +						       unsigned int total_sg,
> +						       gfp_t gfp)
> +{
> +	struct vring_packed_desc *desc;
> +
> +	/*
> +	 * We require lowmem mappings for the descriptors because
> +	 * otherwise virt_to_phys will give us bogus addresses in the
> +	 * virtqueue.
> +	 */
> +	gfp &= ~__GFP_HIGHMEM;
> +
> +	desc = kmalloc(total_sg * sizeof(struct vring_packed_desc), gfp);
> +
> +	return desc;
> +}
> +
>  static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  				       struct scatterlist *sgs[],
>  				       unsigned int total_sg,
> @@ -766,47 +840,449 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  				       void *ctx,
>  				       gfp_t gfp)
>  {
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct vring_packed_desc *desc;
> +	struct scatterlist *sg;
> +	unsigned int i, n, descs_used, uninitialized_var(prev), err_idx;
> +	__virtio16 uninitialized_var(head_flags), flags;
> +	u16 head, avail_wrap_counter, id, curr;
> +	bool indirect;
> +
> +	START_USE(vq);
> +
> +	BUG_ON(data == NULL);
> +	BUG_ON(ctx && vq->indirect);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return -EIO;
> +	}
> +
> +#ifdef DEBUG
> +	{
> +		ktime_t now = ktime_get();
> +
> +		/* No kick or get, with .1 second between?  Warn. */
> +		if (vq->last_add_time_valid)
> +			WARN_ON(ktime_to_ms(ktime_sub(now, vq->last_add_time))
> +					    > 100);
> +		vq->last_add_time = now;
> +		vq->last_add_time_valid = true;
> +	}
> +#endif
> +
> +	BUG_ON(total_sg == 0);
> +
> +	head = vq->next_avail_idx;
> +	avail_wrap_counter = vq->avail_wrap_counter;
> +
> +	if (virtqueue_use_indirect(_vq, total_sg))
> +		desc = alloc_indirect_packed(_vq, total_sg, gfp);
> +	else {
> +		desc = NULL;
> +		WARN_ON_ONCE(total_sg > vq->vring_packed.num && !vq->indirect);
> +	}
> +
> +	if (desc) {
> +		/* Use a single buffer which doesn't continue */
> +		indirect = true;
> +		/* Set up rest to use this indirect table. */
> +		i = 0;
> +		descs_used = 1;
> +	} else {
> +		indirect = false;
> +		desc = vq->vring_packed.desc;
> +		i = head;
> +		descs_used = total_sg;
> +	}
> +
> +	if (vq->vq.num_free < descs_used) {
> +		pr_debug("Can't add buf len %i - avail = %i\n",
> +			 descs_used, vq->vq.num_free);
> +		/* FIXME: for historical reasons, we force a notify here if
> +		 * there are outgoing parts to the buffer.  Presumably the
> +		 * host should service the ring ASAP. */

I don't think we have a reason to do this for packed ring.
No historical baggage there, right?

> +		if (out_sgs)
> +			vq->notify(&vq->vq);
> +		if (indirect)
> +			kfree(desc);
> +		END_USE(vq);
> +		return -ENOSPC;
> +	}
> +
> +	id = vq->free_head;
> +	BUG_ON(id == vq->vring_packed.num);
> +
> +	curr = id;
> +	for (n = 0; n < out_sgs + in_sgs; n++) {
> +		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> +			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
> +					       DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +			if (vring_mapping_error(vq, addr))
> +				goto unmap_release;
> +
> +			flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT |
> +				  (n < out_sgs ? 0 : VRING_DESC_F_WRITE) |
> +				  _VRING_DESC_F_AVAIL(vq->avail_wrap_counter) |
> +				  _VRING_DESC_F_USED(!vq->avail_wrap_counter));
> +			if (!indirect && i == head)
> +				head_flags = flags;
> +			else
> +				desc[i].flags = flags;
> +
> +			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
> +			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
> +			i++;
> +			if (!indirect) {
> +				if (vring_use_dma_api(_vq->vdev)) {
> +					vq->desc_state_packed[curr].addr = addr;
> +					vq->desc_state_packed[curr].len =
> +						sg->length;
> +					vq->desc_state_packed[curr].flags =
> +						virtio16_to_cpu(_vq->vdev,
> +								flags);
> +				}
> +				curr = vq->desc_state_packed[curr].next;
> +
> +				if (i >= vq->vring_packed.num) {
> +					i = 0;
> +					vq->avail_wrap_counter ^= 1;
> +				}
> +			}
> +		}
> +	}
> +
> +	prev = (i > 0 ? i : vq->vring_packed.num) - 1;
> +	desc[prev].id = cpu_to_virtio16(_vq->vdev, id);
> +
> +	/* Last one doesn't continue. */
> +	if (total_sg == 1)
> +		head_flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> +	else
> +		desc[prev].flags &= cpu_to_virtio16(_vq->vdev,
> +						~VRING_DESC_F_NEXT);
> +
> +	if (indirect) {
> +		/* Now that the indirect table is filled in, map it. */
> +		dma_addr_t addr = vring_map_single(
> +			vq, desc, total_sg * sizeof(struct vring_packed_desc),
> +			DMA_TO_DEVICE);
> +		if (vring_mapping_error(vq, addr))
> +			goto unmap_release;
> +
> +		head_flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT |
> +				      _VRING_DESC_F_AVAIL(avail_wrap_counter) |
> +				      _VRING_DESC_F_USED(!avail_wrap_counter));
> +		vq->vring_packed.desc[head].addr = cpu_to_virtio64(_vq->vdev,
> +								   addr);
> +		vq->vring_packed.desc[head].len = cpu_to_virtio32(_vq->vdev,
> +				total_sg * sizeof(struct vring_packed_desc));
> +		vq->vring_packed.desc[head].id = cpu_to_virtio16(_vq->vdev, id);
> +
> +		if (vring_use_dma_api(_vq->vdev)) {
> +			vq->desc_state_packed[id].addr = addr;
> +			vq->desc_state_packed[id].len = total_sg *
> +					sizeof(struct vring_packed_desc);
> +			vq->desc_state_packed[id].flags =
> +					virtio16_to_cpu(_vq->vdev, head_flags);
> +		}
> +	}
> +
> +	/* We're using some buffers from the free list. */
> +	vq->vq.num_free -= descs_used;
> +
> +	/* Update free pointer */
> +	if (indirect) {
> +		n = head + 1;
> +		if (n >= vq->vring_packed.num) {
> +			n = 0;
> +			vq->avail_wrap_counter ^= 1;
> +		}
> +		vq->next_avail_idx = n;
> +		vq->free_head = vq->desc_state_packed[id].next;
> +	} else {
> +		vq->next_avail_idx = i;
> +		vq->free_head = curr;
> +	}
> +
> +	/* Store token and indirect buffer state. */
> +	vq->desc_state_packed[id].num = descs_used;
> +	vq->desc_state_packed[id].data = data;
> +	if (indirect)
> +		vq->desc_state_packed[id].indir_desc = desc;
> +	else
> +		vq->desc_state_packed[id].indir_desc = ctx;
> +
> +	/* A driver MUST NOT make the first descriptor in the list
> +	 * available before all subsequent descriptors comprising
> +	 * the list are made available. */
> +	virtio_wmb(vq->weak_barriers);
> +	vq->vring_packed.desc[head].flags = head_flags;
> +	vq->num_added += descs_used;
> +
> +	pr_debug("Added buffer head %i to %p\n", head, vq);
> +	END_USE(vq);
> +
> +	return 0;
> +
> +unmap_release:
> +	err_idx = i;
> +	i = head;
> +
> +	for (n = 0; n < total_sg; n++) {
> +		if (i == err_idx)
> +			break;
> +		vring_unmap_desc_packed(vq, &desc[i]);
> +		i++;
> +		if (!indirect && i >= vq->vring_packed.num)
> +			i = 0;
> +	}
> +
> +	vq->avail_wrap_counter = avail_wrap_counter;
> +
> +	if (indirect)
> +		kfree(desc);
> +
> +	END_USE(vq);
>  	return -EIO;
>  }
>  
>  static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
>  {
> -	return false;
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 flags;
> +	bool needs_kick;
> +	u32 snapshot;
> +
> +	START_USE(vq);
> +	/* We need to expose the new flags value before checking notification
> +	 * suppressions. */
> +	virtio_mb(vq->weak_barriers);
> +
> +	snapshot = READ_ONCE(*(u32 *)vq->vring_packed.device);
> +	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
> +
> +#ifdef DEBUG
> +	if (vq->last_add_time_valid) {
> +		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
> +					      vq->last_add_time)) > 100);
> +	}
> +	vq->last_add_time_valid = false;
> +#endif
> +
> +	needs_kick = (flags != VRING_EVENT_F_DISABLE);
> +	END_USE(vq);
> +	return needs_kick;
> +}
> +
> +static void detach_buf_packed(struct vring_virtqueue *vq,
> +			      unsigned int id, void **ctx)
> +{
> +	struct vring_desc_state_packed *state = NULL;
> +	struct vring_packed_desc *desc;
> +	unsigned int curr, i;
> +
> +	/* Clear data ptr. */
> +	vq->desc_state_packed[id].data = NULL;
> +
> +	curr = id;
> +	for (i = 0; i < vq->desc_state_packed[id].num; i++) {
> +		state = &vq->desc_state_packed[curr];
> +		vring_unmap_state_packed(vq, state);
> +		curr = state->next;
> +	}
> +
> +	BUG_ON(state == NULL);
> +	vq->vq.num_free += vq->desc_state_packed[id].num;
> +	state->next = vq->free_head;
> +	vq->free_head = id;
> +
> +	if (vq->indirect) {
> +		u32 len;
> +
> +		/* Free the indirect table, if any, now that it's unmapped. */
> +		desc = vq->desc_state_packed[id].indir_desc;
> +		if (!desc)
> +			return;
> +
> +		if (vring_use_dma_api(vq->vq.vdev)) {
> +			len = vq->desc_state_packed[id].len;
> +			for (i = 0; i < len / sizeof(struct vring_packed_desc);
> +					i++)
> +				vring_unmap_desc_packed(vq, &desc[i]);
> +		}
> +		kfree(desc);
> +		vq->desc_state_packed[id].indir_desc = NULL;
> +	} else if (ctx) {
> +		*ctx = vq->desc_state_packed[id].indir_desc;
> +	}
> +}
> +
> +static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
> +				       u16 idx, bool used_wrap_counter)
> +{
> +	u16 flags;
> +	bool avail, used;
> +
> +	flags = virtio16_to_cpu(vq->vq.vdev,
> +				vq->vring_packed.desc[idx].flags);
> +	avail = !!(flags & VRING_DESC_F_AVAIL);
> +	used = !!(flags & VRING_DESC_F_USED);
> +
> +	return avail == used && used == used_wrap_counter;
>  }
>  
>  static inline bool more_used_packed(const struct vring_virtqueue *vq)
>  {
> -	return false;
> +	return is_used_desc_packed(vq, vq->last_used_idx,
> +			vq->used_wrap_counter);
>  }
>  
>  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  					  unsigned int *len,
>  					  void **ctx)
>  {
> -	return NULL;
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 last_used, id;
> +	void *ret;
> +
> +	START_USE(vq);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	if (!more_used_packed(vq)) {
> +		pr_debug("No more buffers in queue\n");
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	/* Only get used elements after they have been exposed by host. */
> +	virtio_rmb(vq->weak_barriers);
> +
> +	last_used = vq->last_used_idx;
> +	id = virtio16_to_cpu(_vq->vdev, vq->vring_packed.desc[last_used].id);
> +	*len = virtio32_to_cpu(_vq->vdev, vq->vring_packed.desc[last_used].len);
> +
> +	if (unlikely(id >= vq->vring_packed.num)) {
> +		BAD_RING(vq, "id %u out of range\n", id);
> +		return NULL;
> +	}
> +	if (unlikely(!vq->desc_state_packed[id].data)) {
> +		BAD_RING(vq, "id %u is not a head!\n", id);
> +		return NULL;
> +	}
> +
> +	vq->last_used_idx += vq->desc_state_packed[id].num;
> +	if (vq->last_used_idx >= vq->vring_packed.num) {
> +		vq->last_used_idx -= vq->vring_packed.num;
> +		vq->used_wrap_counter ^= 1;
> +	}
> +
> +	/* detach_buf_packed clears data, so grab it now. */
> +	ret = vq->desc_state_packed[id].data;
> +	detach_buf_packed(vq, id, ctx);
> +
> +#ifdef DEBUG
> +	vq->last_add_time_valid = false;
> +#endif
> +
> +	END_USE(vq);
> +	return ret;
>  }
>  
>  static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
>  {
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (vq->event_flags_shadow != VRING_EVENT_F_DISABLE) {
> +		vq->event_flags_shadow = VRING_EVENT_F_DISABLE;
> +		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> +							vq->event_flags_shadow);
> +	}
>  }
>  
>  static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
>  {
> -	return 0;
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	START_USE(vq);
> +
> +	/* We optimistically turn back on interrupts, then check if there was
> +	 * more to do. */
> +
> +	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> +		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> +		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> +							vq->event_flags_shadow);
> +	}
> +
> +	END_USE(vq);
> +	return vq->last_used_idx | ((u16)vq->used_wrap_counter << 15);
>  }
>  
> -static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
> +static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned off_wrap)
>  {
> -	return false;
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	bool wrap_counter;
> +	u16 used_idx;
> +
> +	wrap_counter = off_wrap >> 15;
> +	used_idx = off_wrap & ~(1 << 15);
> +
> +	return is_used_desc_packed(vq, used_idx, wrap_counter);
>  }
>  
>  static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
>  {
> -	return false;
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	START_USE(vq);
> +
> +	/* We optimistically turn back on interrupts, then check if there was
> +	 * more to do. */
> +
> +	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> +		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> +		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> +							vq->event_flags_shadow);
> +		/* We need to enable interrupts first before re-checking
> +		 * for more used buffers. */
> +		virtio_mb(vq->weak_barriers);
> +	}
> +
> +	if (more_used_packed(vq)) {
> +		END_USE(vq);
> +		return false;
> +	}
> +
> +	END_USE(vq);
> +	return true;
>  }
>  
>  static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
>  {
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	unsigned int i;
> +	void *buf;
> +
> +	START_USE(vq);
> +
> +	for (i = 0; i < vq->vring_packed.num; i++) {
> +		if (!vq->desc_state_packed[i].data)
> +			continue;
> +		/* detach_buf clears data, so grab it now. */
> +		buf = vq->desc_state_packed[i].data;
> +		detach_buf_packed(vq, i, NULL);
> +		END_USE(vq);
> +		return buf;
> +	}
> +	/* That should have freed everything. */
> +	BUG_ON(vq->vq.num_free != vq->vring_packed.num);
> +
> +	END_USE(vq);
>  	return NULL;
>  }
>  
> @@ -1083,6 +1559,9 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	/* We need to enable interrupts first before re-checking
> +	 * for more used buffers. */
> +	virtio_mb(vq->weak_barriers);
>  	return vq->packed ? virtqueue_poll_packed(_vq, last_used_idx) :
>  			    virtqueue_poll_split(_vq, last_used_idx);
>  }
> -- 
> 2.18.0
