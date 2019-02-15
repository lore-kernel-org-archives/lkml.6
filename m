Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75273C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7FE2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390940AbfBOWAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:00:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41449 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbfBOWAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:00:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id u188so6631535qkh.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DvfEVQuzN4hFXKlkv8lR/BAs8Y6HS7QftF00vIpNslw=;
        b=oon3oZXSSpRQc2SVhYtBGv3aj6zJFazF3wNqbkxPo3FAxx/RvsfG0Cf57qX7JZ9LTN
         kwiBX25BOhaLCXOF48CeVF0lD2SZu9/faLoaYmSbx1VpmarVTbT73opP26GL8wONiFtI
         IOFu0rbSZKUduUaZ5mqhJr0WUsvlAjyMG4Xy8Nc/FfdmdxY1yOkOTSaYsEqBkzD++1t8
         NOJpKCN+YyvWeOxEVce2Td7uhZzOxyynGg1KIy3zSvnAt5Q+9kszucDdYIILCDwR6Qjs
         El+Tsr3NwGHZGk3AMeybnC9rBD+BHda2CU/OV4bHc3fW2BaJ6dwAo3+WyUzl8r7LZayQ
         F20g==
X-Gm-Message-State: AHQUAuannxZ5+SOzOZmw6+LCmzT3WlD3hosO1Vx8kOSWeN2MwSP9veg7
        nGnkE7TVOL8yhYw1rRVXnN6j2Q==
X-Google-Smtp-Source: AHgI3IazvKZjNkWcuRfH0SwccBI6tvx6YH2hxrgDQ8LldjsDIVVnBb+Bn184asJUY1zUaQO4EAw/uQ==
X-Received: by 2002:a37:4a83:: with SMTP id x125mr8688241qka.30.1550267998977;
        Fri, 15 Feb 2019 13:59:58 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id k5sm4132929qti.41.2019.02.15.13.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 13:59:58 -0800 (PST)
Date:   Fri, 15 Feb 2019 16:59:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stephen@networkplumber.org
Subject: Re: [PATCH net] vhost: correctly check the return value of
 translate_desc() in log_used()
Message-ID: <20190215165929-mutt-send-email-mst@kernel.org>
References: <20190215075324.18891-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215075324.18891-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 03:53:24PM +0800, Jason Wang wrote:
> When fail, translate_desc() returns negative value, otherwise the
> number of iovs. So we should fail when the return value is negative
> instead of a blindly check against zero.
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Fixes: cc5e71075947 ("vhost: log dirty page correctly")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

and I guess the log was backported to stable so we want
this backported too.

> ---
>  drivers/vhost/vhost.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 24a129fcdd61..a2e5dc7716e2 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1788,7 +1788,7 @@ static int log_used(struct vhost_virtqueue *vq, u64 used_offset, u64 len)
>  
>  	ret = translate_desc(vq, (uintptr_t)vq->used + used_offset,
>  			     len, iov, 64, VHOST_ACCESS_WO);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
>  	for (i = 0; i < ret; i++) {
> -- 
> 2.17.1
