Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2645C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160AE206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLRXRE29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbeLNOgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:36:45 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33207 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNOgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:36:44 -0500
Received: by mail-ua1-f66.google.com with SMTP id t8so2063881uap.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 06:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e/8zGrSU2HI4zjLOMPQvHJZbSNoy1zFPfOpGRwWhjMs=;
        b=TLRXRE29NxYRY+AsU3UFyE0LXfwRlgppc7M/PoMk1edbfMBJbEoypI6ETdDZBQBMd3
         3z4UEkMpAQw4PRAp82MAiu/iSYhgglZy5U05qMaUdXvsJpvTRVuvx/36Ams72d/3Ma4u
         tBkhCUQkFphgDhzRTnFfHQjODeO/s+XLh6iic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e/8zGrSU2HI4zjLOMPQvHJZbSNoy1zFPfOpGRwWhjMs=;
        b=ZZ4ZsCd+wiC4sRjz/aLbyuv8wLA95rVG4EmWxKIMlU2XhdvmvU56gyKqL97yV81Bcj
         Op7e3SB+C76V0lFvXfRkE1PsFPN9vg08jDEXu5n9oX6s9Hc9X9hegjgYL8Be1jhh1bR8
         A4+lVXelSi/d9wokYIytY1ySjgTmb17oIqx4SCI2WQCIksLPwWUq/DNyV+6McO+ThLGt
         Fmpo8UwFFnIIRsr1iWuP0iv0kjq1mesFRC17FYgX5y3M2X0f9A+655939z9mTKfQdX40
         t1zB5aSTCWjI+VuvfSiQWgaa5FUk1MnEkFyAdpKI4jZurl6RNpyI83sJ7tKRuWehcxGk
         hr1w==
X-Gm-Message-State: AA+aEWYuMLVhqTG7KA/eOFC86DFfEcTCsoUAYSA43KUgZO3aJK1kX1AQ
        FWwdUEFCyufk998KjV3gVe2G5qc6qOTto4Y0JyTkjA==
X-Google-Smtp-Source: AFSGD/W3f3FSmZ/wF49F+zXbnCRVg+R7I00eem8580lCPReKvePRs/X1rG08T88EE9EhV6+dGHPEcp5icd1uwPBMm1g=
X-Received: by 2002:ab0:3484:: with SMTP id c4mr1440647uar.39.1544798203011;
 Fri, 14 Dec 2018 06:36:43 -0800 (PST)
MIME-Version: 1.0
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org> <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Dec 2018 15:36:07 +0100
Message-ID: <CAPDyKFrvrN6+sVGc1sM+hmQo=JR=8FyAz_YRK9DzEQN2jOVX6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/i915: Move to new PM core fields
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

On Fri, 14 Dec 2018 at 15:22, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> With jiffies been replaced by raw ns in PM core accounting, 915 driver is
> updated to use this new time infrastructure.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  drivers/gpu/drm/i915/i915_pmu.c | 12 ++++++------
>  drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
> index d6c8f8f..cf6437d 100644
> --- a/drivers/gpu/drm/i915/i915_pmu.c
> +++ b/drivers/gpu/drm/i915/i915_pmu.c
> @@ -493,14 +493,14 @@ static u64 get_rc6(struct drm_i915_private *i915)
>                  */
>                 if (kdev->power.runtime_status == RPM_SUSPENDED) {
>                         if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
> -                               i915->pmu.suspended_jiffies_last =
> -                                                 kdev->power.suspended_jiffies;
> +                               i915->pmu.suspended_time_last =
> +                                       kdev->power.suspended_time;
>

Huh, so patch 2 introduces a complier error because of removing the
old fields. We can't have that.

Ideally the driver shouldn't touch these fields in the first place,
but because the fields are defined in a public header, there is always
a risk that they becomes abused. I would appreciate if we can change
the driver move away from using these fields and make that a patch
preceding patch 2.

> -                       val = kdev->power.suspended_jiffies -
> -                             i915->pmu.suspended_jiffies_last;
> -                       val += jiffies - kdev->power.accounting_timestamp;
> +                       val = kdev->power.suspended_time -
> +                               i915->pmu.suspended_time_last;
> +                       val += ktime_to_ns(ktime_get()) -
> +                               kdev->power.accounting_timestamp;
>
> -                       val = jiffies_to_nsecs(val);
>                         val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
>
>                         i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
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

Kind regards
Uffe
