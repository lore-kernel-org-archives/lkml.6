Return-Path: <juri.lelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521645318; cv=none;
        d=google.com; s=arc-20160816;
        b=A1xJ47pSOy87icCvYZQcChz+2u/v/dE5S3YHjCy4I545NKgS06j1FVik+Bxkr3/OzT
         OEJZJcuZNwatPTqrma9f2eS0wkJGpdTtKcyrmoG11liYokyhBXT6xNeBGG7FtFXGZmqX
         qusAgn9wAdRysi/oYrpg/pjqW8pOk7ogg2fM10QaWZY3oXGHaqWFcke7VP8gj4hXQUEe
         NhojOd16iBpw450rFp0E9/BngdhqyZu1Fao2vEbo6RuObMZa7WG0utqqjC1H0/143256
         h2WB/ZvqmwPSRIJXqZs5zDJIZStxwNVACC1QVO361YwiLuFasrLft+G8aE93QkUOdPtn
         ox/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=RMUjyZCxaylKrBXYQ+ONMJ+gsET60Wt5LXbij/KtA6g=;
        b=R+1XVGU/jv6zQa3hs2DG2uGKU3IGNYHWWSc0BHJgb4TUr6UtaI98X0SV6n3AqXEo6H
         nnLyezMBjwDHjuK6IkTADac5TrplhCsXGarynK07t7vucYNqkCjrLTr0hpDr4+IHm4WU
         LlpMeTog13EektBouPXDzSL+6aLLHvBHDSRrWN5XhhwIMJ9kdsDGP1gWPZHSfUM0pluh
         0iuKBq6SocPHI0vmmtUM3PfMxblOWIFLNKCXhMYPHg+wJ993tyvf3YTJJFHnFRSDl9ze
         MtVLkXN6YBVTanKYq5I/Wjj8vUrkSou5aKmcbsf/x4AOlSxiW4GvidZFUCaRZRFaxL/h
         UNEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KhBdEfNg;
       spf=pass (google.com: domain of juri.lelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=KhBdEfNg;
       spf=pass (google.com: domain of juri.lelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuqaHsiX+qErehfJF/7BHL9qHWcZo7uYJ7/PSvcQgdLc1qgdtxKilFKNe0jbDR6eqsHC9nFYQ==
Date: Wed, 21 Mar 2018 16:15:13 +0100
From: Juri Lelli <juri.lelli@gmail.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180321151513.GE15165@localhost.localdomain>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321090430.GA6913@localhost.localdomain>
 <20180321122621.GA13951@e110439-lin>
 <20180321125925.GB15165@localhost.localdomain>
 <20180321135557.GB1373@queper01-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321135557.GB1373@queper01-VirtualBox>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595560761501024889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21/03/18 13:55, Quentin Perret wrote:
> On Wednesday 21 Mar 2018 at 13:59:25 (+0100), Juri Lelli wrote:
> > On 21/03/18 12:26, Patrick Bellasi wrote:
> > > On 21-Mar 10:04, Juri Lelli wrote:

[...]

> > > > > +	/*
> > > > > +	 * As the goal is to estimate the OPP reached for a specific util
> > > > > +	 * value, mimic the behaviour of schedutil with a 1.25 coefficient
> > > > > +	 */
> > > > > +	util += util >> 2;
> > > > 
> > > > What about other governors (ondemand for example). Is this supposed to
> > > > work only when schedutil is in use (if so we should probably make it
> > > > conditional on that)?
> > > 
> > > Yes, I would say that EAS mostly makes sense when you have a "minimum"
> > > control on OPPs... otherwise all the energy estimations are really
> > > fuzzy.
> > 
> > Make sense to me. Shouldn't we then make all this conditional on using
> > schedutil?
> 
> So, in theory, EAS could make sense even for other governors than
> schedutil. Even with the performance governor it is probably more
> energy efficient (although users using "performance" probably don't care
> about energy, but that's just an example) to place small tasks onto little
> CPUs up to a certain point given by the energy model. The ideal solution
> would be to change the behaviour of find_cap_state() depending on the
> governor being used, but I don't know if this extra complexity is worth
> it really.
> I'm happy to make all this conditional on schedutil as a first step and
> we can see later if that makes sense to extend EAS to other use-cases.

I agree that EAS makes still sense even for !schedutil cases (your
performance example being one of them, powersave maybe another one?).
Making it work with ondemand is tricky, though.

So, not sure what's the best thing to do, but we should be at least aware
of limitations.

> 
> > 
> > > 
> > > > Also, even when schedutil is in use, shouldn't we ask it for a util
> > > > "computation" instead of replicating its _current_ heuristic?
> > > 
> > > Are you proposing to have the 1.25 factor only here and remove it from
> > > schedutil?
> > 
> > I'm only saying that we shouldn't probably have two places where we add
> > this 1.25 factor to utilization before using it, as in the future one of
> > the two might modify that 1.25 to something else and then we'll have
> > problems. So, maybe a common wrapper that adds such factor?
> 
> Ok, I can definitely factorize this code between schedutil and EAS. And
> BTW, would it make sense to make schedutil use "capacity_margin" instead
> of an arbitrary value ? The semantics feels pretty close. Out of curiosity,
> what was the reason to use C=1.25 in the first place ?

I seem to remember it was choosen out of experiments, but I might surely
be wrong and Rafael, Viresh, others will correct me. :)

> 
> > 
> > > 
> > > > I fear  the two might diverge in the future.
> > > 
> > > That could be avoided by factoring out from schedutil the
> > > "compensation" factor into a proper function to be used by all the
> > > interested playes, isn't it?
> > 
> > And I should have read till the end before writing the above paragraph
> > it seems. :)
> > 
> > Thanks,
> > 
> > - Juri
> 
> Thank you very much for the feedback !

No problem. I'm of course very interested in this. Could you please
directly Cc me (juri.lelli@redhat.com) in next versions?

Thanks,

- Juri
