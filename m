Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88335C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CC821848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XSikKQ5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfAISOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:14:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34873 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfAISOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:14:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so4040489pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kBcrxosn4rbMp/c4KQPE3xLOAJ6eQ+hMTdKu6lkHV4I=;
        b=XSikKQ5bldok6k+L0AIV9rhQRClveXNnRn+vsWcSduU8EcK9AID9q+yC8M+DTPQt81
         SZ0KkJmyyAh8VxVfYTWCPk6S6WY42g9nD578tJzrysMVfSdt+fcVbVH7jxTz+bw4TDCT
         RpepIsmFsH2qrUva2ouI7k1woCKxhunBEUrdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kBcrxosn4rbMp/c4KQPE3xLOAJ6eQ+hMTdKu6lkHV4I=;
        b=B3fKLQQt+xOKJf3rt6iUXlc5nAk+qRDdfptWsfBnbT4aXbABqjHe0PeQxycfOpECi5
         s+0VZc/4Wn5a/YMI3j6MxuAnBK3JIpxtZF6RsBpOZwlTtsyNu8BGl1njWewrmBovlCVD
         cupYTjRVQUSEA/8cwAzDbb4WTo4DY7XOcdWnQC820aYIJoVcx29tyob3HxTPn9BRgZNF
         XziC2sq04dL8DsuT1R34cndCYNcENnUEklrBYQZ1fSO74FCccpzTfG99yjcTnXDxeFgY
         /D2ygkuImPv0qU8TJWSZN6JF16mIEuUQOYxWfH4/eW6uCxUv+RoKDJ1n9DxESqOLl53/
         PnVw==
X-Gm-Message-State: AJcUukeJrjRuoaKC82q/Gm4Rj+fWZObayeTL1hOJ7jDVehmpnIdzMH2X
        0femzwcc3gfOPhMrlqizyicy/Q==
X-Google-Smtp-Source: ALg8bN4BWlmxKl79y/cSQ3SK4GMdI5fZuNaVxe70BYvRvdqggow+pliw95ioHIHzYyceE9Vzx2KysA==
X-Received: by 2002:a63:6ecf:: with SMTP id j198mr6464677pgc.3.1547057692721;
        Wed, 09 Jan 2019 10:14:52 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id d21sm52850404pfo.162.2019.01.09.10.14.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 10:14:51 -0800 (PST)
Date:   Wed, 9 Jan 2019 10:14:51 -0800
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
Message-ID: <20190109181451.GT261387@google.com>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-16-quentin.perret@arm.com>
 <20190108203813.GS261387@google.com>
 <20190109105757.2rowxn3anzyycuod@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109105757.2rowxn3anzyycuod@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:57:57AM +0000, Quentin Perret wrote:
> Hi Matthias ,
> 
> On Tuesday 08 Jan 2019 at 12:38:13 (-0800), Matthias Kaehlcke wrote:
> > >  static int cpufreq_init(struct cpufreq_policy *policy)
> > >  {
> > > +	struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
> > >  	struct cpufreq_frequency_table *freq_table;
> > >  	struct opp_table *opp_table = NULL;
> > >  	struct private_data *priv;
> > > @@ -160,7 +203,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> > >  	unsigned int transition_latency;
> > >  	bool fallback = false;
> > >  	const char *name;
> > > -	int ret;
> > > +	int ret, nr_opp;
> > >  
> > >  	cpu_dev = get_cpu_device(policy->cpu);
> > >  	if (!cpu_dev) {
> > > @@ -237,6 +280,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> > >  		ret = -EPROBE_DEFER;
> > >  		goto out_free_opp;
> > >  	}
> > > +	nr_opp = ret;
> > >  
> > >  	if (fallback) {
> > >  		cpumask_setall(policy->cpus);
> > > @@ -280,6 +324,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
> > >  	policy->cpuinfo.transition_latency = transition_latency;
> > >  	policy->dvfs_possible_from_any_cpu = true;
> > >  
> > > +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> > 
> > Shouldn't there also be a function to unregister a perf domain to be
> > called from cpufreq_exit()?
> > 
> > ->exit() is called on suspend when the CPUs are taken offline, and
> > ->init() on resume, hence em_register_perf_domain() is called multiple
> > times, but without doing any cleanup.
> 
> Right, but this is safe to do as em_register_perf_domain() checks for
> the existence of the domain straight away. So the second time you call
> this em_register_perf_domain() should just bail out. Are you seeing an
> issue with this ?
> 
> As of now, the EM framework is really simple -- it justs allocates the
> pd tables once during boot, and they stay in memory forever. While
> arguably less than optimal, that makes things a whole lot easier to
> manage on the client side (i.e. the scheduler) w/o needing RCU
> protection or so.

I think registering the perf domain only once is fine, since the info
isn't supposed to change and will likely be used again after
_exit(). However since we have em_cpu_get() I'd suggest to use it and
only call em_register_perf_domain() if no perf domain is registered
yet for the CPU. This makes it more evident that the registration is
only done once and simplifies error handling (currently not done at
all), since it's not necessary to check for the special case -EEXIST.

Cheers

Matthias
