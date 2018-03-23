Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbeCWSFl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:05:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbeCWSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:05:38 -0400
Date: Fri, 23 Mar 2018 19:05:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 0/3] perf/core: expose thread context switch out event
 type to user space
Message-ID: <20180323180534.GD4043@hirez.programming.kicks-ass.net>
References: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <713750a0-7cc1-0a27-7253-12ff4f3c9a8d@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 07:08:25PM +0300, Alexey Budankov wrote:
> 
> Implementation of exposing context-switch-out type event as a part 
> of PERF_RECORD_SWITCH[_CPU_WIDE] record.
> 
> Introduced types of events assumed to be:
> a) preempt: when task->state == TASK_RUNNING
> b) yield: !preempt, encoding is done using new bit 
>    PERF_RECORD_MISC_SWITCH_OUT_YIELD like this:

A !preempt context switch isn't nessecarily a yield; please don't use
that name, it means something quite specific and this isn't it.

Specifically, on Linux yield() doesn't actually change task->state, so
when task->state is set !0 it _cannot_ have been yield.

I would invert the thing and call the preempt one SWITCH_OUT_PREEMPT.
