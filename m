Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A07AC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEA921917
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OT008qz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfBGVgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:36:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33427 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGVgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:36:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2so1157723edi.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 13:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=M5J9jxWnNtxZW4ZbFuF/fAPbPpeL4maUkxRYf0Docd4=;
        b=OT008qz0eaI29UW0Wxqay/oXHrO6J/r5PtTWCYjcnqEyREBkOkIA+97Vr5ywjJTKCu
         Y/ezKVYhTafW5jgEadFwyJ2rk3DE/wqVvUP1nZcf5TytPnArKT1WsGfssaHajJ/NaGfG
         0yWD86LQWZ5+i4rHEHUB8reEqY/VcKnyqsso4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=M5J9jxWnNtxZW4ZbFuF/fAPbPpeL4maUkxRYf0Docd4=;
        b=uk4fFL9UaOU+lKAu7t+N1m1N5MWRHdFks8e4EvHvROyl02kOO5SnlJ7fx0pkPbPhZs
         TRZNWG4orKTg6QBjnzBKD5v3i8pBqrFioAALK54JlXAA4cCcyX48qnTU/k2iBphY5ryY
         ocTASD2jLXlfwGXZWaHI32cxpy68Ar3ZbZmMdMBxjpzo/QKm7kFs9Z9uD5XwOdsDn3wr
         4pz0M3Cr1UJ5lkafDOlxxMxEdB0dUHsX7Z3qNX2QjBtVqJ0jN3G9UvajfDs4Q3biC3pk
         iUmFtnGFfsjEts8vbbeV86TJUXv7rsVT1/u+X3sKxREM7C/P+EExRZ9Try9WII1STvC6
         PfIA==
X-Gm-Message-State: AHQUAuY/zBcQ6KAp2rXw80rHeQRg5FW7jhnZPGQHIvHBuSjOVLLzd/9x
        kCR9dweVreWygvwd5mr7iDIObQ==
X-Google-Smtp-Source: AHgI3IZWdyfnbRNZrEDQVVien6GKCl4cdDRtGQHDTE5i9z1H0WIIP2AtemOZ0Xl9AqtnD4D52b9xJw==
X-Received: by 2002:a05:6402:1552:: with SMTP id p18mr13028587edx.4.1549575363619;
        Thu, 07 Feb 2019 13:36:03 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id y14sm91679eju.58.2019.02.07.13.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 13:36:02 -0800 (PST)
Date:   Thu, 7 Feb 2019 22:35:53 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/5] drm: minimize drmP.h dependencies
Message-ID: <20190207213553.GA23159@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Sean Paul <sean@poorly.run>,
        intel-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190126122527.11647-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190126122527.11647-1-sam@ravnborg.org>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 01:25:22PM +0100, Sam Ravnborg wrote:
> Updated patchset, with merged patches removed, new patches added.
> 
> > From the original mail:
> 
>         - drmP.h is now stripped down to include files
>           and forward declarations.
>         - All header files in include/drm/ no longer include drmP.h.
> 
> The series was made on top of drm-misc-next:
> f1a2a540c86441016ce3dff6590b7a09080871de ("video/hdmi: Add an enum for HDMI packet types")

Entire series applied to drm-misc-next, and this time around nothing new
popped up! Thanks for sticking through this.

Cheers, Daniel

> 
> Build tested using arm and x86, ia64, alpha, sparc32, sparc64
> Included staging/vboxvideo in the build test - which revealed
> the build issues Daniel had identifed
> 
> This series include fixes to i915 as it looks in drm-misc.
> This series also include fixes to stagin/vboxvideo, which I
> expect to be committet to drm-misc due to the final patch
> (drmP.h removal from drm_modeset_helper.h) depending on this patch.
> 
> Daniel - thanks for being paitent and applying this piecemal.
> 
>         Sam
> v6:
> - include fixes to vboxvideo (Daniel)
> - include i915 build fixes
> - revised/new rcar-du patch (lots of new build failures popped up)
> - split updates to drm/*.c file to dedicated patch,
>   to make the final removal patch slimmer
> 
> v5:
> - Rebased on top of drm-misc-next and dropped patches already merged
> - Sorted list of include files where they are touched (Laurent)
> - Collected ack's, reviewed by's
> 
> v4:
> - Rebased on top of drm-misc-next and dropped patches already merged
> - Include build test of kirin (Daniel)
> - Plug drm_util.h into drm-internals.rst (Daniel)
> - Fix kernel-doc syntax in drm_util.h (Daniel)
> - Split removal of drmP.h from drm_modeset_helper.h
>   in smaller patches, to ease the merge process
> 
> v3:
> - Added Acks/Reviewed annotations (thanks!)
> - Add forward of drm_gem_object to drm_framebuffer.h (Noralf)
> - Drop "drm: move DRM_IF_VERSION to drm_internal.h" as it is applied to drm-misc
> - Drop "drm: make drm_file.h self contained" as Jan made a similar patch that was appleid to drm-misc
> - Rebased on top of drm-misc-next
> 
> v2:
> - DRM_SWITCH_POWER as enum (Daniel Vetter)
> - Prefer forward decalration over includes (Laurent Pinchart)
> - Updated drm_device to use kerneldoc style (Daniel Vetter)
> - Improved commit messages (David Lechner)
> - Split up patch when removing drmP.h from drm_gem_cma_helper.h
> - rebased on top of drm-misc-next
> - dropped patch already applied
> - added reviewed-by from Laurent Pinchart (Laurent Pinchart)
> - add drm_framebuffer.h patch
> - add kernel-doc comments to drm_util.h
> - moved EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h
> - added note to drmP.h not to add new stuff and not to use in new files
> 
> Sam Ravnborg (5):
>       staging/vboxvideo: prepare for drmP.h removal from drm_modeset_helper.h
>       drm/i915: prepare for drmP.h removal from drm_modeset_helper.h
>       drm/rcar-du: prepare for drmP.h removal from drm_modeset_helper.h
>       drm: prepare for drmP.h removal from drm_modeset_helper.h
>       drm: remove drmP.h from drm_modeset_helper.h
> 
>  drivers/gpu/drm/drm_damage_helper.c       |  1 +
>  drivers/gpu/drm/drm_modeset_helper.c      |  2 ++
>  drivers/gpu/drm/i915/i915_drv.c           |  4 +++-
>  drivers/gpu/drm/i915/intel_atomic.c       |  2 ++
>  drivers/gpu/drm/i915/intel_atomic_plane.c |  2 ++
>  drivers/gpu/drm/i915/intel_display.c      | 29 ++++++++++++++++-------------
>  drivers/gpu/drm/i915/intel_pm.c           |  7 +++++--
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c    |  3 +++
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c     |  1 +
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c     |  2 ++
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c   |  2 ++
>  drivers/gpu/drm/rcar-du/rcar_du_vsp.c     |  1 +
>  drivers/staging/vboxvideo/vbox_drv.c      |  6 +++++-
>  drivers/staging/vboxvideo/vbox_fb.c       | 18 ++++++++++--------
>  drivers/staging/vboxvideo/vbox_mode.c     |  5 ++++-
>  include/drm/drm_modeset_helper.h          |  6 +++++-
>  16 files changed, 64 insertions(+), 27 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
