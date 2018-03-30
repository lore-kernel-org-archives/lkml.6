Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeC3CG6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 22:06:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:41898 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751906AbeC3CG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 22:06:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,378,1517904000";
   d="scan'208";a="29260383"
Date: Fri, 30 Mar 2018 10:05:18 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH V2 8/8] vhost: event suppression for packed ring
Message-ID: <20180330020518.tja3lxkfz7mdwasj@debian>
References: <1522035533-11786-1-git-send-email-jasowang@redhat.com>
 <1522035533-11786-9-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1522035533-11786-9-git-send-email-jasowang@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 11:38:53AM +0800, Jason Wang wrote:
> This patch introduces basic support for event suppression aka driver
> and device area. Compile tested only.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
[...]
> +
> +static bool vhost_notify_packed(struct vhost_dev *dev,
> +				struct vhost_virtqueue *vq)
> +{
> +	__virtio16 event_off_wrap, event_flags;
> +	__u16 old, new;
> +	bool v, wrap;
> +	int off;
> +
> +	/* Flush out used descriptors updates. This is paired
> +	 * with the barrier that the Guest executes when enabling
> +	 * interrupts.
> +	 */
> +	smp_mb();
> +
> +	if (vhost_get_avail(vq, event_flags,
> +			   &vq->driver_event->desc_event_flags) < 0) {
> +		vq_err(vq, "Failed to get driver desc_event_flags");
> +		return true;
> +	}
> +
> +	if (!(event_flags & cpu_to_vhost16(vq, RING_EVENT_FLAGS_DESC)))
> +		return event_flags ==
> +		       cpu_to_vhost16(vq, RING_EVENT_FLAGS_ENABLE);

Maybe it would be better to not use '&' here. Because these flags
are not defined as bits which can be ORed or ANDed. Instead, they
are defined as values:

0x0  enable
0x1  disable
0x2  desc
0x3  reserved

> +
> +	/* Read desc event flags before event_off and event_wrap */
> +	smp_rmb();
> +
> +	if (vhost_get_avail(vq, event_off_wrap,
> +			    &vq->driver_event->desc_event_off_warp) < 0) {
> +		vq_err(vq, "Failed to get driver desc_event_off/wrap");
> +		return true;
> +	}
> +
> +	off = vhost16_to_cpu(vq, event_off_wrap);
> +
> +	wrap = off & 0x1;
> +	off >>= 1;

Based on the below definitions in spec, wrap counter is
the most significant bit.

struct pvirtq_event_suppress {
	le16 {
		desc_event_off : 15; /* Descriptor Ring Change Event Offset */
		desc_event_wrap : 1; /* Descriptor Ring Change Event Wrap Counter */
	} desc; /* If desc_event_flags set to RING_EVENT_FLAGS_DESC */
	le16 {
		desc_event_flags : 2, /* Descriptor Ring Change Event Flags */
		reserved : 14; /* Reserved, set to 0 */
	} flags;
};

> +
> +
> +	old = vq->signalled_used;
> +	v = vq->signalled_used_valid;
> +	new = vq->signalled_used = vq->last_used_idx;
> +	vq->signalled_used_valid = true;
> +
> +	if (unlikely(!v))
> +		return true;
> +
> +	return vhost_vring_packed_need_event(vq, new, old, off) &&
> +	       wrap == vq->used_wrap_counter;
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
> @@ -2789,7 +2911,17 @@ static bool vhost_enable_notify_packed(struct vhost_dev *dev,
>  	__virtio16 flags;
>  	int ret;
>  
> -	/* FIXME: disable notification through device area */
> +	if (!(vq->used_flags & VRING_USED_F_NO_NOTIFY))
> +		return false;
> +	vq->used_flags &= ~VRING_USED_F_NO_NOTIFY;
> +
> +	flags = cpu_to_vhost16(vq, RING_EVENT_FLAGS_ENABLE);
> +	ret = vhost_update_device_flags(vq, flags);
> +	if (ret) {
> +		vq_err(vq, "Failed to enable notification at %p: %d\n",
> +		       &vq->device_event->desc_event_flags, ret);
> +		return false;
> +	}
>  
>  	/* They could have slipped one in as we were doing that: make
>  	 * sure it's written, then check again. */
> @@ -2855,7 +2987,18 @@ EXPORT_SYMBOL_GPL(vhost_enable_notify);
>  static void vhost_disable_notify_packed(struct vhost_dev *dev,
>  					struct vhost_virtqueue *vq)
>  {
> -	/* FIXME: disable notification through device area */
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
> +		       &vq->device_event->desc_event_flags, r);
>  }
>  
>  static void vhost_disable_notify_split(struct vhost_dev *dev,
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 8a9df4f..02d7a36 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -96,8 +96,14 @@ struct vhost_virtqueue {
>  		struct vring_desc __user *desc;
>  		struct vring_desc_packed __user *desc_packed;

Do you think it'd be better to name the desc type as
struct vring_packed_desc? And it will be consistent
with other names, like:

struct vring_packed;
struct vring_packed_desc_event;

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
> diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
> index e297580..7cdbf06 100644
> --- a/include/uapi/linux/virtio_ring.h
> +++ b/include/uapi/linux/virtio_ring.h
> @@ -75,6 +75,25 @@ struct vring_desc_packed {
>  	__virtio16 flags;
>  };
>  
> +/* Enable events */
> +#define RING_EVENT_FLAGS_ENABLE 0x0
> +/* Disable events */
> +#define RING_EVENT_FLAGS_DISABLE 0x1
> +/*
> + * Enable events for a specific descriptor
> + * (as specified by Descriptor Ring Change Event Offset/Wrap Counter).
> + * Only valid if VIRTIO_F_RING_EVENT_IDX has been negotiated.
> + */
> +#define RING_EVENT_FLAGS_DESC 0x2
> +/* The value 0x3 is reserved */
> +
> +struct vring_packed_desc_event {
> +	/* Descriptor Ring Change Event Offset and Wrap Counter */
> +	__virtio16 desc_event_off_warp;
> +	/* Descriptor Ring Change Event Flags */
> +	__virtio16 desc_event_flags;

Do you think it'd be better to remove the prefix (desc_event_) for
the fields. And it will be consistent with other definitions, e.g.:

struct vring_packed_desc {
        /* Buffer Address. */
        __virtio64 addr;
        /* Buffer Length. */
        __virtio32 len;
        /* Buffer ID. */
        __virtio16 id;
        /* The flags depending on descriptor type. */
        __virtio16 flags;
};

> +};
> +
>  /* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
>  struct vring_desc {
>  	/* Address (guest-physical). */
> -- 
> 2.7.4
> 
