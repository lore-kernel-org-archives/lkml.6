Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A824AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5283620852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBHXAV3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5283620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935230AbeFRKyC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:54:02 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46632 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbeFRKyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:54:00 -0400
Received: by mail-ot0-f195.google.com with SMTP id v24-v6so9403806otk.13;
        Mon, 18 Jun 2018 03:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pMFg/EHgG0zDtNGmsOxBaginePYCVGQ+X6IxsfidSas=;
        b=SBHXAV3ACyiuFLboJvxbj4z3Ei4ZwuvXXb88dci3u+6Mv3bJIMO7S1TDkM9iA6KbR8
         OTbHTEmsdW0XgIgSoqo+8W3we0samUv7/BMl9ZfQHyz9pr05NArCmCagwzRqkf6juegI
         RzfqB5aJnSSSwbDEl7p4OIYFKa/KukVSl7YNWjebuB4av91AIhsOBY17Cw8HM7SgsRFK
         WNWwmbdUaHT9b3xR+D1gv8tLRc3BDWuZqzrZdlduFxEg1OCQbRa+yUmsoPCc/0bPjsEl
         SUg8Tl2m6sGZPBwosl6DiEvMAoO2CGwmp/qHL38hJ3sSekzJ3nhZnugeC4+dDTnxPS2w
         AoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pMFg/EHgG0zDtNGmsOxBaginePYCVGQ+X6IxsfidSas=;
        b=CPzZCzYXWk/ZW5e6SqrjJ5SC5MosEFVnwspb1tQjBv7kiBZCEdzQW6SIguMs46V401
         F7nqa5tg9td5fnL/O+QYUu1h7xUAu8PJbL5HWvK0D48NvxMbvsrqYJOduVHZfpvaA921
         4sMsv19HLeJg8R/Klzg7t++laKLx0gTgHNfmwo8gtnXqmC3NLo56xY0BXCI9eiMcbZsX
         2koBV3UM1sOxKraRyoPHyqqqH5fxrSMUpk16+kM/ggyNWiDTbK9FUyDSWKwDytsIh/Bo
         y97uENz5+xIr81W2uDWwKQASvbkmrUt9PJ6R22ui3U75BFK17mRe/Y1LOruZLh0BH+CY
         ODcg==
X-Gm-Message-State: APt69E1WqeIkiJ6CKC3Pijxqr+nOdW4M8IH34kxR2UhRPCOjRmqulQot
        1qhNaajgmr8KE1PDg4f3Ie0KI6oC0+lua9n5uEI=
X-Google-Smtp-Source: ADUXVKLvaPBL+eSSiLYcT4zpwE9rUSd7b0zXwHHtjb/GCTs2WqSYHcS0HhTy4NAFZmjBwrOmHzZ5FbV++tXTbaJPcRk=
X-Received: by 2002:a9d:3e4c:: with SMTP id h12-v6mr7035568otg.150.1529319239735;
 Mon, 18 Jun 2018 03:53:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 03:53:59
 -0700 (PDT)
In-Reply-To: <20180615211209.58478-1-srinivas.pandruvada@linux.intel.com>
References: <20180615211209.58478-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Jun 2018 12:53:59 +0200
X-Google-Sender-Auth: iqWdxrQfdsApREKoMvFUnxXOsxo
Message-ID: <CAJZ5v0gUyr1B2YUrPDf62rXjHxWR3Ss1noLbm6wDW5QJdv=jKA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Fix scaling max/min limits with
 Turbo 3.0
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:12 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> When scaling max/min settings are changed, internally they are converted
> to a ratio using the max turbo 1 core turbo frequency. This works fine
> when 1 core max is same irrespective of the core. But under Turbo 3.0,
> this will not be the case. For example:
> Core 0: max turbo pstate: 43 (4.3GHz)
> Core 1: max turbo pstate: 45 (4.5GHz)
> In this case 1 core turbo ratio will be maximum of all, so it will be
> 45 (4.5GHz). Suppose scaling max is set to 4GHz (ratio 40) for all cores
> ,then on core one it will be
>  = max_state * policy->max / max_freq;
>  = 43 * (4000000/4500000) = 38 (3.8GHz)
>  = 38
> which is 200MHz less than the desired.
> On core2, it will be correctly set to ratio 40 (4GHz). Same holds true
> for scaling min frequency limit. So this requires usage of correct turbo
> max frequency for core one, which in this case is 4.3GHz. So we need to
> adjust per CPU cpu->pstate.turbo_freq using the maximum HWP ratio of that
> core.
>
> This change uses the HWP capability of a core to adjust max turbo
> frequency. But since Broadwell HWP doesn't use ratios in the HWP
> capabilities, we have use legacy max 1 core turbo ratio. This is not a
> problem as the HWP capabilities don't differ among cores in Broadwell.
> So we need to check for non Broadwell CPU model for applying this change.
>
> While doing this change also optimize usage of x86_match_cpu(). Currently
> using, different x86_cpu_id structure values for each feature. We can
> consolidate, so that we don't have to introduce one more here. Added HWP
> feature flag to each CPU model, instead of a new definition.

