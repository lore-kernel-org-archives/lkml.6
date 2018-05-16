Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeEPMir (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:38:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:29601 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeEPMio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:38:44 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,390,1520924400";
   d="scan'208";a="224694269"
Date: Wed, 16 May 2018 20:39:09 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [RFC v4 3/5] virtio_ring: add packed ring support
Message-ID: <20180516123909.GB986@debian>
References: <20180516083737.26504-1-tiwei.bie@intel.com>
 <20180516083737.26504-4-tiwei.bie@intel.com>
 <2000f635-bc34-71ff-ff51-a711c2e9726d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2000f635-bc34-71ff-ff51-a711c2e9726d@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 07:50:16PM +0800, Jason Wang wrote:
> On 2018年05月16日 16:37, Tiwei Bie wrote:
[...]
> >   struct vring_virtqueue {
> > @@ -116,6 +117,9 @@ struct vring_virtqueue {
> >   			/* Last written value to driver->flags in
> >   			 * guest byte order. */
> >   			u16 event_flags_shadow;
> > +
> > +			/* ID allocation. */
> > +			struct idr buffer_id;
> 
> I'm not sure idr is fit for the performance critical case here. Need to
> measure its performance impact, especially if we have few unused slots.

I'm also not sure.. But fortunately, it should be quite easy
to replace it with something else without changing other code.
If it will really hurt the performance, I'll change it.

> 
> >   		};
> >   	};
[...]
> > +static void detach_buf_packed(struct vring_virtqueue *vq, unsigned int head,
> > +			      unsigned int id, void **ctx)
> > +{
> > +	struct vring_packed_desc *desc;
> > +	unsigned int i, j;
> > +
> > +	/* Clear data ptr. */
> > +	vq->desc_state[id].data = NULL;
> > +
> > +	i = head;
> > +
> > +	for (j = 0; j < vq->desc_state[id].num; j++) {
> > +		desc = &vq->vring_packed.desc[i];
> > +		vring_unmap_one_packed(vq, desc);
> 
> As mentioned in previous discussion, this probably won't work for the case
> of out of order completion since it depends on the information in the
> descriptor ring. We probably need to extend ctx to record such information.

Above code doesn't depend on the information in the descriptor
ring. The vq->desc_state[] is the extended ctx.

Best regards,
Tiwei Bie
