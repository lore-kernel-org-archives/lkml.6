Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D2C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC8F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC8F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeILM4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:56:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:5978 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeILM4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:56:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2018 00:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,363,1531810800"; 
   d="scan'208";a="72537400"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.194])
  by orsmga008.jf.intel.com with ESMTP; 12 Sep 2018 00:52:40 -0700
Date:   Wed, 12 Sep 2018 15:51:40 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH net-next v2 2/5] virtio_ring: support creating packed ring
Message-ID: <20180912075140.GA22545@debian>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-3-tiwei.bie@intel.com>
 <20180907095208-mutt-send-email-mst@kernel.org>
 <20180910022837.GA11822@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180910022837.GA11822@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:28:37AM +0800, Tiwei Bie wrote:
> On Fri, Sep 07, 2018 at 10:03:24AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 11, 2018 at 10:27:08AM +0800, Tiwei Bie wrote:
> > > This commit introduces the support for creating packed ring.
> > > All split ring specific functions are added _split suffix.
> > > Some necessary stubs for packed ring are also added.
> > > 
> > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > 
[...]
> > > +
> > > +/*
> > > + * The layout for the packed ring is a continuous chunk of memory
> > > + * which looks like this.
> > > + *
> > > + * struct vring_packed {
> > > + *	// The actual descriptors (16 bytes each)
> > > + *	struct vring_packed_desc desc[num];
> > > + *
> > > + *	// Padding to the next align boundary.
> > > + *	char pad[];
> > > + *
> > > + *	// Driver Event Suppression
> > > + *	struct vring_packed_desc_event driver;
> > > + *
> > > + *	// Device Event Suppression
> > > + *	struct vring_packed_desc_event device;
> > > + * };
> > > + */
> > 
> > Why not just allocate event structures separately?
> > Is it a win to have them share a cache line for some reason?

Users may call vring_new_virtqueue() with preallocated
memory to setup the ring, e.g.:

https://github.com/torvalds/linux/blob/11da3a7f84f1/drivers/s390/virtio/virtio_ccw.c#L513-L522
https://github.com/torvalds/linux/blob/11da3a7f84f1/drivers/misc/mic/vop/vop_main.c#L306-L307

Below is the corresponding definition in split ring:

https://github.com/oasis-tcs/virtio-spec/blob/89dd55f5e606/split-ring.tex#L64-L78

If my understanding is correct, this is just for legacy
interfaces, and we won't define layout in packed ring
and don't need to support vring_new_virtqueue() in packed
ring. Is it correct? Thanks!



