Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B9C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E5C21871
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 15:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="WX8iWyI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbeLXPDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 10:03:21 -0500
Received: from lekensteyn.nl ([178.21.112.251]:40181 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbeLXPDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 10:03:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=ohS3+PHUm3lehlZuXJw8J4yZcIA4GZafGJfx8hEq4NQ=;
        b=WX8iWyI9IZ89I72r5Ogspbnj/wP4I5AbgeghQT00xGWGvu5R+H6X0JC/X2ZWLJJFh8MpvwYRM2LHSSO+IXrdWGQqAqolRf5S6vfQimPWTlCQ4DUpapef8nWHkNC0QzWdwz6+AOpNfDprpBbJH5HKwtKDrIXSQ8dazkDBlJQ3So3q1yJx947lDLJKuCjmQAt0f+oJVcxSYUbzDmunlzpTHcVgzaAlsSBmH2hchfefm+EVTdErcvweZqARtpHVuvkmj2adq4Sx9VHHdVwPMwRzt+aq8jCbTXC8HbSYftbj2rV4j4ARFadAriFVe+ArJpc79anQ6IubjCTDJblFBuZw8Q==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1gbRl2-0003o9-Hh; Mon, 24 Dec 2018 16:03:05 +0100
Date:   Mon, 24 Dec 2018 16:03:02 +0100
From:   Peter Wu <peter@lekensteyn.nl>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rong.a.chen@intel.com, kraxel@redhat.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [PATCH] drm/fb-helper: fix leaks in error path of
 drm_fb_helper_fbdev_setup
Message-ID: <20181224150302.GA2259@al>
References: <20181223004315.GA11455@al>
 <20181223005507.28328-1-peter@lekensteyn.nl>
 <ad4be2e7-b53c-97b5-7029-83f4017e4643@tronnes.org>
 <20181223231033.GA31596@al>
 <80d98ab2-dbf8-8d77-e5ca-07995cef0f1b@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80d98ab2-dbf8-8d77-e5ca-07995cef0f1b@tronnes.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 03:52:55PM +0100, Noralf Trønnes wrote:
> 
> 
> Den 24.12.2018 00.10, skrev Peter Wu:
> > On Sun, Dec 23, 2018 at 02:55:52PM +0100, Noralf Trønnes wrote:
> > > 
> > > 
> > > Den 23.12.2018 01.55, skrev Peter Wu:
> > > > After drm_fb_helper_fbdev_setup calls drm_fb_helper_init,
> > > > "dev->fb_helper" will be initialized (and thus drm_fb_helper_fini will
> > > > have some effect). After that, drm_fb_helper_initial_config is called
> > > > which may call the "fb_probe" driver callback.
> > > > 
> > > > This driver callback may call drm_fb_helper_defio_init (as is done by
> > > > drm_fb_helper_generic_probe) or set a framebuffer (as is done by bochs)
> > > > as documented. These are normally cleaned up on exit by
> > > > drm_fb_helper_fbdev_teardown which also calls drm_fb_helper_fini.
> > > > 
> > > > If an error occurs after "fb_probe", but before setup is complete, then
> > > > calling just drm_fb_helper_fini will leak resources. This was triggered
> > > > by df2052cc922 ("bochs: convert to drm_fb_helper_fbdev_setup/teardown"):
> > > > 
> > > >       [   50.008030] bochsdrmfb: enable CONFIG_FB_LITTLE_ENDIAN to support this framebuffer
> > > >       [   50.009436] bochs-drm 0000:00:02.0: [drm:drm_fb_helper_fbdev_setup] *ERROR* fbdev: Failed to set configuration (ret=-38)
> > > >       [   50.011456] [drm] Initialized bochs-drm 1.0.0 20130925 for 0000:00:02.0 on minor 2
> > > >       [   50.013604] WARNING: CPU: 1 PID: 1 at drivers/gpu/drm/drm_mode_config.c:477 drm_mode_config_cleanup+0x280/0x2a0
> > > >       [   50.016175] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G                T 4.20.0-rc7 #1
> > > >       [   50.017732] EIP: drm_mode_config_cleanup+0x280/0x2a0
> > > >       ...
> > > >       [   50.023155] Call Trace:
> > > >       [   50.023155]  ? bochs_kms_fini+0x1e/0x30
> > > >       [   50.023155]  ? bochs_unload+0x18/0x40
> > > > 
> > > > This can be reproduced with QEMU and CONFIG_FB_LITTLE_ENDIAN=n.
> > > > 
> > > > Link: https://lkml.kernel.org/r/20181221083226.GI23332@shao2-debian
> > > > Link: https://lkml.kernel.org/r/20181223004315.GA11455@al
> > > > Fixes: 8741216396b2 ("drm/fb-helper: Add drm_fb_helper_fbdev_setup/teardown()")
> > > > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > > > Cc: Noralf Trønnes <noralf@tronnes.org>
> > > > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > > > ---
> > > >    drivers/gpu/drm/drm_fb_helper.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > > > index 9d64f874f965..432e0f3b9267 100644
> > > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > > @@ -2860,7 +2860,7 @@ int drm_fb_helper_fbdev_setup(struct drm_device *dev,
> > > >    	return 0;
> > > >    err_drm_fb_helper_fini:
> > > > -	drm_fb_helper_fini(fb_helper);
> > > > +	drm_fb_helper_fbdev_teardown(dev);
> > > 
> > > This change will break the error path for drm_fbdev_generic_setup()
> > > because drm_fb_helper_generic_probe() cleans up on error but doesn't
> > > clear drm_fb_helper->fb resulting in a double drm_framebuffer_remove().
> > 
> > This should probably considered a bug of drm_fb_helper_generic_probe.
> > Ownership of fb_helper should remain with the caller. The caller can
> > detect an error and act accordingly.
> > 
> > > My assumption has been that the drm_fb_helper_funcs->fb_probe callback
> > > cleans up its resources on error. Clearly this is not the case for bochs, so
> > > my take on this is that bochsfb_create() needs to clean up on error.
> > 
> > That assumption still holds for bochs. The problem is this sequence:
> > - drm_fb_helper_fbdev_setup is called.
> > - fb_probe succeeds (this is crucial).
> > - register_framebuffer fails.
> > - error path of setup is triggered.
> > 
> > As fb_helper is fully setup by drivers, the drm_fb_helper core should
> > fully deallocate it again on the error path or else a leak occurs.
> > 
> > > Gerd has a patchset that switches bochs over to the generic fbdev
> > > emulation, but ofc that doesn't help with 4.20:
> > > https://patchwork.freedesktop.org/series/54269/
> > 
> > And that does not help with other users of the drm_fb_helper who use
> > functions like drm_fb_helper_defio_init. They will likely run in the
> > same problem.
> > 
> > I don't have a way to test tinydrm or other drivers, but if you force
> > register_framebuffer to fail, you should be able to reproduce the
> > problem with drm_fb_helper_generic_probe.
> > 
> 
> Now I understand. I have looked at the drivers that use drm_fb_helper
> and no one seem to handle the case where register_framebuffer() is
> failing.
> 
> Here's what drivers do when drm_fb_helper_initial_config() fails:
> 
> Doesn't check:
> amdgpu
> virtio
> 
> Calls drm_fb_helper_fini():
> armada
> ast
> exynos
> gma500
> hisilicon
> mgag200
> msm
> nouveau
> omap
> radeon
> rockchip
> tegra
> udl
> bochs - Uses drm_fb_helper_fbdev_setup()
> qxl - Uses drm_fb_helper_fbdev_setup()
> vboxvideo - Uses drm_fb_helper_fbdev_setup()
> 
> Might clean up, not sure:
> cirrus
> 
> Looks suspicious:
> i915
> 
> I looked at bochs before it switched to drm_fb_helper_fbdev_setup() and
> it also just called drm_fb_helper_fini().
> 
> It looks like you've uncovered something no one has though about (or
> not implemented at least).
> 
> It's not just the framebuffer that's not destroyed, the buffer object
> is also leaked. drm_mode_config_cleanup() yells about the framebuffer
> (and frees it), but says nothing about the buffer object. It might be
> that it can't even be made to detect that since some drivers do special
> stuff for the fbdev buffer.
> 
> I'll pick up on this and do some testing after the Christmas holidays.

Thanks, the warning is bad for CI (which uses QEMU), but otherwise it
should not have any effect on regular users so it can wait.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
