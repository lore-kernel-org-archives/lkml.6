Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id rra3AQ0/Glv9SgAAmS7hNA
	; Fri, 08 Jun 2018 08:32:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E8AA8607E4; Fri,  8 Jun 2018 08:32:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6A36F601C3;
	Fri,  8 Jun 2018 08:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A36F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeFHIcJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:32:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:57721 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752886AbeFHIcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:32:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 01:32:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="47753071"
Received: from debian.sh.intel.com (HELO debian) ([10.67.104.203])
  by orsmga008.jf.intel.com with ESMTP; 08 Jun 2018 01:32:00 -0700
Date: Fri, 8 Jun 2018 16:32:13 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        wexu@redhat.com, jfreimann@redhat.com
Subject: Re: [RFC v6 4/5] virtio_ring: add event idx support in packed ring
Message-ID: <20180608083213.GA8512@debian>
References: <20180605074046.20709-1-tiwei.bie@intel.com>
 <20180605074046.20709-5-tiwei.bie@intel.com>
 <c0621b16-3143-0bf7-f44f-3d1173577734@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0621b16-3143-0bf7-f44f-3d1173577734@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 05:50:32PM +0800, Jason Wang wrote:
> On 2018年06月05日 15:40, Tiwei Bie wrote:
> >   static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> >   {
> >   	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	u16 bufs, used_idx, wrap_counter;
> >   	START_USE(vq);
> >   	/* We optimistically turn back on interrupts, then check if there was
> >   	 * more to do. */
> > +	/* Depending on the VIRTIO_RING_F_EVENT_IDX feature, we need to
> > +	 * either clear the flags bit or point the event index at the next
> > +	 * entry. Always update the event index to keep code simple. */
> > +
> 
> Maybe for packed ring, it's time to treat event index separately to avoid a
> virtio_wmb() for event idx is off.

Okay. I'll do it.

> 
> > +	/* TODO: tune this threshold */
> > +	if (vq->next_avail_idx < vq->last_used_idx)
> > +		bufs = (vq->vring_packed.num + vq->next_avail_idx -
> > +				vq->last_used_idx) * 3 / 4;
> > +	else
> > +		bufs = (vq->next_avail_idx - vq->last_used_idx) * 3 / 4;
> 
> vq->next_avail-idx could be equal to vq->last_usd_idx when the ring is full.
> Though virito-net is the only user now and it can guarantee this won't
> happen. But consider this is a core API, we should make sure it can work for
> any cases.
> 
> It looks to me that bufs is just vq->vring_packed.num - vq->num_free?

I'll try it! Thanks for the suggestion! :)

> 
> > +
> > +	wrap_counter = vq->used_wrap_counter;
> > +
> > +	used_idx = vq->last_used_idx + bufs;
> > +	if (used_idx >= vq->vring_packed.num) {
> > +		used_idx -= vq->vring_packed.num;
> > +		wrap_counter ^= 1;
> > +	}
> > +
> > +	vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> > +			used_idx | (wrap_counter << 15));
> >   	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> > -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > +		/* We need to update event offset and event wrap
> > +		 * counter first before updating event flags. */
> > +		virtio_wmb(vq->weak_barriers);
> > +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> > +						     VRING_EVENT_F_ENABLE;
> >   		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> >   							vq->event_flags_shadow);
> > -		/* We need to enable interrupts first before re-checking
> > -		 * for more used buffers. */
> > -		virtio_mb(vq->weak_barriers);
> >   	}
> > +	/* We need to update event suppression structure first
> > +	 * before re-checking for more used buffers. */
> > +	virtio_mb(vq->weak_barriers);
> > +
> >   	if (more_used_packed(vq)) {
> >   		END_USE(vq);
> >   		return false;
> 
> I think what we need to to make sure the descriptor used_idx is used?
> Otherwise we may stop and restart qdisc too frequently?

Good catch! Yeah. It's not the best choice to check the
descriptor at last_used_idx. I'll try to fix this!

Best regards,
Tiwei Bie

> 
> Thanks
> 
> > -- 
> 
