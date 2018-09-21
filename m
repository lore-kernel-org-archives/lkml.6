Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CB3ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAC72086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="WU8mBRIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAC72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389550AbeIUPGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:06:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44429 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIUPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:06:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so10138342edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7qp8I2J9cN2HrlPxm/AXMT+FJnXPh+bXknrDhTD6lcw=;
        b=WU8mBRIbJkzVmjPokzWzIRTmPGSdrkEfhH7B7srTJox3iDaM9Jt4j5WugjKJN3SwEk
         py5h1n4LtJYYka0sIUny7Ju0pJJrLatxXfv2hFTWjdElAdPK2kPeBmdWQc4xcYO0SOUC
         1/cLCz6r51jQTkpJlBPXE31sBA7cB9tFRD69k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=7qp8I2J9cN2HrlPxm/AXMT+FJnXPh+bXknrDhTD6lcw=;
        b=FcEbwMmwNV2YC+8Wvhe1PN/qx0k/4rKnsMOSZCgYs94/Zn8I7VUbkByPcOfkxUlZ/+
         OwSzPHs1YbXGkGyaz3uz3BET92wHkuyqhrA+t63TCrlnGSkn8PbO4N4UV7mtiFKDWL/O
         lDwjT/P3gEUry07VshBP0hqSnpvbBGC4HGq74IugJ+9e+ANqS6owiMWL/m+IiS5zBDTi
         v4xaej0s6QMGFm3qjx9xhoAqv0fQ/yuS42+KqjuydDOJVBr8L4EUAK61b6ZUbcv70RBv
         JqljF5kl7SBFCe/VGM41EFvI5nwR7ddF93ff4fcOKTDEAPbPxp86kKVVqlZh/yMM8Vrs
         Dfig==
X-Gm-Message-State: APzg51AhydSEJ/KTLX4/SWw4+7XUXz2qz81TujPeWR6nXLlHToWmutHX
        WI86M3gTKGwjUDsf9z5foTDKAA==
X-Google-Smtp-Source: ANB0VdYeTCVYdxShWNHioj9SlAvLTr4iSPnNH1QgjsvAN1Xy9j1aVPDV7r4NlA2gYTTUAU/5Mg/91g==
X-Received: by 2002:a50:a105:: with SMTP id 5-v6mr7100286edj.186.1537521513519;
        Fri, 21 Sep 2018 02:18:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a19-v6sm2534316edd.69.2018.09.21.02.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 02:18:32 -0700 (PDT)
Date:   Fri, 21 Sep 2018 11:18:30 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eric Engestrom <eric.engestrom@intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/fourcc: rename Intel modifiers to follow the
 naming convention
Message-ID: <20180921091830.GA11082@phenom.ffwll.local>
Mail-Followup-To: Eric Engestrom <eric.engestrom@intel.com>,
        dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20180918172217.18754-1-eric.engestrom@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918172217.18754-1-eric.engestrom@intel.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 06:21:59PM +0100, Eric Engestrom wrote:
> All the other vendors use the format
> DRM_FORMAT_MOD_{SAMSUNG,QCOM,VIVANTE,NVIDIA,BROADCOM,ARM}_* for their
> modifiers, except Intel.
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Eric Engestrom <eric.engestrom@intel.com>

I think it'd be good to add why you want this (easier to parse in tooling,
or something like that was what you said on irc). With that addressed,
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch> on both patches.

Probably best if you get i915 maintainers to merge both through drm-intel.
-Daniel
> ---
>  include/uapi/drm/drm_fourcc.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 139632b871816f9e3dad..170a562223387687592a 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -271,7 +271,8 @@ extern "C" {
>   * sharing. It exists since on a given platform it does uniquely identify the
>   * layout in a simple way for i915-specific userspace.
>   */
> -#define I915_FORMAT_MOD_X_TILED	fourcc_mod_code(INTEL, 1)
> +#define DRM_FORMAT_MOD_INTEL_X_TILED	fourcc_mod_code(INTEL, 1)
> +#define I915_FORMAT_MOD_X_TILED	DRM_FORMAT_MOD_INTEL_X_TILED
>  
>  /*
>   * Intel Y-tiling layout
> @@ -286,7 +287,8 @@ extern "C" {
>   * sharing. It exists since on a given platform it does uniquely identify the
>   * layout in a simple way for i915-specific userspace.
>   */
> -#define I915_FORMAT_MOD_Y_TILED	fourcc_mod_code(INTEL, 2)
> +#define DRM_FORMAT_MOD_INTEL_Y_TILED	fourcc_mod_code(INTEL, 2)
> +#define I915_FORMAT_MOD_Y_TILED	DRM_FORMAT_MOD_INTEL_Y_TILED
>  
>  /*
>   * Intel Yf-tiling layout
> @@ -301,7 +303,8 @@ extern "C" {
>   * 64 byte blocks of pixels contain four pixel rows of 16 bytes, where the width
>   * in pixel depends on the pixel depth.
>   */
> -#define I915_FORMAT_MOD_Yf_TILED fourcc_mod_code(INTEL, 3)
> +#define DRM_FORMAT_MOD_INTEL_Yf_TILED fourcc_mod_code(INTEL, 3)
> +#define I915_FORMAT_MOD_Yf_TILED DRM_FORMAT_MOD_INTEL_Yf_TILED
>  
>  /*
>   * Intel color control surface (CCS) for render compression
> @@ -320,8 +323,10 @@ extern "C" {
>   * But that fact is not relevant unless the memory is accessed
>   * directly.
>   */
> -#define I915_FORMAT_MOD_Y_TILED_CCS	fourcc_mod_code(INTEL, 4)
> -#define I915_FORMAT_MOD_Yf_TILED_CCS	fourcc_mod_code(INTEL, 5)
> +#define DRM_FORMAT_MOD_INTEL_Y_TILED_CCS	fourcc_mod_code(INTEL, 4)
> +#define I915_FORMAT_MOD_Y_TILED_CCS	DRM_FORMAT_MOD_INTEL_Y_TILED_CCS
> +#define DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS	fourcc_mod_code(INTEL, 5)
> +#define I915_FORMAT_MOD_Yf_TILED_CCS	DRM_FORMAT_MOD_INTEL_Yf_TILED_CCS
>  
>  /*
>   * Tiled, NV12MT, grouped in 64 (pixels) x 32 (lines) -sized macroblocks
> -- 
> Cheers,
>   Eric
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
