Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216FAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B204C20833
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 08:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IITSHWBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B204C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbeKARcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 13:32:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37328 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeKARcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 13:32:09 -0400
Received: by mail-ed1-f66.google.com with SMTP id u12-v6so13013058eds.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/J12Bw/Qsfna16g+PFOdV+6ud+rYvff1d2xZWlM+Igw=;
        b=IITSHWBLMflN9Q2R1hMUK/xqZMkPt/6Bi4AOM9zA1/HDTwFOCKTVu/+naLCH2ZDy7T
         X4A5noI2wrhhRqQYXOXnytZBZL8nJgNs+jXaKq8b4wFgDnVh15n174U5QZja9IG8NBR4
         4NAq/s5jnUDIOI5cMBRjExBlM6So6kY3h/0fM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/J12Bw/Qsfna16g+PFOdV+6ud+rYvff1d2xZWlM+Igw=;
        b=GrGGi1auRhzln8GBZAn6hYz7syDCsLUOvjkG6iRWKFkK4CPyhLCgaQWVg5BJ3Mg02l
         nD4t9FFdN+GJkdBpr+iLSZbtPbUs6ZC7zdWkAneRhrkRm2vYMpn3fewQNWNj13+0JFRR
         aWiqEhhZ0qfUnVPhmvdOEr67OLktaV80pvsT0ODMCuCVjXbvnznWFxftSfk7XO/VeNYX
         uBlAWeoRASjQGc/Q2JIVEFll8tYB6Nr608AkOGg/la+W4+H6vXuSRmC85tkBNyTLlgn6
         vXkPBxY5A4ZW7/UMTBVhRYtTBZJJVuHCAL+lPka6hubDZ1RDLqMKs/o9IxHKQrierdUk
         5zdQ==
X-Gm-Message-State: AGRZ1gI7mPBq0NhAwW8H3iL5L22gUroxvdXnk5qhdZ84+99eHmSKDPMT
        6EK8zaA+eFVj9cIqEAOPYbJRrHnXrCQ=
X-Google-Smtp-Source: AJdET5chZhln48kh+c7wL7nluZIPzI6fhnniL5HKGHPqBQLUes5Ystndn+ggSm5mHiG+Wh7XmhIaOA==
X-Received: by 2002:a50:8636:: with SMTP id o51-v6mr4402528edo.209.1541061008616;
        Thu, 01 Nov 2018 01:30:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d11-v6sm54092ejl.7.2018.11.01.01.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 01:30:07 -0700 (PDT)
Date:   Thu, 1 Nov 2018 09:30:05 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH v2] drm: Remove 80-column line in
 drm_mode_object.c
Message-ID: <20181101083005.GX21967@phenom.ffwll.local>
Mail-Followup-To: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <20181031174424.odljb6obj25wm47d@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031174424.odljb6obj25wm47d@smtp.gmail.com>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 02:44:24PM -0300, Shayenne da Luz Moura wrote:
> Break line after NULL to decrease the line size.
> 
> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> 
> ---
> Changes in v2:
>   - Remove aditional variable added in v1 and add a line break

Applied, thanks.
-Daniel

> 
>  drivers/gpu/drm/drm_mode_object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
> index be8b754eaf60..cd9bc0ce9be0 100644
> --- a/drivers/gpu/drm/drm_mode_object.c
> +++ b/drivers/gpu/drm/drm_mode_object.c
> @@ -38,7 +38,8 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
>  	int ret;
>  
>  	mutex_lock(&dev->mode_config.idr_mutex);
> -	ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL, 1, 0, GFP_KERNEL);
> +	ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL,
> +			1, 0, GFP_KERNEL);
>  	if (ret >= 0) {
>  		/*
>  		 * Set up the object linking under the protection of the idr
> -- 
> 2.19.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20181031174424.odljb6obj25wm47d%40smtp.gmail.com.
> For more options, visit https://groups.google.com/d/optout.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
