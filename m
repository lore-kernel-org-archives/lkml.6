Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx4+3fyEK3LJyCo1Gamx2I5YR4gV/1cJisR6gYoXpgHANENfcBMRw7WtN29fetyj7NZJmRLE2
ARC-Seal: i=1; a=rsa-sha256; t=1523292134; cv=none;
        d=google.com; s=arc-20160816;
        b=P5aPufgM6FdOHjmjJ81o3SFrB/iSr4Ltqa3M3lzD63dEX4LU6N0q1HkIipBOUQXIeB
         TObBbPPNu2mD7ECJ9OSloCW5AC5xOTvf9Tix0g01tyddFmgNqrik81ci65U5LLM5WpQ7
         UXA8uTo329Rn0TAm7f8P5E0WCA6mO57efO7y4q6Jn1ryfBjHZXMzSUc9rKnkUSwD4OKP
         HBzQNIOzjf8eA+B0d2iVyDhIdRTKKkFhcbczBoYhnm+aLmSBgVnKKgEanm9n/Bw99N3M
         AsxuQFCrGO3jOwI5+cvKNmV2ndkPa0Eyfgedep3qYar178s+oQWjepNtMrDpHfVoi6VI
         hAMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=EpsrHaCfY4EYE1tFUn/RUohwAI1f6g+qd1jOex5Ou9I=;
        b=gfoGccfEkjeicjXPbYDxvJiRRruBrvm+76cbl3rP1wTm/roAgF2ZRvhRTfAfN6+euN
         nMAC6gV9dsh8f2gTvq7K2JB7vOhO2Kb54yBLor6vOjiuhSswnwWVihbJaHkinRRlVBGT
         KrJvXdR5O6DcGIyCqO5NbN4mWnict3Q6f9uYGm+GzEzfd5O6HUASFMtUaHUA6iO9opZ6
         5xyKoQs2VYGgKVazG2GvSdlyfhjQpfapOfNblsTje+HOOcQQ+IsP42tzg7PNUNq3pFRv
         YcHLjKFiYo5vbG5F63OXkx0lKFTf009YTyig2DG4081usUnSbkrCIfFki9mOLnB7WbNb
         ieAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Mon, 9 Apr 2018 17:42:06 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
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
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Message-ID: <20180409164205.GA3520@e108498-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
 <20180409120111.GA4043@hirez.programming.kicks-ass.net>
 <20180409134510.GA4577@e108498-lin.cambridge.arm.com>
 <20180409153233.GA4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409153233.GA4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449333969249680?=
X-GMAIL-MSGID: =?utf-8?q?1597287573220296134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Monday 09 Apr 2018 at 17:32:33 (+0200), Peter Zijlstra wrote:
> On Mon, Apr 09, 2018 at 02:45:11PM +0100, Quentin Perret wrote:
> 
> > In this specific patch, we are basically trying to figure out the
> > boundaries of frequency domains, and the power consumed by each CPU
> > at each OPP, to make them available to the scheduler. The important
> > thing here is that, in both cases, we rely on the OPP library to
> > keep the code as platform-agnostic as possible.
> 
> AFAICT the only users of this PM_OPP stuff is a bunch of ARM platforms.

That's correct.

> Granted, body else has build a big.little style system, so that might
> all be fine I suppose.
> 
> It won't be until some !ARM chip comes along that we'll know how
> generically usable any of this really is.
> 

Right. There is already a lot of diversity in the Arm ecosystem that has
to be managed. That's what I meant by platform-agnostic. Now, I agree
that it should be discussed whether or not this is enough for other
archs ...

It might be reasonable to expect from the archs who want to use EAS that
they expose their OPPs in the OPP lib. That should be harmless, and EAS
needs to know about the OPPs, so they should be made visible, ideally
somewhere generic. Otherwise, that means the interface with the
EAS has to be defined only by the energy model data structures, and the
actual energy model loading procedure becomes free-form arch code.

I quiet like the first idea from a pure design standpoint, but I could
also understand if maintainers of other archs were reluctant to
have new dependencies on PM_OPP ...

> > In the case of the frequency domains for example, the cpufreq driver is
> > in charge of specifying the CPUs that are sharing frequencies. That
> > information can come from DT, or SCPI, or SCMI, or whatever -- we
> > probably shouldn't have to care about that from the scheduler's
> > standpoint. That's why using dev_pm_opp_get_sharing_cpus() is handy,
> > the OPP library gives us the digested information we need.
> 
> So I kinda would've expected to just ask cpufreq, that after all already
> knows these things. Why did we need to invent this pm_opp thing?

Yes, we can definitely rely on cpufreq for this one. There is a "strong"
dependency on PM_OPP to get power values, so I decided to use PM_OPP for
the frequency domains as well, for consistency. But I can change that if
needed.

> 
> Cpufreq has a tons of supported architectures, pm_opp not so much.
> 
> > The power values (dev_pm_opp_get_power) we use right now are those
> > already used by the thermal subsystem (IPA), which means we don't have
> 
> I love an IPA style beer, but I'm thinking that's not the same IPA,
> right :-)

Well, both can help to chill down in a way ... :-)

The IPA I'm talking about means Intelligent Power Allocator. It's a
thermal governor that uses a power model of the platform to allocate
power budgets to CPUs & GPUs using a control loop. The code is in
drivers/thermal/power_allocator.c if this is of interest.

> 
> > to introduce any new DT binding whatsoever. In a close future, the power
> > values could also come from other sources (SCMI for ex), and again it's
> > probably not the scheduler's job to care about those things, so the OPP
> > library is helping us again. As mentioned in the notes, as of today, this
> > approach has dependencies on other patches relating to these things which
> > are already on the list [1].
> 
> Is there any !ARM thermal driver? (clearly I'm not up-to-date on things
> thermal).

I don't think so.

Thanks,
Quentin
