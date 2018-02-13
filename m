Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934358AbeBMKzN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 05:55:13 -0500
Received: from foss.arm.com ([217.140.101.70]:55314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934011AbeBMKzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 05:55:09 -0500
Date: Tue, 13 Feb 2018 10:55:06 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Lukas Wunner <lukas@wunner.de>
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
Message-ID: <20180213105506.GF9111@e110455-lin.cambridge.arm.com>
References: <cover.1518338788.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1518338788.git.lukas@wunner.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

On Sun, Feb 11, 2018 at 10:38:28AM +0100, Lukas Wunner wrote:
> Fix a deadlock on hybrid graphics laptops that's been present since 2013:
> 
> DRM drivers poll connectors in 10 sec intervals.  The poll worker is
> stopped on ->runtime_suspend with cancel_delayed_work_sync().  However
> the poll worker invokes the DRM drivers' ->detect callbacks, which call
> pm_runtime_get_sync().  If the poll worker starts after runtime suspend
> has begun, pm_runtime_get_sync() will wait for runtime suspend to finish
> with the intention of runtime resuming the device afterwards.  The result
> is a circular wait between poll worker and autosuspend worker.
> 
> I'm seeing this deadlock so often it's not funny anymore. I've also found
> 3 nouveau bugzillas about it and 1 radeon bugzilla. (See patch [3/5] and
> [4/5].)
> 
> One theoretical solution would be to add a flag to the ->detect callback
> to tell it that it's running in the poll worker's context.  In that case
> it doesn't need to call pm_runtime_get_sync() because the poll worker is
> only enabled while runtime active and we know that ->runtime_suspend
> waits for it to finish.  But this approach would require touching every
> single DRM driver's ->detect hook.  Moreover the ->detect hook is called
> from numerous other places, both in the DRM library as well as in each
> driver, making it necessary to trace every possible call chain and check
> if it's coming from the poll worker or not.  I've tried to do that for
> nouveau (see the call sites listed in the commit message of patch [3/5])
> and concluded that this approach is a nightmare to implement.
> 
> Another reason for the infeasibility of this approach is that ->detect
> is called from within the DRM library without driver involvement, e.g.
> via DRM's sysfs interface.  In those cases, pm_runtime_get_sync() would
> have to be called by the DRM library, but the DRM library is supposed to
> stay generic, wheras runtime PM is driver-specific.
> 
> So instead, I've come up with this much simpler solution which gleans
> from the current task's flags if it's a workqueue worker, retrieves the
> work_struct and checks if it's the poll worker.  All that's needed is
> one small helper in the workqueue code and another small helper in the
> DRM library.  This solution lends itself nicely to stable-backporting.
> 
> The patches for radeon and amdgpu are compile-tested only, I only have a
> MacBook Pro with an Nvidia GK107 to test.  To test the patches, add an
> "msleep(12*1000);" at the top of the driver's ->runtime_suspend hook.
> This ensures that the poll worker runs after ->runtime_suspend has begun.
> Wait 12 sec after the GPU has begun runtime suspend, then check
> /sys/bus/pci/devices/0000:01:00.0/power/runtime_status.  Without this
> series, the status will be stuck at "suspending" and you'll get hung task
> errors in dmesg after a few minutes.
> 
> i915, malidp and msm "solved" this issue by not stopping the poll worker
> on runtime suspend.  But this results in the GPU bouncing back and forth
> between D0 and D3 continuously.  That's a total no-go for GPUs which
> runtime suspend to D3cold since every suspend/resume cycle costs a
> significant amount of time and energy.  (i915 and malidp do not seem
> to acquire a runtime PM ref in the ->detect callbacks, which seems
> questionable.  msm however does and would also deadlock if it disabled
> the poll worker on runtime suspend.  cc += Archit, Liviu, intel-gfx)

I think I understand the problem you are trying to solve, but I'm
struggling to understand where malidp makes any specific mistakes. First
of all, malidp is only a display engine, so there is no GPU attached to
it, but that is only a small clarification. Second, malidp doesn't use
directly any of the callbacks that you are referring to, it uses the
drm_cma_xxxx() API plus the generic drm_xxxx() call. So if there are any
issues there (as they might well be) I think they would apply to a lot
more drivers and the fix will involve more than just malidp, i915 and
msm.

Would love to get any clarifications on what I might have misunderstood.

Best regards,
Liviu


> 
> Please review.  Thanks,
> 
> Lukas
> 
> Lukas Wunner (5):
>   workqueue: Allow retrieval of current task's work struct
>   drm: Allow determining if current task is output poll worker
>   drm/nouveau: Fix deadlock on runtime suspend
>   drm/radeon: Fix deadlock on runtime suspend
>   drm/amdgpu: Fix deadlock on runtime suspend
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 58 +++++++++++++-------
>  drivers/gpu/drm/drm_probe_helper.c             | 14 +++++
>  drivers/gpu/drm/nouveau/nouveau_connector.c    | 18 +++++--
>  drivers/gpu/drm/radeon/radeon_connectors.c     | 74 +++++++++++++++++---------
>  include/drm/drm_crtc_helper.h                  |  1 +
>  include/linux/workqueue.h                      |  1 +
>  kernel/workqueue.c                             | 16 ++++++
>  7 files changed, 132 insertions(+), 50 deletions(-)
> 
> -- 
> 2.15.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
