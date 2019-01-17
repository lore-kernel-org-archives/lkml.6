Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5958220851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfAQUmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:42:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbfAQUmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:42:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A409C0C5A77;
        Thu, 17 Jan 2019 20:42:42 +0000 (UTC)
Received: from redhat.com (ovpn-123-223.rdu2.redhat.com [10.10.123.223])
        by smtp.corp.redhat.com (Postfix) with SMTP id B19FE60BE5;
        Thu, 17 Jan 2019 20:42:41 +0000 (UTC)
Date:   Thu, 17 Jan 2019 15:42:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jintack Lim <jintack@cs.columbia.edu>
Subject: Re: [PATCH net V4] vhost: log dirty page correctly
Message-ID: <20190117154226-mutt-send-email-mst@kernel.org>
References: <20190116085442.3836-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116085442.3836-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 17 Jan 2019 20:42:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 04:54:42PM +0800, Jason Wang wrote:
> Vhost dirty page logging API is designed to sync through GPA. But we
> try to log GIOVA when device IOTLB is enabled. This is wrong and may
> lead to missing data after migration.
> 
> To solve this issue, when logging with device IOTLB enabled, we will:
> 
> 1) reuse the device IOTLB translation result of GIOVA->HVA mapping to
>    get HVA, for writable descriptor, get HVA through iovec. For used
>    ring update, translate its GIOVA to HVA
> 2) traverse the GPA->HVA mapping to get the possible GPA and log
>    through GPA. Pay attention this reverse mapping is not guaranteed
>    to be unique, so we should log each possible GPA in this case.
> 
> This fix the failure of scp to guest during migration. In -next, we
> will probably support passing GIOVA->GPA instead of GIOVA->HVA.
> 
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Reported-by: Jintack Lim <jintack@cs.columbia.edu>
> Cc: Jintack Lim <jintack@cs.columbia.edu>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

