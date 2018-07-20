Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01387ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E35520673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="euqzlOqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E35520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbeGTFjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 01:39:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36938 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeGTFjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 01:39:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id n7-v6so5744748pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 21:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxhkMrbaxebjOm6h7Yg6Zyigby/9hyd16t2QLtWOKuc=;
        b=euqzlOqd5li+10Qo1s0moSpvwpIwecKecccamLu4mRd2uJ5n3XKm0o6K1iJIwdqIOy
         lesaM1bIKllX8T/WMNezN9goef4kp3S0MPCyAUo0WJr2t6ERAihb9NxvIdyoTVxspi92
         /BeDusgwtDL7F226UDVAIUx3j6GdMwQ7s2Dm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxhkMrbaxebjOm6h7Yg6Zyigby/9hyd16t2QLtWOKuc=;
        b=K1q08/VdEbP0cONAup4uGypKX/JhYrmOV6PSSkTRJWt1H2SDryJTdXuUJ/Y+aVnbFM
         BFJG/IyHmNLZd/Qp/ZBriz1TvrmlCJd3eJy0KC4lXBJ5rNR9VyAlWQaGbZjtnehXBeB3
         T9deLk0z46yGuurfP0j9DWDjaSdi0WHtnsMAIfLcy+J5uYjPBJYrW0RqDeKloMdkiOJl
         qDAvvO7lLUMi23DRPJziWY2r+pttJgNV2cPdYUSxQvrCkdACWBl4Jp5lthV+13XsoiEP
         YcZJ0tzENjUgX5QakFWrxbh2JI7tdjK69VflQoVHTr2gsQzjUA3JTm5bKUhezFktH4ak
         i0aw==
X-Gm-Message-State: AOUpUlFVDtC9okBqEJi71MOJjzblfY8NK+dSRg5trq15dVQEqR6mXqvs
        skK29Dx7b28SANPYZEqIJQMT7Q==
X-Google-Smtp-Source: AAOMgpftNcl0myrdINgqMxCUdmpnThRlHaGhmtOw06x9zFJiE9kbTm259VQ+e/5KWp5kaZ5JUwVxMA==
X-Received: by 2002:a63:d518:: with SMTP id c24-v6mr560650pgg.357.1532062372116;
        Thu, 19 Jul 2018 21:52:52 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id z9-v6sm1238410pfi.150.2018.07.19.21.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 21:52:51 -0700 (PDT)
Date:   Fri, 20 Jul 2018 10:22:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] cpufreq: trace frequency limits change
Message-ID: <20180720045249.urvjk2hbkd2ny67s@vireshk-i7>
References: <20180719195957.59000-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719195957.59000-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-18, 12:59, Joel Fernandes wrote:
> From: Ruchi Kandoi <kandoiruchi@google.com>
> 
> systrace used for tracing for Android systems has carried a patch for
> many years in the Android tree that traces when the cpufreq limits
> change.  With the help of this information, systrace can know when the
> policy limits change and can visually display the data. Lets add
> upstream support for the same.
> 
> Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  Documentation/trace/events-power.rst |  1 +
>  drivers/cpufreq/cpufreq.c            |  1 +
>  include/trace/events/power.h         | 25 +++++++++++++++++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
> index a77daca75e30..2ef318962e29 100644
> --- a/Documentation/trace/events-power.rst
> +++ b/Documentation/trace/events-power.rst
> @@ -27,6 +27,7 @@ cpufreq.
>  
>    cpu_idle		"state=%lu cpu_id=%lu"
>    cpu_frequency		"state=%lu cpu_id=%lu"
> +  cpu_frequency_limits	"min=%lu max=%lu cpu_id=%lu"

The order of prints is min,max,id

>  
>  A suspend event is used to indicate the system going in and out of the
>  suspend mode:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b0dfd3222013..6533c6987866 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2236,6 +2236,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  
>  	policy->min = new_policy->min;
>  	policy->max = new_policy->max;
> +	trace_cpu_frequency_limits(policy->max, policy->min, policy->cpu);

But arguments are max,min,cpu

Lets align them and make it min/max/id everywhere for readability.

>  
>  	policy->cached_target_freq = UINT_MAX;
>  
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 908977d69783..e978b05b0200 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -148,6 +148,31 @@ DEFINE_EVENT(cpu, cpu_frequency,
>  	TP_ARGS(frequency, cpu_id)
>  );
>  
> +TRACE_EVENT(cpu_frequency_limits,
> +
> +	TP_PROTO(unsigned int max_freq, unsigned int min_freq,
> +		unsigned int cpu_id),
> +
> +	TP_ARGS(max_freq, min_freq, cpu_id),
> +
> +	TP_STRUCT__entry(
> +		__field(u32,		min_freq)
> +		__field(u32,		max_freq)
> +		__field(u32,		cpu_id)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->min_freq = min_freq;
> +		__entry->max_freq = max_freq;
> +		__entry->cpu_id = cpu_id;
> +	),
> +
> +	TP_printk("min=%lu max=%lu cpu_id=%lu",
> +		  (unsigned long)__entry->min_freq,
> +		  (unsigned long)__entry->max_freq,
> +		  (unsigned long)__entry->cpu_id)
> +);
> +
>  TRACE_EVENT(device_pm_callback_start,
>  
>  	TP_PROTO(struct device *dev, const char *pm_ops, int event),
> -- 
> 2.18.0.203.gfac676dfb9-goog

-- 
viresh
