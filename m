Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F083C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A14920883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T83jVv5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfAHUiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:38:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45663 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfAHUiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:38:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so2423086plm.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 12:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JptQFPXaFj+7cZrMFm7qMV8jqKhElIWw3ImK4Vrev2c=;
        b=T83jVv5DjVAvoask1c+VzTvqxrHAUa4UlVbtYGHI4HALo20BC09WjB5HmNtWWZD9sc
         IlI4hucVom3wXOTVMMqxHhjIq2nnX3EQV+yhmLIGtUrodvHc3f6fCwHKaLIHsQAGS2qh
         jrTWx4DUojL9f46yoQRU7galP/MpryrR81mbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JptQFPXaFj+7cZrMFm7qMV8jqKhElIWw3ImK4Vrev2c=;
        b=FunQsgC9Y5xw8d/hc+pMaT4DvdMyLGbJWi1iLJG0nzeNwDYovSgG78OjYSvplPlA56
         7/PX6thHyfSBc0pbXwCH5TENZnm4p0Yg8asWhFdLIRg0sNQwH7XZMHjswm60cmPQ9ST6
         XgPvQkR0otHbVtOgmg2ZYSSdFRNtCUndGGnJISDwCiMj1H6sbOj1Du3k2WLjkbvmkum4
         jimHZuSlPxGyoE0u0SRhymzu0ekLUPUeez/34j05NUwQjz3QmXwmgNbegUCMOVKRDPD1
         zh0MCbllJJ395djCKCuA5QcUsBP/TR5mhSqj7aoi6I52+ce7nFN3tJH/BlNpwSImKYKH
         FnAw==
X-Gm-Message-State: AJcUuke4uFOIE8OXAysLv0OH6tSI4vufpU/oDOKgw0SbE9YogmOoXFak
        GO63YQuN8ymBIgsh/xD8idXCAg==
X-Google-Smtp-Source: ALg8bN5J3BhqE50cNZ9m/rEBUXgz/5LBiLBnB402PDIc36UrbRNqb8wuZF869BNGv1Pxnmu3Eh6o+g==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr3145497plk.196.1546979895166;
        Tue, 08 Jan 2019 12:38:15 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r6sm111861602pgk.91.2019.01.08.12.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 12:38:14 -0800 (PST)
Date:   Tue, 8 Jan 2019 12:38:13 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v10 15/15] OPTIONAL: cpufreq: dt: Register an Energy Model
Message-ID: <20190108203813.GS261387@google.com>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-16-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181203095628.11858-16-quentin.perret@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Mon, Dec 03, 2018 at 09:56:28AM +0000, Quentin Perret wrote:
> *******************************************************************
> * This patch illustrates the usage of the newly introduced Energy *
> * Model framework and isn't supposed to be merged as-is.          *
> *******************************************************************
> 
> The Energy Model framework provides an API to register the active power
> of CPUs. Call this API from the cpufreq-dt driver with an estimation
> of the power as P = C * V^2 * f with C, V, and f respectively the
> capacitance of the CPU and the voltage and frequency of the OPP.
> 
> The CPU capacitance is read from the "dynamic-power-coefficient" DT
> binding (originally introduced for thermal/IPA), and the voltage and
> frequency values from PM_OPP.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 48 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index e58bfcb1169e..4cfef5554d86 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -16,6 +16,7 @@
>  #include <linux/cpu_cooling.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> +#include <linux/energy_model.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -150,8 +151,50 @@ static int resources_available(void)
>  	return 0;
>  }
>  
> +static int __maybe_unused of_est_power(unsigned long *mW, unsigned long *KHz,
> +				       int cpu)
> +{
> +	unsigned long mV, Hz, MHz;
> +	struct device *cpu_dev;
> +	struct dev_pm_opp *opp;
> +	struct device_node *np;
> +	u32 cap;
> +	u64 tmp;
> +
> +	cpu_dev = get_cpu_device(cpu);
> +	if (!cpu_dev)
> +		return -ENODEV;
> +
> +	np = of_node_get(cpu_dev->of_node);
> +	if (!np)
> +		return -EINVAL;
> +
> +	if (of_property_read_u32(np, "dynamic-power-coefficient", &cap))
> +		return -EINVAL;
> +
> +	Hz = *KHz * 1000;
> +	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
> +	if (IS_ERR(opp))
> +		return -EINVAL;
> +
> +	mV = dev_pm_opp_get_voltage(opp) / 1000;
> +	dev_pm_opp_put(opp);
> +	if (!mV)
> +		return -EINVAL;
> +
> +	MHz = Hz / 1000000;
> +	tmp = (u64)cap * mV * mV * MHz;
> +	do_div(tmp, 1000000000);
> +
> +	*mW = (unsigned long)tmp;
> +	*KHz = Hz / 1000;
> +
> +	return 0;
> +}
> +
>  static int cpufreq_init(struct cpufreq_policy *policy)
>  {
> +	struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
>  	struct cpufreq_frequency_table *freq_table;
>  	struct opp_table *opp_table = NULL;
>  	struct private_data *priv;
> @@ -160,7 +203,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	unsigned int transition_latency;
>  	bool fallback = false;
>  	const char *name;
> -	int ret;
> +	int ret, nr_opp;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -237,6 +280,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		ret = -EPROBE_DEFER;
>  		goto out_free_opp;
>  	}
> +	nr_opp = ret;
>  
>  	if (fallback) {
>  		cpumask_setall(policy->cpus);
> @@ -280,6 +324,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);

Shouldn't there also be a function to unregister a perf domain to be
called from cpufreq_exit()?

->exit() is called on suspend when the CPUs are taken offline, and
->init() on resume, hence em_register_perf_domain() is called multiple
times, but without doing any cleanup.

Cheers

Matthias
