Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeBSOF7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:05:59 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:32952 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBSOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:05:57 -0500
X-Google-Smtp-Source: AH8x226rDgUasKSlZhY4gQat/mI7ayzAPPsPCzGSt2k5PWGzGkdsrTiIUk6i3PZZTIesYvYtBMpp4w==
Date: Mon, 19 Feb 2018 15:05:53 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Lukas Wunner <lukas@wunner.de>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Ismo Toijala <ismo.toijala@gmail.com>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, Liviu Dudau <Liviu.Dudau@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [Intel-gfx] [Nouveau] [PATCH 0/5] Fix deadlock on runtime
 suspend in DRM drivers
Message-ID: <20180219140553.GA22199@phenom.ffwll.local>
Mail-Followup-To: Lukas Wunner <lukas@wunner.de>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Archit Taneja <architt@codeaurora.org>,
        Ismo Toijala <ismo.toijala@gmail.com>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Liviu Dudau <Liviu.Dudau@arm.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>
References: <cover.1518338788.git.lukas@wunner.de>
 <20180219113443.GU22199@phenom.ffwll.local>
 <20180219115817.4e5ml4jdh22kbvs4@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219115817.4e5ml4jdh22kbvs4@wunner.de>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 12:58:17PM +0100, Lukas Wunner wrote:
> On Mon, Feb 19, 2018 at 12:34:43PM +0100, Daniel Vetter wrote:
> > On Sun, Feb 11, 2018 at 10:38:28AM +0100, Lukas Wunner wrote:
> > > Fix a deadlock on hybrid graphics laptops that's been present since 2013:
> > > 
> > > DRM drivers poll connectors in 10 sec intervals.  The poll worker is
> > > stopped on ->runtime_suspend with cancel_delayed_work_sync().  However
> > > the poll worker invokes the DRM drivers' ->detect callbacks, which call
> > > pm_runtime_get_sync().  If the poll worker starts after runtime suspend
> > > has begun, pm_runtime_get_sync() will wait for runtime suspend to finish
> > > with the intention of runtime resuming the device afterwards.  The result
> > > is a circular wait between poll worker and autosuspend worker.
> > 
> > Don't shut down the poll worker when runtime suspending, that' doesn't
> > work. If you need the poll work, then that means waking up the gpu every
> > few seconds. If you don't need it, then make sure the DRM_CONNECTOR_POLL
> > flags are set correctly (you can update them at runtime, the poll worker
> > will pick that up).
> > 
> > That should fix the deadlock, and it's how we do it in i915 (where igt in
> > CI totally hammers the runtime pm support, and it seems to hold up).
> 
> It would fix the deadlock but it's not an option on dual GPU laptops.
> Power consumption of the discrete GPU is massive (9 W on my machine).
> 
> 
> > > i915, malidp and msm "solved" this issue by not stopping the poll worker
> > > on runtime suspend.  But this results in the GPU bouncing back and forth
> > > between D0 and D3 continuously.  That's a total no-go for GPUs which
> > > runtime suspend to D3cold since every suspend/resume cycle costs a
> > > significant amount of time and energy.  (i915 and malidp do not seem
> > > to acquire a runtime PM ref in the ->detect callbacks, which seems
> > > questionable.  msm however does and would also deadlock if it disabled
> > > the poll worker on runtime suspend.  cc += Archit, Liviu, intel-gfx)
> > 
> > Well, userspace expects hotplug events, even when we runtime suspend
> > stuff. Hence waking shit up with polling. Imo ignoring hotplug events is a
> > pretty serious policy decision which is ok in the context of
> > vga_switcheroo, but not really as an automatic thing. E.g. usb also wakes
> > up if you plug something in, even with all the runtime pm stuff enabled.
> > Same for sata and everything else.
> 
> On the MacBook Pro, the HPD pin of external DP and HDMI ports goes into
> the gmux controller, which sends an interrupt on hotplug even if the GPU
> is powered down.
> 
> Apparently Optimus has a similar functionality, cf. 3a6536c51d5d.

Yeah, for vga_switcheroo and gmux setups shutting down polling explicitly
makes sense. I think ideally we'd stop polling in the gmux handler somehow
(maybe by dropping the relevant DRM_CONNECTOR_POLL flags, or outright
stopping it all). But not when runtime suspending the entire gpu (e.g.
idle system that shuts down the screen and everything, before it decides
a few minutes later to do a full system suspend).

I also think that this approach would lead to cleaner code, having
explicit checks for the (locking) execution context all over the place
tends to result in regrets eventually ime.

> For the rare cases where an external VGA or DVI-A port is present, I guess
> it's reasonable to have the user wake up the machine manually.
> 
> I'm not sure why nouveau polls ports on my laptop, the GK107 only has an
> LVDS and three DP ports, need to investigate.

Yeah, that'd be good to figure out. The probe helpers should shut down the
worker if there's no connector that needs probing. We use that to
enable/disable the poll worker when there's a hotplug storm on the irq
line.

Once that's fixed we can perhaps also untangle the poll-vs-gmux story.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
