Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932142AbeEHKaz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:30:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50886 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754371AbeEHKax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:30:53 -0400
X-Google-Smtp-Source: AB8JxZoaYyq9zKvQdlcG03zDxhXyrt48loe2WrQsLUs/kdZJbRfPaDhpOhsXiQnO5GTciB10nHnIwg==
Date: Tue, 8 May 2018 12:30:49 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Peter Rosin <peda@axentia.se>
Cc: Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 10/26] drm/bridge: panel: provide an owner .odev device
Message-ID: <20180508103049.GP28661@phenom.ffwll.local>
Mail-Followup-To: Peter Rosin <peda@axentia.se>, Jyri Sarha <jsarha@ti.com>,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20180504135212.26977-1-peda@axentia.se>
 <20180504135212.26977-11-peda@axentia.se>
 <5130ea2e-e1cd-53dd-25da-038deb91a13d@ti.com>
 <c446bdec-bf31-f192-c270-d672011d4503@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c446bdec-bf31-f192-c270-d672011d4503@axentia.se>
X-Operating-System: Linux phenom 4.15.0-3-amd64 
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 09:58:49AM +0200, Peter Rosin wrote:
> On 2018-05-08 08:51, Jyri Sarha wrote:
> > On 05/04/18 16:51, Peter Rosin wrote:
> >> It gets rid of an #ifdef and the .of_node member is going away.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  drivers/gpu/drm/bridge/panel.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> >> index 6d99d4a3beb3..f43d77b5ed20 100644
> >> --- a/drivers/gpu/drm/bridge/panel.c
> >> +++ b/drivers/gpu/drm/bridge/panel.c
> >> @@ -169,10 +169,8 @@ struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel,
> >>  	panel_bridge->connector_type = connector_type;
> >>  	panel_bridge->panel = panel;
> >>  
> >> +	panel_bridge->bridge.odev = panel->dev;
> > 
> > I am afraid this approach will eventually conflict with my lately
> > accepted patch[1].
> 
> I don't see how? The links are refcounted. So, if there is one link
> each for the panel and bridge between the drm device and the panel
> device that link will simply get two references. If/when the panel
> device then goes away, the drm device will be brought down because
> of that link (with two references, but that is irrelevant). When
> the drm device is brought down, it will (presumably) bring down the
> bridge as well (which will fix the refcount as the bridge link is
> killed as part of that).
> 
> Or have you done some test and seen an actual problem?
> 
> > The panel already has a device pointer of its own, and technically the
> > bridge element created here is created by the master drm device itself.
> 
> Not always, some bridges also call drm_panel_bridge_add for connecting
> its output to either a panel or another bridge.
> 
> And by that line of argument, the devm_kzalloc in drm_panel_bridge_add
> attaches the bridge memory to the wrong device as well. Maybe that
> should be fixed? Seems orthogonal though, but it would introduce a
> natural struct device in that function to assign to .odev. I think
> the device owning the bridge memory should be the same as the .odev
> device of the bridge.

Drive-by comment: You can't allocate anything with devm_* functions that
represents a core drm struct attached to a drm_device. There's no struct
device anywhere that has the right lifetime (since the drm_device can
easily outlive any physical device).

Yes that makes roughly 100% of all armsoc drm drivers buggy :-/ But it
doesn't matter, since you can't really unplug those devices physically,
hence will only blow up if you force an unbind through sysfs, and then you
get to keep all the pieces. Ignorance is bliss meanwhile ...
-Daniel

> 
> > I suggest assigning odev here to NULL or to master drm device itself.
> 
> I'd rather not use NULL, since it is nice to be able to rely on the
> .odev being there, and WARN if it isn't.
> 
> Cheers,
> Peter
> 
> > Best regards,
> > Jyri
> > 
> >>  	panel_bridge->bridge.funcs = &panel_bridge_bridge_funcs;
> >> -#ifdef CONFIG_OF
> >> -	panel_bridge->bridge.of_node = panel->dev->of_node;
> >> -#endif
> >>  
> >>  	drm_bridge_add(&panel_bridge->bridge);
> >>  
> >>
> > 
> > [1] https://lists.freedesktop.org/archives/dri-devel/2018-April/174559.html
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
