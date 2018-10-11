Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13A6C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE18520841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 09:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE18520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeJKRKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 13:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17451 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbeJKRKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 13:10:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD2B137E80;
        Thu, 11 Oct 2018 09:44:09 +0000 (UTC)
Received: from [10.72.12.114] (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F3A27A44B;
        Thu, 11 Oct 2018 09:44:04 +0000 (UTC)
Subject: Re: [PATCH] virtio_net: enable tx after resuming from suspend
To:     Ake Koomsin <ake@igel.co.jp>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181011075127.2608-1-ake@igel.co.jp>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <dd530053-efab-b661-3423-1faaab8fb12f@redhat.com>
Date:   Thu, 11 Oct 2018 17:44:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011075127.2608-1-ake@igel.co.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 11 Oct 2018 09:44:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月11日 15:51, Ake Koomsin wrote:
> commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> disabled the virtio tx before going to suspend to avoid a use after free.
> However, after resuming, it causes the virtio_net device to lose its
> network connectivity.
>
> To solve the issue, we need to enable tx after resuming.
>
> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
> ---
>   drivers/net/virtio_net.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dab504ec5e50..3453d80f5f81 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2256,6 +2256,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>   	}
>   
>   	netif_device_attach(vi->dev);
> +	netif_start_queue(vi->dev);

I believe this is duplicated with netif_tx_wake_all_queues() in 
netif_device_attach() above?

Thanks

>   	return err;
>   }
>   

