Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752592AbeBHR76 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 12:59:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:50986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbeBHR74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 12:59:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FC021796
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Wanpeng Li <kernellwp@gmail.com>,
        Mike Galbraith <efault@gmx.de>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 0/6] isolation: 1Hz residual tick offloading v5
Date: Thu,  8 Feb 2018 18:59:33 +0100
Message-Id: <1518112779-30196-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series should address most reviews from Peterz in v4:

* Check that the remote tick doesn't come way too late. For that we
  track the last time we called update_curr() with checking
  tsk->se.exec_start which doesn't only account for ticks but also queue
  and dequeue events.

* Add comment to explain why we use HZ as a delay

* Feed changelog with explanation about correctness assumptions on
  calling rq::task_tick() remotely.

The last element is to enforce unbound workqueues to queue a work on
a CPU of the same node when the enqueuer is outside the unbound mask.
This will be sorted out seperately.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	sched/0hz-v5

HEAD: 62711eb7856882d443615f0ef0ba9518977b7abd

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      sched: Rename init_rq_hrtick to hrtick_rq_init
      nohz: Allow to check if remote CPU tick is stopped
      sched/isolation: Isolate workqueues when "nohz_full=" is set
      sched/isolation: Residual 1Hz scheduler tick offload
      sched/nohz: Remove the 1 Hz tick code
      sched/isolation: Tick offload documentation


 Documentation/admin-guide/kernel-parameters.txt |   6 +-
 include/linux/sched/isolation.h                 |   1 +
 include/linux/sched/nohz.h                      |   4 -
 include/linux/tick.h                            |   2 +
 kernel/sched/core.c                             | 116 ++++++++++++++++++------
 kernel/sched/idle_task.c                        |   1 -
 kernel/sched/isolation.c                        |   8 +-
 kernel/sched/sched.h                            |  13 +--
 kernel/time/tick-sched.c                        |  13 +--
 kernel/workqueue.c                              |   3 +-
 10 files changed, 115 insertions(+), 52 deletions(-)
