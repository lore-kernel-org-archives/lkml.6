Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5AAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB6F20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HGTHVe29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfAOMFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:05:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38923 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfAOMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 07:05:53 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so2337104edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 04:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDuwWfJNB9mmkh1ARkKSwShIeAUNpoUACq+csBUmYrE=;
        b=HGTHVe291CNUMEW6qahD9kVBrk15JQzuhPnDQqrgpjc1xCbrOpZ8hcJ4N2LTnwHAYB
         FehJmsEocKV6QHjw17GHVA9VFV8BeK/r+bufUEYcnV2lKk7bOqOz3M3gApx/d5Qjz8NB
         5e/kzaqE1rrAFCCKv8twmUDoG7QWr/nkeHI9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=QDuwWfJNB9mmkh1ARkKSwShIeAUNpoUACq+csBUmYrE=;
        b=RLXGOBJrF1CsImIQCaTCZkmrQbBTdZ0ssPVehiWWbXn+tpyv/p2UAZAHymTs2JOH3M
         hU0PdeP1Ef4Hg65jzVr8bmODoJwVfaCDGP2438x8Eq0Gab7y2h7fpI9qAx5np486wMBi
         oFkSJTPdXaL/9jR1Y2OXHdekPeXjSkunK7LNMCKhUingnmnMD5Rg9cxoSNPBCrcHsl47
         SVVTXTXM9WbG/cT8SLDz0HfvtEw/Zj7ZU3t9ArMM0aIVP2QOMqWiFTNUj8RDofPk0gMg
         lEYYOmk4qo0fpZwNbVP+ZQUA+8iuVxRdGiAR8R0vxjXWOBmprYUpiGmyzfobfOtcEdjh
         9eGA==
X-Gm-Message-State: AJcUukfTzQGkBzBONFbNrmrtybYDDG7VVvnsn1kvTnRmd+MWqB1lcxjd
        aNS5bqTTsJaJBwciOycx52Xcuw==
X-Google-Smtp-Source: ALg8bN5KDYXnc/2PbtBMoPkjit+GjN8Zh6Kx6KtzOx9hZGqjhjrhLpCLBfpey/frFxCtcgDfV50ghw==
X-Received: by 2002:a17:906:9154:: with SMTP id y20-v6mr2882113ejw.8.1547553950967;
        Tue, 15 Jan 2019 04:05:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z2sm5077287edd.4.2019.01.15.04.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 04:05:50 -0800 (PST)
Date:   Tue, 15 Jan 2019 13:05:47 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "seanpaul@google.com" <seanpaul@google.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] [RFC] drm_hwcomposer: Add support for Arm Framebuffer
 Compression (AFBC) modifiers.
