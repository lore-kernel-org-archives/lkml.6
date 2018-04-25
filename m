Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AB8JxZrxf1IBHuzywhDetXCpm5HHq3yxdJO0bbeNW91x/pEGNaJfkcYR7xUXMxrzUA1mjsIAbiNX
ARC-Seal: i=1; a=rsa-sha256; t=1524644597; cv=none;
        d=google.com; s=arc-20160816;
        b=i6pvrl6wzW9w31fqWhqdWz7a5Nzbm6dRjumWGvFALXCmtVeG5WErlp7OG/vNZCRC3P
         qLfC8lSUNvHMZpbn/pLpdzSmtJFN5ktH7iPt3oPxIMLhQMbKg9oyZhBGuYeSzzA1UyCf
         UFjbQ3V23l0uneEHvTCEK/1dtGuRGrmNTWC0Y9wEnLTx25faJXl6CSttNlRcdiQzDK0d
         VBGeEGoYhXye3TXWYW7hoV80JK2hoLq0C58s1tlOKOnhl1Mi5LtsSFbnNRf13oUipkzJ
         cTXNdl/4NmVQM7gBqO1+VNSpxYKAZpi1Xy5x8adGkhIEdiM/h1OGsW8wzzOJOQhnbj1v
         ZWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=9Ed8xXCI9uIxCPlRdzt57E91zk2l0xj6+ZnlXC5EDDw=;
        b=olvFr4MYsaVe4Or6hURHTw2xf0kc2A8Jh1CQOxAu2A6IxPUXpA1Kbw9cT8mmdAAcFX
         r3HcGWnQGsB2ZhqHi8Y4pLPb7mAVitpzj+yMzWJLz1XTEYFGCAyYMAQE/sT9B1qMctTa
         zY4KUIRkn5YNGaconiaA6L7P1iY4EIRD1k+W4shTFicaSlk6BYUxd7WlRNMLlD2yA8+I
         ATojO2H+Dhqwf09+8hzu4KTQpeSCGYf6fpjdQ6MFSDN89hmZtbx6Jp7rhzFrPVrWMMwm
         Vfg3OOojm9rb9rMHMs/UzTtxqE9cT1oCyV8Y4PCUAifx0F7AsgPPkSLTt3B5oRlVLknn
         gvJw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=arm.com
Date: Wed, 25 Apr 2018 09:23:12 +0100
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
Message-ID: <20180425082311.GH14391@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180418121547.GC15682@leoy-ThinkPad-X240s>
 <20180420144245.GB14391@e108498-lin.cambridge.arm.com>
 <20180420162753.GA5254@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420162753.GA5254@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1598705733594009552?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Leo,

Sorry for the delay in responding...

On Saturday 21 Apr 2018 at 00:27:53 (+0800), Leo Yan wrote:
> On Fri, Apr 20, 2018 at 03:42:45PM +0100, Quentin Perret wrote:
> > Hi Leo,
> > 
> > On Wednesday 18 Apr 2018 at 20:15:47 (+0800), Leo Yan wrote:
> > > Sorry I introduce mess at here to spread my questions in several
> > > replying, later will try to ask questions in one replying.  Below are
> > > more questions which it's good to bring up:
> > > 
> > > The code for energy computation is quite neat and simple, but I think
> > > the energy computation mixes two concepts for CPU util: one concept is
> > > the estimated CPU util which is used to select CPU OPP in schedutil,
> > > another concept is the raw CPU util according to CPU real running time;
> > > for example, cpu_util_next() predicts CPU util but this value might be
> > > much higher than cpu_util(), especially after enabled UTIL_EST feature
> > > (I have shallow understanding for UTIL_EST so correct me as needed);
> > 
> > I'm not not sure to understand what you mean by higher than cpu_util()
> > here ... In which case would that happen ?
> 
> After UTIL_EST feature is enabled, cpu_util_next() returns higher value
> than cpu_util(), see below code 'util = max(util, util_est);';  as
> result cpu_util_next() takes consideration for extra compensention
> introduced by UTIL_EST.
> 
> 	if (sched_feat(UTIL_EST)) {
> 	        util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
> 	        if (dst_cpu == cpu)
> 	                util_est += _task_util_est(p);
> 	        else
> 	                util_est = max_t(long, util_est - _task_util_est(p), 0);
> 	        util = max(util, util_est);
> 	}

So, cpu_util() accounts for the UTIL_EST compensation:

	static inline unsigned long cpu_util(int cpu)
	{
		struct cfs_rq *cfs_rq;
		unsigned int util;

		cfs_rq = &cpu_rq(cpu)->cfs;
		util = READ_ONCE(cfs_rq->avg.util_avg);

		if (sched_feat(UTIL_EST))
			util = max(util, READ_ONCE(cfs_rq->avg.util_est.enqueued));

		return min_t(unsigned long, util, capacity_orig_of(cpu));
	}

So cpu_util_next() just mimics that.

> 
> > cpu_util_next() is basically used to figure out what will be the
> > cpu_util() of CPU A after task p has been enqueued on CPU B (no matter
> > what A and B are).
> 
> Same with upper description, cpu_util_next() is not the same thing
> with cpu_util(), cpu_util_next() takes consideration for extra
> compensention introduced by UTIL_EST.
> 
> > > but this patch simply computes CPU capacity and energy with the single
> > > one CPU utilization value (and it will be an inflated value afte enable
> > > UTIL_EST).  Is this purposed for simple implementation?
> > > 
> > > IMHO, cpu_util_next() can be used to predict CPU capacity, on the other
> > > hand, should we use the CPU util without UTIL_EST capping for 'sum_util',
> > > this can be more reasonable to reflect the CPU utilization?
> > 
> > Why would a decayed utilisation be a better estimate of the time that
> > a task is going to spend on a CPU ?
> 
> IIUC, in the scheduler waken up path task_util() is the task utilisation
> before task sleeping, so it's not a decayed value.

I don't think this is correct. sync_entity_load_avg() is called in
select_task_rq_fair() so task_util() *is* decayed upon wakeup.

> cpu_util() is
> decayed value,

This is not necessarily correct either. As mentioned above, cpu_util()
includes the UTIL_EST compensation, so the value isn't necessarily
decayed.

> but is this just we want to reflect cpu historic
> utilisation at the recent past time?  This is the reason I bring up to
> use 'cpu_util() + task_util()' as estimation.
> 
> I understand this patch tries to use pre-decayed value,

No, this patch tries to estimate what will be the return value of
cpu_util() if the task is enqueued on a specific CPU. This value can be
the util_avg (decayed) or the util_est (non-decayed) depending on the
conditions.

> please review
> below example has issue or not:
> if one CPU's cfs_rq->avg.util_est.enqueued is quite high value, then this
> CPU enter idle state and sleep for long while, if we use
> cfs_rq->avg.util_est.enqueued to estimate CPU utilisation, this might
> have big deviation than the CPU run time if place wake task on it?  On
> the other hand, cpu_util() can decay for CPU idle time...
> 
> > > Furthermore, if we consider RT thread is running on CPU and connect with
> > > 'schedutil' governor, the CPU will run at maximum frequency, but we
> > > cannot say the CPU has 100% utilization.  The RT thread case is not
> > > handled in this patch.
> > 
> > Right, we don't account for RT tasks in the OPP prediction for now.
> > Vincent's patches to have a util_avg for RT runqueues could help us
> > do that I suppose ...
> 
> Good to know this.
> 
> > Thanks !
> > Quentin
