Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8383CC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4094721104
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4094721104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeLLOdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:33:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbeLLOdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:33:38 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0B723082E55;
        Wed, 12 Dec 2018 14:33:38 +0000 (UTC)
Received: from redhat.com (ovpn-122-106.rdu2.redhat.com [10.10.122.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 85E5D600C9;
        Wed, 12 Dec 2018 14:33:37 +0000 (UTC)
Date:   Wed, 12 Dec 2018 09:33:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net V2 1/4] vhost: make sure used idx is seen before log
 in vhost_add_used_n()
Message-ID: <20181212093303-mutt-send-email-mst@kernel.org>
References: <20181212100819.21295-1-jasowang@redhat.com>
 <20181212100819.21295-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212100819.21295-2-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 12 Dec 2018 14:33:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 06:08:16PM +0800, Jason Wang wrote:
> We miss a write barrier that guarantees used idx is updated and seen
> before log. This will let userspace sync and copy used ring before
> used idx is update. Fix this by adding a barrier before log_write().
> 
> Fixes: 8dd014adfea6f ("vhost-net: mergeable buffers support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

also for 4.20 and seems like a stable candidate.

> ---
>  drivers/vhost/vhost.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 6b98d8e3a5bf..5915f240275a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2220,6 +2220,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
>  		return -EFAULT;
>  	}
>  	if (unlikely(vq->log_used)) {
> +		/* Make sure used idx is seen before log. */
> +		smp_wmb();
>  		/* Log used index update. */
>  		log_write(vq->log_base,
>  			  vq->log_addr + offsetof(struct vring_used, idx),
> -- 
> 2.17.1
