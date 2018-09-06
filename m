Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04BEC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8667B2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8667B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeIFV6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:58:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbeIFV6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:58:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 280378077104;
        Thu,  6 Sep 2018 17:21:47 +0000 (UTC)
Received: from redhat.com (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with SMTP id CA13F10073DD;
        Thu,  6 Sep 2018 17:21:46 +0000 (UTC)
Date:   Thu, 6 Sep 2018 13:21:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next 06/11] tuntap: split out XDP logic
Message-ID: <20180906131703-mutt-send-email-mst@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-7-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-7-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 17:21:47 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 06 Sep 2018 17:21:47 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 12:05:21PM +0800, Jason Wang wrote:
> This patch split out XDP logic into a single function. This make it to
> be reused by XDP batching path in the following patch.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/tun.c | 84 ++++++++++++++++++++++++++++-------------------
>  1 file changed, 51 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 389aa0727cc6..21b125020b3b 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1635,6 +1635,44 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
>  	return true;
>  }
>  
> +static u32 tun_do_xdp(struct tun_struct *tun,
> +		      struct tun_file *tfile,
> +		      struct bpf_prog *xdp_prog,
> +		      struct xdp_buff *xdp,
> +		      int *err)
> +{
> +	u32 act = bpf_prog_run_xdp(xdp_prog, xdp);
> +
> +	switch (act) {
> +	case XDP_REDIRECT:
> +		*err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
> +		xdp_do_flush_map();
> +		if (*err)
> +			break;
> +		goto out;
> +	case XDP_TX:
> +		*err = tun_xdp_tx(tun->dev, xdp);
> +		if (*err < 0)
> +			break;
> +		*err = 0;
> +		goto out;
> +	case XDP_PASS:
> +		goto out;

Do we need goto? why not just return?

> +	default:
> +		bpf_warn_invalid_xdp_action(act);
> +		/* fall through */
> +	case XDP_ABORTED:
> +		trace_xdp_exception(tun->dev, xdp_prog, act);
> +		/* fall through */
> +	case XDP_DROP:
> +		break;
> +	}
> +
> +	put_page(virt_to_head_page(xdp->data_hard_start));

put here because caller does get_page :( Not pretty.
I'd move this out to the caller.

> +out:
> +	return act;

How about combining err and act? err is < 0 XDP_PASS is > 0.
No need for pointers then.

> +}
> +
>  static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  				     struct tun_file *tfile,
>  				     struct iov_iter *from,
> @@ -1645,10 +1683,10 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	struct sk_buff *skb = NULL;
>  	struct bpf_prog *xdp_prog;
>  	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> -	unsigned int delta = 0;
>  	char *buf;
>  	size_t copied;
> -	int err, pad = TUN_RX_PAD;
> +	int pad = TUN_RX_PAD;
> +	int err = 0;
>  
>  	rcu_read_lock();
>  	xdp_prog = rcu_dereference(tun->xdp_prog);
> @@ -1685,9 +1723,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  	local_bh_disable();
>  	rcu_read_lock();
>  	xdp_prog = rcu_dereference(tun->xdp_prog);
> -	if (xdp_prog && !*skb_xdp) {
> +	if (xdp_prog) {
>  		struct xdp_buff xdp;
> -		void *orig_data;
>  		u32 act;
>  
>  		xdp.data_hard_start = buf;
> @@ -1695,33 +1732,14 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  		xdp_set_data_meta_invalid(&xdp);
>  		xdp.data_end = xdp.data + len;
>  		xdp.rxq = &tfile->xdp_rxq;
> -		orig_data = xdp.data;
> -		act = bpf_prog_run_xdp(xdp_prog, &xdp);
> -
> -		switch (act) {
> -		case XDP_REDIRECT:
> -			err = xdp_do_redirect(tun->dev, &xdp, xdp_prog);
> -			xdp_do_flush_map();
> -			if (err)
> -				goto err_xdp;
> -			goto out;
> -		case XDP_TX:
> -			if (tun_xdp_tx(tun->dev, &xdp) < 0)
> -				goto err_xdp;
> -			goto out;
> -		case XDP_PASS:
> -			delta = orig_data - xdp.data;
> -			len = xdp.data_end - xdp.data;
> -			break;
> -		default:
> -			bpf_warn_invalid_xdp_action(act);
> -			/* fall through */
> -		case XDP_ABORTED:
> -			trace_xdp_exception(tun->dev, xdp_prog, act);
> -			/* fall through */
> -		case XDP_DROP:
> +		act = tun_do_xdp(tun, tfile, xdp_prog, &xdp, &err);
> +		if (err)
>  			goto err_xdp;
> -		}
> +		if (act != XDP_PASS)
> +			goto out;

likely?

> +
> +		pad = xdp.data - xdp.data_hard_start;
> +		len = xdp.data_end - xdp.data;
>  	}
>  	rcu_read_unlock();
>  	local_bh_enable();
> @@ -1729,18 +1747,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  build:
>  	skb = build_skb(buf, buflen);
>  	if (!skb) {
> +		put_page(alloc_frag->page);
>  		skb = ERR_PTR(-ENOMEM);
>  		goto out;
>  	}
>  
> -	skb_reserve(skb, pad - delta);
> +	skb_reserve(skb, pad);
>  	skb_put(skb, len);
>  
>  	return skb;
>  
>  err_xdp:
> -	alloc_frag->offset -= buflen;
> -	put_page(alloc_frag->page);
> +	this_cpu_inc(tun->pcpu_stats->rx_dropped);


This fixes bug in previous patch which dropped it. OK :)

>  out:
>  	rcu_read_unlock();
>  	local_bh_enable();
> -- 
> 2.17.1
