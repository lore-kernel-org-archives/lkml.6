Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60198C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D15F2584B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kedke9CD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D15F2584B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932722AbeFYLs3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:48:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40348 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932211AbeFYLs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:48:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so3462313wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=afkrtDu+foCx7eiaMpQaEyqeMollC2WV7gkgw1wxmBc=;
        b=Kedke9CDeYPqFL5vr/IuO1rHNx1B+kJRCzGwntBYo7xpOWmBk0kqIqlbJSQJtay+Ee
         J888LabUjJADdj0u0p+GZP3+IXXbl18V+g600H/mQHP386H0I3BwP8akNsPW1IZ8/8B2
         uJg6YkEJ3ez0fPkJg2LHzqT5I9vJoOcpf8xEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=afkrtDu+foCx7eiaMpQaEyqeMollC2WV7gkgw1wxmBc=;
        b=W5/v6GmHHAWecpJUAbX5GU5TsTRYpaf6AgAxCsAKUi1A3JaYSU3nlSP6R6Qs6Dumme
         dYWCLpMFiGoSPXeUCX7ZKbjEt/RUWI0CLu5ILtAEL15bO+v7mgam2QBbKzeaXO8f+1JD
         e660DOy/o9niRnEffn1OqOx3E114DfkjrztwR8507t0IMrYYGhvDn88+Uw+rPPLiRCns
         QPkc1AciOCfD1h97WZ2a1nJ21V2SmaJBCAsDEXXf9irqpxZtGBGUbPW/puUBeSHrbdtB
         EHlB+6EBvuLOLQdnlPLO57D/XCyDiwOvmWglsm8BACXiC/JByoi58JXoDaK0HfH434Ii
         eGig==
X-Gm-Message-State: APt69E2zlH7mjeYl5EJCTc3aGCYEDs1RN34EkjzytTDadrTjFMClJD63
        KRAkDu67rRuXK9XvNyoCkj4jM4YQeGE=
X-Google-Smtp-Source: ADUXVKKH8YZjyjqr0osGE9y5SQAIgeg3PT+DA4rlUWe31vBmCAMyLpNPqe9cM8w1W/FXwnML/L5g9A==
X-Received: by 2002:a1c:e618:: with SMTP id d24-v6mr726872wmh.154.1529927306339;
        Mon, 25 Jun 2018 04:48:26 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:a134:e815:db69:bcb1? ([2001:41d0:fe90:b800:a134:e815:db69:bcb1])
        by smtp.googlemail.com with ESMTPSA id 127-v6sm11972880wmk.45.2018.06.25.04.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 04:48:25 -0700 (PDT)
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <126b6192-cacc-5f99-105e-98fbc8409b0c@linaro.org>
Date:   Mon, 25 Jun 2018 13:48:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 10:41, Rafael J. Wysocki wrote:
> On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> 
> [cut]
> 
> One more thing.
> 
>> +/**
>> + * idle_injection_register - idle injection init routine
>> + * @cpumask: the list of CPUs managed by the idle injection device
>> + *
>> + * This is the initialization function in charge of creating the
>> + * initializing of the timer and allocate the structures. It does not
>> + * starts the idle injection cycles.
>> + *
>> + * Return: NULL if an allocation fails.
>> + */
>> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
>> +{
>> +       struct idle_injection_device *ii_dev;
>> +       int cpu, cpu_rb;
>> +
>> +       ii_dev = kzalloc(sizeof(*ii_dev) + cpumask_size(), GFP_KERNEL);
>> +       if (!ii_dev)
>> +               return NULL;
>> +
>> +       cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
>> +       hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +       ii_dev->timer.function = idle_injection_wakeup_fn;
>> +
>> +       for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
>> +
>> +               if (per_cpu(idle_injection_device, cpu)) {
>> +                       pr_err("cpu%d is already registered\n", cpu);
> 
> If you print something like this, it should be clear what it is about
> and what piece of code it comes from as there will be no context
> around it it the log.

Is the prefix as pointed by Viresh enough ? Or do want me to add a trace
like:

pr_err("Failed to register 'cpu%d', it is already registered", cpu);
(where "ii_dev:" gives the context)

?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

