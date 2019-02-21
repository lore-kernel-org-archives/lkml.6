Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CBDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC712080D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfBUOkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:40:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:40844 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbfBUOjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:39:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 06:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="148703451"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2019 06:39:48 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list\:INTEL DRM DRIVERS \(excluding Poulsbo\, Moorestow..." 
        <intel-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/2] drm: move i915_kick_out_vgacon to drm_fb_helper
In-Reply-To: <20190221132528.7cyobqegunh6uoh2@sirius.home.kraxel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190221113534.20764-1-kraxel@redhat.com> <20190221113534.20764-2-kraxel@redhat.com> <87ef81thk8.fsf@intel.com> <20190221132528.7cyobqegunh6uoh2@sirius.home.kraxel.org>
Date:   Thu, 21 Feb 2019 16:41:56 +0200
Message-ID: <877edttd8r.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Thu, Feb 21, 2019 at 03:08:39PM +0200, Jani Nikula wrote:
>> On Thu, 21 Feb 2019, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > It'll be useful for other drivers too, so move it to drm_fb_helper.c
>> > (and rename it of course).  Also add docs.
>> >
>> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> > ---
>> >  include/drm/drm_fb_helper.h     |  2 ++
>> >  drivers/gpu/drm/drm_fb_helper.c | 39 +++++++++++++++++++++++++++++++++++++++
>> >  drivers/gpu/drm/i915/i915_drv.c | 35 +----------------------------------
>> >  3 files changed, 42 insertions(+), 34 deletions(-)
>> >
>> > diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
>> > index bb9acea613..a401ba47ad 100644
>> > --- a/include/drm/drm_fb_helper.h
>> > +++ b/include/drm/drm_fb_helper.h
>> > @@ -649,4 +649,6 @@ drm_fb_helper_remove_conflicting_pci_framebuffers(struct pci_dev *pdev,
>> >  #endif
>> >  }
>> >  
>> > +int drm_fb_helper_kick_out_vgacon(void);
>> > +
>> >  #endif
>> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>> > index 0e9349ff2d..a2d7e5bc51 100644
>> > --- a/drivers/gpu/drm/drm_fb_helper.c
>> > +++ b/drivers/gpu/drm/drm_fb_helper.c
>> > @@ -35,6 +35,7 @@
>> >  #include <linux/sysrq.h>
>> >  #include <linux/slab.h>
>> >  #include <linux/module.h>
>> > +#include <linux/vt_kern.h>
>> >  #include <drm/drmP.h>
>> >  #include <drm/drm_crtc.h>
>> >  #include <drm/drm_fb_helper.h>
>> > @@ -3353,3 +3354,41 @@ int __init drm_fb_helper_modinit(void)
>> >  	return 0;
>> >  }
>> >  EXPORT_SYMBOL(drm_fb_helper_modinit);
>> > +
>> > +/**
>> > + * drm_fb_helper_kick_out_vgacon - deactivate vgacon driver.
>> > + *
>> > + * Deactivate vgacon driver so it stops accessing vga io ports.
>> > + * Should be called after
>> > + * drm_fb_helper_remove_conflicting_pci_framebuffers().
>> > + *
>> > + * Returns:
>> > + * Zero on success or negative error code on failure.
>> > + */
>> > +int drm_fb_helper_kick_out_vgacon(void)
>> > +{
>> > +#if !defined(CONFIG_VGA_CONSOLE)
>> > +        return 0;
>> > +#elif !defined(CONFIG_DUMMY_CONSOLE)
>> > +        return -ENODEV;
>> > +#else
>> 
>> Please retain the original way of keeping conditional compilation
>> outside of functions.
>
> Care to explain why that is better?

Prevalent and documented [1] kernel coding style. It's easier to see
what happens in each branch, and the compiler throws the alternatives
away anyway.

Patches that do code movement should focus on code movement. Any
additional changes should be separate, and justified separately. The
function rename and documentation are of course okay, and they're
mentioned in the commit message as they should.

BR,
Jani.


[1] Documentation/process/coding-style.rst

-- 
Jani Nikula, Intel Open Source Graphics Center
