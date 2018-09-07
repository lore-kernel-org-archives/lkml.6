Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D9FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE182083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 14:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE182083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbeIGSon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 14:44:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728154AbeIGSom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 14:44:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C8C01401EF05;
        Fri,  7 Sep 2018 14:03:27 +0000 (UTC)
Received: from redhat.com (ovpn-124-199.rdu2.redhat.com [10.10.124.199])
        by smtp.corp.redhat.com (Postfix) with SMTP id 791D9112D173;
        Fri,  7 Sep 2018 14:03:24 +0000 (UTC)
Date:   Fri, 7 Sep 2018 10:03:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 2/5] virtio_ring: support creating packed ring
Message-ID: <20180907095208-mutt-send-email-mst@kernel.org>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-3-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711022711.7090-3-tiwei.bie@intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 07 Sep 2018 14:03:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 07 Sep 2018 14:03:27 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:27:08AM +0800, Tiwei Bie wrote:
> This commit introduces the support for creating packed ring.
> All split ring specific functions are added _split suffix.
> Some necessary stubs for packed ring are also added.
> 
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>

I'd rather have a patch just renaming split functions, then
add all packed stuff in as a separate patch on top.


> ---
>  drivers/virtio/virtio_ring.c | 801 +++++++++++++++++++++++------------
>  include/linux/virtio_ring.h  |   8 +-
>  2 files changed, 546 insertions(+), 263 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 814b395007b2..c4f8abc7445a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -60,11 +60,15 @@ struct vring_desc_state {
>  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
>  };
>  
> +struct vring_desc_state_packed {
> +	int next;			/* The next desc state. */

So this can go away with IN_ORDER?

> +};
> +
>  struct vring_virtqueue {
>  	struct virtqueue vq;
>  
> -	/* Actual memory layout for this queue */
> -	struct vring vring;
> +	/* Is this a packed ring? */
> +	bool packed;
>  
>  	/* Can we use weak barriers? */
>  	bool weak_barriers;
> @@ -86,11 +90,39 @@ struct vring_virtqueue {
>  	/* Last used index we've seen. */
>  	u16 last_used_idx;
>  
> -	/* Last written value to avail->flags */
> -	u16 avail_flags_shadow;
> +	union {
> +		/* Available for split ring */
> +		struct {
> +			/* Actual memory layout for this queue. */
> +			struct vring vring;
>  
> -	/* Last written value to avail->idx in guest byte order */
> -	u16 avail_idx_shadow;
> +			/* Last written value to avail->flags */
> +			u16 avail_flags_shadow;
> +
> +			/* Last written value to avail->idx in
> +			 * guest byte order. */
> +			u16 avail_idx_shadow;
> +		};

Name this field split so it's easier to detect misuse of e.g.
packed fields in split code?

> +
> +		/* Available for packed ring */
> +		struct {
> +			/* Actual memory layout for this queue. */
> +			struct vring_packed vring_packed;
> +
> +			/* Driver ring wrap counter. */
> +			bool avail_wrap_counter;
> +
> +			/* Device ring wrap counter. */
> +			bool used_wrap_counter;
> +
> +			/* Index of the next avail descriptor. */
> +			u16 next_avail_idx;
> +
> +			/* Last written value to driver->flags in
> +			 * guest byte order. */
> +			u16 event_flags_shadow;
> +		};
> +	};
>  
>  	/* How to notify other side. FIXME: commonalize hcalls! */
>  	bool (*notify)(struct virtqueue *vq);
> @@ -110,11 +142,24 @@ struct vring_virtqueue {
>  #endif
>  
>  	/* Per-descriptor state. */
> -	struct vring_desc_state desc_state[];
> +	union {
> +		struct vring_desc_state desc_state[1];
> +		struct vring_desc_state_packed desc_state_packed[1];
> +	};
>  };
>  
>  #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
>  
> +static inline bool virtqueue_use_indirect(struct virtqueue *_vq,
> +					  unsigned int total_sg)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	/* If the host supports indirect descriptor tables, and we have multiple
> +	 * buffers, then go indirect. FIXME: tune this threshold */
> +	return (vq->indirect && total_sg > 1 && vq->vq.num_free);
> +}
> +
>  /*
>   * Modern virtio devices have feature bits to specify whether they need a
>   * quirk and bypass the IOMMU. If not there, just use the DMA API.
> @@ -200,8 +245,17 @@ static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
>  			      cpu_addr, size, direction);
>  }
>  
> -static void vring_unmap_one(const struct vring_virtqueue *vq,
> -			    struct vring_desc *desc)
> +static int vring_mapping_error(const struct vring_virtqueue *vq,
> +			       dma_addr_t addr)
> +{
> +	if (!vring_use_dma_api(vq->vq.vdev))
> +		return 0;
> +
> +	return dma_mapping_error(vring_dma_dev(vq), addr);
> +}
> +
> +static void vring_unmap_one_split(const struct vring_virtqueue *vq,
> +				  struct vring_desc *desc)
>  {
>  	u16 flags;
>  
> @@ -225,17 +279,9 @@ static void vring_unmap_one(const struct vring_virtqueue *vq,
>  	}
>  }
>  
> -static int vring_mapping_error(const struct vring_virtqueue *vq,
> -			       dma_addr_t addr)
> -{
> -	if (!vring_use_dma_api(vq->vq.vdev))
> -		return 0;
> -
> -	return dma_mapping_error(vring_dma_dev(vq), addr);
> -}
> -
> -static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
> -					 unsigned int total_sg, gfp_t gfp)
> +static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
> +					       unsigned int total_sg,
> +					       gfp_t gfp)
>  {
>  	struct vring_desc *desc;
>  	unsigned int i;
> @@ -256,14 +302,14 @@ static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
>  	return desc;
>  }
>  
> -static inline int virtqueue_add(struct virtqueue *_vq,
> -				struct scatterlist *sgs[],
> -				unsigned int total_sg,
> -				unsigned int out_sgs,
> -				unsigned int in_sgs,
> -				void *data,
> -				void *ctx,
> -				gfp_t gfp)
> +static inline int virtqueue_add_split(struct virtqueue *_vq,
> +				      struct scatterlist *sgs[],
> +				      unsigned int total_sg,
> +				      unsigned int out_sgs,
> +				      unsigned int in_sgs,
> +				      void *data,
> +				      void *ctx,
> +				      gfp_t gfp)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  	struct scatterlist *sg;
> @@ -299,10 +345,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  
>  	head = vq->free_head;
>  
> -	/* If the host supports indirect descriptor tables, and we have multiple
> -	 * buffers, then go indirect. FIXME: tune this threshold */
> -	if (vq->indirect && total_sg > 1 && vq->vq.num_free)
> -		desc = alloc_indirect(_vq, total_sg, gfp);
> +	if (virtqueue_use_indirect(_vq, total_sg))
> +		desc = alloc_indirect_split(_vq, total_sg, gfp);
>  	else {
>  		desc = NULL;
>  		WARN_ON_ONCE(total_sg > vq->vring.num && !vq->indirect);
> @@ -423,7 +467,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  	for (n = 0; n < total_sg; n++) {
>  		if (i == err_idx)
>  			break;
> -		vring_unmap_one(vq, &desc[i]);
> +		vring_unmap_one_split(vq, &desc[i]);
>  		i = virtio16_to_cpu(_vq->vdev, vq->vring.desc[i].next);
>  	}
>  
> @@ -434,6 +478,355 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  	return -EIO;
>  }
>  
> +static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 new, old;
> +	bool needs_kick;
> +
> +	START_USE(vq);
> +	/* We need to expose available array entries before checking avail
> +	 * event. */
> +	virtio_mb(vq->weak_barriers);
> +
> +	old = vq->avail_idx_shadow - vq->num_added;
> +	new = vq->avail_idx_shadow;
> +	vq->num_added = 0;
> +
> +#ifdef DEBUG
> +	if (vq->last_add_time_valid) {
> +		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
> +					      vq->last_add_time)) > 100);
> +	}
> +	vq->last_add_time_valid = false;
> +#endif
> +
> +	if (vq->event) {
> +		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev, vring_avail_event(&vq->vring)),
> +					      new, old);
> +	} else {
> +		needs_kick = !(vq->vring.used->flags & cpu_to_virtio16(_vq->vdev, VRING_USED_F_NO_NOTIFY));
> +	}
> +	END_USE(vq);
> +	return needs_kick;
> +}
> +
> +static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> +			     void **ctx)
> +{
> +	unsigned int i, j;
> +	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> +
> +	/* Clear data ptr. */
> +	vq->desc_state[head].data = NULL;
> +
> +	/* Put back on free list: unmap first-level descriptors and find end */
> +	i = head;
> +
> +	while (vq->vring.desc[i].flags & nextflag) {
> +		vring_unmap_one_split(vq, &vq->vring.desc[i]);
> +		i = virtio16_to_cpu(vq->vq.vdev, vq->vring.desc[i].next);
> +		vq->vq.num_free++;
> +	}
> +
> +	vring_unmap_one_split(vq, &vq->vring.desc[i]);
> +	vq->vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev, vq->free_head);
> +	vq->free_head = head;
> +
> +	/* Plus final descriptor */
> +	vq->vq.num_free++;
> +
> +	if (vq->indirect) {
> +		struct vring_desc *indir_desc = vq->desc_state[head].indir_desc;
> +		u32 len;
> +
> +		/* Free the indirect table, if any, now that it's unmapped. */
> +		if (!indir_desc)
> +			return;
> +
> +		len = virtio32_to_cpu(vq->vq.vdev, vq->vring.desc[head].len);
> +
> +		BUG_ON(!(vq->vring.desc[head].flags &
> +			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));
> +		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> +
> +		for (j = 0; j < len / sizeof(struct vring_desc); j++)
> +			vring_unmap_one_split(vq, &indir_desc[j]);
> +
> +		kfree(indir_desc);
> +		vq->desc_state[head].indir_desc = NULL;
> +	} else if (ctx) {
> +		*ctx = vq->desc_state[head].indir_desc;
> +	}
> +}
> +
> +static inline bool more_used_split(const struct vring_virtqueue *vq)
> +{
> +	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev, vq->vring.used->idx);
> +}
> +
> +static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> +					 unsigned int *len,
> +					 void **ctx)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	void *ret;
> +	unsigned int i;
> +	u16 last_used;
> +
> +	START_USE(vq);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	if (!more_used_split(vq)) {
> +		pr_debug("No more buffers in queue\n");
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	/* Only get used array entries after they have been exposed by host. */
> +	virtio_rmb(vq->weak_barriers);
> +
> +	last_used = (vq->last_used_idx & (vq->vring.num - 1));
> +	i = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].id);
> +	*len = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].len);
> +
> +	if (unlikely(i >= vq->vring.num)) {
> +		BAD_RING(vq, "id %u out of range\n", i);
> +		return NULL;
> +	}
> +	if (unlikely(!vq->desc_state[i].data)) {
> +		BAD_RING(vq, "id %u is not a head!\n", i);
> +		return NULL;
> +	}
> +
> +	/* detach_buf_split clears data, so grab it now. */
> +	ret = vq->desc_state[i].data;
> +	detach_buf_split(vq, i, ctx);
> +	vq->last_used_idx++;
> +	/* If we expect an interrupt for the next entry, tell host
> +	 * by writing event index and flush out the write before
> +	 * the read in the next get_buf call. */
> +	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> +		virtio_store_mb(vq->weak_barriers,
> +				&vring_used_event(&vq->vring),
> +				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> +
> +#ifdef DEBUG
> +	vq->last_add_time_valid = false;
> +#endif
> +
> +	END_USE(vq);
> +	return ret;
> +}
> +
> +static void virtqueue_disable_cb_split(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> +		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +		if (!vq->event)
> +			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
> +	}
> +}
> +
> +static unsigned virtqueue_enable_cb_prepare_split(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 last_used_idx;
> +
> +	START_USE(vq);
> +
> +	/* We optimistically turn back on interrupts, then check if there was
> +	 * more to do. */
> +	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
> +	 * either clear the flags bit or point the event index at the next
> +	 * entry. Always do both to keep code simple. */
> +	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
> +		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
> +		if (!vq->event)
> +			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
> +	}
> +	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, last_used_idx = vq->last_used_idx);
> +	END_USE(vq);
> +	return last_used_idx;
> +}
> +
> +static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned last_used_idx)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	virtio_mb(vq->weak_barriers);
> +	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev, vq->vring.used->idx);
> +}
> +
> +static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	u16 bufs;
> +
> +	START_USE(vq);
> +
> +	/* We optimistically turn back on interrupts, then check if there was
> +	 * more to do. */
> +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> +	 * either clear the flags bit or point the event index at the next
> +	 * entry. Always update the event index to keep code simple. */
> +	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
> +		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
> +		if (!vq->event)
> +			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
> +	}
> +	/* TODO: tune this threshold */
> +	bufs = (u16)(vq->avail_idx_shadow - vq->last_used_idx) * 3 / 4;
> +
> +	virtio_store_mb(vq->weak_barriers,
> +			&vring_used_event(&vq->vring),
> +			cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs));
> +
> +	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->vring.used->idx) - vq->last_used_idx) > bufs)) {
> +		END_USE(vq);
> +		return false;
> +	}
> +
> +	END_USE(vq);
> +	return true;
> +}
> +
> +static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	unsigned int i;
> +	void *buf;
> +
> +	START_USE(vq);
> +
> +	for (i = 0; i < vq->vring.num; i++) {
> +		if (!vq->desc_state[i].data)
> +			continue;
> +		/* detach_buf clears data, so grab it now. */
> +		buf = vq->desc_state[i].data;
> +		detach_buf_split(vq, i, NULL);
> +		vq->avail_idx_shadow--;
> +		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
> +		END_USE(vq);
> +		return buf;
> +	}
> +	/* That should have freed everything. */
> +	BUG_ON(vq->vq.num_free != vq->vring.num);
> +
> +	END_USE(vq);
> +	return NULL;
> +}
> +
> +/*
> + * The layout for the packed ring is a continuous chunk of memory
> + * which looks like this.
> + *
> + * struct vring_packed {
> + *	// The actual descriptors (16 bytes each)
> + *	struct vring_packed_desc desc[num];
> + *
> + *	// Padding to the next align boundary.
> + *	char pad[];
> + *
> + *	// Driver Event Suppression
> + *	struct vring_packed_desc_event driver;
> + *
> + *	// Device Event Suppression
> + *	struct vring_packed_desc_event device;
> + * };
> + */

