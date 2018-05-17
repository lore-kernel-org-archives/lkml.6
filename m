Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbeEQQ4m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:56:42 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42582 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeEQQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:56:39 -0400
X-Google-Smtp-Source: AB8JxZowvDuRKPcy7GOZYpb9P/b5KP+yJ7DZuGyVdeNOCFhEltF772IWx1JOuEw0bfNi7wtNAf824AHCCNpIRiAC7K4=
MIME-Version: 1.0
In-Reply-To: <1526575358.11765.14.camel@linux.intel.com>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-3-srinivas.pandruvada@linux.intel.com>
 <20180516151925.GO28366@localhost.localdomain> <20180516154733.GF12198@hirez.programming.kicks-ass.net>
 <20180516163105.GP28366@localhost.localdomain> <20180517105907.GC22493@localhost.localdomain>
 <20180517150418.GF22493@localhost.localdomain> <1526571692.11765.10.camel@linux.intel.com>
 <20180517161649.GX12217@hirez.programming.kicks-ass.net> <1526575358.11765.14.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 May 2018 18:56:37 +0200
X-Google-Sender-Auth: ocvLPzWuU6qA8Xyns8KFlX9vU64
Message-ID: <CAJZ5v0j82sm94iCpLOVMBwoSksKx1Y49RfJv=nhhJiKhenZykg@mail.gmail.com>
Subject: Re: [RFC/RFT] [PATCH 02/10] cpufreq: intel_pstate: Conditional
 frequency invariant accounting
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 6:42 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Thu, 2018-05-17 at 18:16 +0200, Peter Zijlstra wrote:
>> On Thu, May 17, 2018 at 08:41:32AM -0700, Srinivas Pandruvada wrote:
>> > One more point to note. Even if we calculate some utilization based
>> > on
>> > the freq-invariant and arrive at a P-state, we will not be able to
>> > control any P-state in turbo region (not even as a cap) on several
>> > Intel processors using PERF_CTL MSRs.
>>
>> Right, but don't we need to set the PERF_CTL to max P in order to
>> access the turbo bins?
>
> Any PERF_CTL setting above what we call "Turbo Activation ratio" (which
> can be less than P1 read from platform info MSR) will do that on these
> systems (Most clients from Ivy bridge).
>
>>  So we still need to compute a P state, but as soon as we
>> reach max P, we're done.
>
> What will happen if we look at all core turbo as max and cap any
> utilization above this to 1024?

I was going to suggest that.

Otherwise, if we ever get (say) the max one-core turbo at any point
and the system only runs parallel workloads after that, it will appear
as underutilized.
