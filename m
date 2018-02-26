Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeBZPbp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:31:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:39490 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751628AbeBZPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:31:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="33712202"
From: Jani Nikula <jani.nikula@intel.com>
To: Chris Wilson <chris@chris-wilson.co.uk>, linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jean Delvare <khali@linux-fr.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Zhong <zhong@linux.vnet.ibm.com>,
        Petri Latvala <petri.latvala@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] kernel: Downgrade warning for unsafe parameters
In-Reply-To: <20180226151919.9674-1-chris@chris-wilson.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180226151919.9674-1-chris@chris-wilson.co.uk>
Date: Mon, 26 Feb 2018 17:31:32 +0200
Message-ID: <87tvu322ej.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> As using an unsafe module parameter is, by its very definition, an
> expected user action, emitting a warning is overkill. Nothing has yet
> gone wrong, and we add a taint flag for any future oops should
> something actually go wrong. So instead of having a user controllable
> pr_warn, downgrade it to a pr_notice for "a normal, but significant
> condition".
>
> We make use of unsafe kernel parameters in igt (we have not yet
> succeeded in removing all such debugging options), which generates a
> warning and taints the kernel. The warning is unhelpful as we then need
> to filter it out again as we check that every test themselves do not
> provoke any kernel warnings.

IGT being https://cgit.freedesktop.org/drm/igt-gpu-tools/ for those not
in the DRM/KMS circles.

> References: 91f9d330cc14 ("module: make it possible to have unsafe, tainting module params")
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Li Zhong <zhong@linux.vnet.ibm.com>
> Cc: Petri Latvala <petri.latvala@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>

Acked-by: Jani Nikula <jani.nikula@intel.com>

When I added the unsafe module params, I erred on the side of making
more noise about tainting, but there was really no discussion about
it. FWIW, I don't mind the change, as long as it's not debug level.

BR,
Jani.

> ---
>  kernel/params.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/params.c b/kernel/params.c
> index cc9108c2a1fd..ce89f757e6da 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -111,8 +111,8 @@ bool parameq(const char *a, const char *b)
>  static void param_check_unsafe(const struct kernel_param *kp)
>  {
>  	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
> -		pr_warn("Setting dangerous option %s - tainting kernel\n",
> -			kp->name);
> +		pr_notice("Setting dangerous option %s - tainting kernel\n",
> +			  kp->name);
>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>  	}
>  }

-- 
Jani Nikula, Intel Open Source Technology Center
