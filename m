Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6044BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953DF2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953DF2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeIJH2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:28:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:11351 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbeIJH2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:28:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2018 19:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,354,1531810800"; 
   d="scan'208";a="262092421"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.194])
  by fmsmga006.fm.intel.com with ESMTP; 09 Sep 2018 19:36:57 -0700
Date:   Mon, 10 Sep 2018 10:35:59 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 4/5] virtio_ring: add event
 idx support in packed ring
Message-ID: <20180910023559.GB11822@debian>
References: <20180711022711.7090-1-tiwei.bie@intel.com>
 <20180711022711.7090-5-tiwei.bie@intel.com>
 <20180907100341-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907100341-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:10:14AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 11, 2018 at 10:27:10AM +0800, Tiwei Bie wrote:
> > This commit introduces the EVENT_IDX support in packed ring.
> > 
> > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> 
> Besides the usual comment about hard-coded constants like <<15:
> does this actually do any good for performance? We don't
> have to if we do not want to.

Got it. Thanks.

> 
> > ---
> >  drivers/virtio/virtio_ring.c | 73 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 65 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index f317b485ba54..f79a1e17f7d1 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1050,7 +1050,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
> >  static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > -	u16 flags;
> > +	u16 new, old, off_wrap, flags, wrap_counter, event_idx;
> >  	bool needs_kick;
> >  	u32 snapshot;
> >  
> > @@ -1059,9 +1059,19 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> >  	 * suppressions. */
> >  	virtio_mb(vq->weak_barriers);
> >  
> > +	old = vq->next_avail_idx - vq->num_added;
> > +	new = vq->next_avail_idx;
> > +	vq->num_added = 0;
> > +
> >  	snapshot = READ_ONCE(*(u32 *)vq->vring_packed.device);
> > +	off_wrap = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot & 0xffff));
> >  	flags = virtio16_to_cpu(_vq->vdev, (__virtio16)(snapshot >> 16)) & 0x3;
> 
> 
> some kind of struct union would be helpful to make this readable.

I will define a struct/union for this.

> 
> >  
> > +	wrap_counter = off_wrap >> 15;
> > +	event_idx = off_wrap & ~(1 << 15);
> > +	if (wrap_counter != vq->avail_wrap_counter)
> > +		event_idx -= vq->vring_packed.num;
> > +
> >  #ifdef DEBUG
> >  	if (vq->last_add_time_valid) {
> >  		WARN_ON(ktime_to_ms(ktime_sub(ktime_get(),
> > @@ -1070,7 +1080,10 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> >  	vq->last_add_time_valid = false;
> >  #endif
> >  
> > -	needs_kick = (flags != VRING_EVENT_F_DISABLE);
> > +	if (flags == VRING_EVENT_F_DESC)
> > +		needs_kick = vring_need_event(event_idx, new, old);
> > +	else
> > +		needs_kick = (flags != VRING_EVENT_F_DISABLE);
> >  	END_USE(vq);
> >  	return needs_kick;
> >  }
> > @@ -1185,6 +1198,15 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> >  	ret = vq->desc_state_packed[id].data;
> >  	detach_buf_packed(vq, id, ctx);
> >  
> > +	/* If we expect an interrupt for the next entry, tell host
> > +	 * by writing event index and flush out the write before
> > +	 * the read in the next get_buf call. */
> > +	if (vq->event_flags_shadow == VRING_EVENT_F_DESC)
> > +		virtio_store_mb(vq->weak_barriers,
> > +				&vq->vring_packed.driver->off_wrap,
> > +				cpu_to_virtio16(_vq->vdev, vq->last_used_idx |
> > +					((u16)vq->used_wrap_counter << 15)));
> > +
> >  #ifdef DEBUG
> >  	vq->last_add_time_valid = false;
> >  #endif
> > @@ -1213,8 +1235,18 @@ static unsigned virtqueue_enable_cb_prepare_packed(struct virtqueue *_vq)
> >  	/* We optimistically turn back on interrupts, then check if there was
> >  	 * more to do. */
> >  
> > +	if (vq->event) {
> > +		vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> > +				vq->last_used_idx |
> > +				((u16)vq->used_wrap_counter << 15));
> > +		/* We need to update event offset and event wrap
> > +		 * counter first before updating event flags. */
> > +		virtio_wmb(vq->weak_barriers);
> > +	}
> > +
> >  	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> > -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> > +						     VRING_EVENT_F_ENABLE;
> >  		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> >  							vq->event_flags_shadow);
> >  	}
> > @@ -1238,22 +1270,47 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, unsigned off_wrap)
> >  static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > +	u16 bufs, used_idx, wrap_counter;
> >  
> >  	START_USE(vq);
> >  
> >  	/* We optimistically turn back on interrupts, then check if there was
> >  	 * more to do. */
> >  
> > +	if (vq->event) {
> > +		/* TODO: tune this threshold */
> > +		bufs = (vq->vring_packed.num - _vq->num_free) * 3 / 4;
> > +		wrap_counter = vq->used_wrap_counter;
> > +
> > +		used_idx = vq->last_used_idx + bufs;
> > +		if (used_idx >= vq->vring_packed.num) {
> > +			used_idx -= vq->vring_packed.num;
> > +			wrap_counter ^= 1;
> > +		}
> > +
> > +		vq->vring_packed.driver->off_wrap = cpu_to_virtio16(_vq->vdev,
> > +				used_idx | (wrap_counter << 15));
> > +
> > +		/* We need to update event offset and event wrap
> > +		 * counter first before updating event flags. */
> > +		virtio_wmb(vq->weak_barriers);
> > +	} else {
> > +		used_idx = vq->last_used_idx;
> > +		wrap_counter = vq->used_wrap_counter;
> > +	}
> > +
> >  	if (vq->event_flags_shadow == VRING_EVENT_F_DISABLE) {
> > -		vq->event_flags_shadow = VRING_EVENT_F_ENABLE;
> > +		vq->event_flags_shadow = vq->event ? VRING_EVENT_F_DESC :
> > +						     VRING_EVENT_F_ENABLE;
> >  		vq->vring_packed.driver->flags = cpu_to_virtio16(_vq->vdev,
> >  							vq->event_flags_shadow);
> > -		/* We need to enable interrupts first before re-checking
> > -		 * for more used buffers. */
> > -		virtio_mb(vq->weak_barriers);
> >  	}
> >  
> > -	if (more_used_packed(vq)) {
> > +	/* We need to update event suppression structure first
> > +	 * before re-checking for more used buffers. */
> > +	virtio_mb(vq->weak_barriers);
> > +
> 
> mb is expensive. We should not do it if we changed nothing.

I will try to avoid it when possible.

> 
> > +	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> >  		END_USE(vq);
> >  		return false;
> >  	}
> > -- 
> > 2.18.0
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
