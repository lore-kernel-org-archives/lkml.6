Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C04C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E9D20700
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jsMo0Myq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733205AbfAKP4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:56:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37538 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbfAKP4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:56:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so13483681edb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HOv0t38exu7RfCLrDZrMLZNOG9JxRiRz9wyZnSDe6H8=;
        b=jsMo0MyqMBxhK6cTnOCp3pSGFT7hcivhxNh2pCsL4eL/xE/XKWAbVMmzyli57lu4Hk
         O3jLS/3COc0Pdx/2FvC4xTKuHZ4JnoKCfpoosWQQ2O7M+G+I7hWJMTdwcPRx3XykYhu8
         nR9Ag8mrRbhSijv/uTQCsab2gQgPxGd8ycuAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HOv0t38exu7RfCLrDZrMLZNOG9JxRiRz9wyZnSDe6H8=;
        b=chf6vREIwgKfwi9ynZaxLgwQwXv0Y3dj8LwNMDUHlm13OxvJl+GdNG0F7chefF1Ywv
         YxJrkGEMK1cXNieVLHVU16b89LujAxfqa6lz4//lK0Bh3FVArfcDR0u/hoYU6/CINmjg
         rpXpT2gMrrxjqDnnGogtvWFHJdbNzl3iD+PivhEeflEDSlgAfxUdQBN8AtGomGX5s3On
         SJt/S5tCz7XI8Ac1Vhe7QDos/AzX/D1VLFS+3E9NHu90zbNjZ4YMCF6f2tulKGI6kZjS
         rQGVROye4AL78nyL/aYyItDlg7UxOjIGbtO8DkzVjycU9VSpjPtUTYHMG2CHlJmm3IMh
         Gdzw==
X-Gm-Message-State: AJcUukezKQZAz6V3G5Q4K4KnnSDazOlmiyhDEaJpz8qQMnz+NwUXMxzg
        QjpD+M+9qpDy+NxtbNPntbNFQw==
X-Google-Smtp-Source: ALg8bN4deVtI+K0+HtbIEq8bW8ufsTrdgpZG7mhyhipF4ZrvwQp1Uwv+dcNCSxu5F135WkUhVWrIhA==
X-Received: by 2002:a50:8262:: with SMTP id 89mr13090301edf.125.1547222192991;
        Fri, 11 Jan 2019 07:56:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j4sm2464348edh.69.2019.01.11.07.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 07:56:32 -0800 (PST)
Date:   Fri, 11 Jan 2019 16:56:29 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: Re: [PATCH v3 08/12] drm: remove include of drmP.h from
 drm_modeset_helper.h
Message-ID: <20190111155629.GD21184@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
References: <20190108192939.15255-1-sam@ravnborg.org>
 <20190108192939.15255-9-sam@ravnborg.org>
 <20190109215354.GZ21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109215354.GZ21184@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.18.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:53:54PM +0100, Daniel Vetter wrote:
> On Tue, Jan 08, 2019 at 08:29:35PM +0100, Sam Ravnborg wrote:
> > drmP.h is an relic from the days when there was a single header file.
> > To enable the removal of drmP.h from all users drop include
> > of drmP.h from drm_modeset_helper.h.
> > 
> > A few files relied on the file included in drmP.h - add explicit
> > include statements to these files.
> > Build tested with arm and x86.
> > 
> > v2:
> > - Add forward declarations to drm_modeset_helper.h (Laurent Pinchart)
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Reviewed-by: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Alexey Brodkin <abrodkin@synopsys.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Archit Taneja <architt@codeaurora.org>
> > Cc: Andrzej Hajda <a.hajda@samsung.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> This one here breaks tinydrm without the tinydrm patch first. I reorderd
> while applying. It also breaks kirin (and maybe more, I didn't check), so
> I've left this one out for now.

Note that I've just fixed up a large pile of these in i915 because I've
been rebasing a patch that removes lots of drm_modeset_helper.h includes.

Getting this all merged will be fun :-/
-Daniel

> -Daniel
> 
> > ---
> >  drivers/gpu/drm/arc/arcpgu_sim.c     | 1 +
> >  drivers/gpu/drm/bridge/cdns-dsi.c    | 2 ++
> >  drivers/gpu/drm/drm_modeset_helper.c | 2 ++
> >  drivers/gpu/drm/rcar-du/rcar_lvds.c  | 1 +
> >  include/drm/drm_modeset_helper.h     | 6 +++++-
> >  5 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/arc/arcpgu_sim.c b/drivers/gpu/drm/arc/arcpgu_sim.c
> > index 68629e614990..3b7556f62230 100644
> > --- a/drivers/gpu/drm/arc/arcpgu_sim.c
> > +++ b/drivers/gpu/drm/arc/arcpgu_sim.c
> > @@ -14,6 +14,7 @@
> >   *
> >   */
> >  
> > +#include <drm/drm_device.h>
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_atomic_helper.h>
> >  
> > diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
> > index ce9496d13986..4b73d0969468 100644
> > --- a/drivers/gpu/drm/bridge/cdns-dsi.c
> > +++ b/drivers/gpu/drm/bridge/cdns-dsi.c
> > @@ -8,11 +8,13 @@
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_bridge.h>
> >  #include <drm/drm_crtc_helper.h>
> > +#include <drm/drm_drv.h>
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_panel.h>
> >  #include <video/mipi_display.h>
> >  
> >  #include <linux/clk.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/iopoll.h>
> >  #include <linux/module.h>
> >  #include <linux/of_address.h>
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
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > index 534a128a869d..8010ed702509 100644
> > --- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > +++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> > +#include <linux/module.h>
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/of_graph.h>
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
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
