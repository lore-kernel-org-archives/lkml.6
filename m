Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeB0CLr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:11:47 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeB0CLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:11:46 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Feb 2018 18:11:45 -0800
From: skannan@codeaurora.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        avilaj@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf/core: Add support for PMUs that can be read
 from any CPU
In-Reply-To: <20180225143802.denbkubqjg2dc7af@salmiak>
References: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
 <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
 <20180225143802.denbkubqjg2dc7af@salmiak>
Message-ID: <90e7ff7d7dc1054db356fb1740ddb990@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-25 06:38, Mark Rutland wrote:
> On Fri, Feb 23, 2018 at 04:19:38PM -0800, Saravana Kannan wrote:
>> Some PMUs events can be read from any CPU. So allow the PMU to mark
>> events as such. For these events, we don't need to reject reads or
>> make smp calls to the event's CPU and cause unnecessary wake ups.
>> 
>> Good examples of such events would be events from caches shared across
>> all CPUs.
> 
> I think that if we need to generalize PERF_EV_CAP_READ_ACTIVE_PKG, it 
> would be
> better to give events a pointer to a cpumask. That could then cover all 
> cases
> quite trivially:
> 
> static int __perf_event_read_cpu(struct perf_event *event, int 
> event_cpu)
> {
> 	int local_cpu = smp_processor_id();
> 
> 	if (event->read_mask &&
> 	    cpumask_test_cpu(local_cpu, event->read_mask))
> 		event_cpu = local_cpu;
> 
> 	return event_cpu;
> }
> 

This is a good improvement on my attempt. If I send a patch for this, is 
that something you'd be willing to incorporate into your patch set and 
make sure the DSU pmu driver handles it correctly?

> ... in the PERF_EV_CAP_READ_ACTIVE_PKG case, we can use the exiting(?) 
> package
> masks, and more generally we can re-use the PMU's affinit mask if it 
> has one.
> 
> That said, I see that many pmu::read() implementations have 
> side-effects on
> hwc->prev_count, and event->count, so I worry that this won't be sfe in 
> general
> (e.g. if we race with the IRQ handler on another CPU).
> 

Yeah, this doesn't have to be mandatory. It can be an optional mask the 
PMU can set up during perf event init.

Peter,

Is this something that's acceptable to you?

Thanks,
Saravana
