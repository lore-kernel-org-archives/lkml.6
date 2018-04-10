Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx4+So/sOT6c1hmfq4GtgCvamOl4OYkb0K3o/aOv28JL4aM9pEbte8JgeLT9zqFUSZlxra4kC
ARC-Seal: i=1; a=rsa-sha256; t=1523381382; cv=none;
        d=google.com; s=arc-20160816;
        b=xaeUliDuWSTzcEnoXIajcecKCF2xlrxutZ5Z7zyhy+fRm5Hg+RhwaEuQs8NDNYLCUH
         zI1MK9z2Flke1Qi1lXCPa6cNJdky8tA4kW3adUPNVePWBIwx3n4NTD9n4Kip8XhigGsm
         AWPp3JsIOzYcGiciWGZD4zCrAzp9Ootf62Hhv8WDtZRXHNQ70CKWlxFU5Sj/+lIAA95M
         tGQ3ScDRmQmhbKjli2qtIQqqbaB8kBFYesqBOykWbu1GlAF4YuSUEgtxqLcWuK72tbn/
         UFqLXviFaQjW6QuoS/nlym41NyGSmzgyxHKCPgaJoYwlZZHY+QRRf4indwwpIDFQDXDA
         AhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=X7d/vXVZF9r2BNWDVQZmiRak52aEtdt4B7MeoH53T7E=;
        b=JF6da8V3xsZsNm8QPw8r0RJg5X8dAf0P3sSUjcL0h1z50zAm9qUx+exSe9NdrKazrq
         PG6oVvbk+k0cfkJWYIeITCHc99h5OyN/hH+J0DfG2LEC77Ss+VDCCLIvrUIi73UY0ddp
         tmRIPxcJgjToQ7jFetT+M/uU+yRvsWAKoTLZU1+Nd66G5ghF7tClypvVD0ATPZqjmyaN
         7RFOt1e/WhwD3vXn1mY1lxjiFCB44cZsPV20WucCE4zKb3MAJ7jgbdeSNAJHHiv2IrXk
         aOVFyHW+0FdXrfOuzYJmx4PFnchbAUoojPzG/E7cKUhPnw9NEDw1UV34/XE5AqFxp5lG
         Y/rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=HC3whXb8;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=HC3whXb8;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Tue, 10 Apr 2018 19:29:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
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
Message-ID: <20180410172932.GD4043@hirez.programming.kicks-ass.net>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-6-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-6-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011691670503989?=
X-GMAIL-MSGID: =?utf-8?q?1597381157225113669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:36:06PM +0100, Dietmar Eggemann wrote:
> +	for_each_freq_domain(fd) {
> +		unsigned long spare_cap, max_spare_cap = 0;
> +		int max_spare_cap_cpu = -1;
> +		unsigned long util;
> +
> +		/* Find the CPU with the max spare cap in the freq. dom. */
> +		for_each_cpu_and(cpu, freq_domain_span(fd), sched_domain_span(sd)) {
> +			if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> +				continue;
> +
> +			if (cpu == prev_cpu)
> +				continue;
> +
> +			util = cpu_util_wake(cpu, p);
> +			cpu_cap = capacity_of(cpu);
> +			if (!util_fits_capacity(util + task_util, cpu_cap))
> +				continue;
> +
> +			spare_cap = cpu_cap - util;
> +			if (spare_cap > max_spare_cap) {
> +				max_spare_cap = spare_cap;
> +				max_spare_cap_cpu = cpu;
> +			}
> +		}
> +
> +		/* Evaluate the energy impact of using this CPU. */
> +		if (max_spare_cap_cpu >= 0) {
> +			cur_energy = compute_energy(p, max_spare_cap_cpu);
> +			if (cur_energy < best_energy) {
> +				best_energy = cur_energy;
> +				best_energy_cpu = max_spare_cap_cpu;
> +			}
> +		}
> +	}

If each CPU has its own frequency domain, then the above loop ends up
being O(n^2), no? Is there really nothing we can do about that? Also, I
feel that warrants a comment warning about this.

Someone, somewhere will try and build a 64+64 cpu system and get
surprised it doesn't work :-)