This one looks good to me

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes from V3:
> - make sure each part of the hva was logged when crossing the boundary
>   of memory regions
> Changes from V2:
> - check and log the case of range overlap
> - remove unnecessary u64 cast
> - use smp_wmb() for the case of device IOTLB as well
> Changes from V1:
> - return error instead of warn
> ---
>  drivers/vhost/net.c   |  3 +-
>  drivers/vhost/vhost.c | 97 ++++++++++++++++++++++++++++++++++++-------
>  drivers/vhost/vhost.h |  3 +-
>  3 files changed, 87 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 36f3d0f49e60..bca86bf7189f 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1236,7 +1236,8 @@ static void handle_rx(struct vhost_net *net)
>  		if (nvq->done_idx > VHOST_NET_BATCH)
>  			vhost_net_signal_used(nvq);
>  		if (unlikely(vq_log))
> -			vhost_log_write(vq, vq_log, log, vhost_len);
> +			vhost_log_write(vq, vq_log, log, vhost_len,
> +					vq->iov, in);
>  		total_len += vhost_len;
>  		if (unlikely(vhost_exceeds_weight(++recv_pkts, total_len))) {
>  			vhost_poll_queue(&vq->poll);
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 9f7942cbcbb2..babbb32b9bf0 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1733,13 +1733,87 @@ static int log_write(void __user *log_base,
>  	return r;
>  }
>  
> +static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
> +{
> +	struct vhost_umem *umem = vq->umem;
> +	struct vhost_umem_node *u;
> +	u64 start, end, l, min;
> +	int r;
> +	bool hit = false;
> +
> +	while (len) {
> +		min = len;
> +		/* More than one GPAs can be mapped into a single HVA. So
> +		 * iterate all possible umems here to be safe.
> +		 */
> +		list_for_each_entry(u, &umem->umem_list, link) {
> +			if (u->userspace_addr > hva - 1 + len ||
> +			    u->userspace_addr - 1 + u->size < hva)
> +				continue;
> +			start = max(u->userspace_addr, hva);
> +			end = min(u->userspace_addr - 1 + u->size,
> +				  hva - 1 + len);
> +			l = end - start + 1;
> +			r = log_write(vq->log_base,
> +				      u->start + start - u->userspace_addr,
> +				      l);
> +			if (r < 0)
> +				return r;
> +			hit = true;
> +			min = min(l, min);
> +		}
> +
> +		if (!hit)
> +			return -EFAULT;
> +
> +		len -= min;
> +		hva += min;
> +	}
> +
> +	return 0;
> +}
> +
> +static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
> +{
> +	struct iovec iov[64];
> +	int i, ret;
> +
> +	if (!vq->iotlb)
> +		return log_write(vq->log_base, vq->log_addr + used_offset, len);
> +
> +	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
> +			     len, iov, 64, VHOST_ACCESS_WO);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ret; i++) {
> +		ret = log_write_hva(vq,	(uintptr_t)iov[i].iov_base,
> +				    iov[i].iov_len);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
> -		    unsigned int log_num, u64 len)
> +		    unsigned int log_num, u64 len, struct iovec *iov, int count)
>  {
>  	int i, r;
>  
>  	/* Make sure data written is seen before log. */
>  	smp_wmb();
> +
> +	if (vq->iotlb) {
> +		for (i = 0; i < count; i++) {
> +			r = log_write_hva(vq, (uintptr_t)iov[i].iov_base,
> +					  iov[i].iov_len);
> +			if (r < 0)
> +				return r;
> +		}
> +		return 0;
> +	}
> +
>  	for (i = 0; i < log_num; ++i) {
>  		u64 l = min(log[i].len, len);
>  		r = log_write(vq->log_base, log[i].addr, l);
> @@ -1769,9 +1843,8 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
>  		smp_wmb();
>  		/* Log used flag write. */
>  		used = &vq->used->flags;
> -		log_write(vq->log_base, vq->log_addr +
> -			  (used - (void __user *)vq->used),
> -			  sizeof vq->used->flags);
> +		log_used(vq, (used - (void __user *)vq->used),
> +			 sizeof vq->used->flags);
>  		if (vq->log_ctx)
>  			eventfd_signal(vq->log_ctx, 1);
>  	}
> @@ -1789,9 +1862,8 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
>  		smp_wmb();
>  		/* Log avail event write */
>  		used = vhost_avail_event(vq);
> -		log_write(vq->log_base, vq->log_addr +
> -			  (used - (void __user *)vq->used),
> -			  sizeof *vhost_avail_event(vq));
> +		log_used(vq, (used - (void __user *)vq->used),
> +			 sizeof *vhost_avail_event(vq));
>  		if (vq->log_ctx)
>  			eventfd_signal(vq->log_ctx, 1);
>  	}
> @@ -2191,10 +2263,8 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
>  		/* Make sure data is seen before log. */
>  		smp_wmb();
>  		/* Log used ring entry write. */
> -		log_write(vq->log_base,
> -			  vq->log_addr +
> -			   ((void __user *)used - (void __user *)vq->used),
> -			  count * sizeof *used);
> +		log_used(vq, ((void __user *)used - (void __user *)vq->used),
> +			 count * sizeof *used);
>  	}
>  	old = vq->last_used_idx;
>  	new = (vq->last_used_idx += count);
> @@ -2236,9 +2306,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
>  		/* Make sure used idx is seen before log. */
>  		smp_wmb();
>  		/* Log used index update. */
> -		log_write(vq->log_base,
> -			  vq->log_addr + offsetof(struct vring_used, idx),
> -			  sizeof vq->used->idx);
> +		log_used(vq, offsetof(struct vring_used, idx),
> +			 sizeof vq->used->idx);
>  		if (vq->log_ctx)
>  			eventfd_signal(vq->log_ctx, 1);
>  	}
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 466ef7542291..1b675dad5e05 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -205,7 +205,8 @@ bool vhost_vq_avail_empty(struct vhost_dev *, struct vhost_virtqueue *);
>  bool vhost_enable_notify(struct vhost_dev *, struct vhost_virtqueue *);
>  
>  int vhost_log_write(struct vhost_virtqueue *vq, struct vhost_log *log,
> -		    unsigned int log_num, u64 len);
> +		    unsigned int log_num, u64 len,
> +		    struct iovec *iov, int count);
>  int vq_iotlb_prefetch(struct vhost_virtqueue *vq);
>  
>  struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type);
> -- 
> 2.17.1
