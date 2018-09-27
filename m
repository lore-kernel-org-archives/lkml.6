Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C86C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1767421582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1767421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeI0XYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:24:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbeI0XYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:24:34 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 723AF80F79;
        Thu, 27 Sep 2018 17:05:21 +0000 (UTC)
Received: from redhat.com (ovpn-123-154.rdu2.redhat.com [10.10.123.154])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6572B30918A5;
        Thu, 27 Sep 2018 17:04:59 +0000 (UTC)
Date:   Thu, 27 Sep 2018 13:04:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     stefanha@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH net V2] vhost-vsock: fix use after free
Message-ID: <20180927123539-mutt-send-email-mst@kernel.org>
References: <20180927122204.4188-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927122204.4188-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 27 Sep 2018 17:05:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 08:22:04PM +0800, Jason Wang wrote:
> The access of vsock is not protected by vhost_vsock_lock. This may
> lead to use after free since vhost_vsock_dev_release() may free the
> pointer at the same time.
> 
> Fix this by holding the lock during the access.
> 
> Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
> Fixes: 16320f363ae1 ("vhost-vsock: add pkt cancel capability")
> Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Wow is that really the best we can do? A global lock on a data path
operation? Granted use after free is nasty but Stefan said he sees
a way to fix it using a per socket refcount. He's on vacation
until Oct 4 though ...

> ---
> - V2: fix typos
> - The patch is needed for -stable.
> ---
>  drivers/vhost/vsock.c | 26 +++++++++++++++++++-------
>  1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 34bc3ab40c6d..7d0b292867fd 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -210,21 +210,27 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
>  	struct vhost_vsock *vsock;
>  	int len = pkt->len;
>  
> +	spin_lock_bh(&vhost_vsock_lock);
> +
>  	/* Find the vhost_vsock according to guest context id  */
> -	vsock = vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
> +	vsock = __vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
>  	if (!vsock) {
>  		virtio_transport_free_pkt(pkt);
> +		spin_unlock_bh(&vhost_vsock_lock);
>  		return -ENODEV;
>  	}
>  
>  	if (pkt->reply)
>  		atomic_inc(&vsock->queued_replies);
>  
> -	spin_lock_bh(&vsock->send_pkt_list_lock);
> +	spin_lock(&vsock->send_pkt_list_lock);
>  	list_add_tail(&pkt->list, &vsock->send_pkt_list);
> -	spin_unlock_bh(&vsock->send_pkt_list_lock);
> +	spin_unlock(&vsock->send_pkt_list_lock);
>  
>  	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
> +
> +	spin_unlock_bh(&vhost_vsock_lock);
> +
>  	return len;
>  }
>  
> @@ -236,18 +242,22 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
>  	int cnt = 0;
>  	LIST_HEAD(freeme);
>  
> +	spin_lock_bh(&vhost_vsock_lock);
> +
>  	/* Find the vhost_vsock according to guest context id  */
> -	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
> -	if (!vsock)
> +	vsock = __vhost_vsock_get(vsk->remote_addr.svm_cid);
> +	if (!vsock) {
> +		spin_unlock_bh(&vhost_vsock_lock);
>  		return -ENODEV;
> +	}
>  
> -	spin_lock_bh(&vsock->send_pkt_list_lock);
> +	spin_lock(&vsock->send_pkt_list_lock);
>  	list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
>  		if (pkt->vsk != vsk)
>  			continue;
>  		list_move(&pkt->list, &freeme);
>  	}
> -	spin_unlock_bh(&vsock->send_pkt_list_lock);
> +	spin_unlock(&vsock->send_pkt_list_lock);
>  
>  	list_for_each_entry_safe(pkt, n, &freeme, list) {
>  		if (pkt->reply)
> @@ -265,6 +275,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
>  			vhost_poll_queue(&tx_vq->poll);
>  	}
>  
> +	spin_unlock_bh(&vhost_vsock_lock);
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
