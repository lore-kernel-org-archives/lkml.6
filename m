Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA291ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717152075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hHIVij+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717152075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbeGRRlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:41:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34159 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbeGRRlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:41:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id y5-v6so2286895pgv.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2e2ukhbu9riqq4zcd3VFyWmCzyciZ8hYBsf883WRA8E=;
        b=hHIVij+YJ6qiJHCzXIZQEdejKNE8n/23iiJ537tAfGr8T70jiGD9p2Db7IDJQz87t/
         a+vKHPlKcTI63djjirBUUOEOeQNrvSkkc4plALVnRvCrS8QqayRZMvFbHeybuPjKqG67
         M40boKhAwjlFCcQlEG6RZw32YzTsIHShS66nI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2e2ukhbu9riqq4zcd3VFyWmCzyciZ8hYBsf883WRA8E=;
        b=AnLegSJP4O7bWKleEP8bhZACVe/PYF5jt0yBgbcoh4cyretTA1mDddda7B3l1AyhJV
         yEjr/I9htW2cdc4ugdCj3nz4C09yyExo49ocuwWAMNoz+khKNJwzIcmwGWjat2fVxXMi
         Ac5F3pqfFPwYv8u3pco6ml0dxyMCppnJlCwNPX44n42+LdN3/6gkeG7DsMco3X7zYXAb
         kkcM1o2aPy3XeJd8TWQg9+K9YfrxFl9SLAs74cNx74arCqc+6lEJB++gh+ZbSVFa3uyR
         sdMuIu4O8cjQQIRGpBKGSUjrZXEVugjzf+Lia6tfK33G3WilRRFONZBhPH7WlLIMy7qd
         4+HQ==
X-Gm-Message-State: AOUpUlFmWH1H6eruUjy29j8AF9eAV+8FGyn+DAMb0oqZdLiLeacN5cPU
        n5iprSzv4Kk7B4GyOz8tC581Zg==
X-Google-Smtp-Source: AAOMgpf0a1ScxeWuKxfIsB4YsXqRdadltNw/79BbAnzm9o3AZ7H6+4ebPus5xwP4swmzC9we1kF2SA==
X-Received: by 2002:a63:704f:: with SMTP id a15-v6mr6505372pgn.443.1531933348272;
        Wed, 18 Jul 2018 10:02:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id t88-v6sm16391331pfg.10.2018.07.18.10.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 10:02:26 -0700 (PDT)
Date:   Wed, 18 Jul 2018 10:02:26 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 01/12] sched/core: uclamp: extend sched_setattr to
 support utilization clamping
Message-ID: <20180718170226.GA21148@joelaf.mtv.corp.google.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-2-patrick.bellasi@arm.com>
 <20180717175025.GA150378@joelaf.mtv.corp.google.com>
 <20180718084218.GI32302@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718084218.GI32302@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 09:42:18AM +0100, Patrick Bellasi wrote:
> On 17-Jul 10:50, Joel Fernandes wrote:
> > On Mon, Jul 16, 2018 at 09:28:55AM +0100, Patrick Bellasi wrote:
> 
> [...]
> 
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index 041f3a022122..1d45a6877d6f 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -583,6 +583,25 @@ config HAVE_UNSTABLE_SCHED_CLOCK
> > >  config GENERIC_SCHED_CLOCK
> > >  	bool
> > >  
> > > +menu "Scheduler features"
> > > +
> > > +config UCLAMP_TASK
> > > +	bool "Enable utilization clamping for RT/FAIR tasks"
> > > +	depends on CPU_FREQ_GOV_SCHEDUTIL
> > 
> > Does it make sense to depend on this? One could turn off schedutil and then
> > uclamp can't be used for any other purpose (big.LITTLE task placement etc)?
> 
> You right, utilization clamping is _going_ to target tasks placement.
> But, the support currently posted in this series is just for OPP
> biasing. Thus, it would not make sense to enabled it when schedutil
> is not available.
> 
> My idea was to keep this dependency while we finalize these bits.
> Once we move on to the tasks placement biasing, we will remove this
> dependency too.
> 
> Does that makes sense?

Yes, that's fine with me.
