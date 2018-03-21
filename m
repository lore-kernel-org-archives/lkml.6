Return-Path: <juri.lelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521651786; cv=none;
        d=google.com; s=arc-20160816;
        b=i9TtHKEnXOfotUM6tYBdrkOwh5XHc3wTXPQlHO1rNVLjOvScJGnSz2grZe9S+NL02S
         gWLIaag5kVZnAbDLRGrQVmxGON5oFE1aFo6exV2mklG9V8YDm5tUKGbR1auKAse0+RVL
         n00j7yVeizcCj6v0thQi95ybEE4ixyLWSPIMVa9ugNaSgkg8J+umq99zfAlVZ95b27oU
         eFqFfNlLwEWFHjI5+iHhuB5xyq/gqm27t6Z/v3zjpJoyShfXWClBgxDU3sUo5RKX/utW
         c3ceAPNIu3Thzd3T8kbg6gWa0ZLXiIhDJByLqDQHeHUwMesNeB6eHXbzdp7lc0U/Jeqv
         6p0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=5V8NQyl8f2LhuYchca1DugHrQj/udbEd9qkoVMwbOQ4=;
        b=neOemjUyonniZCMOwhKJ3KjazWWf/svtJ6LwAOIZkGmoCqrZgEU64jZm2GHxigOnUo
         C1uab1f94CGvqd9b4LT3ETum/jJ6ACEB8O+KoRpUDr9t2R5d/4mlxkxF9tNI5qB22YWS
         b5yWBxIOFJVAQvlpxgYQUOPl19pDsYpKTzmKBe3s0ZfT+ruTopZVX9acaaMv2ru9TjFp
         0ParUL7F5KKhrJhjRL7t7xFmMI5jaq+sd6ZJutAz+9gikc2d+LpdTOKQ2AMIJWpLXxD/
         MuFmYB0jMCkm4HYj87dqCdkrb1Gx5Wu6TqErkE7Pu371TAct7kxqyHIxKliaiVVJz50i
         1s0w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BIZSo3OT;
       spf=pass (google.com: domain of juri.lelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BIZSo3OT;
       spf=pass (google.com: domain of juri.lelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvF+MC30IUgFG9Y+EFLMgqmW8ydyVKyVmJ7UT8wYAZggaqRwsWR25jX490N8BVL/OeTmTIF+Q==
Date: Wed, 21 Mar 2018 18:02:59 +0100
From: Juri Lelli <juri.lelli@gmail.com>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Quentin Perret <quentin.perret@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org, Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180321170259.GG15165@localhost.localdomain>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321090430.GA6913@localhost.localdomain>
 <20180321122621.GA13951@e110439-lin>
 <20180321125925.GB15165@localhost.localdomain>
 <20180321135557.GB1373@queper01-VirtualBox>
 <20180321151513.GE15165@localhost.localdomain>
 <20180321162605.GO4589@e105550-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321162605.GO4589@e105550-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595567542895059470?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21/03/18 16:26, Morten Rasmussen wrote:
> On Wed, Mar 21, 2018 at 04:15:13PM +0100, Juri Lelli wrote:
> > On 21/03/18 13:55, Quentin Perret wrote:
> > > On Wednesday 21 Mar 2018 at 13:59:25 (+0100), Juri Lelli wrote:
> > > > On 21/03/18 12:26, Patrick Bellasi wrote:
> > > > > On 21-Mar 10:04, Juri Lelli wrote:
> > 
> > [...]
> > 
> > > > > > > +	/*
> > > > > > > +	 * As the goal is to estimate the OPP reached for a specific util
> > > > > > > +	 * value, mimic the behaviour of schedutil with a 1.25 coefficient
> > > > > > > +	 */
> > > > > > > +	util += util >> 2;
> > > > > > 
> > > > > > What about other governors (ondemand for example). Is this supposed to
> > > > > > work only when schedutil is in use (if so we should probably make it
> > > > > > conditional on that)?
> > > > > 
> > > > > Yes, I would say that EAS mostly makes sense when you have a "minimum"
> > > > > control on OPPs... otherwise all the energy estimations are really
> > > > > fuzzy.
> > > > 
> > > > Make sense to me. Shouldn't we then make all this conditional on using
> > > > schedutil?
> > > 
> > > So, in theory, EAS could make sense even for other governors than
> > > schedutil. Even with the performance governor it is probably more
> > > energy efficient (although users using "performance" probably don't care
> > > about energy, but that's just an example) to place small tasks onto little
> > > CPUs up to a certain point given by the energy model. The ideal solution
> > > would be to change the behaviour of find_cap_state() depending on the
> > > governor being used, but I don't know if this extra complexity is worth
> > > it really.
> > > I'm happy to make all this conditional on schedutil as a first step and
> > > we can see later if that makes sense to extend EAS to other use-cases.
> > 
> > I agree that EAS makes still sense even for !schedutil cases (your
> > performance example being one of them, powersave maybe another one?).
> > Making it work with ondemand is tricky, though.
> > 
> > So, not sure what's the best thing to do, but we should be at least aware
> > of limitations.
> 
> I would suggest making as few assumptions about the OPP selection as
> possible. Even when we do use schedutil, there could be number of
> reasons why we don't actually get the OPP schedutil requests (thermal,
> hardware-says-no,...).
> 
> In the previous energy model-driven scheduling postings, years back, I
> went with the assumption that OPP would follow the utilization. So if we
> put more tasks on a cpu, the OPP would increase to match. If cpufreq or
> hardware decided to go faster, that is fine but it could lead to
> suboptimal decisions.
> 
> We could call into schedutil somehow to make sure that we at least
> request the same OPP as the energy model assumes if the overhead is
> small and we can present schedutil with all the information it needs to
> choose the OPP for the proposed task placement. I wonder if it is worth
> it, or if we should just decide on a simple assumption on OPP selection
> for energy estimation and stick it in a comment.

Right, I see your point. Refactoring the 1.25 coefficient calculation in
some getter method shouldn't hopefully add much overhead, but yes, it
might not give us much in terms of correctness for certain situations.

Best,

- Juri
