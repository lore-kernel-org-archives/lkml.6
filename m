Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959C5ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C092151D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C092151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeJQQ50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbeJQQ5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:57:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF71B3082DCF;
        Wed, 17 Oct 2018 09:02:42 +0000 (UTC)
Received: from [10.72.12.94] (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F1EA41B475;
        Wed, 17 Oct 2018 09:02:37 +0000 (UTC)
Subject: Re: [PATCH v2] virtio_net: avoid using netif_tx_disable() for
 serializing tx routine
To:     Ake Koomsin <ake@igel.co.jp>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f04bee7a-3892-102d-2be0-f4fda4048e74@redhat.com>
 <20181017075918.7043-1-ake@igel.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <276ac5bb-90f7-5fb6-a826-0bb05ecfa069@redhat.com>
Date:   Wed, 17 Oct 2018 17:02:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017075918.7043-1-ake@igel.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 17 Oct 2018 09:02:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/10/17 下午3:59, Ake Koomsin wrote:
> Commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> introduces netif_tx_disable() after netif_device_detach() in order to
> avoid use-after-free of tx queues. However, there are two issues.
>
> 1) Its operation is redundant with netif_device_detach() if the interface
>     is running.
> 2) In case of the interface is not running before suspending and
>     resuming, the tx does not get resumed by netif_device_attach().
>     This results in losing network connectivity.
>
> It is better to use netif_tx_lock()/netif_tx_unlock() instead for
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
> index 3f5aa59c37b7..41ccf9c994a4 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2267,8 +2267,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>   	/* Make sure no work handler is accessing the device */
>   	flush_work(&vi->config_work);
>   
> +	netif_tx_lock(vi->dev);
>   	netif_device_detach(vi->dev);
> -	netif_tx_disable(vi->dev);
> +	netif_tx_unlock(vi->dev);


Sorry for not finding this earlier. I think we should use 
netif_tx_lock_bh() to prevent start_xmit() to run under bh.

Thanks


>   	cancel_delayed_work_sync(&vi->refill);
>   
>   	if (netif_running(vi->dev)) {
> @@ -2304,7 +2305,9 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>   		}
>   	}
>   
> +	netif_tx_lock(vi->dev);
>   	netif_device_attach(vi->dev);
> +	netif_tx_unlock(vi->dev);
>   	return err;
>   }
>   
