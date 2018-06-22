Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9E7C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83CB23EF8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="axZj/xM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83CB23EF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeFVIaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:30:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34707 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeFVI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:29:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id u25-v6so757766eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jn0S/FAHudF6Cdbfx42uUwmiIws+FjYRWGmIIrdyqTg=;
        b=axZj/xM8mPmIc3shEn/ozrMgUiwjGfNWanlcHftl10ygjZiSmq2gKtEuZ0cZTX1x2e
         T/nxBskTSc3XN5vB3ZUG2gNu7hLyGZ7wsWdo60LBl1t9PvuscEbSdugZEnI3Xe3DQhoa
         Hb3mbbsIsCDE66rCglgSovMrWOQwCTbW4P8Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Jn0S/FAHudF6Cdbfx42uUwmiIws+FjYRWGmIIrdyqTg=;
        b=FitQWMCxucDc7N5YbgQD/F5d3Mt+7xTmvE+72fY7lBVQjQisxmtlAN4aPowlGVWkqC
         OzXrkaF8QHjPih6bmoz5GlQt4f6cv9X1YEWUCVpYWAEVTNioaJhHiaeMg390nVJP5oyz
         Hp/09PyJ28VJA+CjWmns+QrSy4TPiTOI6atEidVrpQQH2ROKdJ9PT75l0EODezU7SLPt
         DxzGaBAcVVcu135qgGfPQgosQAna1Jg0iimzzO3uAI0NOzRsI6endfPGgMIjb7G9HDwp
         W/XX4bGRlsa+zvhj9lnSUVCfUuw0GH2k9Kw7qJm1RAzHfjcKzt5SdylNgX5Zs1F2Z6/+
         20qw==
X-Gm-Message-State: APt69E37eAP6K+Srq/9BMALWnWb+Nb+R/vfzttxeirTD2+YlHFfEj58w
        14C1FR5+6WoK9EQ5WCs5JayUKXpU
X-Google-Smtp-Source: ADUXVKL8wcEEXPe7DQwXEs4X09PsStMLkMdPEo3w8IrNbjzUQ9jak2jg864c/CZANZBlDi796AQaMA==
X-Received: by 2002:a50:c9c1:: with SMTP id c1-v6mr1032550edi.40.1529656197324;
        Fri, 22 Jun 2018 01:29:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id d11-v6sm2937764edh.61.2018.06.22.01.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 01:29:56 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:29:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Consider drivers setting DRIVER_ATOMIC as atomic.
Message-ID: <20180622082954.GF2958@phenom.ffwll.local>
Mail-Followup-To: Eric Anholt <eric@anholt.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180621195428.17447-1-eric@anholt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621195428.17447-1-eric@anholt.net>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 12:54:28PM -0700, Eric Anholt wrote:
> Drivers such as vc4 don't initialize mode_config.funcs until later in
> initialization, but we know they're atomic since they've got the flag
> set.  This avoids oopsing on dereferencing funcs in the new atomic
> methods sanity checks.
> 
> I moved the atomic check function down below the core flag check, to
> avoid needing a prototype.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> Fixes: ba1f665f161c ("drm: Add checks for atomic_[duplicate/destroy]_state with atomic drivers")

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

btw, dim fixes also generates Cc: tags for you (author/reviewer/maintainer
of the commit your fixing), besides just the Fixes: line.
-Daniel

> ---
>  include/drm/drmP.h | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index f5099c12c6a6..c5dfbdb7271d 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -97,6 +97,16 @@ struct pci_controller;
>  
>  #define DRM_IF_VERSION(maj, min) (maj << 16 | min)
>  
> +#define DRM_SWITCH_POWER_ON 0
> +#define DRM_SWITCH_POWER_OFF 1
> +#define DRM_SWITCH_POWER_CHANGING 2
> +#define DRM_SWITCH_POWER_DYNAMIC_OFF 3
> +
> +static inline bool drm_core_check_feature(struct drm_device *dev, int feature)
> +{
> +	return dev->driver->driver_features & feature;
> +}
> +
>  /**
>   * drm_drv_uses_atomic_modeset - check if the driver implements
>   * atomic_commit()
> @@ -107,17 +117,8 @@ struct pci_controller;
>   */
>  static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
>  {
> -	return dev->mode_config.funcs->atomic_commit != NULL;
> -}
> -
> -#define DRM_SWITCH_POWER_ON 0
> -#define DRM_SWITCH_POWER_OFF 1
> -#define DRM_SWITCH_POWER_CHANGING 2
> -#define DRM_SWITCH_POWER_DYNAMIC_OFF 3
> -
> -static inline bool drm_core_check_feature(struct drm_device *dev, int feature)
> -{
> -	return dev->driver->driver_features & feature;
> +	return drm_core_check_feature(dev, DRIVER_ATOMIC) ||
> +		dev->mode_config.funcs->atomic_commit != NULL;
>  }
>  
>  /* returns true if currently okay to sleep */
> -- 
> 2.18.0.rc2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
