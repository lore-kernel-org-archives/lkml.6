Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeFEIgt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 04:36:49 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46902 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbeFEIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 04:36:47 -0400
X-Google-Smtp-Source: ADUXVKKMJ7MaeRMinB5fzKG3empfvzYha4XAr0m6dtEbzi85FbERBmJpgZETn3uxxgMWeMv/8WsE+tXlY2vBNua0f+s=
MIME-Version: 1.0
In-Reply-To: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 5 Jun 2018 10:36:26 +0200
Message-ID: <CAKfTPtB0MHN3=VbS4mYqVH_0fv1WwKq6N1-ogU84mNUAxfCwjw@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] track CPU utilization
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000610ce0056de0f394"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000610ce0056de0f394
Content-Type: text/plain; charset="UTF-8"

Hi Quentin,

On 25 May 2018 at 15:12, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> This patchset initially tracked only the utilization of RT rq. During
> OSPM summit, it has been discussed the opportunity to extend it in order
> to get an estimate of the utilization of the CPU.
>
> - Patches 1-3 correspond to the content of patchset v4 and add utilization
>   tracking for rt_rq.
>
> When both cfs and rt tasks compete to run on a CPU, we can see some frequency
> drops with schedutil governor. In such case, the cfs_rq's utilization doesn't
> reflect anymore the utilization of cfs tasks but only the remaining part that
> is not used by rt tasks. We should monitor the stolen utilization and take
> it into account when selecting OPP. This patchset doesn't change the OPP
> selection policy for RT tasks but only for CFS tasks
>
> A rt-app use case which creates an always running cfs thread and a rt threads
> that wakes up periodically with both threads pinned on same CPU, show lot of
> frequency switches of the CPU whereas the CPU never goes idles during the
> test. I can share the json file that I used for the test if someone is
> interested in.
>
> For a 15 seconds long test on a hikey 6220 (octo core cortex A53 platfrom),
> the cpufreq statistics outputs (stats are reset just before the test) :
> $ cat /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans
> without patchset : 1230
> with patchset : 14

I have attached the rt-app json file that I use for this test

>
> If we replace the cfs thread of rt-app by a sysbench cpu test, we can see
> performance improvements:
>
> - Without patchset :
> Test execution summary:
>     total time:                          15.0009s
>     total number of events:              4903
>     total time taken by event execution: 14.9972
>     per-request statistics:
>          min:                                  1.23ms
>          avg:                                  3.06ms
>          max:                                 13.16ms
>          approx.  95 percentile:              12.73ms
>
> Threads fairness:
>     events (avg/stddev):           4903.0000/0.00
>     execution time (avg/stddev):   14.9972/0.00
>
> - With patchset:
> Test execution summary:
>     total time:                          15.0014s
>     total number of events:              7694
>     total time taken by event execution: 14.9979
>     per-request statistics:
>          min:                                  1.23ms
>          avg:                                  1.95ms
>          max:                                 10.49ms
>          approx.  95 percentile:              10.39ms
>
> Threads fairness:
>     events (avg/stddev):           7694.0000/0.00
>     execution time (avg/stddev):   14.9979/0.00
>
> The performance improvement is 56% for this use case.
>
> - Patches 4-5 add utilization tracking for dl_rq in order to solve similar
>   problem as with rt_rq
>
> - Patches 6 uses dl and rt utilization in the scale_rt_capacity() and remove
>   dl and rt from sched_rt_avg_update
>
> - Patches 7-8 add utilization tracking for interrupt and use it select OPP
>   A test with iperf on hikey 6220 gives:
>     w/o patchset            w/ patchset
>     Tx 276 Mbits/sec        304 Mbits/sec +10%
>     Rx 299 Mbits/sec        328 Mbits/sec +09%
>
>     8 iterations of iperf -c server_address -r -t 5
>     stdev is lower than 1%
>     Only WFI idle state is enable (shallowest arm idle state)
>
> - Patches 9 removes the unused sched_avg_update code
>
> - Patch 10 removes the unused sched_time_avg_ms
>
> Change since v3:
> - add support of periodic update of blocked utilization
> - rebase on lastest tip/sched/core
>
> Change since v2:
> - move pelt code into a dedicated pelt.c file
> - rebase on load tracking changes
>
> Change since v1:
> - Only a rebase. I have addressed the comments on previous version in
>   patch 1/2
>
> Vincent Guittot (10):
>   sched/pelt: Move pelt related code in a dedicated file
>   sched/rt: add rt_rq utilization tracking
>   cpufreq/schedutil: add rt utilization tracking
>   sched/dl: add dl_rq utilization tracking
>   cpufreq/schedutil: get max utilization
>   sched: remove rt and dl from sched_avg
>   sched/irq: add irq utilization tracking
>   cpufreq/schedutil: take into account interrupt
>   sched: remove rt_avg code
>   proc/sched: remove unused sched_time_avg_ms
>
>  include/linux/sched/sysctl.h     |   1 -
>  kernel/sched/Makefile            |   2 +-
>  kernel/sched/core.c              |  38 +---
>  kernel/sched/cpufreq_schedutil.c |  24 ++-
>  kernel/sched/deadline.c          |   7 +-
>  kernel/sched/fair.c              | 381 +++----------------------------------
>  kernel/sched/pelt.c              | 395 +++++++++++++++++++++++++++++++++++++++
>  kernel/sched/pelt.h              |  63 +++++++
>  kernel/sched/rt.c                |  10 +-
>  kernel/sched/sched.h             |  57 ++++--
>  kernel/sysctl.c                  |   8 -
>  11 files changed, 563 insertions(+), 423 deletions(-)
>  create mode 100644 kernel/sched/pelt.c
>  create mode 100644 kernel/sched/pelt.h
>
> --
> 2.7.4
>

