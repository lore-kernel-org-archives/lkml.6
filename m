Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C19AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D0E20855
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 16:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfBSQfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 11:35:38 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35665 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbfBSQfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 11:35:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id w204so55301qka.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 08:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rNyb0phHO/kxef0nUEvEr2Ys4/Fmw8H9FxCGItCtvGA=;
        b=QuO08/xkcs+2Knu02zozca1NNqTj0n/e27BQf87Xlh3NDNnQxSHQ0JDq89Rs1Pbv6j
         qxrL7hWIafIPk43/Gpb0qWS1cqok4Tt3vHL86AROuZpWWzM2A9psdzm39jPdmvE9YQwV
         efp9bWLUOxXnQwoXjuLmHY3qp7AfjoLEXBdheuv6AoPVVlKcIzaqd3Tty2QlWcN91CJJ
         WmuV03/HuB/dUyvpi6tg3yK+HuMPdo3q2Od+bPfe9STIKe8x+jH/tx/uBFk8M0G2rLBv
         3Bs/IOWfJaJuaM+hs5NxKsACE5iHXdCrC8ljkCvYV2xql+DleB6JvDklHsbQZ6GjGEDq
         Cq9g==
X-Gm-Message-State: AHQUAub6DfALlN8G2nNQCbVifcjhBUsHvc0ODYX3jKI1L30hLCZ9zfss
        VlUJGkmEIkzoxJ+Ic3xP6hSgtQ==
X-Google-Smtp-Source: AHgI3IbRMKTY5Xv4vJiPmdjUrnH8JrMhzWN2mYnXytiHTOpgz4V5XW95LLSa7CbThceTjXbJBBDlog==
X-Received: by 2002:a37:bc04:: with SMTP id m4mr5711560qkf.41.1550594137204;
        Tue, 19 Feb 2019 08:35:37 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id n1sm9900350qti.36.2019.02.19.08.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 08:35:36 -0800 (PST)
Date:   Tue, 19 Feb 2019 11:35:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] vhost: only return early if ret indicates an error
 or no iovecs have been processed
Message-ID: <20190219113510-mutt-send-email-mst@kernel.org>
References: <20190219135713.10426-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219135713.10426-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 01:57:13PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the loop that calls log_write_hva on each iovec is never
> executed because of an incorrect error check on the return from the
> call to translate_desc.  The check should be checking for a -ve error
> return and because it makes no sense to iterate over zero items, the
> checks should also check for zero too.
> 
> Detected by CoverityScan, CID#1476969 ("Logically dead code")
> 
> Fixes: cc5e71075947 ("vhost: log dirty page correctly")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Jason posted a similar patch recently.

Are you happy with that one?

> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 24a129fcdd61..a9a1709a859a 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1788,7 +1788,7 @@ static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
>  
>  	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
>  			     len, iov, 64, VHOST_ACCESS_WO);
> -	if (ret)
> +	if (ret <= 0)
>  		return ret;
>  
>  	for (i = 0; i < ret; i++) {
> -- 
> 2.20.1
