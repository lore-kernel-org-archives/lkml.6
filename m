Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeCPKFv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:05:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:58885 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752362AbeCPKFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:05:49 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="25024766"
Date: Fri, 16 Mar 2018 18:04:13 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH RFC 2/2] virtio_ring: support packed ring
Message-ID: <20180316100413.vtqwatregzrmhvt3@debian>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
 <20180223111801.15240-3-tiwei.bie@intel.com>
 <8f73267a-e20e-de64-d8e0-3fd608dbf368@redhat.com>
 <20180316061047.o2xdyuqhak3mzjyw@debian>
 <0a0ecf42-8f7f-9387-8ca4-cb65d0835b56@redhat.com>
 <20180316074028.lun2jy45qqnfeymw@debian>
 <02a3da02-8226-ba4e-1b47-d25755b2c429@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02a3da02-8226-ba4e-1b47-d25755b2c429@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 04:34:28PM +0800, Jason Wang wrote:
> On 2018年03月16日 15:40, Tiwei Bie wrote:
> > On Fri, Mar 16, 2018 at 02:44:12PM +0800, Jason Wang wrote:
> > > On 2018年03月16日 14:10, Tiwei Bie wrote:
> > > > On Fri, Mar 16, 2018 at 12:03:25PM +0800, Jason Wang wrote:
> > > > > On 2018年02月23日 19:18, Tiwei Bie wrote:
> > > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > > > ---
> > > > > >     drivers/virtio/virtio_ring.c | 699 +++++++++++++++++++++++++++++++++++++------
> > > > > >     include/linux/virtio_ring.h  |   8 +-
> > > > > >     2 files changed, 618 insertions(+), 89 deletions(-)
> > [...]
> > > > > >     			      cpu_addr, size, direction);
> > > > > >     }
> > > > > > -static void vring_unmap_one(const struct vring_virtqueue *vq,
> > > > > > -			    struct vring_desc *desc)
> > > > > > +static void vring_unmap_one(const struct vring_virtqueue *vq, void *_desc)
> > > > > >     {
> > > > > Let's split the helpers to packed/split version like other helpers?
> > > > > (Consider the caller has already known the type of vq).
> > > > Okay.
> > > > 
> > > [...]
> > > 
> > > > > > +				desc[i].flags = flags;
> > > > > > +
> > > > > > +			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
> > > > > > +			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
> > > > > > +			desc[i].id = cpu_to_virtio32(_vq->vdev, head);
> > > > > If it's a part of chain, we only need to do this for last buffer I think.
> > > > I'm not sure I've got your point about the "last buffer".
> > > > But, yes, id just needs to be set for the last desc.
> > > Right, I think I meant "last descriptor" :)
> > > 
> > > > > > +			prev = i;
> > > > > > +			i++;
> > > > > It looks to me prev is always i - 1?
> > > > No. prev will be (vq->vring_packed.num - 1) when i becomes 0.
> > > Right, so prev = i ? i - 1 : vq->vring_packed.num - 1.
> > Yes, i wraps together with vq->wrap_counter in following code:
> > 
> > > > > > +			if (!indirect && i >= vq->vring_packed.num) {
> > > > > > +				i = 0;
> > > > > > +				vq->wrap_counter ^= 1;
> > > > > > +			}
> > 
> > > > > > +		}
> > > > > > +	}
> > > > > > +	for (; n < (out_sgs + in_sgs); n++) {
> > > > > > +		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
> > > > > > +			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
> > > > > > +			if (vring_mapping_error(vq, addr))
> > > > > > +				goto unmap_release;
> > > > > > +
> > > > > > +			flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT |
> > > > > > +					VRING_DESC_F_WRITE |
> > > > > > +					VRING_DESC_F_AVAIL(vq->wrap_counter) |
> > > > > > +					VRING_DESC_F_USED(!vq->wrap_counter));
> > > > > > +			if (!indirect && i == head)
> > > > > > +				head_flags = flags;
> > > > > > +			else
> > > > > > +				desc[i].flags = flags;
> > > > > > +
> > > > > > +			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
> > > > > > +			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
> > > > > > +			desc[i].id = cpu_to_virtio32(_vq->vdev, head);
> > > > > > +			prev = i;
> > > > > > +			i++;
> > > > > > +			if (!indirect && i >= vq->vring_packed.num) {
> > > > > > +				i = 0;
> > > > > > +				vq->wrap_counter ^= 1;
> > > > > > +			}
> > > > > > +		}
> > > > > > +	}
> > > > > > +	/* Last one doesn't continue. */
> > > > > > +	if (!indirect && (head + 1) % vq->vring_packed.num == i)
> > > > > > +		head_flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > > > I can't get the why we need this here.
> > > > If only one desc is used, we will need to clear the
> > > > VRING_DESC_F_NEXT flag from the head_flags.
> > > Yes, I meant why following desc[prev].flags won't work for this?
> > Because the update of desc[head].flags (in above case,
> > prev == head) has been delayed. The flags is saved in
> > head_flags.
> 
> Ok, but let's try to avoid modular here e.g tracking the number of sgs in a
> counter.
> 
> And I see lots of duplication in the above two loops, I believe we can unify
> them with a a single loop. the only difference is dma direction and write
> flag.

