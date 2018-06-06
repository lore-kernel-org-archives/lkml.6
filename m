Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dRJ3BYV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1893E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbeFFKvN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:51:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45564 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932428AbeFFKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:51:12 -0400
Date: Wed, 6 Jun 2018 12:50:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V3 02/17] kallsyms, x86: Export addresses of syscall
 trampolines
Message-ID: <20180606105059.GF12198@hirez.programming.kicks-ass.net>
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
 <1526986485-6562-3-git-send-email-adrian.hunter@intel.com>
 <20180605160043.GC7220@tassilo.jf.intel.com>
 <57f1e61f-49fa-99be-6876-48775272ccec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f1e61f-49fa-99be-6876-48775272ccec@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 11:02:08AM +0300, Adrian Hunter wrote:
> On 05/06/18 19:00, Andi Kleen wrote:
> >> +#ifdef CONFIG_X86_64
> >> +int arch_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
> >> +		     char *name)
> >> +{
> >> +	unsigned int cpu, ncpu;
> >> +
> >> +	if (symnum >= num_possible_cpus())
> >> +		return -EINVAL;
> >> +
> >> +	for (cpu = cpumask_first(cpu_possible_mask), ncpu = 0;
> >> +	     cpu < num_possible_cpus() && ncpu < symnum;
> >> +	     cpu = cpumask_next(cpu, cpu_possible_mask), ncpu++)
> >> +		;
> > 
> > That is max_t(unsigned, cpumask_last(cpu_possible_mask), symnum)
> 
> I think it should be:
> 
> -	     cpu < num_possible_cpus() && ncpu < symnum;
> +	     ncpu < symnum;

Since we're bike-shedding:

	for_each_possible_cpu(cpu) {
		if (ncpu++ >= symnum)
			break;
	}
