Return-Path: <morten.rasmussen@arm.com>
X-Google-Smtp-Source: AG47ELtdrrzeN6+Ti/o5rZSMWlJyYVmCaiNHRVea/sM2x+Dug4AJgLeXjpGk0mULUCwikyk45/ji
ARC-Seal: i=1; a=rsa-sha256; t=1521649571; cv=none;
        d=google.com; s=arc-20160816;
        b=xfKabQY5y4sUXD9AMEsleOOrZ+SHLheYrFJZSfBSZ9Zrq15NvXu2lArIB6R+U062CB
         CvBAnUGV/BiNHz1TEm2JDkh2Ao4C9sqBOyh/NkMW7/QocWZ2B06utH6BuT6+pX+Ds1M/
         3jIQ5La1yuTy+9PtFU0PE1qhtTtv1YtlAFlO2vP08po0a5k3vFWxCta/fSjp5U5tiFWw
         73aUsyCNZo/hIj+yq+5iWoUgCpM0s+a+R/KO6pfINR55DQAo4til0F2/UN9SaN3Zfrr8
         3147XQX7ZdMJrhwCm31iStsZY7dCE6BlCDggqZDsEm/TZD3yYkBQI6qPjsWn+fsLLMbs
         i4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=lQrWL1H2LCQ6wQaufThcYFSp+SMfThjwufMWRCTgIx8=;
        b=Dqu8UrrdpqNZruEY3LG9fT/DIiAmpW2+aGhLGyP4rklp/ucDG+KpqJ6Gh2diTcH/1h
         ShVPOnT4W177BLMhBE2a3jVXJR/a+7TiTxDlXuqDOaaY6ZgZsS8yTw1uzaLrxYsQUou/
         ejBFuzaYU4qCgKAqpdwJ/M90xowpbaOIq0JfklDqRzInizthfalZeEjW2+m97iwqraZS
         a80QAHBNOgjdjQespatWt6K9yjALFyuUtmheWGtUVeycyLAvyKPwt5g8bEAsHRUB0mHr
         7sEXiAEtgGE4NZHhPVzUSmU/apOv+TqpuXaqDqiyaPK2YhG0cIS9RfW+BwEUU+LTt0O5
         EmuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of morten.rasmussen@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=morten.rasmussen@arm.com
Date: Wed, 21 Mar 2018 16:26:05 +0000
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Juri Lelli <juri.lelli@gmail.com>
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
Message-ID: <20180321162605.GO4589@e105550-lin.cambridge.arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321090430.GA6913@localhost.localdomain>
 <20180321122621.GA13951@e110439-lin>
 <20180321125925.GB15165@localhost.localdomain>
 <20180321135557.GB1373@queper01-VirtualBox>
 <20180321151513.GE15165@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321151513.GE15165@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595565221373891914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 04:15:13PM +0100, Juri Lelli wrote:
> On 21/03/18 13:55, Quentin Perret wrote:
> > On Wednesday 21 Mar 2018 at 13:59:25 (+0100), Juri Lelli wrote:
> > > On 21/03/18 12:26, Patrick Bellasi wrote:
> > > > On 21-Mar 10:04, Juri Lelli wrote:
> 
> [...]
> 
> > > > > > +	/*
> > > > > > +	 * As the goal is to estimate the OPP reached for a specific util
> > > > > > +	 * value, mimic the behaviour of schedutil with a 1.25 coefficient
> > > > > > +	 */
> > > > > > +	util += util >> 2;
> > > > > 
> > > > > What about other governors (ondemand for example). Is this supposed to
> > > > > work only when schedutil is in use (if so we should probably make it
> > > > > conditional on that)?
> > > > 
> > > > Yes, I would say that EAS mostly makes sense when you have a "minimum"
> > > > control on OPPs... otherwise all the energy estimations are really
> > > > fuzzy.
> > > 
> > > Make sense to me. Shouldn't we then make all this conditional on using
> > > schedutil?
> > 
> > So, in theory, EAS could make sense even for other governors than
> > schedutil. Even with the performance governor it is probably more
> > energy efficient (although users using "performance" probably don't care
> > about energy, but that's just an example) to place small tasks onto little
> > CPUs up to a certain point given by the energy model. The ideal solution
> > would be to change the behaviour of find_cap_state() depending on the
> > governor being used, but I don't know if this extra complexity is worth
> > it really.
> > I'm happy to make all this conditional on schedutil as a first step and
> > we can see later if that makes sense to extend EAS to other use-cases.
> 
> I agree that EAS makes still sense even for !schedutil cases (your
> performance example being one of them, powersave maybe another one?).
> Making it work with ondemand is tricky, though.
> 
> So, not sure what's the best thing to do, but we should be at least aware
> of limitations.

I would suggest making as few assumptions about the OPP selection as
possible. Even when we do use schedutil, there could be number of
reasons why we don't actually get the OPP schedutil requests (thermal,
hardware-says-no,...).

In the previous energy model-driven scheduling postings, years back, I
went with the assumption that OPP would follow the utilization. So if we
put more tasks on a cpu, the OPP would increase to match. If cpufreq or
hardware decided to go faster, that is fine but it could lead to
suboptimal decisions.

We could call into schedutil somehow to make sure that we at least
request the same OPP as the energy model assumes if the overhead is
small and we can present schedutil with all the information it needs to
choose the OPP for the proposed task placement. I wonder if it is worth
it, or if we should just decide on a simple assumption on OPP selection
for energy estimation and stick it in a comment.

Morten
