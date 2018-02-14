Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030608AbeBNN5P (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:57:15 -0500
Received: from mailout3.hostsharing.net ([176.9.242.54]:59369 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030221AbeBNN5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:57:14 -0500
Date: Wed, 14 Feb 2018 14:57:11 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org, Peter Wu <peter@lekensteyn.nl>,
        nouveau@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pierre Moreau <pierre.morrow@free.fr>, linux-kernel@vger.kernel.org,
        Ismo Toijala <ismo.toijala@gmail.com>, intel-gfx@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH 0/5] Fix deadlock on runtime suspend in DRM drivers
Message-ID: <20180214135711.vg7ht2htlprypmie@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
 <20180213105506.GF9111@e110455-lin.cambridge.arm.com>
 <20180213115206.GA16075@wunner.de>
 <20180213154608.GI9111@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213154608.GI9111@e110455-lin.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 03:46:08PM +0000, Liviu Dudau wrote:
> On Tue, Feb 13, 2018 at 12:52:06PM +0100, Lukas Wunner wrote:
> > On Tue, Feb 13, 2018 at 10:55:06AM +0000, Liviu Dudau wrote:
> > > On Sun, Feb 11, 2018 at 10:38:28AM +0100, Lukas Wunner wrote:
> > > > DRM drivers poll connectors in 10 sec intervals.  The poll worker is
> > > > stopped on ->runtime_suspend with cancel_delayed_work_sync().  However
> > > > the poll worker invokes the DRM drivers' ->detect callbacks, which call
> > > > pm_runtime_get_sync().  If the poll worker starts after runtime suspend
> > > > has begun, pm_runtime_get_sync() will wait for runtime suspend to finish
> > > > with the intention of runtime resuming the device afterwards.  The result
> > > > is a circular wait between poll worker and autosuspend worker.
> > > 
> > > I think I understand the problem you are trying to solve, but I'm
> > > struggling to understand where malidp makes any specific mistakes. First
> > > of all, malidp is only a display engine, so there is no GPU attached to
> > > it, but that is only a small clarification. Second, malidp doesn't use
> > > directly any of the callbacks that you are referring to, it uses the
> > > drm_cma_xxxx() API plus the generic drm_xxxx() call. So if there are any
> > > issues there (as they might well be) I think they would apply to a lot
> > > more drivers and the fix will involve more than just malidp, i915 and
> > > msm.
[snip]
> > There are no ->detect hooks declared
> > in drivers/gpu/drm/arm/, so it's unclear to me whether you're able to probe
> > during runtime suspend.
> 
> That's because the drivers in drivers/gpu/drm/arm do not have
> connectors, they are only the CRTC part of the driver. Both hdlcd and
> mali-dp use the component framework to locate an encoder in device tree
> that will then provide the connectors.
> 
> > 
> > hdlcd_drv.c and malidp_drv.c both enable output polling.  Output polling
> > is only necessary if you don't get HPD interrupts.
> 
> That's right, hdlcd and mali-dp don't receive HPD interrupts because
> they don't have any. And because we don't know ahead of time which
> encoder/connector will be paired with the driver, we enable polling as a
> safe fallback.
> 

Looking e.g. at inno_hdmi.c (used by rk3036.dtsi), this calls
drm_helper_hpd_irq_event() on receiving an HPD interrupt, and that
function returns immediately if polling is not enabled.  So you *have*
to enable polling to receive HPD events.

You seem to keep the crtc runtime active as long as it's bound to an
encoder.  If you do not ever intend to runtime suspend the crtc while
an encoder is attached, you don't need to keep polling enabled during
runtime suspend (because there's nothing to poll), but it shouldn't
hurt either.

If you would runtime suspend while an encoder is attached, then you
would only runtime resume every 10 sec (upon polling) if the encoder
was a child of the crtc and would support runtime suspend as well.
That's because the PM core wakes the parent by default when a child
runtime resumes.  However in the DT's I've looked at, the encoder
is never a child of the crtc and at least inno_hdmi.c doesn't use
runtime suspend.

So I think you're all green, I can't spot any grave issues here.
Just be aware of the above-mentioned constraints.

Thanks,

Lukas
