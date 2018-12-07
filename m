Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B3EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E145420850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E145420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLGI00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:26:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeLGI00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:26:26 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45E65A0BF6;
        Fri,  7 Dec 2018 08:26:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB5CF105B1E0;
        Fri,  7 Dec 2018 08:26:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B30AF8FE4; Fri,  7 Dec 2018 09:26:23 +0100 (CET)
Date:   Fri, 7 Dec 2018 09:26:23 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Frediano Ziglio <fziglio@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [Spice-devel] [PATCH 1/3] drm/qxl: allow both PRIV and VRAM
 placement for QXL_GEM_DOMAIN_SURFACE
Message-ID: <20181207082623.ebj5ea4h33f244l3@sirius.home.kraxel.org>
References: <20181206104638.23330-1-kraxel@redhat.com>
 <20181206104638.23330-2-kraxel@redhat.com>
 <1897496108.48579647.1544093758850.JavaMail.zimbra@redhat.com>
 <20181206113416.yydgi7ro47vwgf2d@sirius.home.kraxel.org>
 <885772449.48610143.1544107194097.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <885772449.48610143.1544107194097.JavaMail.zimbra@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 07 Dec 2018 08:26:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 09:39:54AM -0500, Frediano Ziglio wrote:
> > 
> > On Thu, Dec 06, 2018 at 05:55:58AM -0500, Frediano Ziglio wrote:
> > > 
> > > > qxl surfaces (used for framebuffers and gem objects) can live in both
> > > > VRAM and PRIV ttm domains.  Update placement setup to include both.  Put
> > > > PRIV first in the list so it is preferred, so VRAM will have more room
> > > > for objects which must be allocated there.
> > > > 
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > 
> > > I remember these kind of changes in the past made migration
> > > fails. I proposed similar patches years ago and they were rejected
> > > for these reasons.
> > 
> > Pointer?
> 
> I think is this:
> https://patchwork.kernel.org/patch/7374931/

Ok, problem is you are doing it for both QXL_GEM_DOMAIN_VRAM and
QXL_GEM_DOMAIN_SURFACE.  Surfaces can be in both VRAM and PRIV ttm
domains, so for the later this is fine.  Most other allocations must be
in VRAM ttm domain though, so allowing PRIV for QXL_GEM_DOMAIN_VRAM is
*not* ok.

Noticed I need patch 1/2 of that series, otherwise things will break
when we run out of space in PRIV domain and surfaces are allocated in
VRAM.

> > Well, you have to be careful what object you are allocating.  Surfaces
> > can be in both PRIV and VRAM.  Everything else (qxl commands, monitors
> > config, ...) must be in VRAM.
> > 
> > > Looks like we are improving QXL, so that means we are actively working
> > > on it.
> > 
> > Well, I'm just trying make qxl behave better with wayland.
> > 
> 
> As far as I remember the Linux kernel driver simulates the frame buffer
> swap with drawings which cause more memory copies.

Yes.  wayland renders into a dumb gem bo (backed by a qxl surface),
Actual primary surface is a shadow bo though.  Display updates are done
by sending a draw command for the primary surface, with the pixel data
coming from the dumb gem bo.

We could maybe optimize that, by having the image chunk point directly
to the dumb gem bo instead of allocating memory and memcpy'ing the pixel
data.

I don't feel like putting too much effort into qxl performance
optimization though.  The time is better spent on virtio-gpu I think.

BTW: should I send virtio-gpu kernel patches to spice-devel too?

> Not also sure if this workaround make the server consume more network
> bandwidth.

Doesn't make much of a difference I think.  In case we improve qxl/spice
to support (a) one surface per monitor and (b) pageflips so we don't
need the shadow bo, then we would still need to send the pixel data.

> Are we supporting multiple monitors for Wayland?

I have patches for that.  Which basically extend the shadow logic, so
the shadow bo used as primary surface will be big enough that all
heads/monitors/crtcs fit in.  qxl/spice has a single surface then, while
userspace (i.e. wayland) can use one dumb gem bo per head/monitor/crtc.

Guess I should re-send them with spice-devel cc'ed,

> > Main advantage is that it doesn't need qxl device changes, so it works
> > on old hosts too.  But, yes, we can consider to also modernize spice
> > protocol and qxl device.
> 
> On the other hand we faced some bugs due these workarounds so we end up
> with a solution that is less optimal than before and potentially
> with more bugs to fix.

Ahem, well, not really.

Adding support for atomic modesetting to qxl caused some regressions
indeed.  Those should be fixed meanwhile.

Anything which was done in the qxl driver for wayland (most notably the
shadow logic) improved the situation for wayland.  wayland is pretty
much unusable without shadowing.  I'm not aware of any xorg regressions
caused by dumb bo shadowing.  xorg doesn't use dumb bo's in the first
place, and it composes its own qxl drawing commands instead of expecting
the qxl kms driver handle the update on pageflip.

cheers,
  Gerd

