Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AEDC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F23204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F23204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeIMXPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbeIMXPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:15:36 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA16A3002727;
        Thu, 13 Sep 2018 18:05:01 +0000 (UTC)
Received: from redhat.com (ovpn-123-50.rdu2.redhat.com [10.10.123.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6F47B74BBB;
        Thu, 13 Sep 2018 18:05:00 +0000 (UTC)
Date:   Thu, 13 Sep 2018 14:04:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next V2 11/11] vhost_net: batch submitting XDP
 buffers to underlayer sockets
Message-ID: <20180913140332-mutt-send-email-mst@kernel.org>
References: <20180912031709.14112-1-jasowang@redhat.com>
 <20180912031709.14112-12-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912031709.14112-12-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 13 Sep 2018 18:05:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 11:17:09AM +0800, Jason Wang wrote:
> +static void vhost_tx_batch(struct vhost_net *net,
> +			   struct vhost_net_virtqueue *nvq,
> +			   struct socket *sock,
> +			   struct msghdr *msghdr)
> +{
> +	struct tun_msg_ctl ctl = {
> +		.type = TUN_MSG_PTR,
> +		.num = nvq->batched_xdp,
> +		.ptr = nvq->xdp,
> +	};
> +	int err;
> +
> +	if (nvq->batched_xdp == 0)
> +		goto signal_used;
> +
> +	msghdr->msg_control = &ctl;
> +	err = sock->ops->sendmsg(sock, msghdr, 0);
> +	if (unlikely(err < 0)) {
> +		vq_err(&nvq->vq, "Fail to batch sending packets\n");
> +		return;
> +	}
> +
> +signal_used:
> +	vhost_net_signal_used(nvq);
> +	nvq->batched_xdp = 0;
> +}
> +

Given it's all tun-specific now, how about just exporting tap_sendmsg
and calling that? Will get rid of some indirection too.

-- 
MST

