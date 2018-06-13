Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D7599C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E6320891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXbty+NV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E6320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754574AbeFMIYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:24:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45234 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754487AbeFMIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:24:34 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so998983pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 01:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fBM7gcf159jRFRKX3yJkFpofXNttEYFHKF5yB0V2JoY=;
        b=EXbty+NVdWYPwuSeRI/4U6Fd2siE9l+KYhNFS9ad6cckPj87u2c/zevI6GDG295icm
         zCEJx26VyX3G4usaius3fWNDEuiD+0oDjjJAhRZmdbY3IOO7Xo1YPO+38hJDPHXuR/f+
         g6ITbo1mkMknxjUbXQ3Mx5PJZ//2kajPIWsPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fBM7gcf159jRFRKX3yJkFpofXNttEYFHKF5yB0V2JoY=;
        b=Luar9GjnJknctIIAIt9vF6OSQCdKfm1mMBDHen6i8r4O/JaO9xZpDoQGMMiwt92Zys
         VOYtQ/ttKPyCvkR3fUZ70DGa8SObGhrc3VOW5ASYxKPLM8l8pyKWRrjZ4ujsWYnGwwBN
         Gflt9Zlqo7xLfuxf6kESMFRMxMbzVW6MdRxb6uLrBytXgmwYJ04+vYJPjymEB7xWzrvC
         Drr33uQuJrlXdTI8YTS2rQr3kw8f8Ww5Y10FGIxD62kJtHD+a45QWKQXzaGPwbtP0dBT
         Z/un8AXd1FnJkzL4mgmoV2KM2u44wkzxDxayX4drMNVxW/FlOYMMRBdCHEVa8V7M7Xep
         EfRA==
X-Gm-Message-State: APt69E3ecDej4Al7GxBhuJOaFWefoXeVGe/s8b/1FMRN01qWDMr4+IMy
        5a4cA+YcrtMq1eIrxWEPIycBfw==
X-Google-Smtp-Source: ADUXVKL4eAJvsStjAMGbOZZBxTqqAnYAymeJUyfdPURBrlYGuFFkQ1irwjbfo36iFTaUQWBKs5ZBpA==
X-Received: by 2002:a62:66c6:: with SMTP id s67-v6mr3882807pfj.139.1528878274265;
        Wed, 13 Jun 2018 01:24:34 -0700 (PDT)
Received: from localhost ([223.226.91.101])
        by smtp.gmail.com with ESMTPSA id l11-v6sm584397pff.50.2018.06.13.01.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 01:24:33 -0700 (PDT)
Date:   Wed, 13 Jun 2018 13:54:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle
 injection framework
Message-ID: <20180613082431.wsouzw25dx7wugni@vireshk-i7>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612125930.GP12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612125930.GP12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-06-18, 14:59, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 02:00:11PM +0200, Daniel Lezcano wrote:
> > +struct idle_injection_device {
> 
> remove this:
> > +	cpumask_var_t cpumask;
> 
> > +	struct hrtimer timer;
> > +	struct completion stop_complete;
> > +	unsigned int idle_duration_ms;
> > +	unsigned int run_duration_ms;
> > +	atomic_t count;
> 
> add:
> 	unsigned long cpumask[0];
> > +};
> 
> 
> > +static struct idle_injection_device *ii_dev_alloc(void)
> > +{
> > +	struct idle_injection_device *ii_dev;
> > +
> > +	ii_dev = kzalloc(sizeof(*ii_dev), GFP_KERNEL);
> 
> use:
> 
> 	sizeof(*ii_dev) + cpumask_size()
> 
> > +	if (!ii_dev)
> > +		return NULL;
> > +
> 
> delete:
> 
> > +	if (!alloc_cpumask_var(&ii_dev->cpumask, GFP_KERNEL)) {
> > +		kfree(ii_dev);
> > +		return NULL;
> > +	}
> > +
> > +	return ii_dev;
> > +}
> 
> And use:
> 
> 	to_cpumask(ii_dev->cpumask)

What's the benefit of these changes? Is it just about not allocating memory
twice or more than that ?

And what could we do in situations where we need two cpumask variables (we have
a case in cpufreq core for that) ?

-- 
viresh
