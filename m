Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx4+T/zXC5/v3bX+6h6OgihJ0VYk+0n2B9rCiA/e5dtkfudfWnPV7uo0IfuACpOcIE1oo7VaN
ARC-Seal: i=1; a=rsa-sha256; t=1524049605; cv=none;
        d=google.com; s=arc-20160816;
        b=XUsAvZb3bP0bd/a3BiRnOBeXBP4A5D1XvghfSRgnbi12PRN1i18saUsJFYXtVvkUYz
         ARsPs41cOoCTHoe+TMKyaKxprbs8O7e6wsrHuq9AC1xd/P/OixIoZDn7NTZvY7ljTM5M
         yjcgoQxk1Jce7MLFvwDnSmlSLnzbpYndofKfuN/QBmgQfvoiWVt3tXp3GaZhubw48uEh
         mLXVhE37/MHHTYMKm2taYljrYrjIqohp/PEO1ZGcjtYMLm8ZbXMlNAm13nXDViAF4bFD
         xHOQH1rCveNArjJ9bLBej8lDg+rUoIfiJbkHhSTDon6xgMGIAurk/CTpqUdYMKnONtvn
         smEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=E8ofbZp4c1VabaBB8iO2YxSfn+gF3sSjxt2zhRYA1Lo=;
        b=FcRFHSuD6M94wKTR7+PdjHLuYDaGwL6QegXDjzFyZR6p72jAiz54KUezaF78GMkmVU
         N5JWKsi/2kvkPYoSnWaaCZtMeyZMjnRTPGMtUZxI1+oGrRpj8IOiRJdP8odPIJeGCasT
         ly1PyvYk9Th53Gf8nzeEQDcs/jcn085kPUWuyTXyFG4eKOAlCmEwob89dLQkykCxj6PR
         1c9aq8G6mhT6A6qo2eaNr7Dbd0sHysC/Gv95FSFN1MeH4VBIwWJJ3Nl28N9oy0Fyp6S6
         kjbmlaDKMuOABeCIzx7hjvXMO+2ewkTpvAy4rC7TSQLrJSyd5U2LCduWfQtirJSGcKnj
         0ZGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Wed, 18 Apr 2018 12:06:35 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Leo Yan <leo.yan@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180418110635.GA6783@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180417152213.GC18509@leoy-ThinkPad-X240s>
 <20180418081339.GB3943@e108498-lin.cambridge.arm.com>
 <20180418091928.GA15682@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418091928.GA15682@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1598081838988599948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday 18 Apr 2018 at 17:19:28 (+0800), Leo Yan wrote:
> > > BTW, CPU utilization is decayed value and task_util() is not decayed
> > > value, so 'util - task_util(p)' calculates a smaller value than the
> > > prev CPU pure utilization, right?
> > 
> > task_util() is the raw PELT signal, without UTIL_EST, so I think it's
> > fine to do `util - task_util()`.
> > 
> > > 
> > > Another question is can we reuse the function cpu_util_wake() and
> > > just compenstate task util for dst cpu?
> > 
> > Well it's not that simple. cpu_util_wake() will give you the max between
> > the util_avg and the util_est value, so which task_util() should you add
> > to it ? The util_avg or the uti_est value ?
> 
> If feature 'UTIL_EST' is enabled, then add task's util_est; otherwise
> add task util_avg value.

I don't think this is correct. If UTIL_EST is enabled, cpu_util_wake()
will return the max between the util_avg and the util_est. When you call
it, you don't know what you get. Adding the _task_util_est() to
cpu_util_wake() is wrong if cpu_util_avg > cpu_util_est for example.

> 
> I think cpu_util_wake() has similiar logic with here, it merely returns
> CPU level util; but here needs to accumulate CPU level util + task level
> util.  So seems to me, the logic is:
> 
>   cpu_util_wake() + task_util_wake()

I'm not sure to get that one ... What is task_util_wake() ?

Thanks,
Quentin
