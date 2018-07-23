Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D77C6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92E520858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Da85itih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92E520858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbeGWEA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:00:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35278 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeGWEA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:00:28 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so7598131plq.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 20:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GbcTQteZutnrrp0ElE4r3n5F20XUyMblfKc3J+fOsFo=;
        b=Da85itihHX5wgStCUxWD2nFl6v7xTDNODyLsDgjWOnfk9KYPaDfc5QGTlLOyxtFiFu
         qIOTEo2NxDizfWggWhwtmAthjLV5uWNrQZti0K506txKy2Cl7s3e2kUxGr51OgV22NDS
         b9OCCIQUVEHT4d/5yivFHkeMhUf3eX/009Sjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GbcTQteZutnrrp0ElE4r3n5F20XUyMblfKc3J+fOsFo=;
        b=Q0+tEGgRJ4YKrIFMIq4FidwxKJP9V/ChMjHpRRQJdng0rsoR7O0y143upXdf2Q0FTl
         qFwG4kzgW/+3hV/pUuyz93SOKq95ZZ7QrecL8Iw1Yk6jPCMKJTkkCMKmGUnBRSR+I+bc
         kbTt1U88dU/AtOI6ohyOeEUnVooQJXZ3FrlhUMIuDSpP5IOewcDJM+K2v390Cgq/epZP
         DfWu2jQniV5xLheH/JtPLOyUxB6s6cjyaP176lCpb788QeqthZfUKIGt6ffT5jOJsqKQ
         QO3aqIx3x7AaIaE1OTvhWo+DYOBDJ/QrGro00eUiQzjGU49nApmrj04ddzebUz5dtRW7
         is2g==
X-Gm-Message-State: AOUpUlEbubfzpko0N+0iXuSK7Ere34+/7RuTsBMUHVrfodXM72rrVw8A
        ahQ7jOzx/u3FUz9nNN5j7PNNrA==
X-Google-Smtp-Source: AAOMgpc2yePkGXoXPxwz/uyALuVFjZ08QhVcY7xCuad/ohWOOnHqU4SQND0r1cZcdY5DnKnpb/RuHQ==
X-Received: by 2002:a17:902:8c88:: with SMTP id t8-v6mr11087554plo.117.1532314889916;
        Sun, 22 Jul 2018 20:01:29 -0700 (PDT)
Received: from localhost ([122.172.26.112])
        by smtp.gmail.com with ESMTPSA id o27-v6sm15152698pfj.35.2018.07.22.20.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 20:01:29 -0700 (PDT)
Date:   Mon, 23 Jul 2018 08:31:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] cpufreq: trace frequency limits change
Message-ID: <20180723030127.7v5aymf246gfsf5x@vireshk-i7>
References: <20180720222114.200311-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720222114.200311-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-18, 15:21, Joel Fernandes wrote:
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
> v1->v2: Minor changes suggested by Viresh
> 
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
>  
>  A suspend event is used to indicate the system going in and out of the
>  suspend mode:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b0dfd3222013..4fd935df101e 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2236,6 +2236,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  
>  	policy->min = new_policy->min;
>  	policy->max = new_policy->max;
> +	trace_cpu_frequency_limits(policy->min, policy->max, policy->cpu);
>  
>  	policy->cached_target_freq = UINT_MAX;
>  
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 908977d69783..f5bec45108b6 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -148,6 +148,31 @@ DEFINE_EVENT(cpu, cpu_frequency,
>  	TP_ARGS(frequency, cpu_id)
>  );
>  
> +TRACE_EVENT(cpu_frequency_limits,
> +
> +	TP_PROTO(unsigned int min_freq, unsigned int max_freq,
> +		unsigned int cpu_id),
> +
> +	TP_ARGS(min_freq, max_freq, cpu_id),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, min_freq)
> +		__field(u32, max_freq)
> +		__field(u32, cpu_id)
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

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
