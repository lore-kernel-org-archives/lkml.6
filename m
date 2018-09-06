Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9E3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FD520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 17:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FD520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeIFWYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 18:24:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbeIFWYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 18:24:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D53E40241E9;
        Thu,  6 Sep 2018 17:48:10 +0000 (UTC)
Received: from redhat.com (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with SMTP id 23C842166B41;
        Thu,  6 Sep 2018 17:48:10 +0000 (UTC)
Date:   Thu, 6 Sep 2018 13:48:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH net-next 07/11] tuntap: move XDP flushing out of
 tun_do_xdp()
Message-ID: <20180906132209-mutt-send-email-mst@kernel.org>
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-8-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906040526.22518-8-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 17:48:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 06 Sep 2018 17:48:10 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mst@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 12:05:22PM +0800, Jason Wang wrote:
> This will allow adding batch flushing on top.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/tun.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 21b125020b3b..ff1cbf3ebd50 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1646,7 +1646,6 @@ static u32 tun_do_xdp(struct tun_struct *tun,
>  	switch (act) {
>  	case XDP_REDIRECT:
>  		*err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
> -		xdp_do_flush_map();
>  		if (*err)
>  			break;
>  		goto out;
> @@ -1735,6 +1734,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>  		act = tun_do_xdp(tun, tfile, xdp_prog, &xdp, &err);
>  		if (err)
>  			goto err_xdp;
> +
> +		if (act == XDP_REDIRECT)
> +			xdp_do_flush_map();
>  		if (act != XDP_PASS)
>  			goto out;

At this point the switch statement which used to contain all XDP things
seems to be gone completely. Just rewrite with a bunch of if statements
and all xdp handling spread out to where it makes sense?

> -- 
> 2.17.1
