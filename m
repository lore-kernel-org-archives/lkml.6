Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD71EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E65D20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfAON1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:27:06 -0500
Received: from foss.arm.com ([217.140.101.70]:50528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfAON1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:27:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7263A78;
        Tue, 15 Jan 2019 05:27:05 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73DF33F70D;
        Tue, 15 Jan 2019 05:27:05 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id CBDE16801B1; Tue, 15 Jan 2019 13:27:03 +0000 (GMT)
Date:   Tue, 15 Jan 2019 13:27:03 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Ayan Halder <Ayan.Halder@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "seanpaul@google.com" <seanpaul@google.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] [RFC] drm_hwcomposer: Add support for Arm Framebuffer
 Compression (AFBC) modifiers.
Message-ID: <20190115132703.GT20661@e110455-lin.cambridge.arm.com>
References: <1547479696-14376-1-git-send-email-ayan.halder@arm.com>
 <20190115120547.GL10517@phenom.ffwll.local>
 <20190115122418.GS20661@e110455-lin.cambridge.arm.com>
 <CAKMK7uHW=PafGQdcT7HykwSRMtVJ_zufdgBk2O6pVxSxk9CCyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uHW=PafGQdcT7HykwSRMtVJ_zufdgBk2O6pVxSxk9CCyg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 01:38:19PM +0100, Daniel Vetter wrote:
