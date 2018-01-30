Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeA3Kp7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:45:59 -0500
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:46281 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751464AbeA3Kp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:45:57 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/4] Reduce migrations and unnecessary spreading of load to multiple CPUs
Date: Tue, 30 Jan 2018 10:45:51 +0000
Message-Id: <20180130104555.4125-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been observed recently that problems with interaction between
scheduler decisions and cpufreq decisions have been unfavourable.
The scheduler decisions are biased towards reducing latency of searches
which is great on one hand but tends to spread load across an entire socket
unnecessarily. On low utilisation, this means the load on each individual CPU
is low which can be good but cpufreq decides that utilisation on individual
CPUs is too low to increase P-state and overall throughput suffers.

When a cpufreq driver is completely under the control of the OS, it
can be compensated for. For example, intel_pstate can decide to boost
apparent utilisation if a task recently slept on a CPU for idle. However,
if hardware-based cpufreq is in play (e.g. HWP) then very poor decisions
can be made and the OS cannot do much about it. This only gets worse as HWP
becomes more prevalent, sockets get larger and the p-state for individual
cores can be controlled. Just setting the performance governor is not an
answer given that plenty of people really do worry about power utilisation
and still want a reasonable balance between performance and power.

Patches 0-3 of this series reduce the number of migrations due to interrupts.
	Specifically, if prev CPU and the current CPU share cache and prev
	CPU is idle then use it in preference to migrating the load. The full
	reasoning why is in the changelog.

Patch 4 observes that co-operating tasks, particularly between an application
	and a kworker can push a load around a socket very quickly. This is
	particularly true if interrupts are involved (e.g. IO completions)
	and are delivered round-robin (e.g. due to MSI-X). It tracks
	what CPU was used for a recent wakeup and reuses that CPU if it's
	still idle when woken later. This reduces the number of cores that
	are active for a workload and can have a big boost in throughput
	without a hit to wakeup latency or stacking multiple tasks on one
	CPU when a machine is lightly loaded.

 include/linux/sched.h |  8 ++++++
 kernel/sched/core.c   |  1 +
 kernel/sched/fair.c   | 69 +++++++++++++++++++++++++++++++++------------------
 3 files changed, 54 insertions(+), 24 deletions(-)

-- 
2.15.1
