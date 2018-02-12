Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935124AbeBLNEM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:04:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:16449 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933646AbeBLNEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:04:11 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,501,1511856000";
   d="scan'208";a="19298663"
Date: Mon, 12 Feb 2018 15:04:06 +0200
From: Imre Deak <imre.deak@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Ismo Toijala <ismo.toijala@gmail.com>, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, Liviu Dudau <Liviu.Dudau@arm.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans de Goede <hdegoede@redhat.com>, Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH 0/5] Fix deadlock on runtime suspend in DRM drivers
Message-ID: <20180212130406.5dsh7rm47azeyev7@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <cover.1518338788.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518338788.git.lukas@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:38:28AM +0100, Lukas Wunner wrote:
> [...]
> i915, malidp and msm "solved" this issue by not stopping the poll worker
> on runtime suspend.  But this results in the GPU bouncing back and forth
> between D0 and D3 continuously.  That's a total no-go for GPUs which
> runtime suspend to D3cold since every suspend/resume cycle costs a
> significant amount of time and energy.  (i915 and malidp do not seem
> to acquire a runtime PM ref in the ->detect callbacks, which seems
> questionable.  msm however does and would also deadlock if it disabled
> the poll worker on runtime suspend.  cc += Archit, Liviu, intel-gfx)

In i915 polling is on during runtime suspend only if there are outputs
without hotplug interrupt support. A special case is when an output has
working HPD interrupts when in D0, but no interrupts when runtime
suspended. For these we start polling (from a scheduled work) in the
runtime suspend hook and stop it in the runtime resume hook (again from
a scheduled work).

Imo whether to leave polling on or not for the above purpose is a policy
question (configurable with the drm_kms_helper.poll param).

--Imre

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
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
