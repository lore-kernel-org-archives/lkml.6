Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B74C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB852087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Tn+Ev8WF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB852087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeJKQNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:13:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32885 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeJKQNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:13:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id h13-v6so7495562edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KrFHgN+zTRoxLaLuCikdWePibg4bnQ3nmPaM3Af8G9s=;
        b=Tn+Ev8WFcyMzgYmEB6TklOOqrIMHYHfSQSWsAPdxScFNkXUBp2eRbmU9kbGXdChLAr
         khIIkJxMtpzUxORwJfWu7YakCRed1UCbhI3SCtER2oO9RCOErESs3tbF53vmRjsDYmQF
         CC77b9zaNr2C2o3v8rtez3/giDPDZsteAgcLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KrFHgN+zTRoxLaLuCikdWePibg4bnQ3nmPaM3Af8G9s=;
        b=IVzgxrv8ai+eu+ZrjvLzgRQWRoVReV173mOEVee+UvSkVGmEHFnt1zXHsiVwBtiVMo
         i/86bO5dBOZZb/VyE8rjmfRZiIynKN+5DG/3b4frqabkV8Z+4vRfkS7OTjWloVnF1h3V
         lSf2SOCTCFI2qF53HTx6NCMiSebfuiQB53IYaspl09BoKkXRAGMjRPxieXrzZhI6FlV1
         2VHStwToVit+KcKZioQ8MF6R3xRzFFADlXG5ynPCJMGNV6/7oMELc8AsxgcYaPeGGOYJ
         6R1R8bvV+2M1igFXPJbg4A8ki1xhotc2A3AzptoLPHom4kNkhTmfxm3A+nqprZaW623v
         Wq9g==
X-Gm-Message-State: ABuFfojE4nDv8fmbzO9ZqgceeQCFPnyxqLqzfq9n4BCeRJTmImhX3sBZ
        T/QMQ+JI683PbmEQ3uPzQAfqFQ==
X-Google-Smtp-Source: ACcGV603YlIoS8CQ+EMFmjmXtboq77wEBJP9kGTWwGuSneHVzrKHwzef+uEk/mB50ggiFeuLp90REg==
X-Received: by 2002:a17:906:1e45:: with SMTP id i5-v6mr1216196ejj.146.1539247615484;
        Thu, 11 Oct 2018 01:46:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b36-v6sm8999421edb.5.2018.10.11.01.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 01:46:54 -0700 (PDT)
Date:   Thu, 11 Oct 2018 10:46:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm: Use PTR_ERR_OR_ZERO in drm_fb_cma_fbdev_init()
Message-ID: <20181011084652.GZ31561@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <1539176563-144779-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539176563-144779-1-git-send-email-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 01:02:43PM +0000, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/drm_fb_cma_helper.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index fb0dfc6..30741eb 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -124,10 +124,7 @@ int drm_fb_cma_fbdev_init(struct drm_device *dev, unsigned int preferred_bpp,
>  
>  	/* dev->fb_helper will indirectly point to fbdev_cma after this call */
>  	fbdev_cma = drm_fbdev_cma_init(dev, preferred_bpp, max_conn_count);
> -	if (IS_ERR(fbdev_cma))
> -		return PTR_ERR(fbdev_cma);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(fbdev_cma);
>  }
>  EXPORT_SYMBOL_GPL(drm_fb_cma_fbdev_init);
>  
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