Why not just allocate event structures separately?
Is it a win to have them share a cache line for some reason?

> +static inline void vring_init_packed(struct vring_packed *vr, unsigned int num,
> +				     void *p, unsigned long align)
> +{
> +	vr->num = num;
> +	vr->desc = p;
> +	vr->driver = (void *)ALIGN(((uintptr_t)p +
> +		sizeof(struct vring_packed_desc) * num), align);
> +	vr->device = vr->driver + 1;
> +}

What's all this about alignment? Where does it come from?

> +
> +static inline unsigned vring_size_packed(unsigned int num, unsigned long align)
> +{
> +	return ((sizeof(struct vring_packed_desc) * num + align - 1)
> +		& ~(align - 1)) + sizeof(struct vring_packed_desc_event) * 2;
> +}
> +
> +static inline int virtqueue_add_packed(struct virtqueue *_vq,
> +				       struct scatterlist *sgs[],
> +				       unsigned int total_sg,
> +				       unsigned int out_sgs,
> +				       unsigned int in_sgs,
> +				       void *data,
> +				       void *ctx,
> +				       gfp_t gfp)
> +{
> +	return -EIO;
> +}
> +
> +static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> +{
> +	return false;
> +}
> +
> +static inline bool more_used_packed(const struct vring_virtqueue *vq)
> +{
> +	return false;
> +}
> +
> +static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> +					  unsigned int *len,
> +					  void **ctx)
> +{
> +	return NULL;
> +}
> +
> +static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> +{
> +}
> +
> +static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> +{
> +	return 0;
> +}
> +
> +static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
> +{
> +	return false;
> +}
> +
> +static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> +{
> +	return false;
> +}
> +
> +static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
> +{
> +	return NULL;
> +}
> +
> +static inline int virtqueue_add(struct virtqueue *_vq,
> +				struct scatterlist *sgs[],
> +				unsigned int total_sg,
> +				unsigned int out_sgs,
> +				unsigned int in_sgs,
> +				void *data,
> +				void *ctx,
> +				gfp_t gfp)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return vq->packed ? virtqueue_add_packed(_vq, sgs, total_sg, out_sgs,
> +						 in_sgs, data, ctx, gfp) :
> +			    virtqueue_add_split(_vq, sgs, total_sg, out_sgs,
> +						in_sgs, data, ctx, gfp);
> +}
> +
>  /**
>   * virtqueue_add_sgs - expose buffers to other end
>   * @vq: the struct virtqueue we're talking about.
> @@ -550,34 +943,9 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
>  bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> -	u16 new, old;
> -	bool needs_kick;
>  
> -	START_USE(vq);
> -	/* We need to expose available array entries before checking avail
> -	 * event. */
> -	virtio_mb(vq->weak_barriers);
> -
> -	old = vq->avail_idx_shadow - vq->num_added;
> -	new = vq->avail_idx_shadow;
> -	vq->num_added = 0;
> -
> -#ifdef DEBUG
> -	if (vq->last_add_time_valid) {
> -		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
> -					      vq->last_add_time)) > 100);
> -	}
> -	vq->last_add_time_valid = false;
> -#endif
> -
> -	if (vq->event) {
> -		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev, vring_avail_event(&vq->vring)),
> -					      new, old);
> -	} else {
> -		needs_kick = !(vq->vring.used->flags & cpu_to_virtio16(_vq->vdev, VRING_USED_F_NO_NOTIFY));
> -	}
> -	END_USE(vq);
> -	return needs_kick;
> +	return vq->packed ? virtqueue_kick_prepare_packed(_vq) :
> +			    virtqueue_kick_prepare_split(_vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>  
> @@ -625,58 +993,9 @@ bool virtqueue_kick(struct virtqueue *vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick);
>  
> -static void detach_buf(struct vring_virtqueue *vq, unsigned int head,
> -		       void **ctx)
> -{
> -	unsigned int i, j;
> -	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
> -
> -	/* Clear data ptr. */
> -	vq->desc_state[head].data = NULL;
> -
> -	/* Put back on free list: unmap first-level descriptors and find end */
> -	i = head;
> -
> -	while (vq->vring.desc[i].flags & nextflag) {
> -		vring_unmap_one(vq, &vq->vring.desc[i]);
> -		i = virtio16_to_cpu(vq->vq.vdev, vq->vring.desc[i].next);
> -		vq->vq.num_free++;
> -	}
> -
> -	vring_unmap_one(vq, &vq->vring.desc[i]);
> -	vq->vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev, vq->free_head);
> -	vq->free_head = head;
> -
> -	/* Plus final descriptor */
> -	vq->vq.num_free++;
> -
> -	if (vq->indirect) {
> -		struct vring_desc *indir_desc = vq->desc_state[head].indir_desc;
> -		u32 len;
> -
> -		/* Free the indirect table, if any, now that it's unmapped. */
> -		if (!indir_desc)
> -			return;
> -
> -		len = virtio32_to_cpu(vq->vq.vdev, vq->vring.desc[head].len);
> -
> -		BUG_ON(!(vq->vring.desc[head].flags &
> -			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));
> -		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
> -
> -		for (j = 0; j < len / sizeof(struct vring_desc); j++)
> -			vring_unmap_one(vq, &indir_desc[j]);
> -
> -		kfree(indir_desc);
> -		vq->desc_state[head].indir_desc = NULL;
> -	} else if (ctx) {
> -		*ctx = vq->desc_state[head].indir_desc;
> -	}
> -}
> -
>  static inline bool more_used(const struct vring_virtqueue *vq)
>  {
> -	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev, vq->vring.used->idx);
> +	return vq->packed ? more_used_packed(vq) : more_used_split(vq);
>  }
>  
>  /**
> @@ -699,57 +1018,9 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  			    void **ctx)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> -	void *ret;
> -	unsigned int i;
> -	u16 last_used;
>  
> -	START_USE(vq);
> -
> -	if (unlikely(vq->broken)) {
> -		END_USE(vq);
> -		return NULL;
> -	}
> -
> -	if (!more_used(vq)) {
> -		pr_debug("No more buffers in queue\n");
> -		END_USE(vq);
> -		return NULL;
> -	}
> -
> -	/* Only get used array entries after they have been exposed by host. */
> -	virtio_rmb(vq->weak_barriers);
> -
> -	last_used = (vq->last_used_idx & (vq->vring.num - 1));
> -	i = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].id);
> -	*len = virtio32_to_cpu(_vq->vdev, vq->vring.used->ring[last_used].len);
> -
> -	if (unlikely(i >= vq->vring.num)) {
> -		BAD_RING(vq, "id %u out of range\n", i);
> -		return NULL;
> -	}
> -	if (unlikely(!vq->desc_state[i].data)) {
> -		BAD_RING(vq, "id %u is not a head!\n", i);
> -		return NULL;
> -	}
> -
> -	/* detach_buf clears data, so grab it now. */
> -	ret = vq->desc_state[i].data;
> -	detach_buf(vq, i, ctx);
> -	vq->last_used_idx++;
> -	/* If we expect an interrupt for the next entry, tell host
> -	 * by writing event index and flush out the write before
> -	 * the read in the next get_buf call. */
> -	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
> -		virtio_store_mb(vq->weak_barriers,
> -				&vring_used_event(&vq->vring),
> -				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> -
> -#ifdef DEBUG
> -	vq->last_add_time_valid = false;
> -#endif
> -
> -	END_USE(vq);
> -	return ret;
> +	return vq->packed ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
> +			    virtqueue_get_buf_ctx_split(_vq, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> @@ -771,12 +1042,10 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	if (!(vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
> -		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> -		if (!vq->event)
> -			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
> -	}
> -
> +	if (vq->packed)
> +		virtqueue_disable_cb_packed(_vq);
> +	else
> +		virtqueue_disable_cb_split(_vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>  
> @@ -795,23 +1064,9 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>  unsigned virtqueue_enable_cb_prepare(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> -	u16 last_used_idx;
>  
> -	START_USE(vq);
> -
> -	/* We optimistically turn back on interrupts, then check if there was
> -	 * more to do. */
> -	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
> -	 * either clear the flags bit or point the event index at the next
> -	 * entry. Always do both to keep code simple. */
> -	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
> -		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
> -		if (!vq->event)
> -			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
> -	}
> -	vring_used_event(&vq->vring) = cpu_to_virtio16(_vq->vdev, last_used_idx = vq->last_used_idx);
> -	END_USE(vq);
> -	return last_used_idx;
> +	return vq->packed ? virtqueue_enable_cb_prepare_packed(_vq) :
> +			    virtqueue_enable_cb_prepare_split(_vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>  
> @@ -828,8 +1083,8 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	virtio_mb(vq->weak_barriers);
> -	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev, vq->vring.used->idx);
> +	return vq->packed ? virtqueue_poll_packed(_vq, last_used_idx) :
> +			    virtqueue_poll_split(_vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> @@ -867,34 +1122,9 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
>  bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> -	u16 bufs;
>  
> -	START_USE(vq);
> -
> -	/* We optimistically turn back on interrupts, then check if there was
> -	 * more to do. */
> -	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> -	 * either clear the flags bit or point the event index at the next
> -	 * entry. Always update the event index to keep code simple. */
> -	if (vq->avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
> -		vq->avail_flags_shadow &= ~VRING_AVAIL_F_NO_INTERRUPT;
> -		if (!vq->event)
> -			vq->vring.avail->flags = cpu_to_virtio16(_vq->vdev, vq->avail_flags_shadow);
> -	}
> -	/* TODO: tune this threshold */
> -	bufs = (u16)(vq->avail_idx_shadow - vq->last_used_idx) * 3 / 4;
> -
> -	virtio_store_mb(vq->weak_barriers,
> -			&vring_used_event(&vq->vring),
> -			cpu_to_virtio16(_vq->vdev, vq->last_used_idx + bufs));
> -
> -	if (unlikely((u16)(virtio16_to_cpu(_vq->vdev, vq->vring.used->idx) - vq->last_used_idx) > bufs)) {
> -		END_USE(vq);
> -		return false;
> -	}
> -
> -	END_USE(vq);
> -	return true;
> +	return vq->packed ? virtqueue_enable_cb_delayed_packed(_vq) :
> +			    virtqueue_enable_cb_delayed_split(_vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>  
> @@ -909,27 +1139,9 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>  void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> -	unsigned int i;
> -	void *buf;
>  
> -	START_USE(vq);
> -
> -	for (i = 0; i < vq->vring.num; i++) {
> -		if (!vq->desc_state[i].data)
> -			continue;
> -		/* detach_buf clears data, so grab it now. */
> -		buf = vq->desc_state[i].data;
> -		detach_buf(vq, i, NULL);
> -		vq->avail_idx_shadow--;
> -		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
> -		END_USE(vq);
> -		return buf;
> -	}
> -	/* That should have freed everything. */
> -	BUG_ON(vq->vq.num_free != vq->vring.num);
> -
> -	END_USE(vq);
> -	return NULL;
> +	return vq->packed ? virtqueue_detach_unused_buf_packed(_vq) :
> +			    virtqueue_detach_unused_buf_split(_vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>  
> @@ -954,7 +1166,8 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  EXPORT_SYMBOL_GPL(vring_interrupt);
>  
>  struct virtqueue *__vring_new_virtqueue(unsigned int index,
> -					struct vring vring,
> +					union vring_union vring,
> +					bool packed,
>  					struct virtio_device *vdev,
>  					bool weak_barriers,
>  					bool context,
> @@ -962,19 +1175,22 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  					void (*callback)(struct virtqueue *),
>  					const char *name)
>  {
> -	unsigned int i;
>  	struct vring_virtqueue *vq;
> +	unsigned int num, i;
> +	size_t size;
>  
> -	vq = kmalloc(sizeof(*vq) + vring.num * sizeof(struct vring_desc_state),
> -		     GFP_KERNEL);
> +	num = packed ? vring.vring_packed.num : vring.vring_split.num;
> +	size = packed ? num * sizeof(struct vring_desc_state_packed) :
> +			num * sizeof(struct vring_desc_state);
> +
> +	vq = kmalloc(sizeof(*vq) + size, GFP_KERNEL);
>  	if (!vq)
>  		return NULL;
>  
> -	vq->vring = vring;
>  	vq->vq.callback = callback;
>  	vq->vq.vdev = vdev;
>  	vq->vq.name = name;
> -	vq->vq.num_free = vring.num;
> +	vq->vq.num_free = num;
>  	vq->vq.index = index;
>  	vq->we_own_ring = false;
>  	vq->queue_dma_addr = 0;
> @@ -983,9 +1199,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	vq->weak_barriers = weak_barriers;
>  	vq->broken = false;
>  	vq->last_used_idx = 0;
> -	vq->avail_flags_shadow = 0;
> -	vq->avail_idx_shadow = 0;
>  	vq->num_added = 0;
> +	vq->packed = packed;
>  	list_add_tail(&vq->vq.list, &vdev->vqs);
>  #ifdef DEBUG
>  	vq->in_use = false;
> @@ -996,19 +1211,48 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  		!context;
>  	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>  
> +	if (vq->packed) {
> +		vq->vring_packed = vring.vring_packed;
> +		vq->next_avail_idx = 0;
> +		vq->avail_wrap_counter = 1;
> +		vq->used_wrap_counter = 1;
> +		vq->event_flags_shadow = 0;
> +
> +		memset(vq->desc_state_packed, 0,
> +			num * sizeof(struct vring_desc_state_packed));
> +
> +		/* Put everything in free lists. */
> +		vq->free_head = 0;
> +		for (i = 0; i < num-1; i++)
> +			vq->desc_state_packed[i].next = i + 1;
> +	} else {
> +		vq->vring = vring.vring_split;
> +		vq->avail_flags_shadow = 0;
> +		vq->avail_idx_shadow = 0;
> +
> +		/* Put everything in free lists. */
> +		vq->free_head = 0;
> +		for (i = 0; i < num-1; i++)
> +			vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1);
> +
> +		memset(vq->desc_state, 0,
> +			num * sizeof(struct vring_desc_state));
> +	}
> +
>  	/* No callback?  Tell other side not to bother us. */
>  	if (!callback) {
> -		vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> -		if (!vq->event)
> -			vq->vring.avail->flags = cpu_to_virtio16(vdev, vq->avail_flags_shadow);
> +		if (packed) {
> +			vq->event_flags_shadow = VRING_EVENT_F_DISABLE;
> +			vq->vring_packed.driver->flags = cpu_to_virtio16(vdev,
> +						vq->event_flags_shadow);
> +		} else {
> +			vq->avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> +			if (!vq->event)
> +				vq->vring.avail->flags = cpu_to_virtio16(vdev,
> +						vq->avail_flags_shadow);
> +		}
>  	}
>  
> -	/* Put everything in free lists. */
> -	vq->free_head = 0;
> -	for (i = 0; i < vring.num-1; i++)
> -		vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1);
> -	memset(vq->desc_state, 0, vring.num * sizeof(struct vring_desc_state));
> -
>  	return &vq->vq;
>  }
>  EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
> @@ -1055,6 +1299,12 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
>  	}
>  }
>  
> +static inline int
> +__vring_size(unsigned int num, unsigned long align, bool packed)
> +{
> +	return packed ? vring_size_packed(num, align) : vring_size(num, align);
> +}
> +
>  struct virtqueue *vring_create_virtqueue(
>  	unsigned int index,
>  	unsigned int num,
> @@ -1071,7 +1321,8 @@ struct virtqueue *vring_create_virtqueue(
>  	void *queue = NULL;
>  	dma_addr_t dma_addr;
>  	size_t queue_size_in_bytes;
> -	struct vring vring;
> +	union vring_union vring;
> +	bool packed;
>  
>  	/* We assume num is a power of 2. */
>  	if (num & (num - 1)) {
> @@ -1079,9 +1330,13 @@ struct virtqueue *vring_create_virtqueue(
>  		return NULL;
>  	}
>  
> +	packed = virtio_has_feature(vdev, VIRTIO_F_RING_PACKED);
> +
>  	/* TODO: allocate each queue chunk individually */
> -	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
> -		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
> +	for (; num && __vring_size(num, vring_align, packed) > PAGE_SIZE;
> +			num /= 2) {
> +		queue = vring_alloc_queue(vdev, __vring_size(num, vring_align,
> +							     packed),
>  					  &dma_addr,
>  					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
>  		if (queue)
> @@ -1093,17 +1348,21 @@ struct virtqueue *vring_create_virtqueue(
>  
>  	if (!queue) {
>  		/* Try to get a single page. You are my only hope! */
> -		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
> +		queue = vring_alloc_queue(vdev, __vring_size(num, vring_align,
> +							     packed),
>  					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
>  	}
>  	if (!queue)
>  		return NULL;
>  
> -	queue_size_in_bytes = vring_size(num, vring_align);
> -	vring_init(&vring, num, queue, vring_align);
> +	queue_size_in_bytes = __vring_size(num, vring_align, packed);
> +	if (packed)
> +		vring_init_packed(&vring.vring_packed, num, queue, vring_align);
> +	else
> +		vring_init(&vring.vring_split, num, queue, vring_align);
>  
> -	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
> -				   notify, callback, name);
> +	vq = __vring_new_virtqueue(index, vring, packed, vdev, weak_barriers,
> +				   context, notify, callback, name);
>  	if (!vq) {
>  		vring_free_queue(vdev, queue_size_in_bytes, queue,
>  				 dma_addr);
> @@ -1129,10 +1388,17 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  				      void (*callback)(struct virtqueue *vq),
>  				      const char *name)
>  {
> -	struct vring vring;
> -	vring_init(&vring, num, pages, vring_align);
> -	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
> -				     notify, callback, name);
> +	union vring_union vring;
> +	bool packed;
> +
> +	packed = virtio_has_feature(vdev, VIRTIO_F_RING_PACKED);
> +	if (packed)
> +		vring_init_packed(&vring.vring_packed, num, pages, vring_align);
> +	else
> +		vring_init(&vring.vring_split, num, pages, vring_align);


vring_init in the UAPI header is more or less a bug.
I'd just stop using it, keep it around for legacy userspace.

> +
> +	return __vring_new_virtqueue(index, vring, packed, vdev, weak_barriers,
> +				     context, notify, callback, name);
>  }
>  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
>  
> @@ -1142,7 +1408,9 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  
>  	if (vq->we_own_ring) {
>  		vring_free_queue(vq->vq.vdev, vq->queue_size_in_bytes,
> -				 vq->vring.desc, vq->queue_dma_addr);
> +				 vq->packed ? (void *)vq->vring_packed.desc :
> +					      (void *)vq->vring.desc,
> +				 vq->queue_dma_addr);
>  	}
>  	list_del(&_vq->list);
>  	kfree(vq);
> @@ -1184,7 +1452,7 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
>  
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->vring.num;
> +	return vq->packed ? vq->vring_packed.num : vq->vring.num;
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>  
> @@ -1227,6 +1495,10 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> +	if (vq->packed)
> +		return vq->queue_dma_addr + ((char *)vq->vring_packed.driver -
> +				(char *)vq->vring_packed.desc);
> +
>  	return vq->queue_dma_addr +
>  		((char *)vq->vring.avail - (char *)vq->vring.desc);
>  }
> @@ -1238,11 +1510,16 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
>  
>  	BUG_ON(!vq->we_own_ring);
>  
> +	if (vq->packed)
> +		return vq->queue_dma_addr + ((char *)vq->vring_packed.device -
> +				(char *)vq->vring_packed.desc);
> +
>  	return vq->queue_dma_addr +
>  		((char *)vq->vring.used - (char *)vq->vring.desc);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
>  
> +/* Only available for split ring */
>  const struct vring *virtqueue_get_vring(struct virtqueue *vq)
>  {
>  	return &to_vvq(vq)->vring;
> diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> index fab02133a919..992142b35f55 100644
> --- a/include/linux/virtio_ring.h
> +++ b/include/linux/virtio_ring.h
> @@ -60,6 +60,11 @@ static inline void virtio_store_mb(bool weak_barriers,
>  struct virtio_device;
>  struct virtqueue;
>  
> +union vring_union {
> +	struct vring vring_split;
> +	struct vring_packed vring_packed;
> +};
> +
>  /*
>   * Creates a virtqueue and allocates the descriptor ring.  If
>   * may_reduce_num is set, then this may allocate a smaller ring than
> @@ -79,7 +84,8 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
>  
>  /* Creates a virtqueue with a custom layout. */
>  struct virtqueue *__vring_new_virtqueue(unsigned int index,
> -					struct vring vring,
> +					union vring_union vring,
> +					bool packed,
>  					struct virtio_device *vdev,
>  					bool weak_barriers,
>  					bool ctx,
> -- 
> 2.18.0
