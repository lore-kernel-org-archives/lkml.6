Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932850AbeCMMbm convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:31:42 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:51417 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752390AbeCMMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:31:39 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Arnd Bergmann <arnd@arndb.de>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180313120848.2658626-1-arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@arndb.de>,
        "Tvrtko Ursulin" <tvrtko.ursulin@intel.com>,
        "Michal Wajdeczko" <michal.wajdeczko@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20180313120848.2658626-1-arnd@arndb.de>
Message-ID: <152094429237.515.2412380565628307987@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] drm/i915/pmu: avoid -Wmaybe-uninitialized warning
Date: Tue, 13 Mar 2018 12:31:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2018-03-13 12:08:29)
> The conditional spinlock confuses gcc into thinking the 'flags' value
> might contain uninitialized data:
> 
> drivers/gpu/drm/i915/i915_pmu.c: In function '__i915_pmu_event_read':
> arch/x86/include/asm/paravirt_types.h:573:3: error: 'flags' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> The code is correct, but it's easy to see how the compiler gets confused
> here. This avoids the problem by pulling the lock outside of the function
> into its only caller.
> 
> Fixes: 1fe699e30113 ("drm/i915/pmu: Fix sleep under atomic in RC6 readout")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index 4bc7aefa9541..2c8c705d1f18 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -415,7 +415,6 @@ static u64 __get_rc6(struct drm_i915_private *i915)
>  static u64 get_rc6(struct drm_i915_private *i915, bool locked)

bool locked is now unused, right?

>  {
>  #if IS_ENABLED(CONFIG_PM)
> -       unsigned long flags;
>         u64 val;
>  
>         if (intel_runtime_pm_get_if_in_use(i915)) {
> @@ -428,18 +427,12 @@ static u64 get_rc6(struct drm_i915_private *i915, bool locked)
>                  * previously.
>                  */
>  
> -               if (!locked)
> -                       spin_lock_irqsave(&i915->pmu.lock, flags);
> -
>                 if (val >= i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur) {
>                         i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = 0;
>                         i915->pmu.sample[__I915_SAMPLE_RC6].cur = val;
>                 } else {
>                         val = i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur;
>                 }
> -
> -               if (!locked)
> -                       spin_unlock_irqrestore(&i915->pmu.lock, flags);
>         } else {
>                 struct pci_dev *pdev = i915->drm.pdev;
>                 struct device *kdev = &pdev->dev;
> @@ -452,9 +445,6 @@ static u64 get_rc6(struct drm_i915_private *i915, bool locked)
>                  * on top of the last known real value, as the approximated RC6
>                  * counter value.
>                  */
> -               if (!locked)
> -                       spin_lock_irqsave(&i915->pmu.lock, flags);
> -
>                 spin_lock_irqsave(&kdev->power.lock, flags2);
>  
>                 if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> @@ -470,9 +460,6 @@ static u64 get_rc6(struct drm_i915_private *i915, bool locked)
>                 val = jiffies_to_nsecs(val);
>                 val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
>                 i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
> -
> -               if (!locked)
> -                       spin_unlock_irqrestore(&i915->pmu.lock, flags);
>         }
>  
>         return val;
> @@ -519,8 +506,16 @@ static u64 __i915_pmu_event_read(struct perf_event *event, bool locked)
>                         val = count_interrupts(i915);
>                         break;
>                 case I915_PMU_RC6_RESIDENCY:
> -                       val = get_rc6(i915, locked);
> -                       break;
> +                       if (!locked) {
> +                               unsigned long flags;
> +
> +                               spin_lock_irqsave(&i915->pmu.lock, flags);
> +                               val = get_rc6(i915, locked);
> +                               spin_unlock_irqrestore(&i915->pmu.lock, flags);
> +                               break;
> +                       } else {
> +                               val = get_rc6(i915, locked);
> +                       }

break is now on one path only; should be here.
-Chris
