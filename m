Return-Path: <juri.lelli@redhat.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524214647; cv=none;
        d=google.com; s=arc-20160816;
        b=ggbfYEPjW66jv7OhojVPFreao1wtqNp+MVUNa3EqfZm/pGwDpPMOOhrr+hCaiNGji8
         X6OA6FNQqDCudrOViWJ9SrUQXRpdU1MNhvIEbFkGANTJaMdokbd3HuNTuy93T60mDWpU
         qJX12NLGoihHnUBwr7nbv+QbPcMbJedPxLMw1ZycgrwJW9nZjousptyzMtuCzHKvQNip
         4ZZtXfSzhk4rVGjNkLNkjyKo4sfDQCtQAVaRlIZJl/XT78wzRFlv35ct/5SRsbBsUCD3
         JgfhZEin/8R9CqugvLozD2AnloUfoRkfPAJY5bYxfTcSeVd/Tdxz0CT7596vpq+iMXXr
         jI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=8IZAySK+ZNwbbsd60vhvY/nKlpaHuRhBttE/IQQEsRU=;
        b=bA8liWPQnIKFKj6ttmf7wXjzjMsr6k4vVFeNzmfStjJNUs0z9by90USHuE8h3HX7kv
         EpDbGCcA2NaK0A/LXA0Nt5nR7fZcavurFabEXm+p0pzXtkovNHaU6Xf2+kToY0LPK6qx
         OyCMbOQAjQ75k4YthwdXIEPuYV/kPq7BULm+v7/EliGr2knjwdR0ZprzNxz0KC/864St
         k8j9TD8s1rPkr5R2P5JCXo7voz9CQNZmqCnI1Xow2fCX1M9NsOb7tNdwR+oNSkVn29FJ
         YXrCTP0u/RQ6/o6cj1XS6j2kXT+STzIgte+BbdldbuKeRdCf7RoEecOSJ30ca6kKcrQe
         vY2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of juri.lelli@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of juri.lelli@redhat.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=juri.lelli@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
X-Google-Smtp-Source: AIpwx49uKY7eL5oyATDIMyb+KHXu2oDyTuVJ2yKdlwegLf3jRLdw/qBGfb8U1FS4VHOzOXYHitgmYQ==
Date: Fri, 20 Apr 2018 10:57:23 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Joel Fernandes <joelaf@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 3/6] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180420085723.GE24599@localhost.localdomain>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-4-dietmar.eggemann@arm.com>
 <CAJWu+oqxGkUKzmj6OokRHoQ=1B+618cnLL_SXrnXFOgX1GWdkA@mail.gmail.com>
 <20180418111729.GB6783@e108498-lin.cambridge.arm.com>
 <CAJWu+opgqZ9DJtZtxzsum+d-CsCqvm2FOtaLAHuDv-mcD74Qew@mail.gmail.com>
 <CAJWu+oqGtfpwX9_s=Gwt5CKQNfRhztV48RjriGiBS7ZXG8g90w@mail.gmail.com>
 <20180420083118.GA14391@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420083118.GA14391@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011684825023112?=
X-GMAIL-MSGID: =?utf-8?q?1598254899044485138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 20/04/18 09:31, Quentin Perret wrote:
> On Friday 20 Apr 2018 at 01:14:35 (-0700), Joel Fernandes wrote:
> > On Fri, Apr 20, 2018 at 1:13 AM, Joel Fernandes <joelaf@google.com> wrote:
> > > On Wed, Apr 18, 2018 at 4:17 AM, Quentin Perret <quentin.perret@arm.com> wrote:
> > >> On Friday 13 Apr 2018 at 16:56:39 (-0700), Joel Fernandes wrote:

[...]

> > >>>
> > >>> I'm wondering if it makes sense for considering scenarios whether
> > >>> other classes cause CPUs in the domain to go above the tipping point.
> > >>> Then in that case also, it makes sense to not to do EAS in that domain
> > >>> because of the overutilization.
> > >>>
> > >>> I guess task_fits using cpu_util which is PELT only at the moment...
> > >>> so may require some other method like aggregation of CFS PELT, with
> > >>> RT-PELT and DL running bw or something.
> > >>>
> > >>
> > >> So at the moment in cpu_overutilized() we comapre cpu_util() to
> > >> capacity_of() which should include RT and IRQ pressure IIRC. But
> > >> you're right, we might be able to do more here... Perhaps we
> > >> could also use cpu_util_dl() which is available in sched.h now ?
> > >
> > > Yes, should be Ok, and then when RT utilization stuff is available,
> > > then that can be included in the equation as well (probably for now
> > > you could use rt_avg).
> > >
> > > Another crazy idea is to check the contribution of higher classes in
> > > one-shot with (capacity_orig_of - capacity_of) although I think that
> > > method would be less instantaneous/accurate.
> > 
> > Just to add to the last point, the capacity_of also factors in the IRQ
> > contribution if I remember correctly, which is probably a good thing?
> > 
> 
> I think so too yes. But actually, since we compare cpu_util() to
> capacity_of() in cpu_overutilized(), the current implementation should
> already be fairly similar to the "capacity_orig_of - capacity_of"
> implementation you're suggesting I guess.
> And I agree that when Vincent's RT PELT patches get merged we should
> probably use that :-)

Mind that rt_avg contains DL contribution as well ATM

https://elixir.bootlin.com/linux/v4.17-rc1/source/kernel/sched/deadline.c#L1182

So you shouldn't add newer DL utilization signal to it.

OTOH, using RT PELT (once in) is of course to be preferred.

Best,

- Juri
