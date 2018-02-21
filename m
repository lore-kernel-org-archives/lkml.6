Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeBUERk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 23:17:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751217AbeBUERj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 23:17:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A361E21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Wanpeng Li <kernellwp@gmail.com>,
        Mike Galbraith <efault@gmx.de>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 0/7] isolation: 1Hz residual tick offloading v7
Date: Wed, 21 Feb 2018 05:17:22 +0100
Message-Id: <1519186649-3242-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version addresses comments from Thomas:

* Convert tick_nohz_tick_stopped[_cpu]() to bool
* Add comments to each sched_class::task_tick() to make sure that datas
  are always fetched from rq and task passed in parameters to allow
  for remote ticks.
* Add reviewed-by tags

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	sched/0hz-v7

HEAD: b0d4913a0a39c717f354e40c1642264632e76960

Thanks,
	Frederic
---

Frederic Weisbecker (7):
      sched: Rename init_rq_hrtick to hrtick_rq_init
      nohz: Convert tick_nohz_tick_stopped() to bool
      nohz: Allow to check if remote CPU tick is stopped
      sched/isolation: Isolate workqueues when "nohz_full=" is set
      sched/isolation: Offload residual 1Hz scheduler tick
      sched/nohz: Remove the 1 Hz tick code
      sched/isolation: Update nohz documentation to explain tick offload


 Documentation/admin-guide/kernel-parameters.txt |  11 +++
 include/linux/sched/isolation.h                 |   1 +
 include/linux/sched/nohz.h                      |   4 -
 include/linux/tick.h                            |   4 +-
 kernel/sched/core.c                             | 117 ++++++++++++++++++------
 kernel/sched/deadline.c                         |   8 ++
 kernel/sched/fair.c                             |   7 +-
 kernel/sched/idle_task.c                        |   9 +-
 kernel/sched/isolation.c                        |   7 +-
 kernel/sched/rt.c                               |   8 ++
 kernel/sched/sched.h                            |  13 +--
 kernel/sched/stop_task.c                        |   8 ++
 kernel/time/tick-sched.c                        |  15 +--
 kernel/workqueue.c                              |   3 +-
 14 files changed, 162 insertions(+), 53 deletions(-)
