Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC8920652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC8920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbeIFVjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 17:39:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbeIFVjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 17:39:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33412DFF7;
        Thu,  6 Sep 2018 17:02:52 +0000 (UTC)
Received: from redhat.com (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with SMTP id D59D4FA973;
        Thu,  6 Sep 2018 17:02:51 +0000 (UTC)
Date:   Thu, 6 Sep 2018 13:02:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next 03/11] tuntap: enable bh early during processing
 XDP
Message-ID: <20180906130224-mutt-send-email-mst@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-4-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 06 Sep 2018 17:02:52 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 06 Sep 2018 17:02:52 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 12:05:18PM +0800, Jason Wang wrote:
> This patch move the bh enabling a little bit earlier, this will be
> used for factoring out the core XDP logic of tuntap.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

no reason to disable bh for non-xdp things.

> ---
>  drivers/net/tun.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index d3677a544b56..372caf7d67d9 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1726,22 +1726,18 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  			goto err_xdp;
>  		}
>  	}
> +	rcu_read_unlock();
> +	local_bh_enable();
>  
>  	skb = build_skb(buf, buflen);
> -	if (!skb) {
> -		rcu_read_unlock();
> -		local_bh_enable();
> +	if (!skb)
>  		return ERR_PTR(-ENOMEM);
> -	}
>  
>  	skb_reserve(skb, pad - delta);
>  	skb_put(skb, len);
>  	get_page(alloc_frag->page);
>  	alloc_frag->offset += buflen;
>  
> -	rcu_read_unlock();
> -	local_bh_enable();
> -
>  	return skb;
>  
>  err_redirect:
> -- 
> 2.17.1
