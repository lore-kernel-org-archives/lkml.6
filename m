Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C43DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B389208D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 11:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B389208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeHXOgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 10:36:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbeHXOgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 10:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32DA840216E8;
        Fri, 24 Aug 2018 11:02:40 +0000 (UTC)
Received: from redhat.com (ovpn-120-77.rdu2.redhat.com [10.10.120.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 08DFA1006EB7;
        Fri, 24 Aug 2018 11:02:36 +0000 (UTC)
Date:   Fri, 24 Aug 2018 14:02:36 +0300
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com
Subject: Re: [PATCH net] vhost: correctly check the iova range when waking
 virtqueue
Message-ID: <20180824140231-mutt-send-email-mst@kernel.org>
References: <20180824085313.21798-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180824085313.21798-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 24 Aug 2018 11:02:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 24 Aug 2018 11:02:40 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 04:53:13PM +0800, Jason Wang wrote:
> We don't wakeup the virtqueue if the first byte of pending iova range
> is the last byte of the range we just got updated. This will lead a
> virtqueue to wait for IOTLB updating forever. Fixing by correct the
> check and wake up the virtqueue in this case.
> 
> Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
> Reported-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> The patch is needed for -stable.
> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 96c1d8400822..b13c6b4b2c66 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -952,7 +952,7 @@ static void vhost_iotlb_notify_vq(struct vhost_dev *d,
>  	list_for_each_entry_safe(node, n, &d->pending_list, node) {
>  		struct vhost_iotlb_msg *vq_msg = &node->msg.iotlb;
>  		if (msg->iova <= vq_msg->iova &&
> -		    msg->iova + msg->size - 1 > vq_msg->iova &&
> +		    msg->iova + msg->size - 1 >= vq_msg->iova &&
>  		    vq_msg->type == VHOST_IOTLB_MISS) {
>  			vhost_poll_queue(&node->vq->poll);
>  			list_del(&node->node);
> -- 
> 2.17.1
