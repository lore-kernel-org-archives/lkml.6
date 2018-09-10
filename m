Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55892064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55892064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeIJHV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:21:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:29287 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeIJHV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:21:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2018 19:29:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,354,1531810800"; 
   d="scan'208";a="262091556"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.194])
  by fmsmga006.fm.intel.com with ESMTP; 09 Sep 2018 19:29:35 -0700
Date:   Mon, 10 Sep 2018 10:28:37 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 2/5] virtio_ring: support creating packed ring
Message-ID: <20180910022837.GA11822@debian>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-3-tiwei.bie@intel.com>
 <20180907095208-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907095208-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:03:24AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 11, 2018 at 10:27:08AM +0800, Tiwei Bie wrote:
> > This commit introduces the support for creating packed ring.
> > All split ring specific functions are added _split suffix.
> > Some necessary stubs for packed ring are also added.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> I'd rather have a patch just renaming split functions, then
> add all packed stuff in as a separate patch on top.

Sure, I will do that.

> 
> 
> > ---
> >  drivers/virtio/virtio_ring.c | 801 +++++++++++++++++++++++------------
> >  include/linux/virtio_ring.h  |   8 +-
> >  2 files changed, 546 insertions(+), 263 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 814b395007b2..c4f8abc7445a 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -60,11 +60,15 @@ struct vring_desc_state {
> >  	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
> >  };
> >  
> > +struct vring_desc_state_packed {
> > +	int next;			/* The next desc state. */
> 
> So this can go away with IN_ORDER?

Yes. If IN_ORDER is negotiated, next won't be needed anymore.
Currently, IN_ORDER isn't included in this patch set, because
some changes for split ring are needed to make sure that it
will use the descs in the expected order. After that,
optimizations can be done for both of split ring and packed
ring respectively.

> 
> > +};
> > +
> >  struct vring_virtqueue {
> >  	struct virtqueue vq;
> >  
> > -	/* Actual memory layout for this queue */
> > -	struct vring vring;
> > +	/* Is this a packed ring? */
> > +	bool packed;
> >  
> >  	/* Can we use weak barriers? */
> >  	bool weak_barriers;
> > @@ -86,11 +90,39 @@ struct vring_virtqueue {
> >  	/* Last used index we've seen. */
> >  	u16 last_used_idx;
> >  
> > -	/* Last written value to avail->flags */
> > -	u16 avail_flags_shadow;
> > +	union {
> > +		/* Available for split ring */
> > +		struct {
> > +			/* Actual memory layout for this queue. */
> > +			struct vring vring;
> >  
> > -	/* Last written value to avail->idx in guest byte order */
> > -	u16 avail_idx_shadow;
> > +			/* Last written value to avail->flags */
> > +			u16 avail_flags_shadow;
> > +
> > +			/* Last written value to avail->idx in
> > +			 * guest byte order. */
> > +			u16 avail_idx_shadow;
> > +		};
> 
> Name this field split so it's easier to detect misuse of e.g.
> packed fields in split code?

Good point, I'll do that.

> 
> > +
> > +		/* Available for packed ring */
> > +		struct {
> > +			/* Actual memory layout for this queue. */
> > +			struct vring_packed vring_packed;
> > +
> > +			/* Driver ring wrap counter. */
> > +			bool avail_wrap_counter;
> > +
> > +			/* Device ring wrap counter. */
> > +			bool used_wrap_counter;
> > +
> > +			/* Index of the next avail descriptor. */
> > +			u16 next_avail_idx;
> > +
> > +			/* Last written value to driver->flags in
> > +			 * guest byte order. */
> > +			u16 event_flags_shadow;
> > +		};
> > +	};
[...]
> > +
> > +/*
> > + * The layout for the packed ring is a continuous chunk of memory
> > + * which looks like this.
> > + *
> > + * struct vring_packed {
> > + *	// The actual descriptors (16 bytes each)
> > + *	struct vring_packed_desc desc[num];
> > + *
> > + *	// Padding to the next align boundary.
> > + *	char pad[];
> > + *
> > + *	// Driver Event Suppression
> > + *	struct vring_packed_desc_event driver;
> > + *
> > + *	// Device Event Suppression
> > + *	struct vring_packed_desc_event device;
> > + * };
> > + */
> 
> Why not just allocate event structures separately?
> Is it a win to have them share a cache line for some reason?

Will do that.

> 
> > +static inline void vring_init_packed(struct vring_packed *vr, unsigned int num,
> > +				     void *p, unsigned long align)
> > +{
> > +	vr->num = num;
> > +	vr->desc = p;
> > +	vr->driver = (void *)ALIGN(((uintptr_t)p +
> > +		sizeof(struct vring_packed_desc) * num), align);
> > +	vr->device = vr->driver + 1;
> > +}
> 
> What's all this about alignment? Where does it come from?

It comes from the `vring_align` parameter of vring_create_virtqueue()
and vring_new_virtqueue():

https://github.com/torvalds/linux/blob/a49a9dcce802/drivers/virtio/virtio_ring.c#L1061
https://github.com/torvalds/linux/blob/a49a9dcce802/drivers/virtio/virtio_ring.c#L1123

Should I just ignore it in packed ring?

CCW defined this:

#define KVM_VIRTIO_CCW_RING_ALIGN 4096

I'm not familiar with CCW. Currently, in this patch set, packed ring
isn't enabled on CCW dues to some legacy accessors are not implemented
in packed ring yet.

> 
> > +
> > +static inline unsigned vring_size_packed(unsigned int num, unsigned long align)
> > +{
> > +	return ((sizeof(struct vring_packed_desc) * num + align - 1)
> > +		& ~(align - 1)) + sizeof(struct vring_packed_desc_event) * 2;
> > +}
[...]
> > @@ -1129,10 +1388,17 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
> >  				      void (*callback)(struct virtqueue *vq),
> >  				      const char *name)
> >  {
> > -	struct vring vring;
> > -	vring_init(&vring, num, pages, vring_align);
> > -	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
> > -				     notify, callback, name);
> > +	union vring_union vring;
> > +	bool packed;
> > +
> > +	packed = virtio_has_feature(vdev, VIRTIO_F_RING_PACKED);
> > +	if (packed)
> > +		vring_init_packed(&vring.vring_packed, num, pages, vring_align);
> > +	else
> > +		vring_init(&vring.vring_split, num, pages, vring_align);
> 
> 
> vring_init in the UAPI header is more or less a bug.
> I'd just stop using it, keep it around for legacy userspace.

Got it. I'd like to do that. Thanks.

> 
> > +
> > +	return __vring_new_virtqueue(index, vring, packed, vdev, weak_barriers,
> > +				     context, notify, callback, name);
> >  }
> >  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
> >  
> > @@ -1142,7 +1408,9 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >  
> >  	if (vq->we_own_ring) {
> >  		vring_free_queue(vq->vq.vdev, vq->queue_size_in_bytes,
> > -				 vq->vring.desc, vq->queue_dma_addr);
> > +				 vq->packed ? (void *)vq->vring_packed.desc :
> > +					      (void *)vq->vring.desc,
> > +				 vq->queue_dma_addr);
> >  	}
> >  	list_del(&_vq->list);
> >  	kfree(vq);
> > @@ -1184,7 +1452,7 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
> >  
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> >  
> > -	return vq->vring.num;
> > +	return vq->packed ? vq->vring_packed.num : vq->vring.num;
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
> >  
> > @@ -1227,6 +1495,10 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
> >  
> >  	BUG_ON(!vq->we_own_ring);
> >  
> > +	if (vq->packed)
> > +		return vq->queue_dma_addr + ((char *)vq->vring_packed.driver -
> > +				(char *)vq->vring_packed.desc);
> > +
> >  	return vq->queue_dma_addr +
> >  		((char *)vq->vring.avail - (char *)vq->vring.desc);
> >  }
> > @@ -1238,11 +1510,16 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
> >  
> >  	BUG_ON(!vq->we_own_ring);
> >  
> > +	if (vq->packed)
> > +		return vq->queue_dma_addr + ((char *)vq->vring_packed.device -
> > +				(char *)vq->vring_packed.desc);
> > +
> >  	return vq->queue_dma_addr +
> >  		((char *)vq->vring.used - (char *)vq->vring.desc);
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
> >  
> > +/* Only available for split ring */
> >  const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> >  {
> >  	return &to_vvq(vq)->vring;
> > diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> > index fab02133a919..992142b35f55 100644
> > --- a/include/linux/virtio_ring.h
> > +++ b/include/linux/virtio_ring.h
> > @@ -60,6 +60,11 @@ static inline void virtio_store_mb(bool weak_barriers,
> >  struct virtio_device;
> >  struct virtqueue;
> >  
> > +union vring_union {
> > +	struct vring vring_split;
> > +	struct vring_packed vring_packed;
> > +};
> > +
> >  /*
> >   * Creates a virtqueue and allocates the descriptor ring.  If
> >   * may_reduce_num is set, then this may allocate a smaller ring than
> > @@ -79,7 +84,8 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
> >  
> >  /* Creates a virtqueue with a custom layout. */
> >  struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > -					struct vring vring,
> > +					union vring_union vring,
> > +					bool packed,
> >  					struct virtio_device *vdev,
> >  					bool weak_barriers,
> >  					bool ctx,
> > -- 
> > 2.18.0
