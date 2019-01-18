Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77B22086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gxloH0iE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfARPPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:15:38 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:52896 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfARPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:15:37 -0500
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B805B53E;
        Fri, 18 Jan 2019 16:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1547824533;
        bh=C0W348bHwbiqEUMJ82+wbFBJahb50TTSfJ1Ql9D1Wd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxloH0iEQpA+LoY3WqiCqu6Jd/xYQRCpuDVoI4PWzEWg6a17mbpZEniadjqNH4E93
         AQVWoeMBcazK9ywLIfzjBoBBR3bmeFmn1AAy8CnERwUsVz4LKadIWyAA9i3C+dTTbK
         cXU0K6cWnjJzRoN0hf4lnXDMFwLyH4KysIKC2VeQ=
Date:   Fri, 18 Jan 2019 17:15:33 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Clark <robdclark@gmail.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/8] drm: move drm_can_sleep() to drm_util.h
Message-ID: <20190118151533.GD5275@pendragon.ideasonboard.com>
References: <20190112193251.20450-1-sam@ravnborg.org>
 <20190112193251.20450-2-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190112193251.20450-2-sam@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Thank you for the patch.

On Sat, Jan 12, 2019 at 08:32:44PM +0100, Sam Ravnborg wrote:
> Move drm_can_sleep() out of drmP.h to allow users
> to get rid of the drmP.h include.
> 
> There was no header file that was a good match for this helper function.
> So add this to drm_util with the relevant includes.
> 
> Add include of drm_util.h to all users.
> 
> v2:
> - Update comments to use kernel-doc style (Daniel)
> - Add FIXME to drm_can_sleep and add note that this
>   function should not be used in new code (Daniel)
> 
> v3:
> - Fix kernel-doc syntax (Daniel)
> - Plug drm_util.h into drm-internels.rst (Daniel)
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
>  Documentation/gpu/drm-internals.rst             |  9 ++++++
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
>  include/drm/drm_util.h                          | 43 ++++++++++++++++++++++++-
>  14 files changed, 66 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
> index 9090fabf3f7a..2caf21effd28 100644
> --- a/Documentation/gpu/drm-internals.rst
> +++ b/Documentation/gpu/drm-internals.rst
> @@ -233,6 +233,15 @@ Printer
>  .. kernel-doc:: drivers/gpu/drm/drm_print.c
>     :export:
>  
> +Utilities
> +---------
> +
> +.. kernel-doc:: include/drm/drm_util.h
> +   :doc: drm utils
> +
> +.. kernel-doc:: include/drm/drm_util.h
> +   :internal:

Why do we need it twice ?

> +
>  
>  Legacy Support Code
>  ===================

[snip]

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

Please keep headers alphabetically sorted, here and everywhere else in
this patch. This helps locating and avoiding duplicated headers.

>  #include "omap_drv.h"

[snip]

> diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
> index 88abdca89baa..f776a55e5508 100644
> --- a/include/drm/drm_util.h
> +++ b/include/drm/drm_util.h
> @@ -26,7 +26,48 @@
>  #ifndef _DRM_UTIL_H_
>  #define _DRM_UTIL_H_
>  
> -/* helper for handling conditionals in various for_each macros */
> +/**
> + * DOC: drm utils
> + *
> + * Macros and inline functions that does not naturally belong in other places

s/does/do/

> + */
> +
> +#include <linux/irqflags.h>
> +#include <linux/preempt.h>
> +#include <linux/kgdb.h>
> +#include <linux/smp.h>

Four headers needed to use three functions, impressive :-)

Alphabetical sorted here too please (and actually everywhere in this
patch series :-)).

> +/**
> + * for_each_if - helper for handling conditionals in various for_each macros
> + * @condition: The condition to check
> + *
> + * Typical use::
> + *
> + *	#define for_each_foo_bar(x, y) \'
> + *		list_for_each_entry(x, y->list, head) \'
> + *			for_each_if(x->something == SOMETHING)
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

Did you mean False ?

With these fixed,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> + */
> +static inline bool drm_can_sleep(void)
> +{
> +	if (in_atomic() || in_dbg_master() || irqs_disabled())
> +		return false;
> +	return true;
> +}
> +
>  #endif

-- 
Regards,

Laurent Pinchart
