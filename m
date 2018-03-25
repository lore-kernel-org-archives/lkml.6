Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AG47ELuIXuWKq7z2/0WKTXKLn6NxC2P0y/A6ZP5iO4RnJtOu+ewL2oOWrL5qSSEpRIvaefuHubLz
ARC-Seal: i=1; a=rsa-sha256; t=1521941946; cv=none;
        d=google.com; s=arc-20160816;
        b=GlUekzVYciomh1Rj0oUc6q7f7JvyjFIHMKLRwpc9eDyu1YBS590n2xIsO3NhwwvhHV
         vrspl9ArrEyzLvtZFNM4UCzF++DoGZXfHKz6IYmPIHGrbp3pOQMhQsfprKljo+gr2rMU
         SMHtAG47/+YBfZVIgDke3v+LoqFAz0d/DNJ+63pxjgO9GSOaFDEDc3qlpNOuHyGxkZ6n
         nsHK9ujcswle1T//q2TB5/QzP6lZnaqkfpnWMRLkd3yIJl2NsTcEl6bI88EQsfmeL8M2
         hZnTnrdDcnUgPDZiMe4J2OVb3izGvAvfwPzUcVWCE36pXk8mOPRMlTIQqyBFAnArcS/Q
         yZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=HKQSdeDW7ZVt+BkuuCS5h8898NRN16pfnKsHM2Y7oUc=;
        b=0WBnkNVryGKy1+GhrEFnvrjRc2TENCmtneKFndnRgzZ9O9zy4mQcIZr+gd1vKsW0Cu
         FSRUkdaLTroyJwSKrwgCNRgzhFCPFOii8haX/imfmeyatLEefHMFX97+cnSQWxHCPFM6
         PoDcjLWSA5Lm+LpzeRF7aPoSiT6sLLIhEf6uzeFei0rj23MdBHe8aJdTuhY1M1JvzHXb
         aNsAgZe+2MdINFxnJ0Gqr2Z3IB5+W+M/p56XTz2a3oPpTPRv2oNIpDmO3dNuMjAQTmQT
         GNNeaBcWm0yazOk3b760UVjakihdPbh/KEbC/fV/yCoqMrEBJMjh/MXozz1QFVNTs05p
         J3zw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Sun, 25 Mar 2018 02:38:35 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Joel Fernandes <joelaf@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180325013833.GA1803@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
 <20180323160059.GQ4589@e105550-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323160059.GQ4589@e105550-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595871798656551327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Friday 23 Mar 2018 at 16:00:59 (+0000), Morten Rasmussen wrote:
> On Thu, Mar 22, 2018 at 09:27:43AM -0700, Joel Fernandes wrote:
> > Hi,
> > 
> > On Tue, Mar 20, 2018 at 2:43 AM, Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:

[...]

> > Is it possible that before the wakeup, the task's affinity is changed
> > so that p->cpus_allowed no longer contains prev_cpu ? In that case
> > prev_energy wouldn't matter since previous CPU is no longer an option?
> 
> It is possible to wake-up with a disallowed prev_cpu. In fact
> select_idle_sibling() may happily return a disallowed cpu in that case.
> The mistake gets fixed in select_task_rq() which uses
> select_fallback_rq() to find an allowed cpu instead.
> 
> Could we fix the issue in find_energy_efficient_cpu() by a simple test
> like below
> 
> if (cpumask_test_cpu(prev_cpu, &p->cpus_allowed))
> 	prev_energy = best_energy = compute_energy(p, prev_cpu);
> else
> 	prev_energy = best_energy = ULONG_MAX;

Right, that should work. I'll change this in v2.

Thanks,
Quentin
