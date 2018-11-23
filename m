Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B644C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFDC205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFDC205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440419AbeKXCd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:33:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440367AbeKXCd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:33:58 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DA3013D10;
        Fri, 23 Nov 2018 15:49:15 +0000 (UTC)
Received: from redhat.com (ovpn-121-146.rdu2.redhat.com [10.10.121.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7B4841054FDA;
        Fri, 23 Nov 2018 15:49:14 +0000 (UTC)
Date:   Fri, 23 Nov 2018 10:49:13 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] vhost_net: support in order feature
Message-ID: <20181123104333-mutt-send-email-mst@kernel.org>
References: <20181123030016.4924-1-jasowang@redhat.com>
 <20181123030016.4924-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123030016.4924-3-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 23 Nov 2018 15:49:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:00:15AM +0800, Jason Wang wrote:
> This makes vhost_net to support in order feature. This is as simple as
> use datacopy path when it was negotiated. An alternative is not to
> advertise in order when zerocopy is enabled which tends to be
> suboptimal consider zerocopy may suffer from e.g HOL issues.

Well IIRC vhost_zerocopy_signal_used is used to
actually reorder used ring to match available ring.
So with a big comment explaining why it is so,
we could just enable IN_ORDER there too.

> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index d919284f103b..bdf5de5a7eb2 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -74,7 +74,8 @@ enum {
>  	VHOST_NET_FEATURES = VHOST_FEATURES |
>  			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
>  			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
> -			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
> +			 (1ULL << VIRTIO_F_IOMMU_PLATFORM) |
> +	                 (1ULL << VIRTIO_F_IN_ORDER)
>  };
>  
>  enum {
> @@ -971,7 +972,8 @@ static void handle_tx(struct vhost_net *net)
>  	vhost_disable_notify(&net->dev, vq);
>  	vhost_net_disable_vq(net, vq);
>  
> -	if (vhost_sock_zcopy(sock))
> +	if (vhost_sock_zcopy(sock) &&
> +	    !vhost_has_feature(vq, VIRTIO_F_IN_ORDER))
>  		handle_tx_zerocopy(net, sock);
>  	else
>  		handle_tx_copy(net, sock);
> -- 
> 2.17.1
