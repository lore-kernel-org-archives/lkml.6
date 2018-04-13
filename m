Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbeDMPWs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:22:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750783AbeDMPWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:22:47 -0400
Date: Fri, 13 Apr 2018 18:22:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: jasowang@redhat.com, wexu@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jfreimann@redhat.com
Subject: Re: [RFC v2] virtio: support packed ring
Message-ID: <20180413181808-mutt-send-email-mst@kernel.org>
References: <20180401141216.8969-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180401141216.8969-1-tiwei.bie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 01, 2018 at 10:12:16PM +0800, Tiwei Bie wrote:
> +static inline bool more_used(const struct vring_virtqueue *vq)
> +{
> +	return vq->packed ? more_used_packed(vq) : more_used_split(vq);
> +}
> +
> +void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq, unsigned int *len,
> +				  void **ctx)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	void *ret;
> +	unsigned int i;
> +	u16 last_used;
> +
> +	START_USE(vq);
> +
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return NULL;
> +	}
> +
> +	if (!more_used(vq)) {
> +		pr_debug("No more buffers in queue\n");
> +		END_USE(vq);
> +		return NULL;
> +	}

So virtqueue_get_buf_ctx_split should only call more_used_split.

to avoid such issues I think we should lay out the code like this:

XXX_split

XXX_packed

XXX wrappers

> +/* The standard layout

I'd drop standard here.

> for the packed ring is a continuous chunk of memory
> + * which looks like this.
> + *
> + * struct vring_packed
> + * {

Can the opening bracket go on the prev line pls?

> + *	// The actual descriptors (16 bytes each)
> + *	struct vring_packed_desc desc[num];
> + *
> + *	// Padding to the next align boundary.
> + *	char pad[];
> + *
> + *	// Driver Event Suppression
> + *	struct vring_packed_desc_event driver;
> + *
> + *	// Device Event Suppression
> + *	struct vring_packed_desc_event device;

Maybe that's how our driver does it but it's not based on spec
so I don't think this belongs in the header.

> + * };
> + */
> +
> +static inline unsigned vring_packed_size(unsigned int num, unsigned long align)
> +{
> +	return ((sizeof(struct vring_packed_desc) * num + align - 1)
> +		& ~(align - 1)) + sizeof(struct vring_packed_desc_event) * 2;
> +}
> +

Cant say this API makes sense for me.


>  #endif /* _UAPI_LINUX_VIRTIO_RING_H */
> -- 
> 2.11.0
