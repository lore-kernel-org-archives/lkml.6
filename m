Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1F9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F20020875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F20020875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbeGXO4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:56:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388315AbeGXO4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:56:10 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E596120874;
        Tue, 24 Jul 2018 13:49:33 +0000 (UTC)
Date:   Tue, 24 Jul 2018 09:49:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: trace frequency limits change
Message-ID: <20180724094932.11e10452@gandalf.local.home>
In-Reply-To: <20180720222114.200311-1-joel@joelfernandes.org>
References: <20180720222114.200311-1-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018 15:21:14 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

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

Wouldn't it make more sense just to pass in "policy"?

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

Then have here:

		__entry->min_freq = policy->min;
		__entry->max_freq = policy->max;
		__entry->puc_id = policy->cpu;

It would also make the footprint of the tracepoint in the code smaller
as it would pass fewer parameters to the trace event.

-- Steve

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

