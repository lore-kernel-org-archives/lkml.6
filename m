Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524010710; cv=none;
        d=google.com; s=arc-20160816;
        b=E0RlLUcRthUB2p8PCMpZolPA1A1xKpuikYAdVtp5qdOq7nNSriScxV6gUGAmK5RbUF
         cQuIRplgOc4Bg/e4ouyCqRJy4cjZJdy35T1lYwKV1ZAKFjKe0gmyXIdZySXYBXHY0lDm
         YNyKjT+HYdnsug+eJdCoMNpumCxt8cWZRlfiYJzjCUioo3ruJaT2f6Kdl4cxrZgqWuqE
         c2x2kcZ1BwSup6Ly/pMmhZPTOEtlNsXiXHIqWU648koIR26/+8KglzsF7M6i0r5Bmdvv
         RshZnGCj+IpGsDt2M6mLM7jLCkxu9M2nIcuWXiBS7oQUiJRQIPgPap8GoMCeJmZvZGTM
         Dyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=nbw5bi+WYE24671yyt+zG4oESvoi+hfbGtrpiNAQ1CY=;
        b=KcHgEs5/JnhkR1jtbcLinMqSOBPE+DAIW1SjY5YxTBaqfVNfx6IOZ8eBi0hb7RPgBd
         Zmp9VtZfRgqFE/ZfulXcGf/OQ8S2pax5tucAr7LACgfLwM/SteDpMc+/h5fM33+OE5w9
         0Q7Zm5pqf0voMl3HUS875h1kpzM7N+7AZJZpfbFq71JiI6di5ibefWzBCvBchyZtyGQE
         5BLU4GuZUC6Pu2mjQnj80BU0cd4ghpW0xfbNTd/MgFewYFmjfGRMJaUAJlYjBSwV8br8
         vGfcufTGiIb/xKFXYwIT+I0Jf2/kNBvWiPMz5D7vWiHhlb3noUaJ5KdLBJNPIEJ5fkv3
         uz6g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=gOT5ucTW;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=gOT5ucTW;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/DBq5WhwJVhwI6zJnx/BJXtICj0PPjXY4Wb68QOWh/eCP8CSmUYMmfj5OgyZpWAGbuepSvOg==
Date: Wed, 18 Apr 2018 08:18:16 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
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
Subject: Re: [RFC PATCH v2 3/6] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180418001815.GE18509@leoy-ThinkPad-X240s>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-4-dietmar.eggemann@arm.com>
 <20180417142440.GB18509@leoy-ThinkPad-X240s>
 <03a64b8b-9d13-5480-8882-75ecac3d6042@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03a64b8b-9d13-5480-8882-75ecac3d6042@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011684825023112?=
X-GMAIL-MSGID: =?utf-8?q?1598041054757536396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 07:39:21PM +0200, Dietmar Eggemann wrote:
> On 04/17/2018 04:25 PM, Leo Yan wrote:
> 
> >>@@ -5394,8 +5416,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >>  		update_cfs_group(se);
> >>  	}
> >>-	if (!se)
> >>+	if (!se) {
> >>  		add_nr_running(rq, 1);
> >>+		update_overutilized_status(rq);
> >>+	}
> >
> >Maybe this isn't a good question, why only update overutilized flag
> >for enqueue flow but not for dequeue flow?
> 
> [...]
> 
> >>@@ -9955,6 +10009,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >>  	if (static_branch_unlikely(&sched_numa_balancing))
> >>  		task_tick_numa(rq, curr);
> >>+
> >>+	update_overutilized_status(rq);
> >
> >Can sched tick clear overutilized flag if under tipping point?
> 
> No, only the load balancer for this particular sched domain level is able to
> clear the flag. We want to use the existing iteration over all cpus of the
> sched domain span to reset the flag.

Yes and sorry introduce noise.  The overutilized flag is shared with
all CPUs in the sched domain, so one CPU can set overutilized flag
for itself, but the CPU cannot clear the flag due this flag might be
set by other CPUs in the same sched domain.

Thanks,
Leo Yan
