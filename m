Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8974C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B429F2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbfAIOZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:25:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbfAIOZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:25:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 297CE811D9;
        Wed,  9 Jan 2019 14:25:44 +0000 (UTC)
Received: from redhat.com (ovpn-123-72.rdu2.redhat.com [10.10.123.72])
        by smtp.corp.redhat.com (Postfix) with SMTP id C3865608DA;
        Wed,  9 Jan 2019 14:25:42 +0000 (UTC)
Date:   Wed, 9 Jan 2019 09:25:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jintack Lim <jintack@cs.columbia.edu>
Subject: Re: [PATCH net V2] vhost: log dirty page correctly
Message-ID: <20190109091937-mutt-send-email-mst@kernel.org>
References: <20190109072947.23240-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109072947.23240-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 09 Jan 2019 14:25:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 03:29:47PM +0800, Jason Wang wrote:
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
> The patch is needed for stable.
> Changes from V1:
> - return error instead of warn
> ---
>  drivers/vhost/net.c   |  3 +-
>  drivers/vhost/vhost.c | 82 +++++++++++++++++++++++++++++++++++--------
>  drivers/vhost/vhost.h |  3 +-
>  3 files changed, 72 insertions(+), 16 deletions(-)
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
> index 9f7942cbcbb2..ee095f08ffd4 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1733,11 +1733,70 @@ static int log_write(void __user *log_base,
>  	return r;
>  }
>  
> +static int log_write_hva(struct vhost_virtqueue *vq, u64 hva, u64 len)
> +{
> +	struct vhost_umem *umem = vq->umem;
> +	struct vhost_umem_node *u;
> +	u64 gpa;
> +	int r;
> +	bool hit = false;
> +
> +	list_for_each_entry(u, &umem->umem_list, link) {
> +		if (u->userspace_addr < hva &&
> +		    u->userspace_addr + u->size >=
> +		    hva + len) {

So this tries to see that the GPA range is completely within
the GVA region. Does this have to be the case?
And if yes why not return 0 below instead of hit = true?
I'm also a bit concerned about overflow when addr + len is on a 64 bit
boundary.  Why not check add + size - 1 and hva + len - 1 instead?


> +			gpa = u->start + hva - u->userspace_addr;
> +			r = log_write(vq->log_base, gpa, len);
> +			if (r < 0)
> +				return r;
> +			hit = true;
> +		}
> +	}
> +
> +	if (!hit)
> +		return -EFAULT;
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
> +	ret = translate_desc(vq, (u64)(uintptr_t)vq->used + used_offset,
> +			     len, iov, 64, VHOST_ACCESS_WO);


We don't need the cast to u64 here do we?

> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ret; i++) {
> +		ret = log_write_hva(vq,	(u64)(uintptr_t)iov[i].iov_base,


We don't need the cast to u64 here do we?

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
> +	if (vq->iotlb) {
> +		for (i = 0; i < count; i++) {
> +			r = log_write_hva(vq, (u64)(uintptr_t)iov[i].iov_base,
> +					  iov[i].iov_len);


We don't need the cast to u64 here do we?

> +			if (r < 0)
> +				return r;
> +		}
> +		return 0;
> +	}
> +
>  	/* Make sure data written is seen before log. */
>  	smp_wmb();

Shouldn't the wmb be before log_write_hva too?

>  	for (i = 0; i < log_num; ++i) {
> @@ -1769,9 +1828,8 @@ static int vhost_update_used_flags(struct vhost_virtqueue *vq)
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
> @@ -1789,9 +1847,8 @@ static int vhost_update_avail_event(struct vhost_virtqueue *vq, u16 avail_event)
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
> @@ -2191,10 +2248,8 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
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
> @@ -2236,9 +2291,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
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
