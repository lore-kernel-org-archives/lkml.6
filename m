Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EAFC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0134F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0134F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJIPDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:03:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45074 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIPDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:03:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id u22so625131ota.12;
        Tue, 09 Oct 2018 00:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Egn/kGyioReOJ4yUMi6ESPkt6MOWUiS4ngDBvejSGQ0=;
        b=X9Ea1dGBKEIWr6hFMWdPmh7DvAzEPlgquMw+piPIsdgVMaVIi5RKXw7nJsjd2cJPYu
         2fvEyCTN1go32cSOLWHjZ+yh25Yq+tgHZpxm86poi/p+yABetw8r3EBC5AK90tBKm4Bi
         LCEY3Zm9FPLNh/fciKP1fAn/ifOgTSDhoFVfnxPIvxURJGTiIr3LderEI2c0PIMhBfSS
         zGKjYNbDwzMRMykwD0bfShm8njPMwbyssC42mydPrhPiku5TspEs6+MfjMeVXbBgg23A
         qwhzjyHf/5PVGoaMedqT3Crc0yrSnvaRH17799CQu7i71LJKWwfa6xrjIuu7tx5/Rn/c
         qxuQ==
X-Gm-Message-State: ABuFfohZUEAywdsKWog65v1k4DBulaaknKZol/YYYdKJYUs3oXLjWcSt
        CFEm8A4pKv98/sG2K/QfDl5DvSkIszRF9n1r5Gs=
X-Google-Smtp-Source: ACcGV61sIVOJEv5BdQWQVuIktzbHtaOGn9kU5V+rd+CIsiARF7yr8B4aXqNbcE+T6DhsMN/ntHWjjzkwOHHKN14Yszg=
X-Received: by 2002:a9d:34f:: with SMTP id 73mr17103548otv.343.1539071271973;
 Tue, 09 Oct 2018 00:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
In-Reply-To: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Oct 2018 09:47:40 +0200
Message-ID: <CAJZ5v0j0GLHgKS9+mafm3eoFMuNEo6VPa3LhRthg+H5OKHhFqA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: conservative: Fix requested_freq handling
To:     Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 5:11 PM Waldemar Rymarkiewicz
<waldemar.rymarkiewicz@gmail.com> wrote:
>
> From: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
>
> The governor updates dbs_info->requested_freq only after increasing or
> decreasing frequency. There is, however, an use case when this is not
> sufficient.
>
> Imagine, external module constraining cpufreq policy in a way that policy->max

Is the "external module" here a utility or a demon running in user space?

> = policy->min = max_available_freq (eg. 1Ghz). CPUfreq will set freq to
> max_freq and conservative gov will not try downscale/upscale due to the
> limits. It will just exit instead
>
>     if (requested_freq > policy->max || requested_freq < policy->min)
>             //max=min=1Ghz -> requested_freq=cur=1Ghz
>             requested_freq = policy->cur;
>     [...]
>     if (requested_freq == policy->max)
>              goto out;
>
> In a result, dbs_info->requested_freq is not updated with newly calculated
> requested_freq=1Ghz. Next, execution of update routine will use again
> previously stored requested_freq (in my case it was min_available_freq)
>
>     [...]
>     unsigned int requested_freq = dbs_info->requested_freq;
>     [....]
>
> Now, when external module returns to previous policy limits that is
> policy->min = min_available_freq and policy->max = max_available_freq,
> conservative governor is not able to decrease frequency because stored
> requested_freq is still or rather already set to min_available_freq so
> the check (for decreasing)
>
>     [...]
>     if (load < cs_tuners->down_threshold) {
>     [....]
>            if (requested_freq == policy->min)
>                    goto out;
>     [...]
>
> returns from routine before it does any freq change. To fix that just update
> dbs_info->requested_freq every time we go out from the update routine.
>
> Signed-off-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index f20f20a..7f90f6e 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -113,7 +113,6 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>                         requested_freq = policy->max;
>
>                 __cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_H);
> -               dbs_info->requested_freq = requested_freq;
>                 goto out;
>         }
>
> @@ -136,10 +135,10 @@ static unsigned int cs_dbs_update(struct cpufreq_policy *policy)
>                         requested_freq = policy->min;
>
>                 __cpufreq_driver_target(policy, requested_freq, CPUFREQ_RELATION_L);
> -               dbs_info->requested_freq = requested_freq;
>         }
>
>   out:
> +       dbs_info->requested_freq = requested_freq;

This will have a side effect when requested_freq is updated before the
thresholds checks due to the policy_dbs->idle_periods < UINT_MAX
check.

Shouldn't that be avoided?

>         return dbs_data->sampling_rate;
>  }
