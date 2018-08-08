Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EFBC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E46621729
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:19:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SlJgbUVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E46621729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbeHHPiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:38:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38010 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeHHPiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:38:51 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so3493781itb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rzM4TrpRj2WFQprRLUbO9Sq5ONQW8yf96gmBhYgVTwA=;
        b=SlJgbUVp5J/L/trhm1E4X4HPgYTfJs1KwnDkH3DBJLaDJK/4bgFHVT/9ZmAsYNCh7/
         3Ftcmsf7/wliBC4geaXkfZ5P8EbE52rdAa6ziR2rFRn1OSYelcJACrN1ojlNWPp2y8up
         1Xsu4DZlMbNaM91PPsF7ZDnpWmVkwohpGX9w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rzM4TrpRj2WFQprRLUbO9Sq5ONQW8yf96gmBhYgVTwA=;
        b=Y2It6xmmM8KHrP4H4StQSTEXKVMRsC4SJgmsFoICVRIwQMrLGDI5ahaugtOoUbxtxv
         OudtweGEyAo8Ml7HpHB2H7HdCrii9U5hpS0dSd1XTOA8DLUf9y1NIq5HvVadyllznBXB
         xydjg/l/yU1++RvwXCK8odAFFrRK5z/htCKmyAUkHDFifyHbTK4vM/kP6s1kr9/SS1HE
         7PRZ8Da8x9DFIimbZC03H0hOZTB9muDkQy46+aYqW57d6VL6hLYxiwKvRAu5JJYZ1o+p
         mvC9kTdmSvo0eEe6budcK0grE57venCdgvBOM4H4HgTZH+aP7dDVv1GDOBeqDpva643M
         AUOw==
X-Gm-Message-State: AOUpUlGIHmfkgq+/yKgYf32e+T64G9Z38WcZllDVZPw4JM5Q29glYRES
        PJvX4xLv2gqDudw/EoPjFxjZYl9pDJ92nuv8H4Jmrw==
X-Google-Smtp-Source: AA+uWPzaElsyud8a4WmlkiaDne1YwEVsCV/fMmOU1gHNoKPUPnoWZOVnb7yaqPy8d9t+EQ1oTBk9zaW3zDdtrizDDS0=
X-Received: by 2002:a02:4c16:: with SMTP id a22-v6mr2299375jab.48.1533734351105;
 Wed, 08 Aug 2018 06:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180806163946.28380-1-patrick.bellasi@arm.com> <20180806163946.28380-6-patrick.bellasi@arm.com>
In-Reply-To: <20180806163946.28380-6-patrick.bellasi@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 8 Aug 2018 15:18:59 +0200
Message-ID: <CAKfTPtC2adLupg7wy1JU9zxKx1466Sza6fSCcr92wcawm1OYkg@mail.gmail.com>
Subject: Re: [PATCH v3 05/14] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        "Cc: Steve Muckle" <smuckle@google.com>, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On Mon, 6 Aug 2018 at 18:40, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
>

> @@ -222,8 +222,13 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)

>         util = cpu_util_cfs(rq);
> +       if (util)
> +               util = uclamp_util(cpu_of(rq), util);
>         util += cpu_util_rt(rq);
>
>         /*

> @@ -322,11 +328,24 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,

> +       max_boost = sg_cpu->iowait_boost_max;
> +       if (!cpu_util_rt(cpu_rq(sg_cpu->cpu)))
> +               max_boost = uclamp_util(sg_cpu->cpu, max_boost);
> +

> +static inline unsigned int uclamp_value(unsigned int cpu, int clamp_id)
> +{
> +       struct uclamp_cpu *uc_cpu = &cpu_rq(cpu)->uclamp;
> +
> +       if (uc_cpu->value[clamp_id] == UCLAMP_NOT_VALID)
> +               return uclamp_none(clamp_id);
> +
> +       return uc_cpu->value[clamp_id];
> +}
> +

> +static inline unsigned int uclamp_util(unsigned int cpu, unsigned int util)

using struct *rq rq instead of cpu as parameter would align
uclamp_util() interface with other cpu_util_*() interface and remove
some cpu_of(rq) and  cpu_rq(cpu)
> +{
> +       unsigned int min_util = uclamp_value(cpu, UCLAMP_MIN);
> +       unsigned int max_util = uclamp_value(cpu, UCLAMP_MAX);
> +
> +       return clamp(util, min_util, max_util);
> +}