The above implementation for packed ring is basically
an mirror of the existing implementation in split ring
as I want to keep the coding style consistent. Below
is the corresponding code in split ring:

static inline int virtqueue_add(struct virtqueue *_vq,
				struct scatterlist *sgs[],
				unsigned int total_sg,
				unsigned int out_sgs,
				unsigned int in_sgs,
				void *data,
				void *ctx,
				gfp_t gfp)
{
	......

	for (n = 0; n < out_sgs; n++) {
		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
			if (vring_mapping_error(vq, addr))
				goto unmap_release;

			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT);
			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
			prev = i;
			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
		}
	}
	for (; n < (out_sgs + in_sgs); n++) {
		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
			if (vring_mapping_error(vq, addr))
				goto unmap_release;

			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT | VRING_DESC_F_WRITE);
			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
			prev = i;
			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
		}
	}

	......
}

> 
> > 
> > > > > > +	else
> > > > > > +		desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
> > > > > > +
> > > > > > +	if (indirect) {
> > > > > > +		/* FIXME: to be implemented */
> > > > > > +
> > > > > > +		/* Now that the indirect table is filled in, map it. */
> > > > > > +		dma_addr_t addr = vring_map_single(
> > > > > > +			vq, desc, total_sg * sizeof(struct vring_packed_desc),
> > > > > > +			DMA_TO_DEVICE);
> > > > > > +		if (vring_mapping_error(vq, addr))
> > > > > > +			goto unmap_release;
> > > > > > +
> > > > > > +		head_flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT |
> > > > > > +					     VRING_DESC_F_AVAIL(wrap_counter) |
> > > > > > +					     VRING_DESC_F_USED(!wrap_counter));
> > > > > > +		vq->vring_packed.desc[head].addr = cpu_to_virtio64(_vq->vdev, addr);
> > > > > > +		vq->vring_packed.desc[head].len = cpu_to_virtio32(_vq->vdev,
> > > > > > +				total_sg * sizeof(struct vring_packed_desc));
> > > > > > +		vq->vring_packed.desc[head].id = cpu_to_virtio32(_vq->vdev, head);
> > > > > > +	}
> > > > > > +
> > > > > > +	/* We're using some buffers from the free list. */
> > > > > > +	vq->vq.num_free -= descs_used;
> > > > > > +
> > > > > > +	/* Update free pointer */
> > > > > > +	if (indirect) {
> > > > > > +		n = head + 1;
> > > > > > +		if (n >= vq->vring_packed.num) {
> > > > > > +			n = 0;
> > > > > > +			vq->wrap_counter ^= 1;
> > > > > > +		}
> > > > > > +		vq->free_head = n;
> > > > > detach_buf_packed() does not even touch free_head here, so need to explain
> > > > > its meaning for packed ring.
> > > > Above code is for indirect support which isn't really
> > > > implemented in this patch yet.
> > > > 
> > > > For your question, free_head stores the index of the
> > > > next avail desc. I'll add a comment for it or move it
> > > > to union and give it a better name in next version.
> > > Yes, something like avail_idx might be better.
> > > 
> > > > > > +	} else
> > > > > > +		vq->free_head = i;
> > > > > ID is only valid in the last descriptor in the list, so head + 1 should be
> > > > > ok too?
> > > > I don't really get your point. The vq->free_head stores
> > > > the index of the next avail desc.
> > > I think I get your idea now, free_head has two meanings:
> > > 
> > > - next avail index
> > > - buffer id
> > In my design, free_head is just the index of the next
> > avail desc.
> > 
> > Driver can set anything to buffer ID.
> 
> Then you need another method to track id to context e.g hashing.

I keep the context in desc_state[desc_idx]. So there is
no extra method needed to track the context.