> 
> Will do that.
> 
> > 
> > > +static inline void vring_init_packed(struct vring_packed *vr, unsigned int num,
> > > +				     void *p, unsigned long align)
> > > +{
> > > +	vr->num = num;
> > > +	vr->desc = p;
> > > +	vr->driver = (void *)ALIGN(((uintptr_t)p +
> > > +		sizeof(struct vring_packed_desc) * num), align);
> > > +	vr->device = vr->driver + 1;
> > > +}
> > 
> > What's all this about alignment? Where does it come from?
> 
> It comes from the `vring_align` parameter of vring_create_virtqueue()
> and vring_new_virtqueue():
> 
> https://github.com/torvalds/linux/blob/a49a9dcce802/drivers/virtio/virtio_ring.c#L1061
> https://github.com/torvalds/linux/blob/a49a9dcce802/drivers/virtio/virtio_ring.c#L1123
> 
> Should I just ignore it in packed ring?
> 
> CCW defined this:
> 
> #define KVM_VIRTIO_CCW_RING_ALIGN 4096
> 
> I'm not familiar with CCW. Currently, in this patch set, packed ring
> isn't enabled on CCW dues to some legacy accessors are not implemented
> in packed ring yet.
> 
> > 
> > > +
> > > +static inline unsigned vring_size_packed(unsigned int num, unsigned long align)
> > > +{
> > > +	return ((sizeof(struct vring_packed_desc) * num + align - 1)
> > > +		& ~(align - 1)) + sizeof(struct vring_packed_desc_event) * 2;
> > > +}
> [...]
> > > @@ -1129,10 +1388,17 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
> > >  				      void (*callback)(struct virtqueue *vq),
> > >  				      const char *name)
> > >  {
> > > -	struct vring vring;
> > > -	vring_init(&vring, num, pages, vring_align);
> > > -	return __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
> > > -				     notify, callback, name);
> > > +	union vring_union vring;
> > > +	bool packed;
> > > +
> > > +	packed = virtio_has_feature(vdev, VIRTIO_F_RING_PACKED);
> > > +	if (packed)
> > > +		vring_init_packed(&vring.vring_packed, num, pages, vring_align);
> > > +	else
> > > +		vring_init(&vring.vring_split, num, pages, vring_align);
> > 
> > 
> > vring_init in the UAPI header is more or less a bug.
> > I'd just stop using it, keep it around for legacy userspace.
> 
> Got it. I'd like to do that. Thanks.
> 
> > 
> > > +
> > > +	return __vring_new_virtqueue(index, vring, packed, vdev, weak_barriers,
> > > +				     context, notify, callback, name);
> > >  }
> > >  EXPORT_SYMBOL_GPL(vring_new_virtqueue);
> > >  
> > > @@ -1142,7 +1408,9 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> > >  
> > >  	if (vq->we_own_ring) {
> > >  		vring_free_queue(vq->vq.vdev, vq->queue_size_in_bytes,
> > > -				 vq->vring.desc, vq->queue_dma_addr);
> > > +				 vq->packed ? (void *)vq->vring_packed.desc :
> > > +					      (void *)vq->vring.desc,
> > > +				 vq->queue_dma_addr);
> > >  	}
> > >  	list_del(&_vq->list);
> > >  	kfree(vq);
> > > @@ -1184,7 +1452,7 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *_vq)
> > >  
> > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > >  
> > > -	return vq->vring.num;
> > > +	return vq->packed ? vq->vring_packed.num : vq->vring.num;
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
> > >  
> > > @@ -1227,6 +1495,10 @@ dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
> > >  
> > >  	BUG_ON(!vq->we_own_ring);
> > >  
> > > +	if (vq->packed)
> > > +		return vq->queue_dma_addr + ((char *)vq->vring_packed.driver -
> > > +				(char *)vq->vring_packed.desc);
> > > +
> > >  	return vq->queue_dma_addr +
> > >  		((char *)vq->vring.avail - (char *)vq->vring.desc);
> > >  }
> > > @@ -1238,11 +1510,16 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
> > >  
> > >  	BUG_ON(!vq->we_own_ring);
> > >  
> > > +	if (vq->packed)
> > > +		return vq->queue_dma_addr + ((char *)vq->vring_packed.device -
> > > +				(char *)vq->vring_packed.desc);
> > > +
> > >  	return vq->queue_dma_addr +
> > >  		((char *)vq->vring.used - (char *)vq->vring.desc);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
> > >  
> > > +/* Only available for split ring */
> > >  const struct vring *virtqueue_get_vring(struct virtqueue *vq)
> > >  {
> > >  	return &to_vvq(vq)->vring;
> > > diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> > > index fab02133a919..992142b35f55 100644
> > > --- a/include/linux/virtio_ring.h
> > > +++ b/include/linux/virtio_ring.h
> > > @@ -60,6 +60,11 @@ static inline void virtio_store_mb(bool weak_barriers,
> > >  struct virtio_device;
> > >  struct virtqueue;
> > >  
> > > +union vring_union {
> > > +	struct vring vring_split;
> > > +	struct vring_packed vring_packed;
> > > +};
> > > +
> > >  /*
> > >   * Creates a virtqueue and allocates the descriptor ring.  If
> > >   * may_reduce_num is set, then this may allocate a smaller ring than
> > > @@ -79,7 +84,8 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
> > >  
> > >  /* Creates a virtqueue with a custom layout. */
> > >  struct virtqueue *__vring_new_virtqueue(unsigned int index,
> > > -					struct vring vring,
> > > +					union vring_union vring,
> > > +					bool packed,
> > >  					struct virtio_device *vdev,
> > >  					bool weak_barriers,
> > >  					bool ctx,
> > > -- 
> > > 2.18.0
