Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeCMRrA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 13:47:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:28217 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751871AbeCMRq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 13:46:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,465,1515484800";
   d="scan'208";a="41634874"
Subject: Re: [Intel-gfx] [PATCH] [v2] drm/i915/pmu: avoid
 -Wmaybe-uninitialized warning
To: Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20180313161952.552083-1-arnd@arndb.de>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Message-ID: <ce356e4a-31af-4bea-8e75-e484e663f19c@linux.intel.com>
Date: Tue, 13 Mar 2018 17:46:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313161952.552083-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/03/2018 16:19, Arnd Bergmann wrote:
> The conditional spinlock confuses gcc into thinking the 'flags' value
> might contain uninitialized data:
> 
> drivers/gpu/drm/i915/i915_pmu.c: In function '__i915_pmu_event_read':
> arch/x86/include/asm/paravirt_types.h:573:3: error: 'flags' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Hm, how does paravirt_types.h comes into the picture?

> The code is correct, but it's easy to see how the compiler gets confused
> here. This avoids the problem by pulling the lock outside of the function
> into its only caller.

Is it specific gcc version, specific options, or specific kernel config 
that this happens?

Strange that it hasn't been seen so far.

Regards,

Tvrtko

> Fixes: 1fe699e30113 ("drm/i915/pmu: Fix sleep under atomic in RC6 readout")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: removed unused function argument, fixed 'break' statement.
> ---
>   drivers/gpu/drm/i915/i915_pmu.c | 25 ++++++++++---------------
>   1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index 4bc7aefa9541..d6b9b6b5fb98 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -412,10 +412,9 @@ static u64 __get_rc6(struct drm_i915_private *i915)
>   	return val;
>   }
>   
> -static u64 get_rc6(struct drm_i915_private *i915, bool locked)
> +static u64 get_rc6(struct drm_i915_private *i915)
>   {
>   #if IS_ENABLED(CONFIG_PM)
> -	unsigned long flags;
>   	u64 val;
>   
>   	if (intel_runtime_pm_get_if_in_use(i915)) {
> @@ -428,18 +427,12 @@ static u64 get_rc6(struct drm_i915_private *i915, bool locked)
>   		 * previously.
>   		 */
>   
> -		if (!locked)
> -			spin_lock_irqsave(&i915->pmu.lock, flags);
> -
>   		if (val >= i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur) {
>   			i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = 0;
>   			i915->pmu.sample[__I915_SAMPLE_RC6].cur = val;
>   		} else {
>   			val = i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur;
>   		}
> -
> -		if (!locked)
> -			spin_unlock_irqrestore(&i915->pmu.lock, flags);
>   	} else {
>   		struct pci_dev *pdev = i915->drm.pdev;
>   		struct device *kdev = &pdev->dev;
> @@ -452,9 +445,6 @@ static u64 get_rc6(struct drm_i915_private *i915, bool locked)
>   		 * on top of the last known real value, as the approximated RC6
>   		 * counter value.
>   		 */
> -		if (!locked)
> -			spin_lock_irqsave(&i915->pmu.lock, flags);
> -
>   		spin_lock_irqsave(&kdev->power.lock, flags2);
>   
>   		if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> @@ -470,9 +460,6 @@ static u64 get_rc6(struct drm_i915_private *i915, bool locked)
>   		val = jiffies_to_nsecs(val);
>   		val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
>   		i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
> -
> -		if (!locked)
> -			spin_unlock_irqrestore(&i915->pmu.lock, flags);
>   	}
>   
>   	return val;
> @@ -519,7 +506,15 @@ static u64 __i915_pmu_event_read(struct perf_event *event, bool locked)
>   			val = count_interrupts(i915);
>   			break;
>   		case I915_PMU_RC6_RESIDENCY:
> -			val = get_rc6(i915, locked);
> +			if (!locked) {
> +				unsigned long flags;
> +
> +				spin_lock_irqsave(&i915->pmu.lock, flags);
> +				val = get_rc6(i915);
> +				spin_unlock_irqrestore(&i915->pmu.lock, flags);
> +			} else {
> +				val = get_rc6(i915);
> +			}
>   			break;
>   		}
>   	}
> 
