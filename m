Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB46EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995D42475B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995D42475B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932876AbeGDEOB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:14:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932188AbeGDEN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:13:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F6E0406AE3F;
        Wed,  4 Jul 2018 04:13:58 +0000 (UTC)
Received: from wei-ubt (dhcp-14-122.nay.redhat.com [10.66.14.122])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 89B662026D76;
        Wed,  4 Jul 2018 04:13:54 +0000 (UTC)
Date:   Wed, 4 Jul 2018 12:13:52 +0800
From:   Wei Xu <wexu@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tiwei.bie@intel.com,
        maxime.coquelin@redhat.com, jfreimann@redhat.com
Subject: Re: [PATCH net-next 8/8] vhost: event suppression for packed ring
Message-ID: <20180704041352.GA9287@wei-ubt>
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
 <1530596284-4101-9-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530596284-4101-9-git-send-email-jasowang@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 04 Jul 2018 04:13:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 04 Jul 2018 04:13:58 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'wexu@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:38:04PM +0800, Jason Wang wrote:
> This patch introduces support for event suppression. This is done by
> have a two areas: device area and driver area. One side could then try
> to disable or enable (delayed) notification from other side by using a
> boolean hint or event index interface in the areas.
> 
> For more information, please refer Virtio spec.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 191 ++++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/vhost/vhost.h |  10 ++-
>  2 files changed, 185 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 0f3f07c..cccbc82 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1115,10 +1115,15 @@ static int vq_access_ok_packed(struct vhost_virtqueue *vq, unsigned int num,
>  			       struct vring_used __user *used)
>  {
>  	struct vring_desc_packed *packed = (struct vring_desc_packed *)desc;
> +	struct vring_packed_desc_event *driver_event =
> +		(struct vring_packed_desc_event *)avail;
> +	struct vring_packed_desc_event *device_event =
> +		(struct vring_packed_desc_event *)used;
>  
> -	/* TODO: check device area and driver area */
>  	return access_ok(VERIFY_READ, packed, num * sizeof(*packed)) &&
> -	       access_ok(VERIFY_WRITE, packed, num * sizeof(*packed));
> +	       access_ok(VERIFY_WRITE, packed, num * sizeof(*packed)) &&

R/W parameter doesn't make sense to most architectures and the comment in x86
says WRITE is a superset of READ, is it possible to converge them here?

/**
 * access_ok: - Checks if a user space pointer is valid
 * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
 *        %VERIFY_WRITE is a superset of %VERIFY_READ - if it is safe
 *        to write to a block, it is always safe to read from it.
 * @addr: User space pointer to start of block to check
 * @size: Size of block to check
 *
 * Context: User context only. This function may sleep if pagefaults are
 *          enabled.
 *
 * Checks if a pointer to a block of memory in user space is valid.
 *
 * Returns true (nonzero) if the memory block may be valid, false (zero)
 * if it is definitely invalid.
 *
 * Note that, depending on architecture, this function probably just
 * checks that the pointer is in the user space range - after calling
 * this function, memory access functions may still return -EFAULT.
 */
#define access_ok(type, addr, size)     
......

Thanks,
Wei

> +	       access_ok(VERIFY_READ, driver_event, sizeof(*driver_event)) &&
> +	       access_ok(VERIFY_WRITE, device_event, sizeof(*device_event));
>  }
>  
>  static int vq_access_ok_split(struct vhost_virtqueue *vq, unsigned int num,
> @@ -1193,14 +1198,27 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
>  	return true;
>  }
>  
> -int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
> +int vq_iotlb_prefetch_packed(struct vhost_virtqueue *vq)
> +{
> +	int num = vq->num;
> +
> +	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
> +			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
> +	       iotlb_access_ok(vq, VHOST_ACCESS_WO, (u64)(uintptr_t)vq->desc,
> +			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
> +	       iotlb_access_ok(vq, VHOST_ACCESS_RO,
> +			       (u64)(uintptr_t)vq->driver_event,
> +			       sizeof(*vq->driver_event), VHOST_ADDR_AVAIL) &&
> +	       iotlb_access_ok(vq, VHOST_ACCESS_WO,
> +			       (u64)(uintptr_t)vq->device_event,
> +			       sizeof(*vq->device_event), VHOST_ADDR_USED);
> +}
> +
> +int vq_iotlb_prefetch_split(struct vhost_virtqueue *vq)
>  {
>  	size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>  	unsigned int num = vq->num;
>  
> -	if (!vq->iotlb)
> -		return 1;
> -
>  	return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
>  			       num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
>  	       iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->avail,
> @@ -1212,6 +1230,17 @@ int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
>  			       num * sizeof(*vq->used->ring) + s,
>  			       VHOST_ADDR_USED);
>  }
> +
> +int vq_iotlb_prefetch(struct vhost_virtqueue *vq)
> +{
> +	if (!vq->iotlb)
> +		return 1;
> +
> +	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +		return vq_iotlb_prefetch_packed(vq);
> +	else
> +		return vq_iotlb_prefetch_split(vq);
> +}
>  EXPORT_SYMBOL_GPL(vq_iotlb_prefetch);
>  
>  /* Can we log writes? */
> @@ -1771,6 +1800,50 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
>  	return 0;
>  }
>  
> +static int vhost_update_device_flags(struct vhost_virtqueue *vq,
> +				     __virtio16 device_flags)
> +{
> +	void __user *flags;
> +
> +	if (vhost_put_user(vq, device_flags, &vq->device_event->flags,
> +			   VHOST_ADDR_USED) < 0)
> +		return -EFAULT;
> +	if (unlikely(vq->log_used)) {
> +		/* Make sure the flag is seen before log. */
> +		smp_wmb();
> +		/* Log used flag write. */
> +		flags = &vq->device_event->flags;
> +		log_write(vq->log_base, vq->log_addr +
> +			  (flags - (void __user *)vq->device_event),
> +			  sizeof(vq->device_event->flags));
> +		if (vq->log_ctx)
> +			eventfd_signal(vq->log_ctx, 1);
> +	}
> +	return 0;
> +}
> +
> +static int vhost_update_device_off_wrap(struct vhost_virtqueue *vq,
> +					__virtio16 device_off_wrap)
> +{
> +	void __user *off_wrap;
> +
> +	if (vhost_put_user(vq, device_off_wrap, &vq->device_event->off_wrap,
> +			   VHOST_ADDR_USED) < 0)
> +		return -EFAULT;
> +	if (unlikely(vq->log_used)) {
> +		/* Make sure the flag is seen before log. */
> +		smp_wmb();
> +		/* Log used flag write. */
> +		off_wrap = &vq->device_event->off_wrap;
> +		log_write(vq->log_base, vq->log_addr +
> +			  (off_wrap - (void __user *)vq->device_event),
> +			  sizeof(vq->device_event->off_wrap));
> +		if (vq->log_ctx)
> +			eventfd_signal(vq->log_ctx, 1);
> +	}
> +	return 0;
> +}
> +
>  static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
>  {
>  	if (vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
> @@ -2756,16 +2829,13 @@ int vhost_add_used_n(struct vhost_virtqueue *vq,
>  }
>  EXPORT_SYMBOL_GPL(vhost_add_used_n);
>  
> -static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> +static bool vhost_notify_split(struct vhost_dev *dev,
> +			       struct vhost_virtqueue *vq)
>  {
>  	__u16 old, new;
>  	__virtio16 event;
>  	bool v;
>  
> -	/* TODO: check driver area */
> -	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> -		return true;
> -
>  	/* Flush out used index updates. This is paired
>  	 * with the barrier that the Guest executes when enabling
>  	 * interrupts. */
> @@ -2798,6 +2868,64 @@ static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	return vring_need_event(vhost16_to_cpu(vq, event), new, old);
>  }
>  
> +static bool vhost_notify_packed(struct vhost_dev *dev,
> +				struct vhost_virtqueue *vq)
> +{
> +	__virtio16 event_off_wrap, event_flags;
> +	__u16 old, new, off_wrap;
> +	bool v;
> +
> +	/* Flush out used descriptors updates. This is paired
> +	 * with the barrier that the Guest executes when enabling
> +	 * interrupts.
> +	 */
> +	smp_mb();
> +
> +	if (vhost_get_avail(vq, event_flags,
> +			   &vq->driver_event->flags) < 0) {
> +		vq_err(vq, "Failed to get driver desc_event_flags");
> +		return true;
> +	}
> +
> +	if (!vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX))
> +		return event_flags !=
> +		       cpu_to_vhost16(vq, RING_EVENT_FLAGS_DISABLE);
> +
> +	old = vq->signalled_used;
> +	v = vq->signalled_used_valid;
> +	new = vq->signalled_used = vq->last_used_idx;
> +	vq->signalled_used_valid = true;
> +
> +	if (event_flags != cpu_to_vhost16(vq, RING_EVENT_FLAGS_DESC))
> +		return event_flags !=
> +		       cpu_to_vhost16(vq, RING_EVENT_FLAGS_DISABLE);
> +
> +	/* Read desc event flags before event_off and event_wrap */
> +	smp_rmb();
> +
> +	if (vhost_get_avail(vq, event_off_wrap,
> +			    &vq->driver_event->off_wrap) < 0) {
> +		vq_err(vq, "Failed to get driver desc_event_off/wrap");
> +		return true;
> +	}
> +
> +	off_wrap = vhost16_to_cpu(vq, event_off_wrap);
> +
> +	if (unlikely(!v))
> +		return true;
> +
> +	return vhost_vring_packed_need_event(vq, vq->last_used_wrap_counter,
> +					     off_wrap, new, old);
> +}
> +
> +static bool vhost_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
> +{
> +	if (vhost_has_feature(vq, VIRTIO_F_RING_PACKED))
> +		return vhost_notify_packed(dev, vq);
> +	else
> +		return vhost_notify_split(dev, vq);
> +}
> +
>  /* This actually signals the guest, using eventfd. */
>  void vhost_signal(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  {
> @@ -2875,10 +3003,34 @@ static bool vhost_enable_notify_packed(struct vhost_dev *dev,
>  				       struct vhost_virtqueue *vq)
>  {
>  	struct vring_desc_packed *d = vq->desc_packed + vq->avail_idx;
> -	__virtio16 flags;
> +	__virtio16 flags = cpu_to_vhost16(vq, RING_EVENT_FLAGS_ENABLE);
>  	int ret;
>  
> -	/* TODO: enable notification through device area */
> +	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
> +		return false;
> +	vq->used_flags &= ~VRING_USED_F_NO_NOTIFY;
> +
> +	if (vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX)) {
> +		__virtio16 off_wrap = cpu_to_vhost16(vq, vq->avail_idx |
> +				      vq->avail_wrap_counter << 15);
> +
> +		ret = vhost_update_device_off_wrap(vq, off_wrap);
> +		if (ret) {
> +			vq_err(vq, "Failed to write to off warp at %p: %d\n",
> +			       &vq->device_event->off_wrap, ret);
> +			return false;
> +		}
> +		/* Make sure off_wrap is wrote before flags */
> +		smp_wmb();
> +		flags = cpu_to_vhost16(vq, RING_EVENT_FLAGS_DESC);
> +	}
> +
> +	ret = vhost_update_device_flags(vq, flags);
> +	if (ret) {
> +		vq_err(vq, "Failed to enable notification at %p: %d\n",
> +			&vq->device_event->flags, ret);
> +		return false;
> +	}
>  
>  	/* They could have slipped one in as we were doing that: make
>  	 * sure it's written, then check again.
> @@ -2945,7 +3097,18 @@ EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  static void vhost_disable_notify_packed(struct vhost_dev *dev,
>  					struct vhost_virtqueue *vq)
>  {
> -	/* TODO: disable notification through device area */
> +	__virtio16 flags;
> +	int r;
> +
> +	if (vq->used_flags & VRING_USED_F_NO_NOTIFY)
> +		return;
> +	vq->used_flags |= VRING_USED_F_NO_NOTIFY;
> +
> +	flags = cpu_to_vhost16(vq, RING_EVENT_FLAGS_DISABLE);
> +	r = vhost_update_device_flags(vq, flags);
> +	if (r)
> +		vq_err(vq, "Failed to enable notification at %p: %d\n",
> +		       &vq->device_event->flags, r);
>  }
>  
>  static void vhost_disable_notify_split(struct vhost_dev *dev,
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index db09958..d071daf 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -96,8 +96,14 @@ struct vhost_virtqueue {
>  		struct vring_desc __user *desc;
>  		struct vring_desc_packed __user *desc_packed;
>  	};
> -	struct vring_avail __user *avail;
> -	struct vring_used __user *used;
> +	union {
> +		struct vring_avail __user *avail;
> +		struct vring_packed_desc_event __user *driver_event;
> +	};
> +	union {
> +		struct vring_used __user *used;
> +		struct vring_packed_desc_event __user *device_event;
> +	};
>  	const struct vhost_umem_node *meta_iotlb[VHOST_NUM_ADDRS];
>  	struct file *kick;
>  	struct eventfd_ctx *call_ctx;
> -- 
> 2.7.4
> 
