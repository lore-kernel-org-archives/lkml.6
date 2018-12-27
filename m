Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE3AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A9F2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Yn5RV9KK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730995AbeL0MOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 07:14:49 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37297 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbeL0MOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 07:14:48 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so15100696edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 04:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oSmBbyFlcd4Vbqc07UuobxFNkmU5iZuoUmyD5uzDAUE=;
        b=Yn5RV9KK/EWohm7Evp61eYl8M8zEVsJKd3DsFGjbfQPmcCfGhQ7ZOqHo8tnXnpZEfv
         xYJWYLU2We6sTtgpfXKvyM6WH6ljOoIR4TgoHS9dQHyvOAc1Y9Do16cjC2c7F7Vm4jqN
         IBlq8uZaTOKmXAq+d8rtfzekX4+GjGuBQ9rMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oSmBbyFlcd4Vbqc07UuobxFNkmU5iZuoUmyD5uzDAUE=;
        b=Hih6CrDyNNFCgwpL9pEqxrEIr3ZacqRogsEuxAiGoDIX3js2mzX2qYssixcwAQtFRx
         rB9qyR7bg1bu8GBD0KraXYJxCQyHr2wvfFPuV82hxt4M/4Wso0d3K0thZtgCHsI2Extm
         VABTumqn5iIRms7w4lAckm9ink7q9QxTvVNTsQFaoJv/prQurea0LUyu2qGoegYFtVNJ
         Ivm7uMjHsKX+RvIf6MwcP81GIpR6AWheEJZ2rtEnxTmOrs1pGefoVFIbFgxJqmea2KPz
         o+ln72XQjXjzP2Pk42Sa7QQpJvFVF81dm/VHdy+Pghh2JzWC8UkMJjygKlt/6aQfjljw
         tCDQ==
X-Gm-Message-State: AA+aEWbuWgpiN8yMaN0h+873ng7rxGVtDCEOQf4wdYlEZEZkKifPChMH
        t5p4Z515hikkV4cJY5pJSoFx5K3EPJ8=
X-Google-Smtp-Source: AFSGD/XWoCD+XhVetYakBI8NFPIR0Rc1pg4MMsYYGRY+mSTHbCzUBGCbehcdb70f498LKSH60U8h7A==
X-Received: by 2002:a17:906:6b99:: with SMTP id l25-v6mr15215283ejr.154.1545912886103;
        Thu, 27 Dec 2018 04:14:46 -0800 (PST)
Received: from dvetter-linux.ger.corp.intel.com ([194.230.159.220])
        by smtp.gmail.com with ESMTPSA id j8sm11385499ede.55.2018.12.27.04.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 04:14:45 -0800 (PST)
Date:   Thu, 27 Dec 2018 13:14:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Rob Clark <robdclark@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v1 3/7] drm: move drm_can_sleep() to drm_util.h
Message-ID: <20181227121441.GF9058@dvetter-linux.ger.corp.intel.com>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>, Rob Clark <robdclark@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Eric Anholt <eric@anholt.net>
References: <20181226210215.GA27610@ravnborg.org>
 <20181226210353.13993-3-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181226210353.13993-3-sam@ravnborg.org>
X-Operating-System: Linux dvetter-linux.ger.corp.intel.com
 4.19.10-200.fc28.x86_64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 10:03:49PM +0100, Sam Ravnborg wrote:
> Move drm_can_sleep() out of drmP.h to allow users
> to get rid of the drmP.h include.
> 
> There was no header file that was a good match for this helper function.
> So add this to drm_util with the relevant includes.
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
>  drivers/gpu/drm/ast/ast_fb.c                    |  1 +
>  drivers/gpu/drm/cirrus/cirrus_fbdev.c           |  1 +
>  drivers/gpu/drm/drm_flip_work.c                 |  1 +
>  drivers/gpu/drm/mgag200/mgag200_fb.c            |  1 +
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_smp.c        |  1 +
>  drivers/gpu/drm/omapdrm/omap_fbdev.c            |  1 +
>  drivers/gpu/drm/qxl/qxl_cmd.c                   |  2 ++
>  drivers/gpu/drm/radeon/atom.c                   |  2 ++
>  drivers/gpu/drm/radeon/radeon_legacy_encoders.c |  1 +
>  drivers/gpu/drm/vc4/vc4_drv.h                   |  1 +
>  include/drm/drmP.h                              |  8 --------
>  include/drm/drm_util.h                          | 13 +++++++++++++
>  13 files changed, 27 insertions(+), 8 deletions(-)
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
> index de26df0c6044..fb56fe848e81 100644
> --- a/drivers/gpu/drm/ast/ast_fb.c
> +++ b/drivers/gpu/drm/ast/ast_fb.c
> @@ -38,6 +38,7 @@
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
> +#include <drm/drm_util.h>
>  #include <drm/drm_fb_helper.h>
>  #include <drm/drm_crtc_helper.h>
>  #include "ast_drv.h"
> diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
> index 68ab1821e15b..1544fa55d1ff 100644
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
> index 208af9f37914..d17676824377 100644
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
> index bd6ef1f31822..79c6bcc4f509 100644
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
> index 2ba786820052..a77c9ee43b68 100644
> --- a/include/drm/drmP.h
> +++ b/include/drm/drmP.h
> @@ -95,12 +95,4 @@ struct dma_buf_attachment;
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
>  #endif
> diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
> index 88abdca89baa..e3200980d3f3 100644
> --- a/include/drm/drm_util.h
> +++ b/include/drm/drm_util.h
> @@ -26,7 +26,20 @@
>  #ifndef _DRM_UTIL_H_
>  #define _DRM_UTIL_H_
>  
> +#include <linux/irqflags.h>
> +#include <linux/preempt.h>
> +#include <linux/kgdb.h>
> +#include <linux/smp.h>
> +
>  /* helper for handling conditionals in various for_each macros */
>  #define for_each_if(condition) if (!(condition)) {} else
>  
> +/* returns true if currently okay to sleep */

Kerneldoc would be nice for this, specifically a huge warning that this
shouldn't be used (it doesn't work everywhere) and a FIXME that all users
should be removed. We might even want to include this as a todo item in
gpu/todo.rst
-Daniel

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
