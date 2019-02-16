Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F6C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B691222DD
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfBPGBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 01:01:02 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:50415 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfBPGBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 01:01:02 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 4762C100D940E;
        Sat, 16 Feb 2019 07:00:59 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0601016D4FC; Sat, 16 Feb 2019 07:00:58 +0100 (CET)
Date:   Sat, 16 Feb 2019 07:00:58 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        ?????????????? ???????????????? <ukrkyi@gmail.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] gpu: drm: radeon: Set DPM_FLAG_NEVER_SKIP when enabling
 PM-runtime
Message-ID: <20190216060058.gsiddsmj3f27e6v7@wunner.de>
References: <2281684.8tZHfIXjiu@aspire.rjw.lan>
 <CADnq5_NmDYzZZPUh5Wp+a8bycRWFDt3Lhzf0AKx9BECJ_U-Kyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_NmDYzZZPUh5Wp+a8bycRWFDt3Lhzf0AKx9BECJ_U-Kyg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 11:01:04AM -0500, Alex Deucher wrote:
> On Fri, Feb 15, 2019 at 10:39 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On HP ProBook 4540s, if PM-runtime is enabled in the radeon driver
> > and the direct-complete optimization is used for the radeon device
> > during system-wide suspend, the system doesn't resume.
> >
> > Preventing direct-complete from being used with the radeon device by
> > setting the DPM_FLAG_NEVER_SKIP driver flag for it makes the problem
> > go away, which indicates that direct-complete is not safe for the
> > radeon driver in general and should not be used with it (at least
> > for now).
> >
> > This fixes a regression introduced by commit c62ec4610c40
> > ("PM / core: Fix direct_complete handling for devices with no
> > callbacks") which allowed direct-complete to be applied to
> > devices without PM callbacks (again) which in turn unlocked
> > direct-complete for radeon on HP ProBook 4540s.
> 
> Do other similar drivers like amdgpu and nouveau need the same fix?
> I'm not too familiar with the direct_complete feature in general.

direct_complete means that a discrete GPU which is in D3cold upon
entering system sleep is left as is, i.e. it is not woken.  It is
also expected to still be in D3cold when resuming from system sleep
from the PM core's point of view.  (If it is in D0uninitialized, the
GPU's driver needs to ensure it is transitioned to D3cold again.)

I know for a fact that resuming the discrete GPU is not necessary
on my MacBook Pro with Nvidia GPU.  I'd expect those with AMD GPUs
to behave the same.  The apple-gmux driver takes care of putting
the GPU into D3cold on resume from system sleep if it was in D3cold
when entering system sleep (see drivers/platform/x86/apple-gmux.c,
gmux_resume()).

I think it is desirable to use direct_complete because it saves power
(no need to gratuitously wake the GPU upon entering system sleep,
only to immediately cut its power) and it also speeds up the suspend
process by about half a second.

The root cause on the HP ProBook 4540s needs to be debugged, I'd
suspect a BIOS issue which could be adressed by a quirk, either for
this particular machine or for a certain class of devices (e.g. all
machines which use PR3 to transition to D3cold) if that is necessary
to behave identically to Windows.  Or maybe the atpx vga_switcheroo
handler needs to be amended to put the GPU into D3cold on resume from
system sleep if it was runtime suspended before.

Is this machine using s2idle or does it suspend to S3?

Thanks,

Lukas

> > Fixes: c62ec4610c40 ("PM / core: Fix direct_complete handling for devices with no callbacks")
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=201519
> > Reported-by: ?????????????? ???????????????? <ukrkyi@gmail.com>
> > Tested-by: ?????????????? ???????????????? <ukrkyi@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/gpu/drm/radeon/radeon_kms.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > Index: linux-pm/drivers/gpu/drm/radeon/radeon_kms.c
> > ===================================================================
> > --- linux-pm.orig/drivers/gpu/drm/radeon/radeon_kms.c
> > +++ linux-pm/drivers/gpu/drm/radeon/radeon_kms.c
> > @@ -172,6 +172,7 @@ int radeon_driver_load_kms(struct drm_de
> >         }
> >
> >         if (radeon_is_px(dev)) {
> > +               dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
> >                 pm_runtime_use_autosuspend(dev->dev);
> >                 pm_runtime_set_autosuspend_delay(dev->dev, 5000);
> >                 pm_runtime_set_active(dev->dev);
