Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3595C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900D020874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="G9Feiah7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900D020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbeGXSbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:31:36 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41385 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388393AbeGXSbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:31:36 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so2055305ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=toxk+IXZeNr5JmdgFIwY4a/V6xKEg9X97pyxPK/3kCo=;
        b=G9Feiah7WFmqxB/rnB5qOGhj4xArhsT0Yd7mQZJroSNWqoXogYDddp4Frmoezy0js8
         pXjdkkddxrqDp6/E5g0NeqxpBFkKDdzr3giKQlsWcOgXniDp6I9g9O8b+3DjHi75xRWN
         6t7sSD79gu1I/tuICvW9T8LMqWEVQuMHZzbpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=toxk+IXZeNr5JmdgFIwY4a/V6xKEg9X97pyxPK/3kCo=;
        b=Tw+507umCD/qaqGDx+QDf4go1n61MGtZG0Zr1Le+9P0AO5N2NgTtiST8vnerGtcs9A
         mDciyad1+L5dMLpIDitPNIZJw+VJokh3ExcsBcEMVcZjhpV8QD0NqrIGADID3OIE2MC6
         Td/m9Xd7xti64VPooWbyB4gCdJKdcI7uK18raBoY9sQP9FW23XFg4uZFKDrZaC9bpYu3
         80VZ5ix+9wJjZV6vJ+du9ZYUR6Q/UFgbxmJknqwbBtuXjegPWDh3uuvoCSLhtFPcosq8
         38Q3HzPxQBTavprVP2AbM7IhL4MAGGa9CyhBy3I3Zyzqco0WicpYjp3nG+HJwSbkw6sG
         lKmA==
X-Gm-Message-State: AOUpUlGZXRIn5hq0cQizDgZVNtrElYrCckKntNao2c/x/tzQNx9whlHg
        Uymt32W9HU9l/0Np+gpBlHEWlw==
X-Google-Smtp-Source: AAOMgpcVp9A9cmonCixRLRuB14B2bFAwiGqYA0yRr1DUmwz8rMWU+Fg4NPOVCSwpi9PyN6t3qGK0Rg==
X-Received: by 2002:a17:902:a40b:: with SMTP id p11-v6mr17950827plq.228.1532453046184;
        Tue, 24 Jul 2018 10:24:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id p64-v6sm19522303pfa.47.2018.07.24.10.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 10:24:05 -0700 (PDT)
Date:   Tue, 24 Jul 2018 10:24:05 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ruchi Kandoi <kandoiruchi@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: trace frequency limits change
Message-ID: <20180724172405.GA257870@joelaf.mtv.corp.google.com>
References: <20180720222114.200311-1-joel@joelfernandes.org>
 <20180724094932.11e10452@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724094932.11e10452@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:49:32AM -0400, Steven Rostedt wrote:
> On Fri, 20 Jul 2018 15:21:14 -0700
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > From: Ruchi Kandoi <kandoiruchi@google.com>
> > 
> > systrace used for tracing for Android systems has carried a patch for
> > many years in the Android tree that traces when the cpufreq limits
> > change.  With the help of this information, systrace can know when the
> > policy limits change and can visually display the data. Lets add
> > upstream support for the same.
> > 
> > Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > v1->v2: Minor changes suggested by Viresh
> > 
> >  Documentation/trace/events-power.rst |  1 +
> >  drivers/cpufreq/cpufreq.c            |  1 +
> >  include/trace/events/power.h         | 25 +++++++++++++++++++++++++
> >  3 files changed, 27 insertions(+)
> > 
> > diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
> > index a77daca75e30..2ef318962e29 100644
> > --- a/Documentation/trace/events-power.rst
> > +++ b/Documentation/trace/events-power.rst
> > @@ -27,6 +27,7 @@ cpufreq.
> >  
> >    cpu_idle		"state=%lu cpu_id=%lu"
> >    cpu_frequency		"state=%lu cpu_id=%lu"
> > +  cpu_frequency_limits	"min=%lu max=%lu cpu_id=%lu"
> >  
> >  A suspend event is used to indicate the system going in and out of the
> >  suspend mode:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index b0dfd3222013..4fd935df101e 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2236,6 +2236,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  
> >  	policy->min = new_policy->min;
> >  	policy->max = new_policy->max;
> > +	trace_cpu_frequency_limits(policy->min, policy->max, policy->cpu);
> 
> Wouldn't it make more sense just to pass in "policy"?

Yes I agree, good idea.

> >  
> >  	policy->cached_target_freq = UINT_MAX;
> >  
> > diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> > index 908977d69783..f5bec45108b6 100644
> > --- a/include/trace/events/power.h
> > +++ b/include/trace/events/power.h
> > @@ -148,6 +148,31 @@ DEFINE_EVENT(cpu, cpu_frequency,
> >  	TP_ARGS(frequency, cpu_id)
> >  );
> >  
> > +TRACE_EVENT(cpu_frequency_limits,
> > +
> > +	TP_PROTO(unsigned int min_freq, unsigned int max_freq,
> > +		unsigned int cpu_id),
> > +
> > +	TP_ARGS(min_freq, max_freq, cpu_id),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(u32, min_freq)
> > +		__field(u32, max_freq)
> > +		__field(u32, cpu_id)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->min_freq = min_freq;
> > +		__entry->max_freq = max_freq;
> > +		__entry->cpu_id = cpu_id;
> 
> Then have here:
> 
> 		__entry->min_freq = policy->min;
> 		__entry->max_freq = policy->max;
> 		__entry->puc_id = policy->cpu;
> 
> It would also make the footprint of the tracepoint in the code smaller
> as it would pass fewer parameters to the trace event.

Yes, that's a great idea. I'll make the change and post v3.

-Joel
 
