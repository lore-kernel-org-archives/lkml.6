Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94F0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF632086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF632086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeIJHYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:24:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:51315 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeIJHYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:24:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2018 19:04:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,354,1531810800"; 
   d="scan'208";a="255830880"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.194])
  by orsmga005.jf.intel.com with ESMTP; 09 Sep 2018 19:04:26 -0700
Date:   Mon, 10 Sep 2018 10:03:29 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 3/5] virtio_ring: add packed ring support
Message-ID: <20180910020329.GA9076@debian>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-4-tiwei.bie@intel.com>
 <20180907083500-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907083500-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 09:49:14AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 11, 2018 at 10:27:09AM +0800, Tiwei Bie wrote:
> > This commit introduces the support (without EVENT_IDX) for
> > packed ring.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 495 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 487 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index c4f8abc7445a..f317b485ba54 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -55,12 +55,21 @@
> >  #define END_USE(vq)
> >  #endif
> >  
> > +#define _VRING_DESC_F_AVAIL(b)	((__u16)(b) << 7)
> > +#define _VRING_DESC_F_USED(b)	((__u16)(b) << 15)
> 
> Underscore followed by an upper case letter isn't a good idea
> for a symbol. And it's not nice that this does not
> use the VRING_DESC_F_USED from the header.
> How about ((b) ? VRING_DESC_F_USED : 0) instead?
> Is produced code worse then?

Yes, I think the produced code is worse when we use
conditional expression. Below is a simple test:

#define foo1(b) ((b) << 10)
#define foo2(b) ((b) ? (1 << 10) : 0)

unsigned short bar(unsigned short b)
{
	return foo1(b);
}

unsigned short baz(unsigned short b)
{
	return foo2(b);
}

With `gcc -O3 -S`, I got below assembly code:

	.file	"tmp.c"
	.text
	.p2align 4,,15
	.globl	bar
	.type	bar, @function
bar:
.LFB0:
	.cfi_startproc
	movl	%edi, %eax
	sall	$10, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	bar, .-bar
	.p2align 4,,15
	.globl	baz
	.type	baz, @function
baz:
.LFB1:
	.cfi_startproc
	xorl	%eax, %eax
	testw	%di, %di
	setne	%al
	sall	$10, %eax
	ret
	.cfi_endproc
.LFE1:
	.size	baz, .-baz
	.ident	"GCC: (Debian 8.2.0-4) 8.2.0"
	.section	.note.GNU-stack,"",@progbits

That is to say, for `((b) << 10)`, it will shift the
register directly. But for `((b) ? (1 << 10) : 0)`,
in above code, it will zero eax first, and set al
to 1 depend on whether di is 0, and shift eax.

> 
> > +
> >  struct vring_desc_state {
> >  	void *data;			/* Data for callback. */
> >  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> >  };
> >  
> >  struct vring_desc_state_packed {
> > +	void *data;			/* Data for callback. */
> > +	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
> 
> Include vring_desc_state for these?

Sure.

> 
> > +	int num;			/* Descriptor list length. */
> > +	dma_addr_t addr;		/* Buffer DMA addr. */
> > +	u32 len;			/* Buffer length. */
> > +	u16 flags;			/* Descriptor flags. */
> 
> This seems only to be used for indirect. Check indirect field above
> instead and drop this.

The `flags` is also needed to know the direction, i.e. DMA_FROM_DEVICE
or DMA_TO_DEVICE when do DMA unmap.

> 
> >  	int next;			/* The next desc state. */
> 
> Packing things into 16 bit integers will help reduce
> cache pressure here.
> 
> Also, this is only used for unmap, so when dma API is not used,
> maintaining addr and len list management is unnecessary. How about we
> maintain addr/len in a separate array, avoiding accesses on unmap in that case?

Sure. I'll give it a try.

> 
> Also, lots of architectures have a nop unmap in the DMA API.
> See a proposed patch at the end for optimizing that case.

Got it. Thanks.

> 
> >  };
> >  
> > @@ -660,7 +669,6 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned last_used_idx)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> > -	virtio_mb(vq->weak_barriers);
> >  	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev, vq->vring.used->idx);
> >  }
> 
> why is this changing the split queue implementation?

