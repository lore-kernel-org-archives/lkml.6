Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08162C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C662084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfBUNZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:25:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfBUNZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:25:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 117528CC7;
        Thu, 21 Feb 2019 13:25:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-228.ams2.redhat.com [10.36.116.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87C8F5D9E2;
        Thu, 21 Feb 2019 13:25:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id CC71311A9A; Thu, 21 Feb 2019 14:25:28 +0100 (CET)
Date:   Thu, 21 Feb 2019 14:25:28 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:INTEL DRM DRIVERS (excluding Poulsbo, Moorestow..." 
        <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] drm: move i915_kick_out_vgacon to drm_fb_helper
Message-ID: <20190221132528.7cyobqegunh6uoh2@sirius.home.kraxel.org>
References: <20190221113534.20764-1-kraxel@redhat.com>
 <20190221113534.20764-2-kraxel@redhat.com>
 <87ef81thk8.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef81thk8.fsf@intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 21 Feb 2019 13:25:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:08:39PM +0200, Jani Nikula wrote:
> On Thu, 21 Feb 2019, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > It'll be useful for other drivers too, so move it to drm_fb_helper.c
> > (and rename it of course).  Also add docs.
> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/drm/drm_fb_helper.h     |  2 ++
> >  drivers/gpu/drm/drm_fb_helper.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  drivers/gpu/drm/i915/i915_drv.c | 35 +----------------------------------
> >  3 files changed, 42 insertions(+), 34 deletions(-)
> >
> > diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> > index bb9acea613..a401ba47ad 100644
> > --- a/include/drm/drm_fb_helper.h
> > +++ b/include/drm/drm_fb_helper.h
> > @@ -649,4 +649,6 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
> >  #endif
> >  }
> >  
> > +int drm_fb_helper_kick_out_vgacon(void);
> > +
> >  #endif
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index 0e9349ff2d..a2d7e5bc51 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/sysrq.h>
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> > +#include <linux/vt_kern.h>
> >  #include <drm/drmP.h>
> >  #include <drm/drm_crtc.h>
> >  #include <drm/drm_fb_helper.h>
> > @@ -3353,3 +3354,41 @@ int __init drm_fb_helper_modinit(void)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(drm_fb_helper_modinit);
> > +
> > +/**
> > + * drm_fb_helper_kick_out_vgacon - deactivate vgacon driver.
> > + *
> > + * Deactivate vgacon driver so it stops accessing vga io ports.
> > + * Should be called after
> > + * drm_fb_helper_remove_conflicting_pci_framebuffers().
> > + *
> > + * Returns:
> > + * Zero on success or negative error code on failure.
> > + */
> > +int drm_fb_helper_kick_out_vgacon(void)
> > +{
> > +#if !defined(CONFIG_VGA_CONSOLE)
> > +        return 0;
> > +#elif !defined(CONFIG_DUMMY_CONSOLE)
> > +        return -ENODEV;
> > +#else
> 
> Please retain the original way of keeping conditional compilation
> outside of functions.

Care to explain why that is better?

thanks,
  Gerd

