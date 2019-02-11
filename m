Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B858AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C5E21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbfBKSAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:00:08 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55114 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730464AbfBKSAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:00:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B5EBEBD;
        Mon, 11 Feb 2019 10:00:07 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 14FA73F675;
        Mon, 11 Feb 2019 10:00:05 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Dietmar.Eggemann@arm.com
Subject: [PATCH v2 0/3] sched/fair: NOHZ cleanups and misfit improvement
Date:   Mon, 11 Feb 2019 17:59:43 +0000
Message-Id: <20190211175946.4961-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In

  commit 5fbdfae5221a ("sched/fair: Kick nohz balance if rq->misfit_task_load")

was added a trigger for nohz kicks, which is required to offload misfit tasks
from LITTLE to big CPUs. However, those kicks could be issued a lot more
frequently than what is strictly needed.

This patch-set tunes down unneeded nohz kicks.

- Patch 1 adds some more comments to nohz_balancer_kick()
- Patches [2-3] tweak the nohz kick conditions for asymmetric systems

* Changes since v1

  - Patches 1-3 from v1 are in tip/sched/core and thus not included
    tip HEAD is 1b5500d73466 ("sched/fair: Remove unused 'sd' parameter from select_idle_smt()")
  - Patch 1 from v2 is new (Peter)
  - Patch 3 from v2 (5 from v1) now shuffles conditions to avoid a goto (Peter)

* nohz_balancer_kick() shuffling impact

  The ASYM_PACKING loop used to be towards the end of nohz_balancer_kick(),
  and the LLC condition was higher up. Since the LLC condition is very
  often true, we probably were avoiding the loop most of the time on systems
  that use ASYM_PACKING. However, I don't have one at hand and I'm not sure
  hacking up a kernel to enable ASYM_PACKING on a system that doesn't need it
  would be truly relevant.

  I ran 20 iterations of

    'hackbench -g 1 -l 100000'

  on a 2-sockets Xeon E5 (40 logical cores, no ASYM_PACKING) but the difference
  (hackbench duration & nohz_balancer_kick() FTrace profiling) lies in the noise.

--------------------------------------------------------------------------------
* Testing
** kick_ilb() hits
  This causes a large reduction in calls to kick_ilb() (and thus subsequent
  rescheduling interrupts & useless nohz balance calls) in most scenarios.

  The "best case" one is running NR_BIG_CPUS big tasks, which I tested with
  4 50% periodic tasks running for 5 seconds on my HiKey960 (4x4 big.LITTLE):

  | CPU | hits (baseline) | hits (patchset) |
  |-----+-----------------+-----------------|
  |   0 |              31 |              41 |
  |   1 |              21 |               3 |
  |   2 |              35 |               2 |
  |   3 |               9 |               4 |
  |-----+-----------------+-----------------|
  |   4 |             170 |               4 |
  |   5 |             573 |               4 |
  |   6 |             544 |               4 |
  |   7 |             579 |               4 |


  Something a bit less idealistic with NR_CPUS-1 big tasks still shows some
  improvements (7 100% tasks running for 5 seconds on my HiKey960):

  | CPU | hits (baseline) | hits (patchset) |
  |-----+-----------------+-----------------|
  |   0 |              14 |             122 |
  |   1 |              47 |             162 |
  |   2 |              11 |             156 |
  |   3 |               9 |               3 |
  |-----+-----------------+-----------------|
  |   4 |              53 |               6 |
  |   5 |             276 |              13 |
  |   6 |             312 |               7 |
  |   7 |             250 |              11 |

  I was surprised to see such an increase in calls to kick_ilb() from LITTLE
  CPUs ([0-3]), but after a bit of investigation it turns out that the big
  CPUs would always run nohz_balancer_kick() a jiffy before the LITTLEs, so
  the LITTLEs would always bail out because nohz.next_balance had just been
  updated before they called nohz_balancer_kick(). IOW,

      time_before(now, nohz.next_balance)

  would always be true on CPUs [0-3] during my workload. Quieting the kicks
  issued by the big CPUs allowed the LITTLEs to execute nohz_balancer_kick()
  past that condition, explaining the higher number of kicks issued from LITTLE
  CPUs.
  
** misfit behaviour
  For good measure I also ran the usual misfit tests [1] which showed no
  particular change.

[1]: https://github.com/ARM-software/lisa/blob/next/lisa/tests/kernel/scheduler/misfit.py

Valentin Schneider (3):
  sched/fair: Comment some nohz_balancer_kick() kick conditions
  sched/fair: Tune down misfit nohz kicks
  sched/fair: Skip LLC nohz logic for asymmetric systems

 kernel/sched/fair.c | 84 +++++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 21 deletions(-)

--
2.20.1

