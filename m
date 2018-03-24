Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AG47ELvlRKSgfNnjG2u0LUbocRtOSJJC18dwmo/4mUKBDxcwUVOInIqB/KRYKdX2akZRyrL41zO1
ARC-Seal: i=1; a=rsa-sha256; t=1521854541; cv=none;
        d=google.com; s=arc-20160816;
        b=jB2J6wMgtihIwJEXLW90upIDa7fO3MOdpZ6WtIvE6UV46pvZbLOMgWeplUQ9DYyPPS
         JqzMsAxZddo5SPVOAcIjh5CDArBd6b17LjrthLzCyXAZrp5UxIfcQTQxqp1jLnKqaGaV
         tN2hcP4UBV1T5AB5U9ysir1h2Lqg7RCHc7dN6K60KFH5+GLa5neEaFIecCUD8T1mRCSk
         LSmkHArNKo1I2htOpR31aW2snJq1s/K9K1yGKVZYwMnb3YySC9mtYYP4QMU77rRvCDgL
         f15+KkAs5d+FvdGqBT+xcn4MBfTeR5xGuUBMHwq+P34JGYpCjPaLF3by6yxFEoSfEPGs
         uMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=CbuPKV5y/Gb8vaM0m4629u+ctbHyJaOdU3BKGD/Sx6Q=;
        b=zp7wBVTRAUq8/LysvFFFiZ20t+jVHpOLnaAIjfaYMf+ORQ75oTsgzODtj2GSonK1P0
         7l9pV+b26QlYV9WY06C0Jv6d8M0FbdLXCdfCQjUa7Dadr19UvJvKp59RuJG0uXI1wels
         tmLqSjeW0Yocp+b/UctCRdhEC4EiH/U/LzksJN2qQBH1Ll+B18GvJ/8WP2N6uwpwZKz/
         zNE5uXgoP9o1zH31GmmgB1WiEMFyJiRuS3+MBPYzeDxi1RvNwUEmx5DndkIOQcZOnLnY
         hTlQFe+srESVjeeDOfBToQmLWtfYk4dl2Ht+7krkBGzrC/KPLtcsX1y6Vz436nqFHNpW
         qakg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Sat, 24 Mar 2018 01:22:06 +0000
From: Quentin Perret <quentin.perret@arm.com>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Joel Fernandes <joelaf@google.com>,
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
Message-ID: <20180324012205.GA1317@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <20180321153518.GC13951@e110439-lin>
 <CAJWu+opupHfDF8QoSC2AQnoFXnz3idt6pr-fq6nUp1C59XjtXA@mail.gmail.com>
 <20180323154745.GP4589@e105550-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323154745.GP4589@e105550-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595780147869630887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday 23 Mar 2018 at 15:47:45 (+0000), Morten Rasmussen wrote:
> On Thu, Mar 22, 2018 at 01:10:22PM -0700, Joel Fernandes wrote:
> > On Wed, Mar 21, 2018 at 8:35 AM, Patrick Bellasi
> > <patrick.bellasi@arm.com> wrote:
> > > [...]
> > >
> > >> @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> > >>                       break;
> > >>               }
> > >>
> > >> +             /*
> > >> +              * Energy-aware task placement is performed on the highest
> > >> +              * non-overutilized domain spanning over cpu and prev_cpu.
> > >> +              */
> > >> +             if (want_energy && !sd_overutilized(tmp) &&
> > >> +                 cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))
> > >> +                     energy_sd = tmp;
> > >> +
> > >
> > > Not entirely sure, but I was trying to understand if we can avoid to
> > > modify the definition of want_affine (in the previous chunk) and move
> > > this block before the previous "if (want_affine..." (in mainline but
> > > not in this chunk), which will became an else, e.g.
> > >
> > >         if (want_energy && !sd_overutilized(tmp) &&
> > >                 // ...
> > >         else if (want_energy && !sd_overutilized(tmp) &&
> > >                 // ...
> > >
> > > Isn't that the same?
> > >
> > > Maybe there is a code path I'm missing... but otherwise it seems a
> > > more self contained modification of select_task_rq_fair...
> > 
> > Just replying to this here Patrick instead of the other thread.
> > 
> > I think this is the right place for the block from Quentin quoted
> > above because we want to search for the highest domain that is
> > !overutilized and look among those for the candidates. So from that
> > perspective, we can't move the block to the beginning and it seems to
> > be in the right place. My main concern on the other thread was
> > different, I was talking about the cases where sd_flag & tmp->flags
> > don't match. In that case, sd = NULL would trump EAS and I was
> > wondering if that's the right thing to do...
> 
> You mean if SD_BALANCE_WAKE isn't set on sched_domains?
> 
> The current code seems to rely on that flag to be set to work correctly.
> Otherwise, the loop might bail out on !want_affine and we end up doing
> the find_energy_efficient_cpu() on the lowest level sched_domain even if
> there is higher level one which isn't over-utilized.
> 
> However, SD_BALANCE_WAKE should be set if SD_ASYM_CPUCAPACITY is set so
> sd == NULL shouldn't be possible? This only holds as long as we only
> want EAS for asymmetric systems.

That's correct, we are under the assumption that the SD_ASYM_CPUCAPACITY
flag is set somewhere in the hierarchy here. If a sched domain has this
flag set, SD_BALANCE_WAKE is propagated to all lower sched domains
(see sd_init() in kernel/sched/topology.c) so we should be fine.
