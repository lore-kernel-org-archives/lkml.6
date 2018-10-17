Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FABCECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFFD2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFFD2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbeJQUZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:25:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbeJQUZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:25:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01474308404C;
        Wed, 17 Oct 2018 12:30:23 +0000 (UTC)
Received: from [10.72.12.94] (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 433475C69C;
        Wed, 17 Oct 2018 12:30:11 +0000 (UTC)
Subject: Re: [PATCH v3] virtio_net: avoid using netif_tx_disable() for
 serializing tx routine
To:     Ake Koomsin <ake@igel.co.jp>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <276ac5bb-90f7-5fb6-a826-0bb05ecfa069@redhat.com>
 <20181017104419.13003-1-ake@igel.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9e3b3279-44b2-63a0-326c-90840c1c210d@redhat.com>
Date:   Wed, 17 Oct 2018 20:30:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017104419.13003-1-ake@igel.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 17 Oct 2018 12:30:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/10/17 下午6:44, Ake Koomsin wrote:
> Commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> introduces netif_tx_disable() after netif_device_detach() in order to
> avoid use-after-free of tx queues. However, there are two issues.
>
> 1) Its operation is redundant with netif_device_detach() in case the
>     interface is running.
> 2) In case of the interface is not running before suspending and
>     resuming, the tx does not get resumed by netif_device_attach().
>     This results in losing network connectivity.
>
> It is better to use netif_tx_lock_bh()/netif_tx_unlock_bh() instead for
> serializing tx routine during reset. This also preserves the symmetry
> of netif_device_detach() and netif_device_attach().
>
> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
> ---
>   drivers/net/virtio_net.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3f5aa59c37b7..3e2c041d76ac 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2267,8 +2267,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>   	/* Make sure no work handler is accessing the device */
>   	flush_work(&vi->config_work);
>   
> +	netif_tx_lock_bh(vi->dev);
>   	netif_device_detach(vi->dev);
> -	netif_tx_disable(vi->dev);
> +	netif_tx_unlock_bh(vi->dev);
>   	cancel_delayed_work_sync(&vi->refill);
>   
>   	if (netif_running(vi->dev)) {
> @@ -2304,7 +2305,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>   		}
>   	}
>   
> +	netif_tx_lock_bh(vi->dev);
>   	netif_device_attach(vi->dev);
> +	netif_tx_unlock_bh(vi->dev);
>   	return err;
>   }
>   


Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

