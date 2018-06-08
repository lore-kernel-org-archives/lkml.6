Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QzykLzgKGltDKQAAmS7hNA
	; Fri, 08 Jun 2018 04:46:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9CF176074D; Fri,  8 Jun 2018 04:46:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1AB1F606FA;
	Fri,  8 Jun 2018 04:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AB1F606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeFHEqq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 00:46:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750923AbeFHEqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 00:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F6A788847;
        Fri,  8 Jun 2018 04:46:44 +0000 (UTC)
Received: from redhat.com (ovpn-120-126.rdu2.redhat.com [10.10.120.126])
        by smtp.corp.redhat.com (Postfix) with SMTP id E2DD72144B24;
        Fri,  8 Jun 2018 04:46:43 +0000 (UTC)
Date: Fri, 8 Jun 2018 07:46:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost_net: remove VHOST_NET_F_VIRTIO_NET_HDR support
Message-ID: <20180608074115-mutt-send-email-mst@kernel.org>
References: <1528429842-22835-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528429842-22835-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 08 Jun 2018 04:46:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 08 Jun 2018 04:46:44 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 11:50:42AM +0800, Jason Wang wrote:
> This feature bit is duplicated with VIRTIO_F_ANY_LAYOUT, this means if
> a userpsace want to enable VRITIO_F_ANY_LAYOUT,
> VHOST_NET_F_VIRTIO_NET_HDR will be implied too. This is wrong and will
> break networking.

What breaks networking exactly? VHOST_NET supported ANY_LAYOUT
from day one. For this reason it does not need to know about
VRITIO_F_ANY_LAYOUT and we reused the bit for other purposes.



> Fixing this by safely removing
> VHOST_NET_F_VIRTIO_NET_HDR support. There should be very few or even
> no userspace can use this.

Quite possibly, but it is hard to be sure. It seems safer to
maintain it unless there's an actual reason something's broken.

> Further cleanups could be done for
> -net-next for safety.
> 
> In the future, we need a vhost dedicated feature set/get ioctl()
> instead of reusing virtio ones.

Not just in the future, we might want to switch iommu
to a sane structure without the 64 bit padding bug
right now.

> 
> Fixes: 4e9fa50c6ccbe ("vhost: move features to core")

This tag makes no sense here IMHO. Looks like people are using some tool
that just looks at the earliest version where patch won't apply. The
commit in question just moved some code around.

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 986058a..83eef52 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -69,7 +69,6 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
>  
>  enum {
>  	VHOST_NET_FEATURES = VHOST_FEATURES |
> -			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>  			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
>  			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
>  };
> @@ -1255,15 +1254,11 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
>  			       (1ULL << VIRTIO_F_VERSION_1))) ?
>  			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
>  			sizeof(struct virtio_net_hdr);
> -	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
> -		/* vhost provides vnet_hdr */
> -		vhost_hlen = hdr_len;
> -		sock_hlen = 0;
> -	} else {
> -		/* socket provides vnet_hdr */
> -		vhost_hlen = 0;
> -		sock_hlen = hdr_len;
> -	}
> +
> +        /* socket provides vnet_hdr */
> +	vhost_hlen = 0;
> +	sock_hlen = hdr_len;
> +
>  	mutex_lock(&n->dev.mutex);
>  	if ((features & (1 << VHOST_F_LOG_ALL)) &&
>  	    !vhost_log_access_ok(&n->dev))
> -- 
> 2.7.4
