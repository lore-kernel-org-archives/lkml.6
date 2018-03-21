Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeCUHcQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:32:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:50962 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbeCUHcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:32:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,339,1517904000";
   d="scan'208";a="210044630"
Date: Wed, 21 Mar 2018 15:30:38 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [PATCH RFC 2/2] virtio_ring: support packed ring
Message-ID: <20180321073038.gukl2pxqszuudv4t@debian>
References: <20180223111801.15240-1-tiwei.bie@intel.com>
 <20180223111801.15240-3-tiwei.bie@intel.com>
 <8f73267a-e20e-de64-d8e0-3fd608dbf368@redhat.com>
 <20180316061047.o2xdyuqhak3mzjyw@debian>
 <0a0ecf42-8f7f-9387-8ca4-cb65d0835b56@redhat.com>
 <20180316074028.lun2jy45qqnfeymw@debian>
 <02a3da02-8226-ba4e-1b47-d25755b2c429@redhat.com>
 <20180316100413.vtqwatregzrmhvt3@debian>
 <094ca28b-d8af-bf7a-ea7e-0d0bf7518bda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <094ca28b-d8af-bf7a-ea7e-0d0bf7518bda@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 07:36:47PM +0800, Jason Wang wrote:
> On 2018年03月16日 18:04, Tiwei Bie wrote:
> > On Fri, Mar 16, 2018 at 04:34:28PM +0800, Jason Wang wrote:
> > > On 2018年03月16日 15:40, Tiwei Bie wrote:
> > > > On Fri, Mar 16, 2018 at 02:44:12PM +0800, Jason Wang wrote:
> > > > > On 2018年03月16日 14:10, Tiwei Bie wrote:
> > > > > > On Fri, Mar 16, 2018 at 12:03:25PM +0800, Jason Wang wrote:
> > > > > > > On 2018年02月23日 19:18, Tiwei Bie wrote:
> > > > > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > > > > > ---
> > > > > > > >      drivers/virtio/virtio_ring.c | 699 +++++++++++++++++++++++++++++++++++++------
> > > > > > > >      include/linux/virtio_ring.h  |   8 +-
> > > > > > > >      2 files changed, 618 insertions(+), 89 deletions(-)
[...]
> > > @@ -1096,17 +1599,21 @@ struct virtqueue *vring_create_virtqueue(
> > > > > > > >      	if (!queue) {
> > > > > > > >      		/* Try to get a single page. You are my only hope! */
> > > > > > > > -		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
> > > > > > > > +		queue = vring_alloc_queue(vdev, __vring_size(num, vring_align,
> > > > > > > > +							     packed),
> > > > > > > >      					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
> > > > > > > >      	}
> > > > > > > >      	if (!queue)
> > > > > > > >      		return NULL;
> > > > > > > > -	queue_size_in_bytes = vring_size(num, vring_align);
> > > > > > > > -	vring_init(&vring, num, queue, vring_align);
> > > > > > > > +	queue_size_in_bytes = __vring_size(num, vring_align, packed);
> > > > > > > > +	if (packed)
> > > > > > > > +		vring_packed_init(&vring.vring_packed, num, queue, vring_align);
> > > > > > > > +	else
> > > > > > > > +		vring_init(&vring.vring_split, num, queue, vring_align);
> > > > > > > Let's rename vring_init to vring_init_split() like other helpers?
> > > > > > The vring_init() is a public API in include/uapi/linux/virtio_ring.h.
> > > > > > I don't think we can rename it.
> > > > > I see, then this need more thoughts to unify the API.
> > > > My thought is to keep the old API as is, and introduce
> > > > new types and helpers for packed ring.
> > > I admit it's not a fault of this patch. But we'd better think of this in the
> > > future, consider we may have new kinds of ring.
> > > 
> > > > More details can be found in this patch:
> > > > https://lkml.org/lkml/2018/2/23/243
> > > > (PS. The type which has bit fields is just for reference,
> > > >    and will be changed in next version.)
> > > > 
> > > > Do you have any other suggestions?
> > > No.
> > Hmm.. Sorry, I didn't describe my question well.
> > I mean do you have any suggestions about the API
> > design for packed ring in uapi header? Currently
> > I introduced below two new helpers:
> > 
> > static inline void vring_packed_init(struct vring_packed *vr, unsigned int num,
> > 				     void *p, unsigned long align);
> > static inline unsigned vring_packed_size(unsigned int num, unsigned long align);
> > 
> > When new rings are introduced in the future, above
> > helpers can't be reused. Maybe we should make the
> > helpers be able to determine the ring type?
> 
> Let's wait for Michael's comment here. Generally, I fail to understand why
> vring_init() become a part of uapi. Git grep shows the only use cases are
> virtio_test/vringh_test.

Thank you very much for the review on this patch!
I'll send out a new version ASAP to address these
comments. :)

Best regards,
Tiwei Bie