Because above barrier is also needed by virtqueue_poll_packed(),
so I moved it to virtqueue_poll() and also added some comments
for it.

> 
> 
> >  
> > @@ -757,6 +765,72 @@ static inline unsigned vring_size_packed(unsigned int num, unsigned long align)
> >  		& ~(align - 1)) + sizeof(struct vring_packed_desc_event) * 2;
> >  }
> >  
> > +static void vring_unmap_state_packed(const struct vring_virtqueue *vq,
> > +				     struct vring_desc_state_packed *state)
> > +{
> > +	u16 flags;
> > +
> > +	if (!vring_use_dma_api(vq->vq.vdev))
> > +		return;
> > +
> > +	flags = state->flags;
> > +
> > +	if (flags & VRING_DESC_F_INDIRECT) {
> > +		dma_unmap_single(vring_dma_dev(vq),
> > +				 state->addr, state->len,
> > +				 (flags & VRING_DESC_F_WRITE) ?
> > +				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +	} else {
> > +		dma_unmap_page(vring_dma_dev(vq),
> > +			       state->addr, state->len,
> > +			       (flags & VRING_DESC_F_WRITE) ?
> > +			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +	}
> > +}
> > +
> > +static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> > +				   struct vring_packed_desc *desc)
> > +{
> > +	u16 flags;
> > +
> > +	if (!vring_use_dma_api(vq->vq.vdev))
> > +		return;
> > +
> > +	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
> 
> I see no reason to use virtioXX wrappers for the packed ring.
> That's there to support legacy devices. Just use leXX.

Okay.

> 
> > +
> > +	if (flags & VRING_DESC_F_INDIRECT) {
> > +		dma_unmap_single(vring_dma_dev(vq),
> > +				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
> > +				 virtio32_to_cpu(vq->vq.vdev, desc->len),
> > +				 (flags & VRING_DESC_F_WRITE) ?
> > +				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +	} else {
> > +		dma_unmap_page(vring_dma_dev(vq),
> > +			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
> > +			       virtio32_to_cpu(vq->vq.vdev, desc->len),
> > +			       (flags & VRING_DESC_F_WRITE) ?
> > +			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +	}
> > +}
> > +
> > +static struct vring_packed_desc *alloc_indirect_packed(struct virtqueue *_vq,
> > +						       unsigned int total_sg,
> > +						       gfp_t gfp)
> > +{
> > +	struct vring_packed_desc *desc;
> > +
> > +	/*
> > +	 * We require lowmem mappings for the descriptors because
> > +	 * otherwise virt_to_phys will give us bogus addresses in the
> > +	 * virtqueue.
> 
> Where is virt_to_phys used? I don't see it in this patch.

In vring_map_single(), virt_to_phys() will be used to translate
the address to phys if dma api isn't used:

https://github.com/torvalds/linux/blob/a49a9dcce802/drivers/virtio/virtio_ring.c#L197

> 
> > +	 */
> > +	gfp &= ~__GFP_HIGHMEM;
> > +
> > +	desc = kmalloc(total_sg * sizeof(struct vring_packed_desc), gfp);
> > +
> > +	return desc;
> > +}
> > +
> >  static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >  				       struct scatterlist *sgs[],
> >  				       unsigned int total_sg,
> > @@ -766,47 +840,449 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >  				       void *ctx,
> >  				       gfp_t gfp)
> >  {
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	struct vring_packed_desc *desc;
> > +	struct scatterlist *sg;
> > +	unsigned int i, n, descs_used, uninitialized_var(prev), err_idx;
> > +	__virtio16 uninitialized_var(head_flags), flags;
> > +	u16 head, avail_wrap_counter, id, curr;
> > +	bool indirect;
> > +
> > +	START_USE(vq);
> > +
> > +	BUG_ON(data == NULL);
> > +	BUG_ON(ctx && vq->indirect);
> > +
> > +	if (unlikely(vq->broken)) {
> > +		END_USE(vq);
> > +		return -EIO;
> > +	}
> > +
> > +#ifdef DEBUG
> > +	{
> > +		ktime_t now = ktime_get();
> > +
> > +		/* No kick or get, with .1 second between?  Warn. */
> > +		if (vq->last_add_time_valid)
> > +			WARN_ON(ktime_to_ms(ktime_sub(now, vq->last_add_time))
> > +					    > 100);
> > +		vq->last_add_time = now;
> > +		vq->last_add_time_valid = true;
> > +	}
> > +#endif
> 
> Add incline helpers for this debug stuff rather than
> duplicate it from split ring?

Sure. I'd like to do that.

> 
> 
> > +
> > +	BUG_ON(total_sg == 0);
> > +
> > +	head = vq->next_avail_idx;
> > +	avail_wrap_counter = vq->avail_wrap_counter;
> > +
> > +	if (virtqueue_use_indirect(_vq, total_sg))
> > +		desc = alloc_indirect_packed(_vq, total_sg, gfp);
> > +	else {
> > +		desc = NULL;
> > +		WARN_ON_ONCE(total_sg > vq->vring_packed.num && !vq->indirect);
> > +	}
> 
> 
> Apparently this attempts to treat indirect descriptors same as
> direct ones. This is how it is in the split ring, but not in
> the packed one. I think you want two separate functions, for
> direct and indirect.

Okay, I'll do that.

> 
> > +
> > +	if (desc) {
> > +		/* Use a single buffer which doesn't continue */
> > +		indirect = true;
> > +		/* Set up rest to use this indirect table. */
> > +		i = 0;
> > +		descs_used = 1;
> > +	} else {
> > +		indirect = false;
> > +		desc = vq->vring_packed.desc;
> > +		i = head;
> > +		descs_used = total_sg;
> > +	}
> > +
> > +	if (vq->vq.num_free < descs_used) {
> > +		pr_debug("Can't add buf len %i - avail = %i\n",
> > +			 descs_used, vq->vq.num_free);
> > +		/* FIXME: for historical reasons, we force a notify here if
> > +		 * there are outgoing parts to the buffer.  Presumably the
> > +		 * host should service the ring ASAP. */
> > +		if (out_sgs)
> > +			vq->notify(&vq->vq);
> > +		if (indirect)
> > +			kfree(desc);
> > +		END_USE(vq);
> > +		return -ENOSPC;
> > +	}
> > +
> > +	id = vq->free_head;
> > +	BUG_ON(id == vq->vring_packed.num);
> > +
> > +	curr = id;
> > +	for (n = 0; n < out_sgs + in_sgs; n++) {
> > +		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> > +			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
> > +					       DMA_TO_DEVICE : DMA_FROM_DEVICE);
> > +			if (vring_mapping_error(vq, addr))
> > +				goto unmap_release;
> > +
> > +			flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT |
> > +				  (n < out_sgs ? 0 : VRING_DESC_F_WRITE) |
> > +				  _VRING_DESC_F_AVAIL(vq->avail_wrap_counter) |
> > +				  _VRING_DESC_F_USED(!vq->avail_wrap_counter));
> 
> Spec says:
> 	The VIRTQ_DESC_F_WRITE flags bit is the only valid flag for descriptors in the
> 	indirect table.
> 
> All this logic isn't needed for indirect.
> 
> Also, why re-calculate avail/used flags every time? They only change
> when you wrap around.

Will do that. Thanks.

> 
> 
> > +			if (!indirect && i == head)
> > +				head_flags = flags;
> > +			else
> > +				desc[i].flags = flags;
> > +
> > +			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
> > +			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
> > +			i++;
> > +			if (!indirect) {
> > +				if (vring_use_dma_api(_vq->vdev)) {
> > +					vq->desc_state_packed[curr].addr = addr;
> > +					vq->desc_state_packed[curr].len =
> > +						sg->length;
> > +					vq->desc_state_packed[curr].flags =
> > +						virtio16_to_cpu(_vq->vdev,
> > +								flags);
> > +				}
> > +				curr = vq->desc_state_packed[curr].next;
> > +
> > +				if (i >= vq->vring_packed.num) {
> > +					i = 0;
> > +					vq->avail_wrap_counter ^= 1;
> > +				}
> > +			}
> > +		}
> > +	}
> > +
> > +	prev = (i > 0 ? i : vq->vring_packed.num) - 1;
> > +	desc[prev].id = cpu_to_virtio16(_vq->vdev, id);
> 
> Is it easier to write this out in all descriptors, to avoid the need to
> calculate prev?

