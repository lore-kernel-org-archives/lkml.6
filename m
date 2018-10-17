Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8522DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D2C21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D2C21526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeJQXF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:05:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeJQXF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:05:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEB6230001E0;
        Wed, 17 Oct 2018 15:09:21 +0000 (UTC)
Received: from redhat.com (ovpn-124-92.rdu2.redhat.com [10.10.124.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id D7B915C63B;
        Wed, 17 Oct 2018 15:09:20 +0000 (UTC)
Date:   Wed, 17 Oct 2018 11:09:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Ake Koomsin <ake@igel.co.jp>
Cc:     Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio_net: avoid using netif_tx_disable() for
 serializing tx routine
Message-ID: <20181017110741-mutt-send-email-mst@kernel.org>
References: <276ac5bb-90f7-5fb6-a826-0bb05ecfa069@redhat.com>
 <20181017104419.13003-1-ake@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017104419.13003-1-ake@igel.co.jp>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 17 Oct 2018 15:09:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 07:44:12PM +0900, Ake Koomsin wrote:
> Commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> introduces netif_tx_disable() after netif_device_detach() in order to
> avoid use-after-free of tx queues. However, there are two issues.
> 
> 1) Its operation is redundant with netif_device_detach() in case the
>    interface is running.
> 2) In case of the interface is not running before suspending and
>    resuming, the tx does not get resumed by netif_device_attach().
>    This results in losing network connectivity.
> 
> It is better to use netif_tx_lock_bh()/netif_tx_unlock_bh() instead for
> serializing tx routine during reset. This also preserves the symmetry
> of netif_device_detach() and netif_device_attach().
> 
> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> Signed-off-by: Ake Koomsin <ake@igel.co.jp>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks a lot for debugging!
Seems like stable material to me, right?

> ---
>  drivers/net/virtio_net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3f5aa59c37b7..3e2c041d76ac 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2267,8 +2267,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	/* Make sure no work handler is accessing the device */
>  	flush_work(&vi->config_work);
>  
> +	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);
> -	netif_tx_disable(vi->dev);
> +	netif_tx_unlock_bh(vi->dev);
>  	cancel_delayed_work_sync(&vi->refill);
>  
>  	if (netif_running(vi->dev)) {
> @@ -2304,7 +2305,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  		}
>  	}
>  
> +	netif_tx_lock_bh(vi->dev);
>  	netif_device_attach(vi->dev);
> +	netif_tx_unlock_bh(vi->dev);
>  	return err;
>  }
>  
> -- 
> 2.19.1
