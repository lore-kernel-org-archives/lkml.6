Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx49sUPKBfI2hRiaqP7KPbAgVqZhGSsyoclKIyK6WIumiiRnUAaNmq6u23C7xcws6nhh0BH23
ARC-Seal: i=1; a=rsa-sha256; t=1524235371; cv=none;
        d=google.com; s=arc-20160816;
        b=Y2dVb0S+YDypT5m9M3ZM7wXJXphlC2yM+0KCl06v5bv8aO0SecyswtdpehhOMufXtr
         HiUKA/zs5+RE8+ZAsO84nkr8VJcaK5NgVxr8s7kLdCPxSbKRqVvFZCB/H16gX6WaVTaT
         g7kWJGnDB/CygyMvJEa1pAYMo/CIBZjBaQqip7t3TUFDgQSEXHc/6aE5oTApLUZz9d+n
         /hTpBQq8mNrgpZkHb+ojfsxrDA/bRu58PvolFFDZUlFZwkh/4PyF5UYX1O9IGgUDNr1r
         J9XMQusy20qhSX6HQkQcHsKG9retGytO4OKwfNcYrWjFxdJ0kUB/U2i5pztrz29Twnjx
         6dFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=URImvV3BBkVfxMqeh12T7r0/MgRgFLTivJijX4/Wa7g=;
        b=Jt73dI9tUym/g285xzl49J7CCu3gkU6j9OaYlgC7dnbfAd2dfkHv+9S2ri6B71+HFq
         0PQlAVTLiskyQvbxEAUw8AAanzW4kny80wNYsTsbmsfORztsmDpd+kzbMPspC4c8S4XF
         i57j6Nn4MUDk3pDCfGx7md3JcEyFQC6VUVk0eZw7sH1/+SGJB0FwFqCLh5hwZKL1fSLJ
         gDxn4OMoDc76Ae2w+mhRPLlFdkbvRfYfvdpjRNhNV1e7eyVSfacPOC3Qs4KXa0pZlrlj
         3amWVE+vf0DjjqVEkYUkAxef1HPYIGeBlUqQZfbebCYCA+rujSudtjXKiSeStoVO/23S
         f40w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Fri, 20 Apr 2018 15:42:45 +0100
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
Message-ID: <20180420144245.GB14391@e108498-lin.cambridge.arm.com>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
 <20180418121547.GC15682@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418121547.GC15682@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1598276628827488909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Leo,

On Wednesday 18 Apr 2018 at 20:15:47 (+0800), Leo Yan wrote:
> Sorry I introduce mess at here to spread my questions in several
> replying, later will try to ask questions in one replying.  Below are
> more questions which it's good to bring up:
> 
> The code for energy computation is quite neat and simple, but I think
> the energy computation mixes two concepts for CPU util: one concept is
> the estimated CPU util which is used to select CPU OPP in schedutil,
> another concept is the raw CPU util according to CPU real running time;
> for example, cpu_util_next() predicts CPU util but this value might be
> much higher than cpu_util(), especially after enabled UTIL_EST feature
> (I have shallow understanding for UTIL_EST so correct me as needed);

I'm not not sure to understand what you mean by higher than cpu_util()
here ... In which case would that happen ?

cpu_util_next() is basically used to figure out what will be the
cpu_util() of CPU A after task p has been enqueued on CPU B (no matter
what A and B are).

> but this patch simply computes CPU capacity and energy with the single
> one CPU utilization value (and it will be an inflated value afte enable
> UTIL_EST).  Is this purposed for simple implementation?
> 
> IMHO, cpu_util_next() can be used to predict CPU capacity, on the other
> hand, should we use the CPU util without UTIL_EST capping for 'sum_util',
> this can be more reasonable to reflect the CPU utilization?

Why would a decayed utilisation be a better estimate of the time that
a task is going to spend on a CPU ?

> 
> Furthermore, if we consider RT thread is running on CPU and connect with
> 'schedutil' governor, the CPU will run at maximum frequency, but we
> cannot say the CPU has 100% utilization.  The RT thread case is not
> handled in this patch.

Right, we don't account for RT tasks in the OPP prediction for now.
Vincent's patches to have a util_avg for RT runqueues could help us
do that I suppose ...

Thanks !
Quentin
