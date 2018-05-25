Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935709AbeEYHEx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 03:04:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:60734 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934393AbeEYHEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 03:04:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,439,1520924400";
   d="scan'208";a="58391694"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Joe Perches <joe@perches.com>, Russell King <linux@armlinux.org.uk>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, Rob Clark <robdclark@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Roger He <Hongbo.He@amd.com>, Dave Airlie <airlied@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] gpu: Consistently use octal not symbolic permissions
In-Reply-To: <2108eb98b35ab682d44ca7bf40276e93d9566bbf.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <9b0f5f5cf6bccc003beef82f0972be655613075d.1527193246.git.joe@perches.com> <87a7so44q5.fsf@intel.com> <2108eb98b35ab682d44ca7bf40276e93d9566bbf.camel@perches.com>
Date: Fri, 25 May 2018 10:04:40 +0300
Message-ID: <8736yg43nb.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018, Joe Perches <joe@perches.com> wrote:
> On Fri, 2018-05-25 at 09:41 +0300, Jani Nikula wrote:
>> On Thu, 24 May 2018, Joe Perches <joe@perches.com> wrote:
>> > There is currently a mixture of octal and symbolic permissions uses
>> > in files in drivers/gpu/drm and one file in drivers/gpu.
>> > 
>> > There are ~270 existing octal uses and ~115 S_<FOO> uses.
>> > 
>> > Convert all the S_<FOO> symbolic permissions to their octal equivalents
>> > as using octal and not symbolic permissions is preferred by many as more
>> > readable.
>> > 
>> > see: https://lkml.org/lkml/2016/8/2/1945
>> > 
>> > Done with automated conversion via:
>> > $ ./scripts/checkpatch.pl -f --types=SYMBOLIC_PERMS --fix-inplace <files...>
>> > 
>> > Miscellanea:
>> > 
>> > o Wrapped modified multi-line calls to a single line where appropriate
>> > o Realign modified multi-line calls to open parenthesis
>> > o drivers/gpu/drm/msm/adreno/a5xx_debugfs.c has a world-writeable
>> >   debug permission for "reset" - perhaps that should be modified
>> > Signed-off-by: Joe Perches <joe@perches.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  2 +-
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c             | 98 +++++++++++-----------
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |  3 +-
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  9 +-
>> >  drivers/gpu/drm/armada/armada_debugfs.c            |  4 +-
>> >  drivers/gpu/drm/drm_debugfs.c                      |  6 +-
>> >  drivers/gpu/drm/drm_debugfs_crc.c                  |  4 +-
>> >  drivers/gpu/drm/drm_sysfs.c                        |  2 +-
>> >  drivers/gpu/drm/i915/gvt/firmware.c                |  2 +-
>> >  drivers/gpu/drm/i915/i915_debugfs.c                |  8 +-
>> >  drivers/gpu/drm/i915/i915_perf.c                   |  2 +-
>> >  drivers/gpu/drm/i915/i915_sysfs.c                  | 22 ++---
>> >  drivers/gpu/drm/i915/intel_pipe_crc.c              |  2 +-
>> 
>> Please send at least i915 changes separately. There's zero reason to
>> make our lives harder for this change.
>
> The idea is to avoid unnecessary multiple patches for
> individual trees.

You're changing like a dozen trees. And apparently maintainers of
different trees also have different opinions on whether this is a good
idea or not. Mass changes like this go nowhere, and if they do, will
cause unnecessary conflicts that could have been trivially avoided.

BR,
Jani.

> But you could do that via something like:
>
> $ git am --include='drivers/gpu/drm/i915/*' <patch>
>
> cheers, Joe
>

-- 
Jani Nikula, Intel Open Source Graphics Center
