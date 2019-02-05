Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42861C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1489C2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 20:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbfBEUuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 15:50:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfBEUuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 15:50:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8D423D95D;
        Tue,  5 Feb 2019 20:50:08 +0000 (UTC)
Received: from redhat.com (ovpn-116-138.sin2.redhat.com [10.67.116.138])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0F0F31001F4D;
        Tue,  5 Feb 2019 20:49:43 +0000 (UTC)
Date:   Tue, 5 Feb 2019 15:49:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, dodgen@google.com, konrad.wilk@oracle.com,
        dhildenb@redhat.com, aarcange@redhat.com
Subject: Re: [RFC][Patch v8 5/7] virtio: Enables to add a single descriptor
 to the host
Message-ID: <20190205154545-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <20190204201854.2328-6-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204201854.2328-6-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 05 Feb 2019 20:50:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 03:18:52PM -0500, Nitesh Narayan Lal wrote:
> This patch enables the caller to expose a single buffers to the
> other end using vring descriptor. It also allows the caller to
> perform this action in synchornous manner by using virtqueue_kick_sync.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>

I am not sure why do we need this API. Polling in guest
until host runs isn't great either since these
might be running on the same host CPU.



> ---
>  drivers/virtio/virtio_ring.c | 72 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  4 ++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755484e3..93c161ac6a28 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1695,6 +1695,52 @@ static inline int virtqueue_add(struct virtqueue *_vq,
>  					out_sgs, in_sgs, data, ctx, gfp);
>  }
>  
> +/**
> + * virtqueue_add_desc - add a buffer to a chain using a vring desc
> + * @vq: the struct virtqueue we're talking about.
> + * @addr: address of the buffer to add.
> + * @len: length of the buffer.
> + * @in: set if the buffer is for the device to write.
> + *
> + * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
> + */
> +int virtqueue_add_desc(struct virtqueue *_vq, u64 addr, u32 len, int in)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct vring_desc *desc = vq->split.vring.desc;
> +	u16 flags = in ? VRING_DESC_F_WRITE : 0;
> +	unsigned int i;
> +	void *data = (void *)addr;
> +	int avail_idx;
> +
> +	/* Sanity check */
> +	if (!_vq)
> +		return -EINVAL;
> +
> +	START_USE(vq);
> +	if (unlikely(vq->broken)) {
> +		END_USE(vq);
> +		return -EIO;
> +	}
> +
> +	i = vq->free_head;
> +	flags &= ~VRING_DESC_F_NEXT;
> +	desc[i].flags = cpu_to_virtio16(_vq->vdev, flags);
> +	desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
> +	desc[i].len = cpu_to_virtio32(_vq->vdev, len);
> +
> +	vq->vq.num_free--;
> +	vq->free_head = virtio16_to_cpu(_vq->vdev, desc[i].next);
> +	vq->split.desc_state[i].data = data;
> +	vq->split.avail_idx_shadow = 1;
> +	avail_idx = vq->split.avail_idx_shadow;
> +	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev, avail_idx);
> +	vq->num_added = 1;
> +	END_USE(vq);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_add_desc);
> +
>  /**
>   * virtqueue_add_sgs - expose buffers to other end
>   * @vq: the struct virtqueue we're talking about.
> @@ -1842,6 +1888,32 @@ bool virtqueue_notify(struct virtqueue *_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_notify);
>  
> +/**
> + * virtqueue_kick_sync - update after add_buf and busy wait till update is done
> + * @vq: the struct virtqueue
> + *
> + * After one or more virtqueue_add_* calls, invoke this to kick
> + * the other side. Busy wait till the other side is done with the update.
> + *
> + * Caller must ensure we don't call this with other virtqueue
> + * operations at the same time (except where noted).
> + *
> + * Returns false if kick failed, otherwise true.
> + */
> +bool virtqueue_kick_sync(struct virtqueue *vq)
> +{
> +	u32 len;
> +
> +	if (likely(virtqueue_kick(vq))) {
> +		while (!virtqueue_get_buf(vq, &len) &&
> +		       !virtqueue_is_broken(vq))
> +			cpu_relax();
> +		return true;
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_kick_sync);
> +
>  /**
>   * virtqueue_kick - update after add_buf
>   * @vq: the struct virtqueue
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index fa1b5da2804e..58943a3a0e8d 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -57,6 +57,10 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>  		      unsigned int in_sgs,
>  		      void *data,
>  		      gfp_t gfp);
> +/* A desc with this init id is treated as an invalid desc */
> +int virtqueue_add_desc(struct virtqueue *_vq, u64 addr, u32 len, int in);
> +
> +bool virtqueue_kick_sync(struct virtqueue *vq);
>  
>  bool virtqueue_kick(struct virtqueue *vq);
>  
> -- 
> 2.17.2
