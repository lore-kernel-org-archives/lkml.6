Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B482DC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECA12081F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 01:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ECA12081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeLKBey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 20:34:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeLKBex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 20:34:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F35363082B0F;
        Tue, 11 Dec 2018 01:34:52 +0000 (UTC)
Received: from redhat.com (ovpn-120-187.rdu2.redhat.com [10.10.120.187])
        by smtp.corp.redhat.com (Postfix) with SMTP id 29237608F2;
        Tue, 11 Dec 2018 01:34:52 +0000 (UTC)
Date:   Mon, 10 Dec 2018 20:34:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>
Subject: Re: [PATCH net 2/4] vhost_net: rework on the lock ordering for busy
 polling
Message-ID: <20181210203119-mutt-send-email-mst@kernel.org>
References: <20181210094454.21144-1-jasowang@redhat.com>
 <20181210094454.21144-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210094454.21144-3-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 11 Dec 2018 01:34:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:44:52PM +0800, Jason Wang wrote:
> When we try to do rx busy polling in tx path in commit 441abde4cd84
> ("net: vhost: add rx busy polling in tx path"), we lock rx vq mutex
> after tx vq mutex is held. This may lead deadlock so we try to lock vq
> one by one in commit 78139c94dc8c ("net: vhost: lock the vqs one by
> one"). With this commit, we avoid the deadlock with the assumption
> that handle_rx() and handle_tx() run in a same process. But this
> commit remove the protection for IOTLB updating which requires the
> mutex of each vq to be held.
> 
> To solve this issue, the first step is to have a exact same lock
> ordering for vhost_net. This is done through:
> 
> - For handle_rx(), if busy polling is enabled, lock tx vq immediately.
> - For handle_tx(), always lock rx vq before tx vq, and unlock it if
>   busy polling is not enabled.
> - Remove the tricky locking codes in busy polling.
> 
> With this, we can have a exact same lock ordering for vhost_net, this
> allows us to safely revert commit 78139c94dc8c ("net: vhost: lock the
> vqs one by one") in next patch.
> 
> The patch will add two more atomic operations on the tx path during
> each round of handle_tx(). 1 byte TCP_RR does not notice such
> overhead.
> 
> Fixes: commit 78139c94dc8c ("net: vhost: lock the vqs one by one")
> Cc: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/net.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index ab11b2bee273..5f272ab4d5b4 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -513,7 +513,6 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  	struct socket *sock;
>  	struct vhost_virtqueue *vq = poll_rx ? tvq : rvq;
>  
> -	mutex_lock_nested(&vq->mutex, poll_rx ? VHOST_NET_VQ_TX: VHOST_NET_VQ_RX);
>  	vhost_disable_notify(&net->dev, vq);
>  	sock = rvq->private_data;
>  
> @@ -543,8 +542,6 @@ static void vhost_net_busy_poll(struct vhost_net *net,
>  		vhost_net_busy_poll_try_queue(net, vq);
>  	else if (!poll_rx) /* On tx here, sock has no rx data. */
>  		vhost_enable_notify(&net->dev, rvq);
> -
> -	mutex_unlock(&vq->mutex);
>  }
>  
>  static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
> @@ -913,10 +910,16 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  static void handle_tx(struct vhost_net *net)
>  {
>  	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
> +	struct vhost_net_virtqueue *nvq_rx = &net->vqs[VHOST_NET_VQ_RX];
>  	struct vhost_virtqueue *vq = &nvq->vq;
> +	struct vhost_virtqueue *vq_rx = &nvq_rx->vq;
>  	struct socket *sock;
>  
> +	mutex_lock_nested(&vq_rx->mutex, VHOST_NET_VQ_RX);
>  	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_TX);
> +	if (!vq->busyloop_timeout)
> +		mutex_unlock(&vq_rx->mutex);
> +
>  	sock = vq->private_data;
>  	if (!sock)
>  		goto out;
> @@ -933,6 +936,8 @@ static void handle_tx(struct vhost_net *net)
>  		handle_tx_copy(net, sock);
>  
>  out:
> +	if (vq->busyloop_timeout)
> +		mutex_unlock(&vq_rx->mutex);
>  	mutex_unlock(&vq->mutex);
>  }
>  


So rx mutex taken on tx path now.  And tx mutex is on rc path ...  This
is just messed up. Why can't tx polling drop rx lock before
getting the tx lock and vice versa?

Or if we really wanted to force everything to be locked at
all times, let's just use a single mutex.



> @@ -1060,7 +1065,9 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
>  static void handle_rx(struct vhost_net *net)
>  {
>  	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_RX];
> +	struct vhost_net_virtqueue *nvq_tx = &net->vqs[VHOST_NET_VQ_TX];
>  	struct vhost_virtqueue *vq = &nvq->vq;
> +	struct vhost_virtqueue *vq_tx = &nvq_tx->vq;
>  	unsigned uninitialized_var(in), log;
>  	struct vhost_log *vq_log;
>  	struct msghdr msg = {
> @@ -1086,6 +1093,9 @@ static void handle_rx(struct vhost_net *net)
>  	int recv_pkts = 0;
>  
>  	mutex_lock_nested(&vq->mutex, VHOST_NET_VQ_RX);
> +	if (vq->busyloop_timeout)
> +		mutex_lock_nested(&vq_tx->mutex, VHOST_NET_VQ_TX);
> +
>  	sock = vq->private_data;
>  	if (!sock)
>  		goto out;
> @@ -1200,6 +1210,8 @@ static void handle_rx(struct vhost_net *net)
>  out:
>  	vhost_net_signal_used(nvq);
>  	mutex_unlock(&vq->mutex);
> +	if (vq->busyloop_timeout)
> +		mutex_unlock(&vq_tx->mutex);
>  }
>  
>  static void handle_tx_kick(struct vhost_work *work)
> -- 
> 2.17.1
