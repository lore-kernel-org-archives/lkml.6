Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD521C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF6A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aoDuywxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfAUJd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:33:28 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32921 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfAUJd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:33:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id p6so16069759eds.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJJmz1F33uDUMdkUhN2i1lu9e9r2W3zTHmnCrEgEfgE=;
        b=aoDuywxm36siEX5jtExL4YXSDt9wtFIXrhn0PHxmLMDeArOc4141fZpsLLxDTLHKKg
         xVSn7zz2lXXGjAcUMhCzL/rU7ZgUkFjrCF1qs4holcLY29UptQD8CARgYq7vxRo80ymy
         k2vCyRFZOU04ReQcy7z2jb22mz/nMPcn83v6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=vJJmz1F33uDUMdkUhN2i1lu9e9r2W3zTHmnCrEgEfgE=;
        b=jvQoU5F/04fcJkjlBQx9gV6kCfrwV8M+2BQr25Rl5xuzaPj8fwg9Ef2n+reEU7lJtP
         icuTg1xmXJO3MepDVSzTbkeaa8SzIDmVo0TZZpkRllz4OZ36bybTXPa6Yb1RIP0/9GvI
         QNAzU03lZA/6DMbI3BdRJDhw47GKIT1pMBUka0T9JgvDOC49VAPth5Xosl84E9PM+9eJ
         oAoaOAov7OiBwl+X5oGYY8+Vc2XvL9I1KwpByeFeqARh5RZouuPd9HtlyT1rKaHXcf2t
         5c17Mqm7W4EXla4NY69CEhOCl6mAnZwAe9OOBklhtKrgSR7jNo2DbC0g5vkAXfugRg2H
         RoTA==
X-Gm-Message-State: AJcUukcjtXe1vKaZwjlWOAy8mFlPpJhC1JP+b53k6JIuSUx28EfgbnUY
        SvyTVQghybxE9AqS2GB1yHQznZskVtE=
X-Google-Smtp-Source: ALg8bN4prQsXk21dEc704x8byi2xuCRygyRQms2I92rzi13aVUfXugdHMY8UKT7KyKe+y6UQlVBsmQ==
X-Received: by 2002:a17:906:f146:: with SMTP id gw6mr736903ejb.176.1548063206291;
        Mon, 21 Jan 2019 01:33:26 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b45sm8980515eda.34.2019.01.21.01.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 01:33:25 -0800 (PST)
Date:   Mon, 21 Jan 2019 10:33:23 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] drm/bridge: lvds-encoder: remove surplus NULL checks
Message-ID: <20190121093323.GP3271@phenom.ffwll.local>
Mail-Followup-To: Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <be258481-b3e4-8051-abb2-ca430ecc2836@samsung.com>
 <20190118231129.8281-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118231129.8281-1-peda@axentia.se>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:11:38PM +0000, Peter Rosin wrote:
> The gpio API explicitly allows skipping the NULL check, precisely to
> allow for neat support for optional gpios. Which is exactly what is at
> play here.
> 
> Reported-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Peter Rosin <peda@axentia.se>

lgtm, Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

btw plan to stick around a bit in drm land, i.e. want commit rights for
drm-misc?
-Daniel

> ---
>  drivers/gpu/drm/bridge/lvds-encoder.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
> index 36d8557bc097..584007eaf6e1 100644
> --- a/drivers/gpu/drm/bridge/lvds-encoder.c
> +++ b/drivers/gpu/drm/bridge/lvds-encoder.c
> @@ -36,8 +36,7 @@ static void lvds_encoder_enable(struct drm_bridge *bridge)
>  							 struct lvds_encoder,
>  							 bridge);
>  
> -	if (lvds_encoder->powerdown_gpio)
> -		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 0);
> +	gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 0);
>  }
>  
>  static void lvds_encoder_disable(struct drm_bridge *bridge)
> @@ -46,8 +45,7 @@ static void lvds_encoder_disable(struct drm_bridge *bridge)
>  							 struct lvds_encoder,
>  							 bridge);
>  
> -	if (lvds_encoder->powerdown_gpio)
> -		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 1);
> +	gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 1);
>  }
>  
>  static struct drm_bridge_funcs funcs = {
> -- 
> 2.11.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
