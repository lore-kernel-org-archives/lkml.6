Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B5EC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6018920865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="TwOhGWZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6018920865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbeIKMcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:32:42 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45719 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbeIKMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:32:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id p52-v6so18407511eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 00:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GQoWPqbfqOFb0F1rWXeI46EOiKsH46LnXSKEVSaW3Oo=;
        b=TwOhGWZijh92DhqY6h5dNEzNJ4fFNHtuoas3NxA3tJqQuHj32O6bKgL3eabcOqTAD9
         uwCQM1hvtihHFN5caK1U+8UOQyFDZ4J3apiTdasf/GY3MVpzX0oh0YFbmuA9dzv312DM
         kbFiEbkCs10KVOAXWtKOB9PLXMi3r9EGiXZC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=GQoWPqbfqOFb0F1rWXeI46EOiKsH46LnXSKEVSaW3Oo=;
        b=P6Ups7fqqjxz8wEKJZGwdhpbifXnDQwfz9w1a6yFh05KE0IHxGiiokQs0ihVWOk3WC
         6HIssWDpL7LAyKRKyKYM5vM/XYm2LUogpOk2odp/tHVW+7u0faERqj6EXhsMME8ZI8Go
         4CYGngmgrTJo2YuBDW/+t13uDQQV9+OPEPzjplnPSo/Kk+oSMZYcjgeq1AZkKCTgnVH8
         15DDMXzrOfQQ2IiddGCNts8zvWV2uKBHXqq+dMAXfnr+OG+9A74Utlsr6iYSUkqlf0eJ
         Wal0SwHKOChyC0V3d3Vh5MO8yrU+9HDZsJg9y6jhSuQb6KzB+LKpIoQAZK4lqKoYaegG
         I72Q==
X-Gm-Message-State: APzg51D7GieS3J/I6LqVYxdvJsZiPkS6oxFA/5LI4ffiMLBmxojxxSVA
        PYhHxNzkHvEpJukP1w+xZSXw1Q==
X-Google-Smtp-Source: ANB0VdZUQaLUTZMZNebE2Uo32SHbObAHHWFhv1oPv+DXZsdgWmyX+L165iYyPwNT6vlfWJoj03nhPA==
X-Received: by 2002:a50:a38a:: with SMTP id s10-v6mr25598214edb.99.1536651281557;
        Tue, 11 Sep 2018 00:34:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w20-v6sm18874627edc.12.2018.09.11.00.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 00:34:40 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:34:39 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH -next] drm: Remove set but not used variable 'config'
Message-ID: <20180911073438.GG19774@phenom.ffwll.local>
Mail-Followup-To: YueHaibing <yuehaibing@huawei.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <1536646814-186429-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536646814-186429-1-git-send-email-yuehaibing@huawei.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 06:20:14AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/drm_plane.c: In function 'drm_mode_getplane_res':
> drivers/gpu/drm/drm_plane.c:475:26: warning:
>  variable 'config' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
-Daniel
> ---
>  drivers/gpu/drm/drm_plane.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 36bf3fe..4a72c68 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -472,7 +472,6 @@ int drm_mode_getplane_res(struct drm_device *dev, void *data,
>  			  struct drm_file *file_priv)
>  {
>  	struct drm_mode_get_plane_res *plane_resp = data;
> -	struct drm_mode_config *config;
>  	struct drm_plane *plane;
>  	uint32_t __user *plane_ptr;
>  	int count = 0;
> @@ -480,7 +479,6 @@ int drm_mode_getplane_res(struct drm_device *dev, void *data,
>  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
>  		return -EINVAL;
>  
> -	config = &dev->mode_config;
>  	plane_ptr = u64_to_user_ptr(plane_resp->plane_id_ptr);
>  
>  	/*
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
