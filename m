Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbeDDIP5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:15:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:3790 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751167AbeDDIPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:15:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,405,1517904000";
   d="scan'208";a="43882174"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Xidong Wang <wangxidong_97@163.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Xidong Wang <wangxidong_97@163.com>
Subject: Re: [PATCH 1/1] drm/i915:Do not use kfree() to free kmem_cache_alloc() return value
In-Reply-To: <1522823851-28177-1-git-send-email-wangxidong_97@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1522823851-28177-1-git-send-email-wangxidong_97@163.com>
Date: Wed, 04 Apr 2018 11:16:42 +0300
Message-ID: <87y3i38jyt.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Apr 2018, Xidong Wang <wangxidong_97@163.com> wrote:
> In eb_lookup_vmas(), lut, the return value of kmem_cache_alloc(), is freed
> with kfree().I think the expected paired function is kmem_cache_free().

Agreed. But did you try to compile your patch before sending?

Fixes: d1b48c1e7184 ("drm/i915: Replace execbuf vma ht with an idr")
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: <stable@vger.kernel.org> # v4.14+

BR,
Jani.

>
> Signed-off-by: Xidong Wang <wangxidong_97@163.com>
> ---
>  drivers/gpu/drm/i915/i915_gem_execbuffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> index 8c170db..08fe476 100644
> --- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> +++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
> @@ -728,7 +728,7 @@ static int eb_lookup_vmas(struct i915_execbuffer *eb)
>  
>  		err = radix_tree_insert(handles_vma, handle, vma);
>  		if (unlikely(err)) {
> -			kfree(lut);
> +			kmem_cache_free(lut);
>  			goto err_obj;
>  		}

-- 
Jani Nikula, Intel Open Source Technology Center