> 
> >   And in my design,
> > I save desc index in buffer ID.
> > 
> > I'll add comments for them.
> > 
> > > If I'm correct, let's better add a comment for this.
> > > 
> > > > > > +
> > > > > > +	/* Store token and indirect buffer state. */
> > > > > > +	vq->desc_state[head].num = descs_used;
> > > > > > +	vq->desc_state[head].data = data;
> > > > > > +	if (indirect)
> > > > > > +		vq->desc_state[head].indir_desc = desc;
> > > > > > +	else
> > > > > > +		vq->desc_state[head].indir_desc = ctx;
> > > > > > +
> > > > > > +	virtio_wmb(vq->weak_barriers);
> > > > > Let's add a comment to explain the barrier here.
> > > > Okay.
> > > > 
> > > > > > +	vq->vring_packed.desc[head].flags = head_flags;
> > > > > > +	vq->num_added++;
> > > > > > +
> > > > > > +	pr_debug("Added buffer head %i to %p\n", head, vq);
> > > > > > +	END_USE(vq);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +
> > > > > > +unmap_release:
> > > > > > +	err_idx = i;
> > > > > > +	i = head;
> > > > > > +
> > > > > > +	for (n = 0; n < total_sg; n++) {
> > > > > > +		if (i == err_idx)
> > > > > > +			break;
> > > > > > +		vring_unmap_one(vq, &desc[i]);
> > > > > > +		i++;
> > > > > > +		if (!indirect && i >= vq->vring_packed.num)
> > > > > > +			i = 0;
> > > > > > +	}
> > > > > > +
> > > > > > +	vq->wrap_counter = wrap_counter;
> > > > > > +
> > > > > > +	if (indirect)
> > > > > > +		kfree(desc);
> > > > > > +
> > > > > > +	END_USE(vq);
> > > > > > +	return -EIO;
> > > > > > +}
> > [...]
> > > > > > @@ -1096,17 +1599,21 @@ struct virtqueue *vring_create_virtqueue(
> > > > > >     	if (!queue) {
> > > > > >     		/* Try to get a single page. You are my only hope! */
> > > > > > -		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
> > > > > > +		queue = vring_alloc_queue(vdev, __vring_size(num, vring_align,
> > > > > > +							     packed),
> > > > > >     					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
> > > > > >     	}
> > > > > >     	if (!queue)
> > > > > >     		return NULL;
> > > > > > -	queue_size_in_bytes = vring_size(num, vring_align);
> > > > > > -	vring_init(&vring, num, queue, vring_align);
> > > > > > +	queue_size_in_bytes = __vring_size(num, vring_align, packed);
> > > > > > +	if (packed)
> > > > > > +		vring_packed_init(&vring.vring_packed, num, queue, vring_align);
> > > > > > +	else
> > > > > > +		vring_init(&vring.vring_split, num, queue, vring_align);
> > > > > Let's rename vring_init to vring_init_split() like other helpers?
> > > > The vring_init() is a public API in include/uapi/linux/virtio_ring.h.
> > > > I don't think we can rename it.
> > > I see, then this need more thoughts to unify the API.
> > My thought is to keep the old API as is, and introduce
> > new types and helpers for packed ring.
> 
> I admit it's not a fault of this patch. But we'd better think of this in the
> future, consider we may have new kinds of ring.
> 
> > 
> > More details can be found in this patch:
> > https://lkml.org/lkml/2018/2/23/243
> > (PS. The type which has bit fields is just for reference,
> >   and will be changed in next version.)
> > 
> > Do you have any other suggestions?
> 
> No.

Hmm.. Sorry, I didn't describe my question well.
I mean do you have any suggestions about the API
design for packed ring in uapi header? Currently
I introduced below two new helpers:

static inline void vring_packed_init(struct vring_packed *vr, unsigned int num,
				     void *p, unsigned long align);
static inline unsigned vring_packed_size(unsigned int num, unsigned long align);

When new rings are introduced in the future, above
helpers can't be reused. Maybe we should make the
helpers be able to determine the ring type?

Best regards,
Tiwei Bie

> 
> Thanks
> 
> > 
> > Best regards,
> > Tiwei Bie
> > 
> > > > > > -	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
> > > > > > -				   notify, callback, name);
> > > > > > +	vq = __vring_new_virtqueue(index, vring, packed, vdev, weak_barriers,
> > > > > > +				   context, notify, callback, name);
> > > > > >     	if (!vq) {
> > > > > >     		vring_free_queue(vdev, queue_size_in_bytes, queue,
> > > > > >     				 dma_addr);
> > [...]
> 