Message-ID: <20190115120547.GL10517@phenom.ffwll.local>
Mail-Followup-To: Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "seanpaul@google.com" <seanpaul@google.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
References: <1547479696-14376-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547479696-14376-1-git-send-email-ayan.halder@arm.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 03:28:27PM +0000, Ayan Halder wrote:
> One needs to translate the Gralloc buffer flags for AFBC (eg
> MALI_GRALLOC_INTFMT_AFBC_BASIC) to the corresponding linux kernel drm modifiers.
> This gets passed to libdrm via drmModeAddFB2WithModifiers.
> 
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> 
> /-- Note for reviewer
> I was able to get this working for Android P on Juno with Mali DP650 and Mali
> T860 gpu(with some additional hacks). I have not yet validated this hikey960.
> 
> I have used the following components:-
> 1. Gralloc (from https://android.googlesource.com/device/linaro/hikey/+/master/gralloc960)
>   - Built with MALI_MMSS=1
> 2. Libdrm (from git://anongit.freedesktop.org/mesa/drm)
>   - You would need drm_fourcc.h and gralloc_handle.h
> --/

I thought drm_hwcomposer has switched over to gitlab merge requests?
README at least says so:

https://gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer

Cheers, Daniel

> ---
>  platformdrmgeneric.cpp | 42 ++++++++++++++++++++++++++++++++++++++++++
>  platformdrmgeneric.h   |  2 ++
>  platformhisi.cpp       | 14 ++++++++++++--
>  3 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/platformdrmgeneric.cpp b/platformdrmgeneric.cpp
> index 503c04a..a520224 100644
> --- a/platformdrmgeneric.cpp
> +++ b/platformdrmgeneric.cpp
> @@ -18,6 +18,7 @@
>  
>  #include "platformdrmgeneric.h"
>  #include "drmdevice.h"
> +#include "mali_gralloc_formats.h"
>  #include "platform.h"
>  
>  #include <drm/drm_fourcc.h>
> @@ -83,6 +84,31 @@ uint32_t DrmGenericImporter::ConvertHalFormatToDrm(uint32_t hal_format) {
>    }
>  }
>  
> +uint64_t DrmGenericImporter::ConvertGrallocFormatToDrmModifiers(uint64_t flags,
> +                                                                bool is_rgb) {
> +  uint64_t features = 0;
> +
> +  if (flags & MALI_GRALLOC_INTFMT_AFBC_BASIC)
> +    features |= AFBC_FORMAT_MOD_BLOCK_SIZE_16x16;
> +
> +  if (is_rgb)
> +    features |= AFBC_FORMAT_MOD_YTR;
> +
> +  if (flags & MALI_GRALLOC_INTFMT_AFBC_SPLITBLK)
> +    features |= (AFBC_FORMAT_MOD_SPLIT | AFBC_FORMAT_MOD_SPARSE);
> +
> +  if (flags & MALI_GRALLOC_INTFMT_AFBC_WIDEBLK)
> +    features |= AFBC_FORMAT_MOD_BLOCK_SIZE_32x8;
> +
> +  if (flags & MALI_GRALLOC_INTFMT_AFBC_TILED_HEADERS)
> +    features |= AFBC_FORMAT_MOD_TILED;
> +
> +  if (features)
> +    return DRM_FORMAT_MOD_ARM_AFBC(features);
> +  else
> +    return 0;
> +}
> +
>  uint32_t DrmGenericImporter::DrmFormatToBitsPerPixel(uint32_t drm_format) {
>    switch (drm_format) {
>      case DRM_FORMAT_ARGB8888:
> @@ -101,6 +127,22 @@ uint32_t DrmGenericImporter::DrmFormatToBitsPerPixel(uint32_t drm_format) {
>    }
>  }
>  
> +bool DrmGenericImporter::IsDrmFormatRgb(uint32_t drm_format) {
> +  switch (drm_format) {
> +    case DRM_FORMAT_ARGB8888:
> +    case DRM_FORMAT_XBGR8888:
> +    case DRM_FORMAT_ABGR8888:
> +    case DRM_FORMAT_BGR888:
> +    case DRM_FORMAT_BGR565:
> +      return true;
> +    case DRM_FORMAT_YVU420:
> +      return false;
> +    default:
> +      ALOGE("Unsupported format %u assuming rgb?", drm_format);
> +      return true;
> +  }
> +}
> +
>  int DrmGenericImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t *bo) {
>    gralloc_handle_t *gr_handle = gralloc_handle(handle);
>    if (!gr_handle)
> diff --git a/platformdrmgeneric.h b/platformdrmgeneric.h
> index 233ba55..43cb618 100644
> --- a/platformdrmgeneric.h
> +++ b/platformdrmgeneric.h
> @@ -36,6 +36,8 @@ class DrmGenericImporter : public Importer {
>    bool CanImportBuffer(buffer_handle_t handle) override;
>  
>    uint32_t ConvertHalFormatToDrm(uint32_t hal_format);
> +  uint64_t ConvertGrallocFormatToDrmModifiers(uint64_t flags, bool is_rgb);
> +  bool IsDrmFormatRgb(uint32_t drm_format);
>    uint32_t DrmFormatToBitsPerPixel(uint32_t drm_format);
>  
>   private:
> diff --git a/platformhisi.cpp b/platformhisi.cpp
> index 76fe1e7..1cb7e2c 100644
> --- a/platformhisi.cpp
> +++ b/platformhisi.cpp
> @@ -71,6 +71,9 @@ int HisiImporter::Init() {
>  }
>  
>  int HisiImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t *bo) {
> +  bool is_rgb;
> +  uint64_t modifiers[4] = {0};
> +
>    memset(bo, 0, sizeof(hwc_drm_bo_t));
>  
>    private_handle_t const *hnd = reinterpret_cast<private_handle_t const *>(
> @@ -94,6 +97,10 @@ int HisiImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t *bo) {
>    if (fmt < 0)
>      return fmt;
>  
> +  is_rgb = IsDrmFormatRgb(fmt);
> +  modifiers[0] = ConvertGrallocFormatToDrmModifiers(hnd->internal_format,
> +                                                    is_rgb);
> +
>    bo->width = hnd->width;
>    bo->height = hnd->height;
>    bo->hal_format = hnd->req_format;
> @@ -129,8 +136,11 @@ int HisiImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t *bo) {
>        break;
>    }
>  
> -  ret = drmModeAddFB2(drm_->fd(), bo->width, bo->height, bo->format,
> -                      bo->gem_handles, bo->pitches, bo->offsets, &bo->fb_id, 0);
> +  ret = drmModeAddFB2WithModifiers(drm_->fd(), bo->width, bo->height,
> +                                   bo->format, bo->gem_handles, bo->pitches,
> +                                   bo->offsets, modifiers, &bo->fb_id,
> +                                   modifiers[0] ? DRM_MODE_FB_MODIFIERS : 0);
> +
>    if (ret) {
>      ALOGE("could not create drm fb %d", ret);
>      return ret;
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
