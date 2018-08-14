Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F84C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A9021763
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A9021763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbeHNMIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:08:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42252 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730340AbeHNMIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:08:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AFD0F2B36;
        Tue, 14 Aug 2018 09:22:28 +0000 (UTC)
Received: from localhost (ovpn-200-47.brq.redhat.com [10.40.200.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53D692026D7E;
        Tue, 14 Aug 2018 09:22:26 +0000 (UTC)
Date:   Tue, 14 Aug 2018 11:22:22 +0200
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com
Subject: Re: [RFC PATCH net-next V2 6/6] virtio-net: support XDP rx handler
Message-ID: <20180814112222.42177a24@redhat.com>
In-Reply-To: <1534130250-5302-7-git-send-email-jasowang@redhat.com>
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
        <1534130250-5302-7-git-send-email-jasowang@redhat.com>
Organization: Red Hat Inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 14 Aug 2018 09:22:28 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 14 Aug 2018 09:22:28 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jbrouer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2018 11:17:30 +0800
Jason Wang <jasowang@redhat.com> wrote:

> This patch tries to add the support of XDP rx handler to
> virtio-net. This is straight-forward, just call xdp_do_pass() and
> behave depends on its return value.
> 
> Test was done by using XDP_DROP (xdp1) for macvlan on top of
> virtio-net. PPS of SKB mode was ~1.2Mpps while PPS of native XDP mode
> was ~2.2Mpps. About 83% improvement was measured.

I'm not convinced...

Why are you not using XDP_REDIRECT, which is already implemented in
receive_mergeable (which you modify below).

The macvlan driver just need to implement ndo_xdp_xmit(), and then you
can redirect (with XDP prog from physical driver into the guest).  It
should be much faster...


> Notes: for RFC, only mergeable buffer case was implemented.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 62311dd..1e22ad9 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -777,6 +777,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  	rcu_read_lock();
>  	xdp_prog = rcu_dereference(rq->xdp_prog);
>  	if (xdp_prog) {
> +		rx_xdp_handler_result_t ret;
>  		struct xdp_frame *xdpf;
>  		struct page *xdp_page;
>  		struct xdp_buff xdp;
> @@ -825,6 +826,15 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  
>  		switch (act) {
>  		case XDP_PASS:
> +			ret = xdp_do_pass(&xdp);
> +			if (ret == RX_XDP_HANDLER_DROP)
> +				goto drop;
> +			if (ret != RX_XDP_HANDLER_FALLBACK) {
> +				if (unlikely(xdp_page != page))
> +					put_page(page);
> +				rcu_read_unlock();
> +				goto xdp_xmit;
> +			}
>  			/* recalculate offset to account for any header
>  			 * adjustments. Note other cases do not build an
>  			 * skb and avoid using offset
> @@ -881,6 +891,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		case XDP_ABORTED:
>  			trace_xdp_exception(vi->dev, xdp_prog, act);
>  			/* fall through */
> +drop:
>  		case XDP_DROP:
>  			if (unlikely(xdp_page != page))
>  				__free_pages(xdp_page, 0);



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
