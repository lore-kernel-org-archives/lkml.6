Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F5C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C64216F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="X8xhIM9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C64216F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeHHKpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:45:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42286 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:45:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4-v6so827219edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJyiqdZic1VHnOsGJ+Itv6QwE/ryZ0YCv8sR4lPrkIs=;
        b=X8xhIM9LoF7zt7gNZ8OpLQpVrfbKejfYtjXbLisgjCqTdTp9kaXuoFLYbDb2o0+omu
         2kbp94eHIt5CeAkBl4FrM6ZnLaDXMX5mUhB9cw9AfO0sXsLQ3lhDNQ/9PABMevNT+Xko
         4+N4T37ULCu7/vrdQD03zpG5iBcxHrTvWExx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZJyiqdZic1VHnOsGJ+Itv6QwE/ryZ0YCv8sR4lPrkIs=;
        b=rbrhOOG216FCWxrqRiPOHURBhj4yt6fKatbof77upJQXmkjqxnQ3eAfMwxmfvwz6gu
         duP0Wpot9sNcnjnssvluC22v9Bp3i8B2zK17m0Bhj5eJ0SRCHGsYIdq/MvHz6EIeVlLH
         WNcCAJBqV8ls4zU5+cJp6l456O8dTRyei7LNY16o+tun1VtR/VgVExik170MwrC6VKse
         xLX96jrr5sSYzVy3lk+wAPGnltBAnoHu10Rwe94ZcsD64CkQsrrVCMUok5+H250tHcrJ
         2wPUWq3rnJiPVImT5mT9Bk82xn8MrTzF1tUDnydyXrgGSEoonRg0xWJY4f5eMGqhJ/Z8
         DdRQ==
X-Gm-Message-State: AOUpUlEvD1PflU6i5jnFYwVHfEh6EeIHxFhQsCzEkaWHUHYBU3r77NmU
        IdvDEsgZ51v8VL2R6BwedSPjyzDz3eg=
X-Google-Smtp-Source: AA+uWPwACfaav4dSjwONSZjU7vrLRPkvGxZo+DUEfibZOoL1JuSoF3VbLECFKf8OW7TdQ9tsqVb/AQ==
X-Received: by 2002:a50:d307:: with SMTP id g7-v6mr2156053edh.221.1533716819642;
        Wed, 08 Aug 2018 01:26:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56fc:0:d707:d7d8:b180:96e5])
        by smtp.gmail.com with ESMTPSA id w3-v6sm3721523edb.16.2018.08.08.01.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 01:26:59 -0700 (PDT)
Date:   Wed, 8 Aug 2018 10:26:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH] dma-buf: fix sanity check in dma_buf_export
Message-ID: <20180808082657.GJ3008@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
References: <20180808062540.13545-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808062540.13545-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 08:25:40AM +0200, Gerd Hoffmann wrote:
> Commit 09ea0dfbf972 made map_atomic and map function pointers optional,
> but didn't adapt the sanity check in dma_buf_export.  Fix that.
> 
> Note that the atomic map interface has been removed altogether meanwhile
> (commit f664a52695), therefore we have to remove the map check only.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Chris Wilson just submitted the exact same patch ...
-Daniel

> ---
>  drivers/dma-buf/dma-buf.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 13884474d1..02f7f9a899 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -405,7 +405,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  			  || !exp_info->ops->map_dma_buf
>  			  || !exp_info->ops->unmap_dma_buf
>  			  || !exp_info->ops->release
> -			  || !exp_info->ops->map
>  			  || !exp_info->ops->mmap)) {
>  		return ERR_PTR(-EINVAL);
>  	}
> -- 
> 2.9.3
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
