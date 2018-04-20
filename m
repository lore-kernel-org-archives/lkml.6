Return-Path: <leo.yan@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524241685; cv=none;
        d=google.com; s=arc-20160816;
        b=D2zIm208NIU6KGMIZbDtj/YCsTwZwZ+4XYFdT/iTJCtKG08unqrCQFBUpmIk/qBvlp
         uI0OLc+9CAmNNvww6ygN6eqsMdJx6JIS6ZEz/ip5PCJiRhOJQPiaONbVmYkMX34d/8g3
         rOyXHhKF3qAushCn/TXef4d//lXGL0cSOAbDJjJ56TWAGbUxVdUHNSVGet/yu/GJ1wJV
         Wcrr4XcueMgcLIcKn6DScfdkqXVVwdHHLV74lM9VegXuoFQZ+pqNVGwhpIa+jXJ12Khr
         Crl4MtHeyj2Xc82UBs/CaVQdnaz9IeFsdW7Y9ng1qIqdBXrb0/Qzp7168soyKO1T4U40
         zg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=g5ut3aEEa4Pn3K+jUxoPCcP7jDCd2WsBlNGL4R3gvqc=;
        b=iMLsucDbh0qNI05wXICsbo3x0vltCOREpgQ9HEn53TM0Ox54vJqhEwLViYYHQTu/g+
         RV6sb/6ZS9Df0tHtOeha8UAkgiy8hZGHaiP/IRdvyYAKXMXBp5Z0s0OdfDl2DWYPsyCU
         DpF8eP3vpnlBt3osg5++vYb2ocahuOj9hbjvmeBku75Hb+ELShb6htBe+BVvMA3F07PQ
         +uPDG7HLQ2yUD8h3YW846dOnddSFIz3jmh3XMvmcXg3OQORzoGvayIEDzkZyjQFhNDLA
         8uWHJnGxk+7NCD9Vb+GHtp3X7KiqL5O8tQ+hHOFxTg3G7j6ZZ87O0bj2I58+hxOvYU0R
         H7hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=D2aFWXoh;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=D2aFWXoh;
       spf=pass (google.com: domain of leo.yan@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=leo.yan@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/p/kKXNydP10O+AnE69Ky+TkLkzFN4QPYU333/am1UptG6fkZdzz/13+4VuHp2/0fCWLVA3Q==
Date: Sat, 21 Apr 2018 00:27:53 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
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
Message-ID: <20180420162753.GA5254@leoy-ThinkPad-X240s>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180418121547.GC15682@leoy-ThinkPad-X240s>
 <20180420144245.GB14391@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420144245.GB14391@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1598283249362318586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 20, 2018 at 03:42:45PM +0100, Quentin Perret wrote:
> Hi Leo,
> 
> On Wednesday 18 Apr 2018 at 20:15:47 (+0800), Leo Yan wrote:
> > Sorry I introduce mess at here to spread my questions in several
> > replying, later will try to ask questions in one replying.  Below are
> > more questions which it's good to bring up:
> > 
> > The code for energy computation is quite neat and simple, but I think
> > the energy computation mixes two concepts for CPU util: one concept is
> > the estimated CPU util which is used to select CPU OPP in schedutil,
> > another concept is the raw CPU util according to CPU real running time;
> > for example, cpu_util_next() predicts CPU util but this value might be
> > much higher than cpu_util(), especially after enabled UTIL_EST feature
> > (I have shallow understanding for UTIL_EST so correct me as needed);
> 
> I'm not not sure to understand what you mean by higher than cpu_util()
> here ... In which case would that happen ?

After UTIL_EST feature is enabled, cpu_util_next() returns higher value
than cpu_util(), see below code 'util = max(util, util_est);';  as
result cpu_util_next() takes consideration for extra compensention
introduced by UTIL_EST.

	if (sched_feat(UTIL_EST)) {
	        util_est = READ_ONCE(cfs_rq->avg.util_est.enqueued);
	        if (dst_cpu == cpu)
	                util_est += _task_util_est(p);
	        else
	                util_est = max_t(long, util_est - _task_util_est(p), 0);
	        util = max(util, util_est);
	}

> cpu_util_next() is basically used to figure out what will be the
> cpu_util() of CPU A after task p has been enqueued on CPU B (no matter
> what A and B are).

Same with upper description, cpu_util_next() is not the same thing
with cpu_util(), cpu_util_next() takes consideration for extra
compensention introduced by UTIL_EST.

> > but this patch simply computes CPU capacity and energy with the single
> > one CPU utilization value (and it will be an inflated value afte enable
> > UTIL_EST).  Is this purposed for simple implementation?
> > 
> > IMHO, cpu_util_next() can be used to predict CPU capacity, on the other
> > hand, should we use the CPU util without UTIL_EST capping for 'sum_util',
> > this can be more reasonable to reflect the CPU utilization?
> 
> Why would a decayed utilisation be a better estimate of the time that
> a task is going to spend on a CPU ?

IIUC, in the scheduler waken up path task_util() is the task utilisation
before task sleeping, so it's not a decayed value.  cpu_util() is
decayed value, but is this just we want to reflect cpu historic
utilisation at the recent past time?  This is the reason I bring up to
use 'cpu_util() + task_util()' as estimation.

I understand this patch tries to use pre-decayed value, please review
below example has issue or not:
if one CPU's cfs_rq->avg.util_est.enqueued is quite high value, then this
CPU enter idle state and sleep for long while, if we use
cfs_rq->avg.util_est.enqueued to estimate CPU utilisation, this might
have big deviation than the CPU run time if place wake task on it?  On
the other hand, cpu_util() can decay for CPU idle time...

> > Furthermore, if we consider RT thread is running on CPU and connect with
> > 'schedutil' governor, the CPU will run at maximum frequency, but we
> > cannot say the CPU has 100% utilization.  The RT thread case is not
> > handled in this patch.
> 
> Right, we don't account for RT tasks in the OPP prediction for now.
> Vincent's patches to have a util_avg for RT runqueues could help us
> do that I suppose ...

Good to know this.

> Thanks !
> Quentin