--000000000000610ce0056de0f394
Content-Type: application/json; name="test-rt.json"
Content-Disposition: attachment; filename="test-rt.json"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ji1fjqfi0

ewoJInRhc2tzIiA6IHsKCQkidGhyZWFkQSIgOiB7CgkJCSJpbnN0YW5jZSIgOiAxLAoJCQkicG9s
aWN5IiA6ICJTQ0hFRF9PVEhFUiIsCgkJCSJsb29wIiA6IC0xLAoJCQkicGhhc2VzIiA6IHsKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiYWN0aXZlMSIgOiB7CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAibG9vcCIgOiAxMDAsCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAiY3B1cyIgOiBbNV0sCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAicnVuIiA6IDI3NzAwCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfQoJCQl9CgkJfSwKICAgICAgICAidGhyZWFkQiIgOiB7CgkJCSJpbnN0YW5jZSIg
OiAxLAogICAgICAgICAgICAicG9saWN5IiA6ICJTQ0hFRF9GSUZPIiwKCSAgCSJkZWxheSIgOiAx
Nzc3NzAsCiAgICAgICAgICAgICJsb29wIiA6IC0xLAogICAgICAgICAgICAicGhhc2VzIiA6IHsK
CQkJCSJhY3RpdmUxIiA6IHsKCQkJCQkibG9vcCIgOiA1MCwKCQkJCQkiY3B1cyIgOiBbNV0sCgkJ
CQkJInJ1biIgOiA5MDAwLAoJCQkJCSJ0aW1lciIgOiAgeyAicmVmIiA6ICJ0aWNrQiIsICJwZXJp
b2QiIDogMTc3NzcsIH0KCQkJCX0sCgkJCQkiaWRsZTEiIDogewoJCQkJCSJsb29wIiA6IDEsCgkJ
CQkJImNwdXMiIDogWzVdLAoJCQkJCSJ0aW1lciIgOiAgeyAicmVmIiA6ICJ0aWNrQiIsICJwZXJp
b2QiIDogMzc3Nzc3LCB9CgkJCQl9CgkJCX0KCQl9Cgl9LAoJImdsb2JhbCIgOiB7CgkJImR1cmF0
aW9uIiA6IDE1LAoJCSJkZWZhdWx0X3BvbGljeSIgOiAiU0NIRURfT1RIRVIiLAoJCSJjYWxpYnJh
dGlvbiIgOiAxNTEsCgkJImxvY2tfcGFnZXMiIDogdHJ1ZSwKCQkiZnRyYWNlIiA6IGZhbHNlLAoJ
CSJsb2dkaXIiIDogIi4vIiwKCQkibG9nX3NpemUiIDogImRpc2FibGUiCgl9Cn0KCg==
--000000000000610ce0056de0f394--
