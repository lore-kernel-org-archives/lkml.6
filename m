Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx4/nO6wIz9bK0VO1k+/kW8kM8dP81cSFiXS5haHt6ggc4MN43yweN7SFp+/652SUUdOnkfW8
ARC-Seal: i=1; a=rsa-sha256; t=1524038273; cv=none;
        d=google.com; s=arc-20160816;
        b=ETjCf4mvD/yyvwPX4I5RQ14G4LBlSsxJAoq+SkSlLgq1ykSlH12/vJ7VuEFFpwfMIG
         7Rc7zBtKNjk2RPD7NHMg7p5WHv0OA0lv3il7LUZHE9C1xt9iZ4seRf24lFv2lLMeft8M
         5vfTx8hotrumBisX97u2KDlywFOwTSfgpd7aGJsFtDwzjbmiBJqOFceFRVWlL22Nm655
         waKUrNQgvOgGmYZ4CLEPKbj0KQU1tcJ3o2MPtNIykf/fAfSisrQojgko9h37oQW+gqYB
         E46c+M0yDtT99NoIqLs3VxR05WAUDIegVfsrCec02aR56Wz+ulV2rekJapMV0yM4JXwO
         AHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=AzJYLpdwWDQfETFLwjc+8kX7Y1M60H8cgRqBGsfwR50=;
        b=qFnMYoRIyU17I7u4KKJdOK/DwF01ZFSJTQ8zzMc3zQ8oryWppV3808Nyiyx3BvZiY/
         xriUkcmJUgb/sb3BPXJ87DEhduObUSw+eZTGy9/iV1iMySfLiBfEWJsfyHmms5+Qu9AT
         mpGLU10qN6KLIT/ev0J4H5tYxrx0LG+B4K1Hi2KSEdmf/K9Tv1uZmCmnKzz0cj7Ye3dl
         NtzxpJvFk4/PR7fSvm4EnuxizMKCN25MvImGIlxwx7rfr7AkR+BMAxULIMFBTUtubx3+
         CzYussGxqx1AcghJ+TDCAaC9wEljD0Dd3HgCvWpWfMsAn7/ZC/+SAUZDwx+jXH+gsvBI
         MhbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Wed, 18 Apr 2018 08:57:43 +0100
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
Subject: Re: [RFC PATCH v2 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180418075742.GA3943@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-6-dietmar.eggemann@arm.com>
 <20180417153944.GD18509@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417153944.GD18509@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011691670503989?=
X-GMAIL-MSGID: =?utf-8?q?1598069956418906671?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Leo,

On Tuesday 17 Apr 2018 at 23:39:44 (+0800), Leo Yan wrote:
> > +	for_each_freq_domain(fd) {
> > +		unsigned long spare_cap, max_spare_cap = 0;
> > +		int max_spare_cap_cpu = -1;
> > +		unsigned long util;
> > +
> > +		/* Find the CPU with the max spare cap in the freq. dom. */
> > +		for_each_cpu_and(cpu, freq_domain_span(fd), sched_domain_span(sd)) {
> > +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> > +				continue;
> > +
> > +			if (cpu == prev_cpu)
> > +				continue;
> > +
> > +			util = cpu_util_wake(cpu, p);
> > +			cpu_cap = capacity_of(cpu);
> > +			if (!util_fits_capacity(util + task_util, cpu_cap))
> > +				continue;
> > +
> > +			spare_cap = cpu_cap - util;
> > +			if (spare_cap > max_spare_cap) {
> > +				max_spare_cap = spare_cap;
> > +				max_spare_cap_cpu = cpu;
> > +			}
> > +		}
> 
> If have two clusters, and if firstly iterate the big cluster, then
> max_spare_cap is a big value for big cluster and later LITTLE cluster
> has no chance to have higher value for spare_cap.  For this case, the
> LITTLE CPU will be skipped for energy computation?

max_spare_cap is reset to 0 at the top of the for_each_freq_domain()
loop above so that shouldn't happen.

Thanks,
Quentin
