Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx4+DAOaOWbJMs9ZSpzG5AXYa7lq46cUKt6W0P8fJG1n0MUQnd7dq7gIGkBeOoMBLf3hN3jAt
ARC-Seal: i=1; a=rsa-sha256; t=1521855268; cv=none;
        d=google.com; s=arc-20160816;
        b=lSoDhNp75WXwQNqnZWUn4jPBxjOMynS0Xv0Eck/HGdFAbkVskc1s6Vhr+d0sHRV8ow
         XDOCMg3P7779SOzrEYl/uS71ABHsVrc0n1ylLuvYeaNbhNUBdMamYNY8VWeU0T9qkwc+
         bET931Fw+oEcVBYWNiOyjRt0HYcTuETDEJBhaljmTP1L19SthDgufw+AX9lmLg+w53kY
         KLAG8AEbSbbA8xV/rmh1A5Av+sMtZdM4aBh3jMBksKivGCIyXk20iDz2whfqm4xk9eLZ
         qbYr18X3FqoNDT3iuxUYssd7J+Hq68Iv/7BuYv0h4nVUqz8ei6ia5RG94ROBDYPhUttx
         zLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=mQjfRKPgRqzaOhCzK8IfJ4l2wtXOVdMbpyVyvnmqAhs=;
        b=0RXKQqIzSOf2NdXj3meTd7Uw5BCxmbcnWAWYvM4A+k2GdVYDLE4BrNLUUStGmXkgfj
         q1kqE8eqlJpivVLChFdrIQsebW6Sb9nve2FVHTKiTO6LG0R+NaX5el2luImOyj+tPjDc
         2xFu0gI+PbZIqcgNjbYKnVLV8KH0ysLCVEbSUaW3eEZ4UBwxRVZhVAlSlV1ENe8tufSP
         GjYlJkO/qGP29KOAGTrP3N4A2m4IyhzOL7vsAWzMMzysYzZ1uG6XUZXFe8FZsmJp4iMv
         /AjsGm/gKWhnhOPPVC/MqsR9q90TEBaR48bPOwW74ibnlxw56qjlahSnFQpigfeE5uSj
         wesw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Sat, 24 Mar 2018 01:34:22 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180324013421.GB1317@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <20180321153518.GC13951@e110439-lin>
 <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com>
 <20180323154745.GP4589@e105550-lin.cambridge.arm.com>
 <CAJWu+oqP9NLkhhZsTZ5JogSWgp6D2FoGAmP76Szi4+n87XNSsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqP9NLkhhZsTZ5JogSWgp6D2FoGAmP76Szi4+n87XNSsQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595780910754170667?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday 23 Mar 2018 at 18:13:56 (-0700), Joel Fernandes wrote:
> Hi Morten,
> 
> On Fri, Mar 23, 2018 at 8:47 AM, Morten Rasmussen
> <morten.rasmussen@arm.com> wrote:
> > On Thu, Mar 22, 2018 at 01:10:22PM -0700, Joel Fernandes wrote:

[...]

> > You mean if SD_BALANCE_WAKE isn't set on sched_domains?
> 
> Yes.
> 
> > The current code seems to rely on that flag to be set to work correctly.
> > Otherwise, the loop might bail out on !want_affine and we end up doing
> > the find_energy_efficient_cpu() on the lowest level sched_domain even if
> > there is higher level one which isn't over-utilized.
> >
> > However, SD_BALANCE_WAKE should be set if SD_ASYM_CPUCAPACITY is set so
> > sd == NULL shouldn't be possible? This only holds as long as we only
> > want EAS for asymmetric systems.
> 
> Yes, I see you had topology code that set SD_BALANCE_WAKE for ASYM. It
> makes sense to me then, thanks for the clarification.
> 
> Still I feel it is a bit tedious/confusing when reading code to draw
> the conclusion about why sd is checked first before doing
> find_energy_efficient_cpu (and that sd will != NULL for ASYM systems).
> If energy_sd is set, then we can just proceed with EAS without
> checking that sd != NULL. This function in mainline is already pretty
> confusing as it is :-(

Right I see your point. The code is correct as is, but I agree that having
a code structured as

	if (energy_sd) {
		new_cpu = find_energy_efficient_cpu(energy_sd, p, prev_cpu);
	} else if (!sd) {
		...

might be easier to understand and functionally equivalent. What do you
think ?

Thanks,
Quentin
