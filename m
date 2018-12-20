Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA62C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33BA21741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 22:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d8qw0krp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390129AbeLTWEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 17:04:05 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34016 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLTWEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 17:04:05 -0500
Received: by mail-vs1-f65.google.com with SMTP id y27so2076409vsi.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 14:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BOdjQ63e8C27dQDC7WTxFCCJnPfhoA/bwAMdeKeHT60=;
        b=d8qw0krpzABMvz2EX+YWzxhPISS5QZmftiBpxtkNbo9CR9fOCQqOd9cqutRimFC0Lf
         T8sPK8g3biR+EKi+fk8Rh6lqmM5ioOlFK1v0TEJB5/k5aKQJNe/8TbNNvMYWrckWrSnk
         VAPpaKVmZEU8vYFp3uyfAtW9ZDtFOP6Z967TI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOdjQ63e8C27dQDC7WTxFCCJnPfhoA/bwAMdeKeHT60=;
        b=Y7t3cpCq40zbom2xcvLZYwW6z/HmDg3XeePE18LtQtczmHwBMXIV8vIocoWGZNCiXX
         2FyLuTmL7/V1dqyzQBZNtdE4YouihiR7m+MZD6IUW3prfcF/BcVUO9JbKkXanKYlK+Rh
         /XX94LRBxdD+gVnT3SzdD1wzu+k1/RVPyf1QU2dWAlihSTjza6nNw+kVn+j6ybrmP3fn
         zzeDnI34uosR9x747zpzCVJwGIFenN6RfCzSUdf51MtJchdc+FnuYlZgMRh6+ZfDY1r2
         6YjlPzsSKeIuMlnAK7MjCDmuDFberZStlGjxo6758uK98guSYBjUbtcJrqX9WVUggAjA
         KDTg==
X-Gm-Message-State: AA+aEWa3741KVV4r5wu+CluoY6HYL1aySuWbfpgExApCSH1+/axz7/nR
        FAtlZ9Bbipzt1cbdYDvdmzhCRrjR/oM8IDp1oMzxETfA
X-Google-Smtp-Source: AFSGD/XInVmYhdlPz1yRIPhMoOib27vgezpKX+bj8VGPbfW64arTArl72Pj8DKCQ9X1oCfs0DwC4gcjTMEVnmwhFAxw=
X-Received: by 2002:a67:b245:: with SMTP id s5mr13144642vsh.200.1545343443971;
 Thu, 20 Dec 2018 14:04:03 -0800 (PST)
MIME-Version: 1.0
References: <1545315417-14483-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1545315417-14483-1-git-send-email-vincent.guittot@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Dec 2018 23:03:28 +0100
Message-ID: <CAPDyKFqZfCoL1N_Ca12mR0sk_JR7EhxchXGR_R3=9dFXu6Qoyw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] drm/i915: Move on the new pm runtime interface
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        jani.nikula@linux.intel.com,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        rodrigo.vivi@intel.com, David Airlie <airlied@linux.ie>,
        "Intel graphics driver community testing & development" 
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018 at 15:17, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> Use the new pm runtime interface to get the accounted suspended time:
> pm_runtime_accounted_time_get()

pm_runtime_suspended_time()

This change also makes quite some nice cleanups to the code, which is
mostly because of converting to the new runtime PM API. I think the
changelog deserves to state that, in some simple way.

>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Other than the minor things above:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 16 ++++++----------
>  drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
>  2 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index d6c8f8f..3f76f60 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/irq.h>
> +#include <linux/pm_runtime.h>
>  #include "i915_pmu.h"
>  #include "intel_ringbuffer.h"
>  #include "i915_drv.h"
> @@ -478,7 +479,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
>                  * counter value.
>                  */
>                 spin_lock_irqsave(&i915->pmu.lock, flags);
> -               spin_lock(&kdev->power.lock);
>
>                 /*
>                  * After the above branch intel_runtime_pm_get_if_in_use failed
> @@ -491,16 +491,13 @@ static u64 get_rc6(struct drm_i915_private *i915)
>                  * suspended and if not we cannot do better than report the last
>                  * known RC6 value.
>                  */
> -               if (kdev->power.runtime_status == RPM_SUSPENDED) {
> -                       if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> -                               i915->pmu.suspended_jiffies_last =
> -                                                 kdev->power.suspended_jiffies;
> +               if (pm_runtime_status_suspended(kdev)) {
> +                       val = pm_runtime_suspended_time(kdev);
>
> -                       val = kdev->power.suspended_jiffies -
> -                             i915->pmu.suspended_jiffies_last;
> -                       val += jiffies - kdev->power.accounting_timestamp;
> +                       if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> +                               i915->pmu.suspended_time_last = val;
>
> -                       val = jiffies_to_nsecs(val);
> +                       val -= i915->pmu.suspended_time_last;
>                         val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
>
>                         i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
> @@ -510,7 +507,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
>                         val = i915->pmu.sample[__I915_SAMPLE_RC6].cur;
>                 }
>
> -               spin_unlock(&kdev->power.lock);
>                 spin_unlock_irqrestore(&i915->pmu.lock, flags);
>         }
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
> index 7f164ca..3dc2a30 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.h
> +++ b/drivers/gpu/drm/i915/i915_pmu.h
> @@ -95,9 +95,9 @@ struct i915_pmu {
>          */
>         struct i915_pmu_sample sample[__I915_NUM_PMU_SAMPLERS];
>         /**
> -        * @suspended_jiffies_last: Cached suspend time from PM core.
> +        * @suspended_time_last: Cached suspend time from PM core.
>          */
> -       unsigned long suspended_jiffies_last;
> +       u64 suspended_time_last;
>         /**
>          * @i915_attr: Memory block holding device attributes.
>          */
> --
> 2.7.4
>
