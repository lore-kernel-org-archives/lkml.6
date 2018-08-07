Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E226AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1C12156E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hoe+iitN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D1C12156E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHGWeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:34:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45404 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbeHGWeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:34:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id s16-v6so170070edq.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wrLBrXmZd4GjfCdhgUNnOhUllhnHy2P+5JzJVe6pOlQ=;
        b=hoe+iitNtyYgxn2apfBhH/g5qL4OjQsaRCCykhkVH5id4N74Zb3SaCyRyihi4/wkaI
         XolvsCpCBQ9Mrr9Jk0ikjlK/VMM9BTjpHhZuDVSJxVb0kQV9z+ExyOYwZ+6+QFvMsX07
         si0sG5/8JDXfReev+/wVf82B+ZwKbVs8U+ljo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=wrLBrXmZd4GjfCdhgUNnOhUllhnHy2P+5JzJVe6pOlQ=;
        b=tlsxvzLVK6CZFWQTMzPCY6OR/gj7eieH0TtmPP6BWr+6aGY3Qz6LkgYg5vJsi7TE4G
         +O+tv6i/xX4mw1LsdKVnAC5Xsb/hil6Xq+oycCPA2q0lSzv3oxa9Fs7zD/XmGQxsyaLM
         C6u1DP6kLWRiw/bV6gBC9f4OI10fkWUfCzB+VafY5znw4HcorWdrW9HbWfNHKy9Rv1c7
         rvZS60Pac2hoOY0w6SXf4Znc3ttqYgRTlEvzaKlMD9ag3zk8Wwai7hF0DmjHd6raNxLf
         tpTypoH6WNnfSzSq/wyMzdeZdbAUz3WTATjCgeYa1Hje3/vOSUPT+VsmuY7f95raAt9O
         QwUw==
X-Gm-Message-State: AOUpUlHlQEDVxKbgT4qThfdns3iOIycaGk2SOGjsqV9v2Ixhr3PfqfJP
        qqpjtxQaL1sbTnMsob86HytS5GiakSE=
X-Google-Smtp-Source: AAOMgpcCi2lbEJH9pA7EUUmAuN+3ciL2nE6cIsyZB+SVLUcm0pNAQr/cXbz20NwqAjHPuGWgp6NHyA==
X-Received: by 2002:a50:d51d:: with SMTP id u29-v6mr23497832edi.51.1533673084120;
        Tue, 07 Aug 2018 13:18:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56fc:0:d707:d7d8:b180:96e5])
        by smtp.gmail.com with ESMTPSA id g14-v6sm979973edm.25.2018.08.07.13.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 13:18:03 -0700 (PDT)
Date:   Tue, 7 Aug 2018 22:18:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] drm/sun4i: Avoid failing to init fbdev without any
 connector
Message-ID: <20180807201801.GF3008@phenom.ffwll.local>
Mail-Followup-To: Paul Kocialkowski <contact@paulk.fr>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@googlegroups.com
References: <20180807193919.4800-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807193919.4800-1-contact@paulk.fr>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 09:39:19PM +0200, Paul Kocialkowski wrote:
> Initializing and registering fbdev requires at least one DRM connector
> and will fail otherwise. In order to support headless setups (for
> instance for GPU rendering with the GBM backend, where a DRI card node
> is required to provide GEM memory reservation), add a check on the
> number of registered connectors before initializing fbdev.

sun4i is a pure kms driver, why exactly do you need it for gbm backed
rendering? What exactly is rendering here, and why does it insist on a
display card node, even if that display card node is 100% defunct?
-Daniel

> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> index 5f29850ef8ac..19a265e4a93a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
> @@ -49,6 +49,8 @@ static struct drm_mode_config_helper_funcs sun4i_de_mode_config_helpers = {
>  
>  int sun4i_framebuffer_init(struct drm_device *drm)
>  {
> +	int ret;
> +
>  	drm_mode_config_reset(drm);
>  
>  	drm->mode_config.max_width = 8192;
> @@ -57,7 +59,13 @@ int sun4i_framebuffer_init(struct drm_device *drm)
>  	drm->mode_config.funcs = &sun4i_de_mode_config_funcs;
>  	drm->mode_config.helper_private = &sun4i_de_mode_config_helpers;
>  
> -	return drm_fb_cma_fbdev_init(drm, 32, 0);
> +	if (drm->mode_config.num_connector > 0) {
> +		ret = drm_fb_cma_fbdev_init(drm, 32, 0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  void sun4i_framebuffer_free(struct drm_device *drm)
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
