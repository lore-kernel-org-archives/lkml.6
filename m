Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B49C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411912081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411912081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeLIXYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 18:24:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeLIXYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 18:24:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16790368E7;
        Sun,  9 Dec 2018 23:24:54 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 260A25DAA0;
        Sun,  9 Dec 2018 23:24:51 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: Re: [PATCH 3.16 047/328] xen-netfront: fix queue name setting
In-Reply-To: <lsq.1544392233.936009164@decadent.org.uk>
References: <lsq.1544392233.936009164@decadent.org.uk>
Date:   Mon, 10 Dec 2018 00:24:53 +0100
Message-ID: <87y38ycmgq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 09 Dec 2018 23:24:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Hutchings <ben@decadent.org.uk> writes:

> 3.16.62-rc1 review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>
> commit 2d408c0d4574b01b9ed45e02516888bf925e11a9 upstream.
>
> Commit f599c64fdf7d ("xen-netfront: Fix race between device setup and
> open") changed the initialization order: xennet_create_queues() now
> happens before we do register_netdev() so using netdev->name in
> xennet_init_queue() is incorrect, we end up with the following in
> /proc/interrupts:
>
>  60:        139          0   xen-dyn    -event     eth%d-q0-tx
>  61:        265          0   xen-dyn    -event     eth%d-q0-rx
>  62:        234          0   xen-dyn    -event     eth%d-q1-tx
>  63:          1          0   xen-dyn    -event     eth%d-q1-rx
>
> and this looks ugly. Actually, using early netdev name (even when it's
> already set) is also not ideal: nowadays we tend to rename eth devices
> and queue name may end up not corresponding to the netdev name.
>
> Use nodename from xenbus device for queue naming: this can't change in VM's
> lifetime. Now /proc/interrupts looks like
>
>  62:        202          0   xen-dyn    -event     device/vif/0-q0-tx
>  63:        317          0   xen-dyn    -event     device/vif/0-q0-rx
>  64:        262          0   xen-dyn    -event     device/vif/0-q1-tx
>  65:         17          0   xen-dyn    -event     device/vif/0-q1-rx
>
> Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/net/xen-netfront.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/drivers/net/xen-netfront.c
> +++ b/drivers/net/xen-netfront.c
> @@ -1646,7 +1646,7 @@ static int xennet_init_queue(struct netf
>  	queue->rx_refill_timer.function = rx_refill_timeout;
>  
>  	snprintf(queue->name, sizeof(queue->name), "%s-q%u",
> -		 queue->info->netdev->name, queue->id);
> +		 queue->info->xbdev->nodename, queue->id);
>  
>  	/* Initialise tx_skbs as a free chain containing every entry. */
>  	queue->tx_skb_freelist = 0;
>

We should also take 

commit 21f2706b20100bb3db378461ab9b8e2035309b5b
Author: Xiao Liang <xiliang@redhat.com>
Date:   Tue Aug 14 23:21:28 2018 +0800

    xen-netfront: fix warn message as irq device name has '/'

as it fixes an issue introduced by the commit in question. Sorry if this
is already in your series but I wasn't CCed on it.

-- 
Vitaly
