Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF94C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9AC20863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lAPbgyNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbfBKJQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:16:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37005 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfBKJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:16:32 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so1016561pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 01:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nll5qJc4+5cFu37dVw7E6pyiUvfGyANWpL1pMp5somY=;
        b=lAPbgyNI+TK5+TDQP1ePckMohKqA9ceDELHyRvoD2PJsHHLhptFqM+z/04LYw653pJ
         y1ZviMp3nkALyRZBNDHnlbt3d6mLlhQlD4ZhCUhijCD0eJRtgR+DSAq9+XSpcmhnc+kb
         yjZVtcRgc7n9bj7vBdMA+JjCLZJaQ34VTTXnMZo+gvY7Plj2ALU++SxGAstPiHDIP2eS
         ZE5OwGasVFEryrBfgJbDIeVIvPnUPR0gE79LuD90vsZt+Njz4yCxtMSnfHffMotY8LfO
         svVaib+F6RCxun4cxl8jvdNmcREl4TEzkFwF7zFmMJMfmt68tXdeJ8NI+DFQ5I1C5x8I
         gMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nll5qJc4+5cFu37dVw7E6pyiUvfGyANWpL1pMp5somY=;
        b=OAS/LWO2cZgQ9gOGgDLAwbdRFSa5Vu5PYRPIM+APWQWZWuudl3wctwOXBsby9kxBDv
         y7mFeH0Y76nep5OgPxehb+oKISD+hHz+H5x/E9bX0plzH6eYQyVCVqIVIpfim4Qvkcgo
         hGp3WE6/fZ/jw83/zRTXYDYPh7sFDgOdMl1WjYntwfZBgRFr9RZoD709Y7CCfOfVhGYl
         r5J3xNG0sPgzzgi8qioQTYWHNQudEuXqpZnuqkudETKjoE+ZMM0boMhbgZpqZRrXciMY
         Iy2pI2p6QrfEjF/AlcDNYiwIiKHJU9ui2YprvUsDFci7fQMG/Vg3lMdt7sMZHs98q+zl
         dm3w==
X-Gm-Message-State: AHQUAubtwIwF8uYeVAGHxE3a3HL/5EmNX93e8JPT7Ac36+M2sBBTUwT9
        INk1keAn2W6u0cHJ/ymIlEAdHQ==
X-Google-Smtp-Source: AHgI3IYcxBGqGHWsYGdsBq9R+bbtubzr/NIsxKPo2SrIrPQwtw+MLcPkq6nG8CUPRQ+xavzm1Uf3XA==
X-Received: by 2002:a63:4e05:: with SMTP id c5mr1155281pgb.393.1549876590763;
        Mon, 11 Feb 2019 01:16:30 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y72sm15198061pfa.98.2019.02.11.01.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 01:16:29 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:46:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ACPI: add "processor.broadcast_ppc" hook to
 broadcast  _PPC to all online CPUs
Message-ID: <20190211091627.homaij2rtqzrytbu@vireshk-i7>
References: <20190209120232.21582-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209120232.21582-1-yu.c.chen@intel.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-02-19, 20:02, Chen Yu wrote:
> On Dell Inc. XPS13 9333, the BIOS changes the value of
> MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
> the power source changes), the maximum frequency of the
> CPU is not updated accordingly. This is due to the policy's
> cpuinfo.max is not updated when _PPC notifier fires.
> 
> Fix this problem by updating the policy's cpuinfo.max
> and broadcast the _PPC notifier to all online CPUs.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200759
> Reported-and-tested-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> Originally-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
>  drivers/cpufreq/cpufreq.c        |  2 ++
>  drivers/cpufreq/intel_pstate.c   | 15 ++++++++++++++-
>  3 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
> index a303fd0e108c..737dbf5aa7f7 100644
> --- a/drivers/acpi/processor_perflib.c
> +++ b/drivers/acpi/processor_perflib.c
> @@ -63,6 +63,10 @@ module_param(ignore_ppc, int, 0644);
>  MODULE_PARM_DESC(ignore_ppc, "If the frequency of your machine gets wrongly" \
>  		 "limited by BIOS, this should help");
>  
> +static int broadcast_ppc;
> +module_param(broadcast_ppc, int, 0644);
> +MODULE_PARM_DESC(broadcast_ppc, "Broadcast the ppc to all online CPUs");
> +
>  #define PPC_REGISTERED   1
>  #define PPC_IN_USE       2
>  
> @@ -180,8 +184,16 @@ void acpi_processor_ppc_has_changed(struct acpi_processor *pr, int event_flag)
>  		else
>  			acpi_processor_ppc_ost(pr->handle, 0);
>  	}
> -	if (ret >= 0)
> -		cpufreq_update_policy(pr->id);
> +	if (ret >= 0) {
> +		if (broadcast_ppc) {
> +			int cpu;
> +
> +			for_each_possible_cpu(cpu)
> +				cpufreq_update_policy(cpu);
> +		} else {
> +			cpufreq_update_policy(pr->id);
> +		}
> +	}
>  }
>  
>  int acpi_processor_get_bios_limit(int cpu, unsigned int *limit)
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..95e08816b512 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2237,6 +2237,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
>  
>  	policy->min = new_policy->min;
>  	policy->max = new_policy->max;
> +	policy->cpuinfo.max_freq = new_policy->cpuinfo.max_freq;
> +	policy->cpuinfo.min_freq = new_policy->cpuinfo.min_freq;
>  	trace_cpu_frequency_limits(policy);
>  
>  	policy->cached_target_freq = UINT_MAX;
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index dd66decf2087..e1881313c396 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2081,11 +2081,24 @@ static void intel_pstate_adjust_policy_max(struct cpufreq_policy *policy,
>  
>  static int intel_pstate_verify_policy(struct cpufreq_policy *policy)
>  {
> +	int max_freq;
>  	struct cpudata *cpu = all_cpu_data[policy->cpu];
>  
>  	update_turbo_state();
> +	max_freq = intel_pstate_get_max_freq(cpu);
> +
> +	if (acpi_ppc && policy->max == policy->cpuinfo.max_freq &&
> +	    max_freq != policy->cpuinfo.max_freq) {
> +		/*
> +		 * System was not running under any constraints, but the
> +		 * current max possible frequency is changed. So reset
> +		 * policy limits.
> +		 */
> +		policy->cpuinfo.max_freq = policy->max = max_freq;
> +	}
> +
>  	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
> -				     intel_pstate_get_max_freq(cpu));
> +				     max_freq);
>  
>  	if (policy->policy != CPUFREQ_POLICY_POWERSAVE &&
>  	    policy->policy != CPUFREQ_POLICY_PERFORMANCE)

By TURBO I believe this is about boost-frequencies and you should use
that infrastructure to make it work, isn't it ?

-- 
viresh
