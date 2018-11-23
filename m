Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC36C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AAA20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AAA20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440321AbeKXC0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:26:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436647AbeKXC0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:26:07 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C17E307EA83;
        Fri, 23 Nov 2018 15:41:26 +0000 (UTC)
Received: from redhat.com (ovpn-121-146.rdu2.redhat.com [10.10.121.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id 908535C548;
        Fri, 23 Nov 2018 15:41:25 +0000 (UTC)
Date:   Fri, 23 Nov 2018 10:41:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] vhost: don't touch avail ring if in_order
 is negotiated
Message-ID: <20181123103750-mutt-send-email-mst@kernel.org>
References: <20181123030016.4924-1-jasowang@redhat.com>
 <20181123030016.4924-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123030016.4924-4-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 23 Nov 2018 15:41:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:00:16AM +0800, Jason Wang wrote:
> Device use descriptors table in order, so there's no need to read
> index from available ring. This eliminate the cache contention on
> avail ring completely.

Well this isn't what the in order feature says in the spec.

It forces the used ring to be in the same order as
the available ring. So I don't think you can skip
checking the available ring. And in fact depending on
ring size and workload, using all of descriptor buffer might
cause a slowdown.
Rather you should be able to get
about the same speedup, but from skipping checking
the used ring in virtio.


> Virito-user + vhost_kernel + XDP_DROP gives about ~10% improvement on
> TX from 4.8Mpps to 5.3Mpps on Intel(R) Core(TM) i7-5600U CPU @
> 2.60GHz.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 3a5f81a66d34..c8be151bc897 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2002,6 +2002,7 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  	__virtio16 avail_idx;
>  	__virtio16 ring_head;
>  	int ret, access;
> +	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>  
>  	/* Check it isn't doing very strange things with descriptor numbers. */
>  	last_avail_idx = vq->last_avail_idx;
> @@ -2034,15 +2035,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
>  
>  	/* Grab the next descriptor number they're advertising, and increment
>  	 * the index we've seen. */
> -	if (unlikely(vhost_get_avail(vq, ring_head,
> -		     &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
> -		vq_err(vq, "Failed to read head: idx %d address %p\n",
> -		       last_avail_idx,
> -		       &vq->avail->ring[last_avail_idx % vq->num]);
> -		return -EFAULT;
> +	if (!in_order) {
> +		if (unlikely(vhost_get_avail(vq, ring_head,
> +		    &vq->avail->ring[last_avail_idx & (vq->num - 1)]))) {
> +			vq_err(vq, "Failed to read head: idx %d address %p\n",
> +				last_avail_idx,
> +				&vq->avail->ring[last_avail_idx % vq->num]);
> +			return -EFAULT;
> +		}
> +		head = vhost16_to_cpu(vq, ring_head);
> +	} else {
> +		head = last_avail_idx & (vq->num - 1);
>  	}
>  
> -	head = vhost16_to_cpu(vq, ring_head);
>  
>  	/* If their number is silly, that's an error. */
>  	if (unlikely(head >= vq->num)) {
> -- 
> 2.17.1
