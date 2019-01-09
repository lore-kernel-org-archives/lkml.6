Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD15C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AD22075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="a/UzS9AR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfAIVUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:20:16 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39774 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfAIVUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:20:15 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so8497934edt.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DTa8rsS6M9IwkOdyknCOGGHqjIMGtC/5eFA19O2kuTg=;
        b=a/UzS9ARRfERHIgkIFtoseTSSKOEWMbsPsl16IhkKYmG8FAqGybUFIc74gx1fGyoMZ
         nnLdgFA6pi2RovYJWE6XMpmfoe23V0LF+4qIuNP2sd+DtZD/crrzmWGVOKfJFrQrymgi
         yTKYgvg8cdCwE5mSloBWIYFfU0FEK3niAV+Rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DTa8rsS6M9IwkOdyknCOGGHqjIMGtC/5eFA19O2kuTg=;
        b=qRdXDwTRE1W1m96Qd+hJPIFLPEiKK7nzdLay76XdvXl9dF0m5/QQYwJ9ZPXFQnFdS4
         lWg2M75n3ZZcjoybOereA+WmHgiTVGZTYA2yX5LCjW0/3D+HoRIM4Tcc3npBTl2WT8P2
         JlRCFpjUTaY+w1cyKQo1vuRWHWDmOxP99UP9mZESSovLEstALJX7y1b4F1LByeOqU4yI
         HiK/RKhVCw4JUuh4KxVxhVNjCOQohxfQD4y61VYof1Z+5HiWoFMOIf2Wg85XTfP4SvHc
         gBbtyzehgafytFNRXQM2DzwiuxJYd8iFQ3pMxh0Y1ji2qVdW6dhz7WBzA/6CX+/N0z/D
         Y6hQ==
X-Gm-Message-State: AJcUukctzrTso08fr7X7kYTnJBNdO8DY7YomHQ+f6t+hk6nxiFQERpNo
        nwTHIZhoFpzVd6mhOa5pMp1T0w==
X-Google-Smtp-Source: ALg8bN7Mc5QnHuS8jItL8/qE7wxETVTwUHYEo/Mm0N4+Y67PHOA2K+lXd+ZQRD3QmPziUvxePBWS0Q==
X-Received: by 2002:aa7:dc51:: with SMTP id g17mr7165994edu.115.1547068812088;
        Wed, 09 Jan 2019 13:20:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id f20sm1617829edf.19.2019.01.09.13.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 13:20:11 -0800 (PST)
Date:   Wed, 9 Jan 2019 22:20:09 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 04/12] drm: move drm_can_sleep() to drm_util.h
Message-ID: <20190109212008.GY21184@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>, Rob Clark <robdclark@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Eric Anholt <eric@anholt.net>
References: <20190108192939.15255-1-sam@ravnborg.org>
 <20190108192939.15255-5-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190108192939.15255-5-sam@ravnborg.org>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:29:31PM +0100, Sam Ravnborg wrote:
