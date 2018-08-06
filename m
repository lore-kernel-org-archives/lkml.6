Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E534C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE1B219E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="i3j6l3gV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE1B219E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeHFKrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:47:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46434 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHFKrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:47:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id o8-v6so4718480edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KvZ2rQrBfvE1jRF1chd3Ge/9IAkQCD+b8XTWZVZMKqI=;
        b=i3j6l3gVGV7LWmIX0qa5gj47iRlsn6ieJ4Rr4ydGKH9y83lVwFv0VSUtCJ2PjJgTue
         nKA0F+oJO5mKM0Xq+3MIzRt9lY9UNSfVO5XMAhhOIkc2oDU30+lYUOQ9wicxBov7KX49
         mIuVH1SuyCzmh4XFf7IMuh6g7nmmJR1UhAwvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KvZ2rQrBfvE1jRF1chd3Ge/9IAkQCD+b8XTWZVZMKqI=;
        b=QKuSca9Fgt1r/4MOA826KvuCuIZf3NsNbUyWfWB5LBpOR/ay6nkQc0avGHr938gOUi
         2VmTYMnRd4RpYqm2AFh9ICaSbL55B0dOox5C77Od33laJPk+r6fNBN42Gh2ujmnTyDjG
         Ov9xuKDrMNEnmm6mljIqJbQDHmdZo8731vkUkO7G/5+xClsrD2dzbODTcWOhmUTEmdyx
         oUwVr+r3N5dqKtLZoiJWVuQRDWfbErojU8yDMBk4fHkD3t9I31G3/mkYQdevpMjZcxnq
         15bgEyVV58qxj6S8OrLIf7iLNh1Zc1nH8YUViqQi0YFDVurNd5n244IzsVS9jm/A6Q8w
         +CbQ==
X-Gm-Message-State: AOUpUlGOUesZqqRIpPqhhxK28ZiO8k07lKMEdMuIRIrXkOY19gnMIaOl
        ffbHuEYDtH0ckEwsOoikET4o8Q==
X-Google-Smtp-Source: AAOMgpfCe+prjuxleY4cxmrKrS7ByDupPkJue/LAYk6R+4szVXbzAO/mU/qYTnQXkjKYaZYoGoldcA==
X-Received: by 2002:a50:9286:: with SMTP id k6-v6mr17434128eda.66.1533544774232;
        Mon, 06 Aug 2018 01:39:34 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:56fc:0:d707:d7d8:b180:96e5])
        by smtp.gmail.com with ESMTPSA id i3-v6sm4855407edt.42.2018.08.06.01.39.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 01:39:32 -0700 (PDT)
Date:   Mon, 6 Aug 2018 10:39:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Remove drm_fbdev_cma_set_suspend()
Message-ID: <20180806083930.GJ3008@phenom.ffwll.local>
Mail-Followup-To: Souptick Joarder <jrdr.linux@gmail.com>,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180730192326.GA31354@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730192326.GA31354@jordon-HP-15-Notebook-PC>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:53:26AM +0530, Souptick Joarder wrote:
> drm_fbdev_cma_set_suspend() is not getting called from
> any other places. If there is no plan to use it in future
> we can remove this API.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

cma version of fbdev helpers are indeed getting subsumed by fbdev helpers
at large, so this makes sense I think.

Applied for 4.20, thanks for your patch.
-Daniel
> ---
>  drivers/gpu/drm/drm_fb_cma_helper.c | 15 ---------------
>  include/drm/drm_fb_cma_helper.h     |  1 -
>  2 files changed, 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_fb_cma_helper.c b/drivers/gpu/drm/drm_fb_cma_helper.c
> index 186d00a..4c283d9 100644
> --- a/drivers/gpu/drm/drm_fb_cma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_cma_helper.c
> @@ -516,21 +516,6 @@ void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma)
>  EXPORT_SYMBOL_GPL(drm_fbdev_cma_hotplug_event);
>  
>  /**
> - * drm_fbdev_cma_set_suspend - wrapper around drm_fb_helper_set_suspend
> - * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> - * @state: desired state, zero to resume, non-zero to suspend
> - *
> - * Calls drm_fb_helper_set_suspend, which is a wrapper around
> - * fb_set_suspend implemented by fbdev core.
> - */
> -void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state)
> -{
> -	if (fbdev_cma)
> -		drm_fb_helper_set_suspend(&fbdev_cma->fb_helper, state);
> -}
> -EXPORT_SYMBOL(drm_fbdev_cma_set_suspend);
> -
> -/**
>   * drm_fbdev_cma_set_suspend_unlocked - wrapper around
>   *                                      drm_fb_helper_set_suspend_unlocked
>   * @fbdev_cma: The drm_fbdev_cma struct, may be NULL
> diff --git a/include/drm/drm_fb_cma_helper.h b/include/drm/drm_fb_cma_helper.h
> index d532f88a..52f09dc 100644
> --- a/include/drm/drm_fb_cma_helper.h
> +++ b/include/drm/drm_fb_cma_helper.h
> @@ -32,7 +32,6 @@ struct drm_fbdev_cma *drm_fbdev_cma_init(struct drm_device *dev,
>  
>  void drm_fbdev_cma_restore_mode(struct drm_fbdev_cma *fbdev_cma);
>  void drm_fbdev_cma_hotplug_event(struct drm_fbdev_cma *fbdev_cma);
> -void drm_fbdev_cma_set_suspend(struct drm_fbdev_cma *fbdev_cma, bool state);
>  void drm_fbdev_cma_set_suspend_unlocked(struct drm_fbdev_cma *fbdev_cma,
>  					bool state);
>  
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
