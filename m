Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbeC0QnH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:43:07 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39498 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932455AbeC0Qm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:42:58 -0400
X-Google-Smtp-Source: AIpwx4/3gLOdBY66bPGloS3f1w1jeNUQtzjiLLLEPwnBnDXcodxEggdn2J3f5OXgxNR6eoH1x4E0Iluk3eqpb4cu5Ak=
MIME-Version: 1.0
In-Reply-To: <1521736338.6308.24.camel@surriel.com>
References: <4137867.C4jYrWdt8n@aspire.rjw.lan> <20180314120450.GT4043@hirez.programming.kicks-ass.net>
 <1521736338.6308.24.camel@surriel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Mar 2018 18:42:57 +0200
X-Google-Sender-Auth: WfebQPjJmP9xLKV-mYGrF0pP4mk
Message-ID: <CAJZ5v0ikayycQs1m2rTa8WRLZ5sQ5q2SQVZkDuuy6GOE=dJFQQ@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle: poll_state: Add time limit to poll_idle()
To: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 5:32 PM, Rik van Riel <riel@surriel.com> wrote:
> On Wed, 2018-03-14 at 13:04 +0100, Peter Zijlstra wrote:
>
>> On x86 we don't have to use that time_check_counter thing,
>> sched_clock()
>> is really cheap, not sure if it makes sense on other platforms.
>
> Are you sure? I saw a 5-10% increase in CPU use,
> for a constant query rate to a memcache style
> workload, with v3 of this patch.

I think I know what's going on.

Increased utilization with the same amount of work per time unit (and
I guess that's the case given the lack of specific information about
the workload) means more non-idle time with respect to total time and
that implies reduced frequency (eg. less turbo).

Now, combine that with the Doug's observation that limiting the rate
of local_clock() invocations in the poll_idle() loop reduces power
draw during experiments on his system significantly and with the other
one that in both cases local_lock() ends up being rdtsc() (most
likely).

What this implies to me is that invoking rdtsc() at a high rate on
multiple logical CPUs in parallel causes chips to get hot.  Actually
that may be so hot that they hit power/thremal (eg. RAPL) limits and
get their frequency reduced as a result.

Limiting the rate of local_clock() invocations obviously avoids this issue.