> Move drm_can_sleep() out of drmP.h to allow users
> to get rid of the drmP.h include.
> 
> There was no header file that was a good match for this helper function.
> So add this to drm_util with the relevant includes.
> 
> Update comments to use kernel-doc style.
> Add FIXME to drm_can_sleep and add note
> that this function should not be used in new code
> 
> Add include of drm_util.h to all users.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c               |  2 ++
>  drivers/gpu/drm/ast/ast_fb.c                    |  2 ++
>  drivers/gpu/drm/cirrus/cirrus_fbdev.c           |  1 +
>  drivers/gpu/drm/drm_flip_work.c                 |  1 +
>  drivers/gpu/drm/mgag200/mgag200_fb.c            |  1 +
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c        |  1 +
>  drivers/gpu/drm/omapdrm/omap_fbdev.c            |  1 +
>  drivers/gpu/drm/qxl/qxl_cmd.c                   |  2 ++
>  drivers/gpu/drm/radeon/atom.c                   |  2 ++
>  drivers/gpu/drm/radeon/radeon_legacy_encoders.c |  1 +
>  drivers/gpu/drm/vc4/vc4_drv.h                   |  1 +
>  include/drm/drmP.h                              |  8 -----
>  include/drm/drm_util.h                          | 42 ++++++++++++++++++++++++-
>  13 files changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index e9934de1b9cf..dd30f4e61a8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -27,6 +27,8 @@
>  #include <linux/slab.h>
>  #include <asm/unaligned.h>
>  
> +#include <drm/drm_util.h>
> +
>  #define ATOM_DEBUG
>  
>  #include "atom.h"
> diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
> index a80bca1a857f..eb66bf7d3e63 100644
> --- a/drivers/gpu/drm/ast/ast_fb.c
> +++ b/drivers/gpu/drm/ast/ast_fb.c
> @@ -39,7 +39,9 @@
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_fb_helper.h>
> +#include <drm/drm_util.h>
>  #include <drm/drm_crtc_helper.h>
> +
>  #include "ast_drv.h"
>  
>  static void ast_dirty_update(struct ast_fbdev *afbdev,
> diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> index 4dd499c7d1ba..79fea1b8bc14 100644
> --- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> +++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> @@ -10,6 +10,7 @@
>   */
>  #include <linux/module.h>
>  #include <drm/drmP.h>
> +#include <drm/drm_util.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  
> diff --git a/drivers/gpu/drm/drm_flip_work.c b/drivers/gpu/drm/drm_flip_work.c
> index 12dea16f22a8..3da3bf5af405 100644
> --- a/drivers/gpu/drm/drm_flip_work.c
> +++ b/drivers/gpu/drm/drm_flip_work.c
> @@ -22,6 +22,7 @@
>   */
>  
>  #include <drm/drmP.h>
> +#include <drm/drm_util.h>
>  #include <drm/drm_flip_work.h>
>  
>  /**
> diff --git a/drivers/gpu/drm/mgag200/mgag200_fb.c b/drivers/gpu/drm/mgag200/mgag200_fb.c
> index 30726c9fe28c..6893934b26c0 100644
> --- a/drivers/gpu/drm/mgag200/mgag200_fb.c
> +++ b/drivers/gpu/drm/mgag200/mgag200_fb.c
> @@ -12,6 +12,7 @@
>   */
>  #include <linux/module.h>
>  #include <drm/drmP.h>
> +#include <drm/drm_util.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
> index 96c2b828dba4..fa2d1d8995ee 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c
> @@ -16,6 +16,7 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#include <drm/drm_util.h>
>  
>  #include "mdp5_kms.h"
>  #include "mdp5_smp.h"
> diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> index aee99194499f..851c59f07eb1 100644
> --- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
> +++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
> @@ -16,6 +16,7 @@
>   */
>  
>  #include <drm/drm_crtc.h>
> +#include <drm/drm_util.h>
>  #include <drm/drm_fb_helper.h>
>  
>  #include "omap_drv.h"
> diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
> index dffc5093ff16..2e100f644236 100644
> --- a/drivers/gpu/drm/qxl/qxl_cmd.c
> +++ b/drivers/gpu/drm/qxl/qxl_cmd.c
> @@ -25,6 +25,8 @@
>  
>  /* QXL cmd/ring handling */
>  
> +#include <drm/drm_util.h>
> +
>  #include "qxl_drv.h"
>  #include "qxl_object.h"
>  
> diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom.c
> index e55cbeee7a53..ac98ad561870 100644
> --- a/drivers/gpu/drm/radeon/atom.c
> +++ b/drivers/gpu/drm/radeon/atom.c
> @@ -27,6 +27,8 @@
>  #include <linux/slab.h>
>  #include <asm/unaligned.h>
>  
> +#include <drm/drm_util.h>
> +
>  #define ATOM_DEBUG
>  
>  #include "atom.h"
> diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> index 222a1fa41d7c..7e3257e8fd56 100644
> --- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
> @@ -24,6 +24,7 @@
>   *          Alex Deucher
>   */
>  #include <drm/drmP.h>
> +#include <drm/drm_util.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/radeon_drm.h>
>  #include "radeon.h"
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
> index c24b078f0593..2c635f001c71 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.h
> +++ b/drivers/gpu/drm/vc4/vc4_drv.h
> @@ -9,6 +9,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/reservation.h>
>  #include <drm/drmP.h>
> +#include <drm/drm_util.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_atomic.h>
> diff --git a/include/drm/drmP.h b/include/drm/drmP.h
> index 9e47c8dc6b87..bc4cb3732407 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -94,14 +94,6 @@ struct dma_buf_attachment;
>  struct pci_dev;
>  struct pci_controller;
>  
> -/* returns true if currently okay to sleep */
> -static inline bool drm_can_sleep(void)
> -{
> -	if (in_atomic() || in_dbg_master() || irqs_disabled())
> -		return false;
> -	return true;
> -}
> -
>  #if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
>  #define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
>  #else
> diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
> index 88abdca89baa..8fda5777471c 100644
> --- a/include/drm/drm_util.h
> +++ b/include/drm/drm_util.h
> @@ -26,7 +26,47 @@
>  #ifndef _DRM_UTIL_H_
>  #define _DRM_UTIL_H_
>  
> -/* helper for handling conditionals in various for_each macros */
> +/**
> + * DOC: drm utils
> + *
> + * Macros and inline functions that does not naturally belong in other places
> + */

The nice new docs here aren't included anywhere. We already have a "Misc
Utilities" in drm-internals.rst, including this there under a "Utilities"
subheading makes sense I think - yes I know, not the most creative name :-)
> +
> +#include <linux/irqflags.h>
> +#include <linux/preempt.h>
> +#include <linux/kgdb.h>
> +#include <linux/smp.h>
> +
> +/**
> + * for_each_if - helper for handling conditionals in various for_each macros
> + * @condition The condition to check
> + *
> + * Typical use:
> + * #define for_each_foo_bar(x, y) \
> + *	list_for_each_entry(x, y->list, head) \
> + *		for_each_if(x->something == SOMETHING)

I think the formatting of this in the html output will look off:
Double-colon plus indenting should fix that.

Merged the first 3 patches of this series thus far.

Thanks, Daniel

> + *
> + * The for_each_if() macro makes the use of for_each_foo_bar() less error
> + * prone.
> + */
>  #define for_each_if(condition) if (!(condition)) {} else
>  
> +/**
> + * drm_can_sleep - returns true if currently okay to sleep
> + *
> + * This function shall not be used in new code.
> + * The check for running in atomic context may not work - see linux/preempt.h.
> + *
> + * FIXME: All users of drm_can_sleep should be removed (see todo.rst)
> + *
> + * Returns:
> + * True if kgdb is active or we are in an atomic context or irqs are disabled
> + */
> +static inline bool drm_can_sleep(void)
> +{
> +	if (in_atomic() || in_dbg_master() || irqs_disabled())
> +		return false;
> +	return true;
> +}
> +
>  #endif
> -- 
> 2.12.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
