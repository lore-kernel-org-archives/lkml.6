Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935005AbeBMLwJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:52:09 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:34159 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934456AbeBMLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:52:07 -0500
Date: Tue, 13 Feb 2018 12:52:06 +0100
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
Message-ID: <20180213115206.GA16075@wunner.de>
References: <cover.1518338788.git.lukas@wunner.de>
 <20180213105506.GF9111@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213105506.GF9111@e110455-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:55:06AM +0000, Liviu Dudau wrote:
> On Sun, Feb 11, 2018 at 10:38:28AM +0100, Lukas Wunner wrote:
> > DRM drivers poll connectors in 10 sec intervals.  The poll worker is
> > stopped on ->runtime_suspend with cancel_delayed_work_sync().  However
> > the poll worker invokes the DRM drivers' ->detect callbacks, which call
> > pm_runtime_get_sync().  If the poll worker starts after runtime suspend
> > has begun, pm_runtime_get_sync() will wait for runtime suspend to finish
> > with the intention of runtime resuming the device afterwards.  The result
> > is a circular wait between poll worker and autosuspend worker.
> 
> I think I understand the problem you are trying to solve, but I'm
> struggling to understand where malidp makes any specific mistakes. First
> of all, malidp is only a display engine, so there is no GPU attached to
> it, but that is only a small clarification. Second, malidp doesn't use
> directly any of the callbacks that you are referring to, it uses the
> drm_cma_xxxx() API plus the generic drm_xxxx() call. So if there are any
> issues there (as they might well be) I think they would apply to a lot
> more drivers and the fix will involve more than just malidp, i915 and
> msm.

I don't know if malidp makes any specific mistakes and didn't mean to
cast it in a negative light, sorry.

So a lot of DRM drivers acquire a runtime PM ref in the connector ->detect
hook because they can't probe connectors while runtime suspended.
E.g. for a PCI device, probing might require mmio access, which isn't
possible outside of power state D0.  There are no ->detect hooks declared
in drivers/gpu/drm/arm/, so it's unclear to me whether you're able to probe
during runtime suspend.

hdlcd_drv.c and malidp_drv.c both enable output polling.  Output polling
is only necessary if you don't get HPD interrupts.

You're not disabling polling upon runtime suspend.  Thus, if a runtime PM
ref is acquired during polling (such as in a ->detect hook), the GPU will
be runtime resumed every 10 secs.  You may want to verify that's not the
case.  If you decide that you do want to stop polling during runtime
suspend because it runtime resumes the GPU continuously, you'll need the
helper introduced in this series.  So by cc'ing you I just wanted to keep
you in the loop about an issue that may potentially affect your driver.

Let me know if there are any questions.

Thanks,

Lukas
