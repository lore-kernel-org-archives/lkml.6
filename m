Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359D6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E339B21855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="TaPzn7hL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAXUHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:07:51 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:39603 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfAXUHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:07:49 -0500
Received: by mail-yb1-f193.google.com with SMTP id s17so2896632ybp.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K9oL2XaHdEjD6f/yaUTpY20aTJ21pDNgkRFnmYiQQ04=;
        b=TaPzn7hLX0tBlR3vhmP+hcgYwtEA+4zcbSloC4luxdyH/TvKicL1QwKfbBtt8IOtNt
         U/fnkZCQumYAbpRJj5ttGAybN0XEdgDhzGE7K49BIMjjzC95qoYpmQHcQl4/fD/DKAAC
         AI/Q0L/5imZk7K8H6QMhf5VLCH8TJG9RvxBvW20FWICh2vejgDTRI845bqdNN9cdHUYo
         xQYF1D3xB0BpHq2gGgRGq82Xf0qyZQ3LPpdNVSlIC23KWl/45p27uMg6fQ71tO0fuZDP
         FQC1gRS1jQigrRebMmrbHqm7hEJxzsb5afiM8T8miTQX+uoXtbybSaMO144nYOY/FsHJ
         xAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K9oL2XaHdEjD6f/yaUTpY20aTJ21pDNgkRFnmYiQQ04=;
        b=txLe3nXqMvbcXv2k5bhmzDf/5DN/bl2eJ/YfNsC03K0WcXY0tkC9ZoyIR0mgyohPum
         VrSsUUdySsqr02ewOeg98uE6ekJXq/L8fqcUN4pkigiJ15qieX12ICv2mEwQc76DIN7Q
         S6KOB/za3EbD4OPE2kB0LnhW+WqZvpi/H6tAXE1fAIAjTuKlUf2iTbr0ofX35EEv43eZ
         NMH4b0c77H/8TAaQ+czj+wkb5P10zfgYhycRXiXC4sRykLukrtWpwx564HMil6x+IcH7
         pVttiIKUlaqGqI23lmnVMNvL7w9N83U0J0mO57+JHBqArxG+e8ZnpWSAHx64DTNye/Mb
         H+QA==
X-Gm-Message-State: AJcUukctfElo76wdkdKmIszqHdQ0zvloni6z/domxxNjq0RnSGIeERFb
        h5wwUnGfrQj68VtEp2jeQjSw6dDFl4NzGg==
X-Google-Smtp-Source: ALg8bN4FEuZLoQJE9c6nrXwL/uVXnLI/OaWEJRi1Qwx6Fmy19CfvKqW2wqNByBXqfkbAtNC0EXsSZw==
X-Received: by 2002:a25:ab32:: with SMTP id u47mr7295904ybi.191.1548360468681;
        Thu, 24 Jan 2019 12:07:48 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id t128sm8245800ywa.79.2019.01.24.12.07.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:07:47 -0800 (PST)
Date:   Thu, 24 Jan 2019 15:07:47 -0500
From:   Sean Paul <sean@poorly.run>
To:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] drm: remove drmP.h from drm_modeset_helper.h
Message-ID: <20190124200747.GQ114153@art_vandelay>
References: <20190119084014.5355-1-sam@ravnborg.org>
 <20190119084014.5355-7-sam@ravnborg.org>
 <20190124140320.GY3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124140320.GY3271@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:03:20PM +0100, Daniel Vetter wrote:
> On Sat, Jan 19, 2019 at 09:40:14AM +0100, Sam Ravnborg wrote:
> > With the removal of drmP.h from drm_modeset_helper.h
> > the drmP.h are no longer included by any include files
> > in include/drm.
> > The drmP.h file is thus only included explicit
> > either in .c files or in local .h files.
> > This makes the process of deleting the drmP.h includes easier
> > as we have a more local dependency chain.
> > 
> > Include build failure fixes in drm files after the drmP.h removal.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> 
> Merge the previous 5 patches from this series, but this now goes boom on
> vbox in staging. Needs another prep patch I think.

Soo, can we drop vboxvideo yet?

Sean

> -Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_damage_helper.c  | 1 +
> >  drivers/gpu/drm/drm_modeset_helper.c | 2 ++
> >  include/drm/drm_modeset_helper.h     | 6 +++++-
> >  3 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> > index e16aa5ae00b4..ee67c96841fa 100644
> > --- a/drivers/gpu/drm/drm_damage_helper.c
> > +++ b/drivers/gpu/drm/drm_damage_helper.c
> > @@ -32,6 +32,7 @@
> >  
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_damage_helper.h>
> > +#include <drm/drm_device.h>
> >  
> >  /**
> >   * DOC: overview
> > diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
> > index 9150fa385bba..9bc1ef788c77 100644
> > --- a/drivers/gpu/drm/drm_modeset_helper.c
> > +++ b/drivers/gpu/drm/drm_modeset_helper.c
> > @@ -23,8 +23,10 @@
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_fb_helper.h>
> > +#include <drm/drm_fourcc.h>
> >  #include <drm/drm_modeset_helper.h>
> >  #include <drm/drm_plane_helper.h>
> > +#include <drm/drm_print.h>
> >  
> >  /**
> >   * DOC: aux kms helpers
> > diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
> > index efa337f03129..995fd981cab0 100644
> > --- a/include/drm/drm_modeset_helper.h
> > +++ b/include/drm/drm_modeset_helper.h
> > @@ -23,7 +23,11 @@
> >  #ifndef __DRM_KMS_HELPER_H__
> >  #define __DRM_KMS_HELPER_H__
> >  
> > -#include <drm/drmP.h>
> > +struct drm_crtc;
> > +struct drm_crtc_funcs;
> > +struct drm_device;
> > +struct drm_framebuffer;
> > +struct drm_mode_fb_cmd2;
> >  
> >  void drm_helper_move_panel_connectors_to_head(struct drm_device *);
> >  
> > -- 
> > 2.12.0
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Sean Paul, Software Engineer, Google / Chromium OS