I'd prefer a fix that can be propagated to -stable and then the
optimization as a separate patch.

>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 43 ++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 1de5ec8..26d1fc7 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -308,6 +308,12 @@ static struct global_params global;
>  static DEFINE_MUTEX(intel_pstate_driver_lock);
>  static DEFINE_MUTEX(intel_pstate_limits_lock);
>
> +#define INTEL_PSTATE_HWP_FEATURE_DISABLE_EE    0x01
> +#define INTEL_PSTATE_HWP_PERF_BOOST            0x02
> +#define INTEL_PSTATE_HWP_BROADWELL             0x04
> +
> +static u32 intel_pstate_hwp_features;

Why isn't it a member of strict cpudata?

> +
>  #ifdef CONFIG_ACPI
>
>  static bool intel_pstate_get_ppc_enable_status(void)
> @@ -1413,7 +1419,16 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>         cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
>         cpu->pstate.scaling = pstate_funcs.get_scaling();
>         cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
> -       cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> +
> +       if (hwp_active &&
> +           !(intel_pstate_hwp_features & INTEL_PSTATE_HWP_BROADWELL)) {
> +               unsigned int phy_max, current_max;
> +
> +               intel_pstate_get_hwp_max(cpu->cpu, &phy_max, &current_max);
> +               cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
> +       } else {
> +               cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
> +       }
>
>         if (pstate_funcs.get_aperf_mperf_shift)
>                 cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
> @@ -1789,14 +1804,16 @@ static const struct x86_cpu_id intel_pstate_cpu_oob_ids[] __initconst = {
>         {}
>  };
>
> -static const struct x86_cpu_id intel_pstate_cpu_ee_disable_ids[] = {
> -       ICPU(INTEL_FAM6_KABYLAKE_DESKTOP, core_funcs),
> -       {}
> -};
> -
> -static const struct x86_cpu_id intel_pstate_hwp_boost_ids[] = {
> -       ICPU(INTEL_FAM6_SKYLAKE_X, core_funcs),
> -       ICPU(INTEL_FAM6_SKYLAKE_DESKTOP, core_funcs),
> +#define ICPU1(model, feature) \
> +       { X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
> +        feature}
> +
> +static const struct x86_cpu_id intel_pstate_hwp_feature_ids[] = {
> +       ICPU1(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
> +       ICPU1(INTEL_FAM6_BROADWELL_XEON_D, INTEL_PSTATE_HWP_BROADWELL),
> +       ICPU1(INTEL_FAM6_KABYLAKE_DESKTOP, INTEL_PSTATE_HWP_FEATURE_DISABLE_EE),
> +       ICPU1(INTEL_FAM6_SKYLAKE_DESKTOP, INTEL_PSTATE_HWP_PERF_BOOST),
> +       ICPU1(INTEL_FAM6_SKYLAKE_X, INTEL_PSTATE_HWP_PERF_BOOST),
>         {}
>  };
>
> @@ -1825,14 +1842,16 @@ static int intel_pstate_init_cpu(unsigned int cpunum)
>         if (hwp_active) {
>                 const struct x86_cpu_id *id;
>
> -               id = x86_match_cpu(intel_pstate_cpu_ee_disable_ids);
> +               id = x86_match_cpu(intel_pstate_hwp_feature_ids);
>                 if (id)
> +                       intel_pstate_hwp_features = id->driver_data;
> +
> +               if (intel_pstate_hwp_features & INTEL_PSTATE_HWP_FEATURE_DISABLE_EE)
>                         intel_pstate_disable_ee(cpunum);
>
>                 intel_pstate_hwp_enable(cpu);
>
> -               id = x86_match_cpu(intel_pstate_hwp_boost_ids);
> -               if (id)
> +               if (intel_pstate_hwp_features & INTEL_PSTATE_HWP_PERF_BOOST)
>                         hwp_boost = true;
>         }
>
> --
> 2.7.5
>
