Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A1C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A88B208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSR1HA4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A88B208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937066AbeFRKWw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:22:52 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34528 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933659AbeFRKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:22:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id a63-v6so7935314pfl.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6usyBiJ9wshzmhynqcRekJ/Jvcfo+fPSSBgTKJ6nheg=;
        b=bSR1HA4/zSo+9pBl4pAKj6d9EQGRZgAxKScHqWekXUX0ajic9o7VP5U9scOZJsI7K/
         r+Uk8PkzxryhEgLltDKDRChDx34fnH/KQkKv31yDT+LAyNzSyhQ8MP6jSu86yj8kbLHC
         U+IPgR3toHXLkhUf9AreGOzTB0oBLpvKFJj/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6usyBiJ9wshzmhynqcRekJ/Jvcfo+fPSSBgTKJ6nheg=;
        b=lYURHmApR9iMhW7OYDXz1yLTA2gUwjxiBND7W+Ks6TrTMznOqYIIczIRCGKdzOAOIM
         4Ac4e2qcIrVQPPtV1OqQE48Nv6zGDAT69u7KizOXOYSXdsrT8sGxFKN69FxrOkMPcE1q
         YcpHo2z3lufi+ciGnSWQEJHs/jHhpZW6HGterv4ianIILO75J0TOSgez+RvowO3xMeyf
         3HIS9e7dZuOvAMuPGnDVAKNUSh9K8RB5QyEtS6cwPYCNvjOjQT5v1WUAH8ciNBadQ6ri
         /a8zudLarUKoctpSlwT/5dpAC4RC6BbzMCDP/leN0uVln3et4eUlD2zsROzDuXhsNSwH
         QHLg==
X-Gm-Message-State: APt69E2/um0QWEror2aLl16D+7q0BE+eutr9QLrJ2qKR1G2VHp5uvKEp
        swM9LW7Lvm4DkBcOtX8BcitmJQ==
X-Google-Smtp-Source: ADUXVKIc6Vi8PdgpHfTJ6l1VMCQsOX0bDIKzRSL/lw4vIOTv0puGBJbs9rSREIW/hr+ih+PRn9HVaw==
X-Received: by 2002:a62:8b0a:: with SMTP id j10-v6mr12826002pfe.28.1529317368438;
        Mon, 18 Jun 2018 03:22:48 -0700 (PDT)
Received: from localhost ([122.167.164.190])
        by smtp.gmail.com with ESMTPSA id b2-v6sm30356569pfc.44.2018.06.18.03.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 03:22:46 -0700 (PDT)
Date:   Mon, 18 Jun 2018 15:52:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V7] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180618102245.x5cfei3i7voq65zc@vireshk-i7>
References: <1529054393-27077-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529054393-27077-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-18, 11:19, Daniel Lezcano wrote:
> +/**
> + * idle_injection_stop - stops the idle injections
> + * @ii_dev: a pointer to an idle injection_device structure
> + *
> + * The function stops the idle injection and waits for the threads to
> + * complete. If we are in the process of injecting an idle cycle, then
> + * this will wait the end of the cycle.
> + *
> + * When the function returns there is no more idle injection
> + * activity. The kthreads are scheduled out and the periodic timer is
> + * off.
> + */
> +void idle_injection_stop(struct idle_injection_device *ii_dev)
> +{
> +	struct idle_injection_thread *iit;
> +	unsigned int cpu;
> +
> +	pr_debug("Stopping injecting idle cycles on CPUs '%*pbl'\n",
> +		 cpumask_pr_args(to_cpumask(ii_dev->cpumask)));
> +
> +	hrtimer_cancel(&ii_dev->timer);
> +
> +	/*
> +	 * We want the guarantee we have a quescient point where
> +	 * parked threads stay in there state while we are stopping
> +	 * the idle injection. After exiting the loop, if any CPU is
> +	 * plugged in, the 'should_run' boolean being false, the
> +	 * smpboot main loop schedules the task out.
> +	 */
> +	cpu_hotplug_disable();
> +
> +	for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {

Maybe you should do below for all CPUs in the mask. Is the below usecase
possible ?

- CPU0-4 are part of the mask and are all online.
- hrtimer fires and sets should_run for all of them to 1.
- Right at this time CPU3 goes offline, so the thread gets parked with
  should_run == 1. Is there a reason why this can't happen ?
- Now we unregister the stuff and CPU3 again comes online.
- Because it had should_run as true, we again run the thread and Crash.

makes sense ?

> +		iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +		iit->should_run = 0;
> +
> +		wait_task_inactive(iit->tsk, 0);

I am not very sure of what guarantees this will provide.

@Peter: Do you see any more race scenarios here ?

> +	}
> +
> +	cpu_hotplug_enable();
> +}

> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
> +{
> +	struct idle_injection_device *ii_dev;
> +	int cpu;
> +
> +	ii_dev = kzalloc(sizeof(*ii_dev) + cpumask_size(), GFP_KERNEL);
> +	if (!ii_dev)
> +		return NULL;
> +
> +	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
> +	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	ii_dev->timer.function = idle_injection_wakeup_fn;
> +
> +	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
> +
> +		if (per_cpu(idle_injection_device, cpu)) {
> +			pr_err("cpu%d is already registered\n", cpu);
> +			goto out_rollback_per_cpu;
> +		}
> +
> +		per_cpu(idle_injection_device, cpu) = ii_dev;
> +	}
> +
> +	return ii_dev;
> +
> +out_rollback_per_cpu:
> +	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask))
> +		per_cpu(idle_injection_device, cpu) = NULL;

So if two parts of the kernel call this routine with the same cpumask, then the
second call will also overwrite the masks with NULL and return error. That will
screw up things a bit here.

-- 
viresh