Yeah, I'll do that.

> 
> > +
> > +	/* Last one doesn't continue. */
> > +	if (total_sg == 1)
> > +		head_flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > +	else
> > +		desc[prev].flags &= cpu_to_virtio16(_vq->vdev,
> > +						~VRING_DESC_F_NEXT);
> 
> Wouldn't it be easier to avoid setting VRING_DESC_F_NEXT
> in the first place?
> 	 if (n != in_sgs - 1 && n != out_sgs - 1)

Will this affect the branch prediction?

> 
> must be better than writing descriptor an extra time.

Not quite sure about this. I think this descriptor has just
been written, it should still be in the cache.

> 
> > +
> > +	if (indirect) {
> > +		/* Now that the indirect table is filled in, map it. */
> > +		dma_addr_t addr = vring_map_single(
> > +			vq, desc, total_sg * sizeof(struct vring_packed_desc),
> > +			DMA_TO_DEVICE);
> > +		if (vring_mapping_error(vq, addr))
> > +			goto unmap_release;
> > +
> > +		head_flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT |
> > +				      _VRING_DESC_F_AVAIL(avail_wrap_counter) |
> > +				      _VRING_DESC_F_USED(!avail_wrap_counter));
> > +		vq->vring_packed.desc[head].addr = cpu_to_virtio64(_vq->vdev,
> > +								   addr);
> > +		vq->vring_packed.desc[head].len = cpu_to_virtio32(_vq->vdev,
> > +				total_sg * sizeof(struct vring_packed_desc));
> > +		vq->vring_packed.desc[head].id = cpu_to_virtio16(_vq->vdev, id);
> > +
> > +		if (vring_use_dma_api(_vq->vdev)) {
> > +			vq->desc_state_packed[id].addr = addr;
> > +			vq->desc_state_packed[id].len = total_sg *
> > +					sizeof(struct vring_packed_desc);
> > +			vq->desc_state_packed[id].flags =
> > +					virtio16_to_cpu(_vq->vdev, head_flags);
> > +		}
> > +	}
> > +
> > +	/* We're using some buffers from the free list. */
> > +	vq->vq.num_free -= descs_used;
> > +
> > +	/* Update free pointer */
> > +	if (indirect) {
> > +		n = head + 1;
> > +		if (n >= vq->vring_packed.num) {
> > +			n = 0;
> > +			vq->avail_wrap_counter ^= 1;
> > +		}
> > +		vq->next_avail_idx = n;
> > +		vq->free_head = vq->desc_state_packed[id].next;
> > +	} else {
> > +		vq->next_avail_idx = i;
> > +		vq->free_head = curr;
> > +	}
> > +
> > +	/* Store token and indirect buffer state. */
> > +	vq->desc_state_packed[id].num = descs_used;
> > +	vq->desc_state_packed[id].data = data;
> > +	if (indirect)
> > +		vq->desc_state_packed[id].indir_desc = desc;
> > +	else
> > +		vq->desc_state_packed[id].indir_desc = ctx;
> > +
> > +	/* A driver MUST NOT make the first descriptor in the list
> > +	 * available before all subsequent descriptors comprising
> > +	 * the list are made available. */
> > +	virtio_wmb(vq->weak_barriers);
> > +	vq->vring_packed.desc[head].flags = head_flags;
> > +	vq->num_added += descs_used;
> > +
> > +	pr_debug("Added buffer head %i to %p\n", head, vq);
> > +	END_USE(vq);
> > +
> > +	return 0;
> > +
> > +unmap_release:
> > +	err_idx = i;
> > +	i = head;
> > +
> > +	for (n = 0; n < total_sg; n++) {
> > +		if (i == err_idx)
> > +			break;
> > +		vring_unmap_desc_packed(vq, &desc[i]);
> > +		i++;
> > +		if (!indirect && i >= vq->vring_packed.num)
> > +			i = 0;
> > +	}
> > +
> > +	vq->avail_wrap_counter = avail_wrap_counter;
> > +
> > +	if (indirect)
> > +		kfree(desc);
> > +
> > +	END_USE(vq);
> >  	return -EIO;
> >  }
> >  
> >  static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> >  {
> > -	return false;
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	u16 flags;
> > +	bool needs_kick;
> > +	u32 snapshot;
> > +
> > +	START_USE(vq);
> > +	/* We need to expose the new flags value before checking notification
> > +	 * suppressions. */
> > +	virtio_mb(vq->weak_barriers);
> > +
> > +	snapshot = READ_ONCE(*(u32 *)vq->vring_packed.device);
> > +	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
> 
> What are all these hard-coded things? Also either we do READ_ONCE
> everywhere or nowhere. Why is this place special? Any why read 32 bit
> if you only want the 16?

Yeah, READ_ONCE() and reading 32bits are not really needed in
this patch. But it's needed in the next patch. I thought it's
not wrong to do this, so I introduced them from the first place.

Just to double check: is the below code (apart from the
hard-coded value and virtio16) from the next patch OK?

"""
    snapshot = READ_ONCE(*(u32 *)vq->vring_packed.device);
+   off_wrap = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot & 0xffff));
    flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
"""

> 
> And doesn't sparse complain about cast to __virtio16?

I'll give it a try in the next version.

> 
> > +
> > +#ifdef DEBUG
> > +	if (vq->last_add_time_valid) {
> > +		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
> > +					      vq->last_add_time)) > 100);
> > +	}
> > +	vq->last_add_time_valid = false;
> > +#endif
> > +
> > +	needs_kick = (flags != VRING_EVENT_F_DISABLE);
> > +	END_USE(vq);
> > +	return needs_kick;
> > +}
> > +
> > +static void detach_buf_packed(struct vring_virtqueue *vq,
> > +			      unsigned int id, void **ctx)
> > +{
> > +	struct vring_desc_state_packed *state = NULL;
> > +	struct vring_packed_desc *desc;
> > +	unsigned int curr, i;
> > +
> > +	/* Clear data ptr. */
> > +	vq->desc_state_packed[id].data = NULL;
> > +
> > +	curr = id;
> > +	for (i = 0; i < vq->desc_state_packed[id].num; i++) {
> > +		state = &vq->desc_state_packed[curr];
> > +		vring_unmap_state_packed(vq, state);
> > +		curr = state->next;
> > +	}
> > +
> > +	BUG_ON(state == NULL);
> > +	vq->vq.num_free += vq->desc_state_packed[id].num;
> > +	state->next = vq->free_head;
> > +	vq->free_head = id;
> > +
> > +	if (vq->indirect) {
> > +		u32 len;
> > +
> > +		/* Free the indirect table, if any, now that it's unmapped. */
> > +		desc = vq->desc_state_packed[id].indir_desc;
> > +		if (!desc)
> > +			return;
> > +
> > +		if (vring_use_dma_api(vq->vq.vdev)) {
> > +			len = vq->desc_state_packed[id].len;
> > +			for (i = 0; i < len / sizeof(struct vring_packed_desc);
> > +					i++)
> > +				vring_unmap_desc_packed(vq, &desc[i]);
> > +		}
> > +		kfree(desc);
> > +		vq->desc_state_packed[id].indir_desc = NULL;
> > +	} else if (ctx) {
> > +		*ctx = vq->desc_state_packed[id].indir_desc;
> > +	}
> > +}
> > +
> > +static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
> > +				       u16 idx, bool used_wrap_counter)
> > +{
> > +	u16 flags;
> > +	bool avail, used;
> > +
> > +	flags = virtio16_to_cpu(vq->vq.vdev,
> > +				vq->vring_packed.desc[idx].flags);
> > +	avail = !!(flags & VRING_DESC_F_AVAIL);
> > +	used = !!(flags & VRING_DESC_F_USED);
> > +
> > +	return avail == used && used == used_wrap_counter;
> 
> I think that you don't need to look at avail flag to detect a used
> descriptor. The reason device writes it is to avoid confusing
> *device* next time descriptor wraps.

Okay, I'll just check the used flag.

> 
> >  }
> >  
> >  static inline bool more_used_packed(const struct vring_virtqueue *vq)
> >  {
> > -	return false;
> > +	return is_used_desc_packed(vq, vq->last_used_idx,
> > +			vq->used_wrap_counter);
> >  }
> >  
> >  static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  					  unsigned int *len,
> >  					  void **ctx)
> >  {
> > -	return NULL;
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	u16 last_used, id;
> > +	void *ret;
> > +
> > +	START_USE(vq);
> > +
> > +	if (unlikely(vq->broken)) {
> > +		END_USE(vq);
> > +		return NULL;
> > +	}
> > +
> > +	if (!more_used_packed(vq)) {
> > +		pr_debug("No more buffers in queue\n");
> > +		END_USE(vq);
> > +		return NULL;
> > +	}
> > +
> > +	/* Only get used elements after they have been exposed by host. */
> > +	virtio_rmb(vq->weak_barriers);
> > +
> > +	last_used = vq->last_used_idx;
> > +	id = virtio16_to_cpu(_vq->vdev, vq->vring_packed.desc[last_used].id);
> > +	*len = virtio32_to_cpu(_vq->vdev, vq->vring_packed.desc[last_used].len);
> > +
> > +	if (unlikely(id >= vq->vring_packed.num)) {
> > +		BAD_RING(vq, "id %u out of range\n", id);
> > +		return NULL;
> > +	}
> > +	if (unlikely(!vq->desc_state_packed[id].data)) {
> > +		BAD_RING(vq, "id %u is not a head!\n", id);
> > +		return NULL;
> > +	}
> > +
> > +	vq->last_used_idx += vq->desc_state_packed[id].num;
> > +	if (vq->last_used_idx >= vq->vring_packed.num) {
> > +		vq->last_used_idx -= vq->vring_packed.num;
> > +		vq->used_wrap_counter ^= 1;
> > +	}
> > +
> > +	/* detach_buf_packed clears data, so grab it now. */
> > +	ret = vq->desc_state_packed[id].data;
> > +	detach_buf_packed(vq, id, ctx);
> > +
> > +#ifdef DEBUG
> > +	vq->last_add_time_valid = false;
> > +#endif
> > +
> > +	END_USE(vq);
> > +	return ret;
> >  }
> >  
> >  static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> >  {
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	if (vq->event_flags_shadow != VRING_EVENT_F_DISABLE) {
> > +		vq->event_flags_shadow = VRING_EVENT_F_DISABLE;
> > +		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> > +							vq->event_flags_shadow);
> > +	}
> >  }
> >  
> >  static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> >  {
> > -	return 0;
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	START_USE(vq);
> > +
> > +	/* We optimistically turn back on interrupts, then check if there was
> > +	 * more to do. */
> > +
> > +	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> > +		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > +		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> > +							vq->event_flags_shadow);
> > +	}
> > +
> > +	END_USE(vq);
> > +	return vq->last_used_idx | ((u16)vq->used_wrap_counter << 15);
> >  }
> >  
> > -static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned last_used_idx)
> > +static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned off_wrap)
> >  {
> > -	return false;
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	bool wrap_counter;
> > +	u16 used_idx;
> > +
> > +	wrap_counter = off_wrap >> 15;
> > +	used_idx = off_wrap & ~(1 << 15);
> > +
> > +	return is_used_desc_packed(vq, used_idx, wrap_counter);
> 
> These >> 15 << 15 all over the place duplicate info.
> Pls put 15 in the header.

Sure.

> 
> Also can you maintain the counters properly shifted?
> Then just use them.

Then, we may need to maintain both of the shifted wrapper
counters and un-shifted wrapper counters at the same time.

> 
> 
> >  }
> >  
> >  static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> >  {
> > -	return false;
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	START_USE(vq);
> > +
> > +	/* We optimistically turn back on interrupts, then check if there was
> > +	 * more to do. */
> > +
> > +	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> > +		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > +		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> > +							vq->event_flags_shadow);
> > +		/* We need to enable interrupts first before re-checking
> > +		 * for more used buffers. */
> > +		virtio_mb(vq->weak_barriers);
> > +	}
> > +
> > +	if (more_used_packed(vq)) {
> > +		END_USE(vq);
> > +		return false;
> > +	}
> > +
> > +	END_USE(vq);
> > +	return true;
> >  }
> >  
> >  static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
> >  {
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	unsigned int i;
> > +	void *buf;
> > +
> > +	START_USE(vq);
> > +
> > +	for (i = 0; i < vq->vring_packed.num; i++) {
> > +		if (!vq->desc_state_packed[i].data)
> > +			continue;
> > +		/* detach_buf clears data, so grab it now. */
> > +		buf = vq->desc_state_packed[i].data;
> > +		detach_buf_packed(vq, i, NULL);
> > +		END_USE(vq);
> > +		return buf;
> > +	}
> > +	/* That should have freed everything. */
> > +	BUG_ON(vq->vq.num_free != vq->vring_packed.num);
> > +
> > +	END_USE(vq);
> >  	return NULL;
> >  }
> >  
> > @@ -1083,6 +1559,9 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned last_used_idx)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> > +	/* We need to enable interrupts first before re-checking
> > +	 * for more used buffers. */
> > +	virtio_mb(vq->weak_barriers);
> >  	return vq->packed ? virtqueue_poll_packed(_vq, last_used_idx) :
> >  			    virtqueue_poll_split(_vq, last_used_idx);
> >  }
> 
> Possible optimization for when dma API is in use:

