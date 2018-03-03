Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeCCPlX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:41:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43078 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCCPlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:41:22 -0500
Date: Sat, 3 Mar 2018 16:41:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: skannan@codeaurora.org
Cc: mark.rutland@arm.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        avilaj@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf/core: Add support for PMUs that can be read
 from any CPU
Message-ID: <20180303154113.GH25201@hirez.programming.kicks-ass.net>
References: <1519431578-11995-1-git-send-email-skannan@codeaurora.org>
 <1519431578-11995-2-git-send-email-skannan@codeaurora.org>
 <20180224084106.GC25201@hirez.programming.kicks-ass.net>
 <7cab1b91545e81e4b6b09e85c2f81d7e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cab1b91545e81e4b6b09e85c2f81d7e@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 05:53:57PM -0800, skannan@codeaurora.org wrote:
> On 2018-02-24 00:41, Peter Zijlstra wrote:
> > On Fri, Feb 23, 2018 at 04:19:38PM -0800, Saravana Kannan wrote:
> > > Some PMUs events can be read from any CPU. So allow the PMU to mark
> > > events as such. For these events, we don't need to reject reads or
> > > make smp calls to the event's CPU and cause unnecessary wake ups.
> > > 
> > > Good examples of such events would be events from caches shared across
> > > all CPUs.
> > 
> > So why would the existing ACTIVE_PKG not work for you? Because clearly
> > your example does not cross a package.
> 
> Because based on testing it on hardware, it looks like the two clusters in
> an ARM DynamIQ design are not considered part of the same "package". When I
> say clusters, I using the more common interpretation of "homogeneous CPUs
> running on the same clock"/CPUs in a cpufreq policy and not ARM's new
> redefinition of cluster. So, on a SoC with 4 little and 4 big cores, it'll
> still trigger a lot of unnecessary smp calls/IPIs that cause unnecessary
> wakeups.

arch/arm64/include/asm/topology.h:#define topology_physical_package_id(cpu)     (cpu_topology[cpu].cluster_id)

*sigh*... that's just broken...
