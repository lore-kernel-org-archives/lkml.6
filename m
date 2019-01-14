Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D00C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C290204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfANSEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:04:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54235 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfANSEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:04:54 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F096E445DB;
        Mon, 14 Jan 2019 18:04:53 +0000 (UTC)
Received: from redhat.com (ovpn-124-229.rdu2.redhat.com [10.10.124.229])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9EE72806BF;
        Mon, 14 Jan 2019 18:04:51 +0000 (UTC)
Date:   Mon, 14 Jan 2019 13:04:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jintack Lim <jintack@cs.columbia.edu>
Subject: Re: [PATCH net V3] vhost: log dirty page correctly
Message-ID: <20190114125357-mutt-send-email-mst@kernel.org>
References: <20190111040036.12413-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111040036.12413-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 14 Jan 2019 18:04:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:00:36PM +0800, Jason Wang wrote:
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
> ---
> Changes from V2:
> - check and log the case of range overlap
> - remove unnecessary u64 cast
> - use smp_wmb() for the case of device IOTLB as well
> Changes from V1:
> - return error instead of warn
> ---
>  drivers/vhost/net.c   |  3 +-
>  drivers/vhost/vhost.c | 88 ++++++++++++++++++++++++++++++++++++-------
>  drivers/vhost/vhost.h |  3 +-
>  3 files changed, 78 insertions(+), 16 deletions(-)
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
> index 9f7942cbcbb2..55a2e8f9f8ca 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1733,13 +1733,78 @@ static int log_write(void __user *log_base,
>  	return r;
>  }
>  
> +static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
> +{
> +	struct vhost_umem *umem = vq->umem;
> +	struct vhost_umem_node *u;
> +	u64 start, end;
> +	int r;
> +	bool hit = false;
> +
> +	/* More than one GPAs can be mapped into a single HVA. So
> +	 * iterate all possible umems here to be safe.
> +	 */
> +	list_for_each_entry(u, &umem->umem_list, link) {
> +		if (u->userspace_addr > hva - 1 + len ||
> +		    u->userspace_addr - 1 + u->size < hva)
> +			continue;
> +		start = max(u->userspace_addr, hva);
> +		end = min(u->userspace_addr - 1 + u->size, hva - 1 + len);
> +		r = log_write(vq->log_base,
> +			      u->start + start - u->userspace_addr,
> +			      end - start + 1);
> +		if (r < 0)
> +			return r;
> +		hit = true;
> +	}
> +
> +	if (!hit)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +

I definitely like the simplicity.

But there's one point left here: if len crosses a region boundary,
but doesn't all fall within a region, we don't consistently report -EFAULT.

So I suspect we need to start by finding a region that contains hva.
If there are many of these - move right to the end of the
leftmost one and then repeat until we run out of len
or fail to find a region and exit with -EFAULT.




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
> @@ -1769,9 +1834,8 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
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
> @@ -1789,9 +1853,8 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
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
> @@ -2191,10 +2254,8 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
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
> @@ -2236,9 +2297,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
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