Got it. Will give it a try!

Best regards,
Tiwei Bie

> 
> --->
> 
> dma: detecting nop unmap
> 
> drivers need to maintain the dma address for unmap purposes,
> but these cycles are wasted when unmap callback is not
> defined. Add an API for drivers to check that and avoid
> unmap completely. Debug builds still have unmap.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----
> 
> diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
> index a785f2507159..38b2c27c8449 100644
> --- a/include/linux/dma-debug.h
> +++ b/include/linux/dma-debug.h
> @@ -42,6 +42,11 @@ extern void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
>  extern void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
>  				 size_t size, int direction, bool map_single);
>  
> +static inline bool has_debug_dma_unmap(struct device *dev)
> +{
> +	return true;
> +}
> +
>  extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  			     int nents, int mapped_ents, int direction);
>  
> @@ -121,6 +126,11 @@ static inline void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
>  {
>  }
>  
> +static inline bool has_debug_dma_unmap(struct device *dev)
> +{
> +	return false;
> +}
> +
>  static inline void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
>  				    int nents, int mapped_ents, int direction)
>  {
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 1db6a6b46d0d..656f3e518166 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -241,6 +241,14 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>  	return addr;
>  }
>  
> +static inline bool has_dma_unmap(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	return ops->unmap_page || ops->unmap_sg || ops->unmap_resource ||
> +		has_dma_unmap(dev);
> +}
> +
>  static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
>  					  size_t size,
>  					  enum dma_data_direction dir,
