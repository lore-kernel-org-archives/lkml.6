Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66611C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD9620882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="E+bsULlF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD9620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeILSdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:33:53 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38203 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeILSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:33:53 -0400
Received: by mail-yb1-f196.google.com with SMTP id e18-v6so1412314ybq.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J8qZ/GohhHiQXBXKWRb+V0ItqCEdEnCXKUH/PNVulEg=;
        b=E+bsULlF8HisALMcGqGa8kXkUuLfW0/K3SueTIkGj/+j3cd553ENBWA3fCxpCPC1/I
         RojW2cFeXZz9phuFA2YtTsM3qHSPEIOK1EiiXiFZa/7LleMTNXoG0hLKGvy5yPeemsKF
         H2Ake6z274ejL6YG06gQ5XItDxvq9FnLrr0DLNQg7sgQSd0VtU1slRoxI4KVN2zPlxni
         s2s3iG9r4JPjWYwDzoB+DjANNKx+/Iq1f1az+oRYp+Zc0/vhDQrimHz/kKLk7/kAYzZG
         eet/T7VSRmE/09FdFO7k6dQPcbWH+PauoQMrx3wthJBAPrvLjgN2GL8n3dFtkpzR8pFx
         auRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J8qZ/GohhHiQXBXKWRb+V0ItqCEdEnCXKUH/PNVulEg=;
        b=orL56bDpzWcCKmBOT9WNwpROVrhyJGIyBJFp4+E+Q7hFUH/4/nmW9kcyb5JPPhTaTF
         jlR3QtkNtoy9ui4S/siQhSeFWXF1b9b8qbEcUtfi73LwOB89/OBHumw3fZvcAGcmxCzL
         VNuZUOTOn4oi5JKMft8vq+GYJQrcjsp/01klCuuUpkprGKrJBAL2/cGT54x2VBVKwZ1y
         ZjEVeI7sJy84jIcmL27JjRPBOe6gYoMlMJu74GPpdS/tkwCHTT0e3Sr6Znpm4MGjkWb1
         5L97WOUpbmJKMe0rn+YF45w0//rhRj7C2yigupE56blp/WD73Tc7s+ozjZufwqRwq4tT
         Svaw==
X-Gm-Message-State: APzg51B3c7KqrKWpczp6nG8WgT98judAR7aLIMYrsJVENbkLHcnNNQaI
        +tMoGOFLqT/tIsVzTVETtv5/9w==
X-Google-Smtp-Source: ANB0VdZ7oxSn/f/2O8p3eabhcJ+LJE+B9Xrmixs1N7qw8zDQmVCacXAUr4F5Vm91jizqsH8N9xLy+w==
X-Received: by 2002:a5b:2c1:: with SMTP id h1-v6mr881468ybp.476.1536758961501;
        Wed, 12 Sep 2018 06:29:21 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id r84-v6sm323645ywe.10.2018.09.12.06.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 06:29:21 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:29:20 -0400
From:   Sean Paul <sean@poorly.run>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/fb-helper: Remove set but not used variable
 'connector_funcs'
Message-ID: <20180912132920.GJ188300@art_vandelay>
References: <1536722130-108819-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536722130-108819-1-git-send-email-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:15:30AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/drm_fb_helper.c: In function 'drm_pick_crtcs':
> drivers/gpu/drm/drm_fb_helper.c:2373:43: warning:
>  variable 'connector_funcs' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for your patch, applied to -misc-fixes

Sean

> ---
>  drivers/gpu/drm/drm_fb_helper.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> index 73cf10a..16e3a59 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -2370,7 +2370,6 @@ static int drm_pick_crtcs(struct drm_fb_helper *fb_helper,
>  {
>  	int c, o;
>  	struct drm_connector *connector;
> -	const struct drm_connector_helper_funcs *connector_funcs;
>  	int my_score, best_score, score;
>  	struct drm_fb_helper_crtc **crtcs, *crtc;
>  	struct drm_fb_helper_connector *fb_helper_conn;
> @@ -2399,8 +2398,6 @@ static int drm_pick_crtcs(struct drm_fb_helper *fb_helper,
>  	if (drm_has_preferred_mode(fb_helper_conn, width, height))
>  		my_score++;
>  
> -	connector_funcs = connector->helper_private;
> -
>  	/*
>  	 * select a crtc for this connector and then attempt to configure
>  	 * remaining connectors
> 
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
