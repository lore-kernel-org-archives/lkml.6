Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E143C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528382086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FmQUlzlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfARBtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:49:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37917 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfARBtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:49:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so5747419pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 17:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HyeqiDoULERLnYOpUYxn/7ASrgVSsDzlGEWIqgPraJs=;
        b=FmQUlzlO69o4iysoiShtMG3npABH83QVpiRosznou+QBmm4IChvycl1hVSMHeXKOub
         uFL5G4pHrpVx3WvRxKpALXSa5rYn1LQu+SCwMKNHT6A3E8QERH/jHlDn+f4Eo26Bgy51
         qR5b6rPM4fLHguLiCKknAN/Y0PWofplZW46h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HyeqiDoULERLnYOpUYxn/7ASrgVSsDzlGEWIqgPraJs=;
        b=d/I46WK4mHfHBWvup3yadzwj97RaOemoOUyrsb9+tDH67IKYJ6JZlM45TQhKTu+mBp
         jri/cMPSKL58IMmRkauAyNCW0DWz01Aw8LtnJ8I4AaRCDCPpMCjIXfNRPFkoqjyPHS+p
         RHtUHEW3yUQROBKkYLyBrAAgl9E1sZcKglckxB5kXTe8lYzQeP6gm1Tabn9E6MF36xMy
         nV5hdfAwlBJoYGzmvVKIBD3icl69dzT8nsActnx5tAb5ID4nvG0Vh5rd4FpBkQ0KISLr
         gI++2XCELTPhCxxYJpGTCOLAvcTgwcgf/KuT29qNpSJauoEM1pN5fxiVXiGKWo0cfrWN
         wXdA==
X-Gm-Message-State: AJcUukdKRRtr6sZMP342UZGPSK+eSUjADSrZLkFnnxzWLs43q5Tk9F7q
        UQn2A6Ml7Om4nAt7PUXis2U53g==
X-Google-Smtp-Source: ALg8bN6Hgm7EBjy8eJIro/mYWdfS+vL4IFp+GyVXC9ATW0281YCU+B6CbF4/9Kklv21QVnKgmaMnWg==
X-Received: by 2002:a63:9402:: with SMTP id m2mr15150001pge.93.1547776160287;
        Thu, 17 Jan 2019 17:49:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f6sm6809850pfg.188.2019.01.17.17.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 17:49:19 -0800 (PST)
Date:   Thu, 17 Jan 2019 17:49:19 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpufreq: Implement freq-constraint callback
Message-ID: <20190118014919.GZ261387@google.com>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
 <d6dad7a600a528665eaf309ab2182bc7b5e8060c.1547197612.git.viresh.kumar@linaro.org>
 <20190118014632.GY261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118014632.GY261387@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:46:32PM -0800, Matthias Kaehlcke wrote:
> On Fri, Jan 11, 2019 at 02:48:35PM +0530, Viresh Kumar wrote:
> > This implements the frequency constraint callback and registers it with
> > the freq-constraint framework whenever a policy is created. On policy
> > removal the callback is unregistered.
> > 
> > The constraints are also taken into consideration in
> > cpufreq_set_policy().
> > 
> > No constraints are added until now though.
> 
> nit: 'for now'?
> 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig   |  1 +
> >  drivers/cpufreq/cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 608af20a3494..2c2842cf2734 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -2,6 +2,7 @@ menu "CPU Frequency scaling"
> >  
> >  config CPU_FREQ
> >  	bool "CPU Frequency scaling"
> > +	select DEVICE_FREQ_CONSTRAINT
> >  	select SRCU
> >  	help
> >  	  CPU Frequency scaling allows you to change the clock speed of 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index a8fa684f5f90..63028612d011 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -21,6 +21,7 @@
> >  #include <linux/cpufreq.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > +#include <linux/freq_constraint.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel_stat.h>
> >  #include <linux/module.h>
> > @@ -1163,6 +1164,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> >  		per_cpu(cpufreq_cpu_data, cpu) = NULL;
> >  	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >  
> > +	freq_constraint_remove_cpumask_callback(policy->related_cpus);
> >  	cpufreq_policy_put_kobj(policy);
> >  	free_cpumask_var(policy->real_cpus);
> >  	free_cpumask_var(policy->related_cpus);
> > @@ -1170,6 +1172,24 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> >  	kfree(policy);
> >  }
> >  
> > +static void freq_constraint_callback(void *param)
> > +{
> > +	struct cpufreq_policy *policy = param;
> > +	struct cpufreq_policy new_policy = *policy;
> > +
> > +	new_policy.min = policy->user_policy.min;
> > +	new_policy.max = policy->user_policy.max;
> > +
> > +	down_write(&policy->rwsem);
> > +	if (policy_is_inactive(policy))
> > +		goto unlock;
> > +
> > +	cpufreq_set_policy(policy, &new_policy);
> > +
> > +unlock:
> > +	up_write(&policy->rwsem);
> > +}
> > +
> >  static int cpufreq_online(unsigned int cpu)
> >  {
> >  	struct cpufreq_policy *policy;
> > @@ -1236,6 +1256,14 @@ static int cpufreq_online(unsigned int cpu)
> >  			per_cpu(cpufreq_cpu_data, j) = policy;
> >  			add_cpu_dev_symlink(policy, j);
> >  		}
> > +
> > +		ret = freq_constraint_set_cpumask_callback(policy->related_cpus,
> > +					freq_constraint_callback, policy);
> > +		if (ret) {
> > +			pr_err("Failed to set freq-constraints: %d (%*pbl)\n",
> > +			       ret, cpumask_pr_args(policy->cpus));
> > +			goto out_destroy_policy;
> > +		}
> >  	} else {
> >  		policy->min = policy->user_policy.min;
> >  		policy->max = policy->user_policy.max;
> > @@ -2198,6 +2226,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  				struct cpufreq_policy *new_policy)
> >  {
> >  	struct cpufreq_governor *old_gov;
> > +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> > +	unsigned long fc_min, fc_max;
> >  	int ret;
> >  
> >  	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> > @@ -2217,6 +2247,20 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = freq_constraints_get(cpu_dev, &fc_min, &fc_max);
> > +	if (ret) {
> > +		dev_err(cpu_dev, "cpufreq: Failed to get freq-constraints\n");
> > +	} else {
> > +		if (fc_min > new_policy->min)
> > +			new_policy->min = fc_min;
> > +		if (fc_max < new_policy->max)
> > +			new_policy->max = fc_max;
> > +	}
> 
> nit: for if/else constructs with a typical and an 'exception' case
> IMO it is usually more readable when the normal case is handled in the
> 'if' branch (first) and the exception in 'else'.

Forgot to add this:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