> On Tue, Jan 15, 2019 at 1:24 PM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> >
> > On Tue, Jan 15, 2019 at 01:05:47PM +0100, Daniel Vetter wrote:
> > > On Mon, Jan 14, 2019 at 03:28:27PM +0000, Ayan Halder wrote:
> > > > One needs to translate the Gralloc buffer flags for AFBC (eg
> > > > MALI_GRALLOC_INTFMT_AFBC_BASIC) to the corresponding linux kernel drm modifiers.
> > > > This gets passed to libdrm via drmModeAddFB2WithModifiers.
> > > >
> > > > Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > > >
> > > > /-- Note for reviewer
> > > > I was able to get this working for Android P on Juno with Mali DP650 and Mali
> > > > T860 gpu(with some additional hacks). I have not yet validated this hikey960.
> > > >
> > > > I have used the following components:-
> > > > 1. Gralloc (from https://android.googlesource.com/device/linaro/hikey/+/master/gralloc960)
> > > >   - Built with MALI_MMSS=1
> > > > 2. Libdrm (from git://anongit.freedesktop.org/mesa/drm)
> > > >   - You would need drm_fourcc.h and gralloc_handle.h
> > > > --/
> > >
> > > I thought drm_hwcomposer has switched over to gitlab merge requests?
> > > README at least says so:
> > >
> > > https://gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer
> >
> > So are we to send pull requests for RFCs as well?
> 
> Hm, not sure you should stuff RFC material into your linux-next
> branches. I thought that's only for patches which by all intents are
> ready for the next merge window, i.e. reviewed&tested and all that.
> Not for in-flight stuff still under discussion.

I think you're confusing the documentation patch with the drm_hwcomposer one (this one).

Best regards,
Liviu

> -Daniel
> 
> 
> > Best regards,
> > Liviu
> >
> > >
> > > Cheers, Daniel
> > >
> > > > ---
> > > >  platformdrmgeneric.cpp | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > >  platformdrmgeneric.h   |  2 ++
> > > >  platformhisi.cpp       | 14 ++++++++++++--
> > > >  3 files changed, 56 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/platformdrmgeneric.cpp b/platformdrmgeneric.cpp
> > > > index 503c04a..a520224 100644
> > > > --- a/platformdrmgeneric.cpp
> > > > +++ b/platformdrmgeneric.cpp
> > > > @@ -18,6 +18,7 @@
> > > >
> > > >  #include "platformdrmgeneric.h"
> > > >  #include "drmdevice.h"
> > > > +#include "mali_gralloc_formats.h"
> > > >  #include "platform.h"
> > > >
> > > >  #include <drm/drm_fourcc.h>
> > > > @@ -83,6 +84,31 @@ uint32_t DrmGenericImporter::ConvertHalFormatToDrm(uint32_t hal_format) {
> > > >    }
> > > >  }
> > > >
> > > > +uint64_t DrmGenericImporter::ConvertGrallocFormatToDrmModifiers(uint64_t flags,
> > > > +                                                                bool is_rgb) {
> > > > +  uint64_t features = 0;
> > > > +
> > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_BASIC)
> > > > +    features |= AFBC_FORMAT_MOD_BLOCK_SIZE_16x16;
> > > > +
> > > > +  if (is_rgb)
> > > > +    features |= AFBC_FORMAT_MOD_YTR;
> > > > +
> > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_SPLITBLK)
> > > > +    features |= (AFBC_FORMAT_MOD_SPLIT | AFBC_FORMAT_MOD_SPARSE);
> > > > +
> > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_WIDEBLK)
> > > > +    features |= AFBC_FORMAT_MOD_BLOCK_SIZE_32x8;
> > > > +
> > > > +  if (flags & MALI_GRALLOC_INTFMT_AFBC_TILED_HEADERS)
> > > > +    features |= AFBC_FORMAT_MOD_TILED;
> > > > +
> > > > +  if (features)
> > > > +    return DRM_FORMAT_MOD_ARM_AFBC(features);
> > > > +  else
> > > > +    return 0;
> > > > +}
> > > > +
> > > >  uint32_t DrmGenericImporter::DrmFormatToBitsPerPixel(uint32_t drm_format) {
> > > >    switch (drm_format) {
> > > >      case DRM_FORMAT_ARGB8888:
> > > > @@ -101,6 +127,22 @@ uint32_t DrmGenericImporter::DrmFormatToBitsPerPixel(uint32_t drm_format) {
> > > >    }
> > > >  }
> > > >
> > > > +bool DrmGenericImporter::IsDrmFormatRgb(uint32_t drm_format) {
> > > > +  switch (drm_format) {
> > > > +    case DRM_FORMAT_ARGB8888:
> > > > +    case DRM_FORMAT_XBGR8888:
> > > > +    case DRM_FORMAT_ABGR8888:
> > > > +    case DRM_FORMAT_BGR888:
> > > > +    case DRM_FORMAT_BGR565:
> > > > +      return true;
> > > > +    case DRM_FORMAT_YVU420:
> > > > +      return false;
> > > > +    default:
> > > > +      ALOGE("Unsupported format %u assuming rgb?", drm_format);
> > > > +      return true;
> > > > +  }
> > > > +}
> > > > +
> > > >  int DrmGenericImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t *bo) {
> > > >    gralloc_handle_t *gr_handle = gralloc_handle(handle);
> > > >    if (!gr_handle)
> > > > diff --git a/platformdrmgeneric.h b/platformdrmgeneric.h
> > > > index 233ba55..43cb618 100644
> > > > --- a/platformdrmgeneric.h
> > > > +++ b/platformdrmgeneric.h
> > > > @@ -36,6 +36,8 @@ class DrmGenericImporter : public Importer {
> > > >    bool CanImportBuffer(buffer_handle_t handle) override;
> > > >
> > > >    uint32_t ConvertHalFormatToDrm(uint32_t hal_format);
> > > > +  uint64_t ConvertGrallocFormatToDrmModifiers(uint64_t flags, bool is_rgb);
> > > > +  bool IsDrmFormatRgb(uint32_t drm_format);
> > > >    uint32_t DrmFormatToBitsPerPixel(uint32_t drm_format);
> > > >
> > > >   private:
> > > > diff --git a/platformhisi.cpp b/platformhisi.cpp
> > > > index 76fe1e7..1cb7e2c 100644
> > > > --- a/platformhisi.cpp
> > > > +++ b/platformhisi.cpp
> > > > @@ -71,6 +71,9 @@ int HisiImporter::Init() {
> > > >  }
> > > >
> > > >  int HisiImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t *bo) {
> > > > +  bool is_rgb;
> > > > +  uint64_t modifiers[4] = {0};
> > > > +
> > > >    memset(bo, 0, sizeof(hwc_drm_bo_t));
> > > >
> > > >    private_handle_t const *hnd = reinterpret_cast<private_handle_t const *>(
> > > > @@ -94,6 +97,10 @@ int HisiImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t *bo) {
> > > >    if (fmt < 0)
> > > >      return fmt;
> > > >
> > > > +  is_rgb = IsDrmFormatRgb(fmt);
> > > > +  modifiers[0] = ConvertGrallocFormatToDrmModifiers(hnd->internal_format,
> > > > +                                                    is_rgb);
> > > > +
> > > >    bo->width = hnd->width;
> > > >    bo->height = hnd->height;
> > > >    bo->hal_format = hnd->req_format;
> > > > @@ -129,8 +136,11 @@ int HisiImporter::ImportBuffer(buffer_handle_t handle, hwc_drm_bo_t *bo) {
> > > >        break;
> > > >    }
> > > >
> > > > -  ret = drmModeAddFB2(drm_->fd(), bo->width, bo->height, bo->format,
> > > > -                      bo->gem_handles, bo->pitches, bo->offsets, &bo->fb_id, 0);
> > > > +  ret = drmModeAddFB2WithModifiers(drm_->fd(), bo->width, bo->height,
> > > > +                                   bo->format, bo->gem_handles, bo->pitches,
> > > > +                                   bo->offsets, modifiers, &bo->fb_id,
> > > > +                                   modifiers[0] ? DRM_MODE_FB_MODIFIERS : 0);
> > > > +
> > > >    if (ret) {
> > > >      ALOGE("could not create drm fb %d", ret);
> > > >      return ret;
> > > > --
> > > > 2.7.4
> > > >
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> >
> > --
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ¯\_(ツ)_/¯
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
