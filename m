Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeBAQvO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:51:14 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:51796 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751783AbeBAQvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:51:12 -0500
X-Google-Smtp-Source: AH8x226Bnwn+GBp98FUA2hkvpvRxGn1Ikf+58WnWKUTmeoSdJqIoKMMO4/MIFgmeLdsxKH8joYhLAA==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/7] sched/deadline: fix cpusets bandwidth accounting
Date: Thu,  1 Feb 2018 09:51:02 -0700
Message-Id: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the follow-up patchset to [1] that attempt to fix a problem
reported by Steve Rostedt [2] where DL bandwidth accounting is not
recomputed after CPUset and CPU hotplug operations.  When CPU hotplug and
some CUPset manipulation take place root domains are destroyed and new ones
created, loosing at the same time DL accounting information pertaining to
utilisation.  Please see [1] for a full description of the approach.

In this revision a shortcoming identified by Luca is addressed, with most
of the solution kept unchanged.

A notable addition is patch 7/7 - it addresses a problem seen when hot
plugging out a CPU where a DL task is running (see changelog for full
details).  The issue is unrelated to this patchset and will manifest
itself on a mainline kernel.

I will start working on that problem once done with this set but lumping
it in here to raise awareness and provide a stop-gap measure while a
better solution is designed.  This set is also available here [3] with the
instrumentation for patch 7/7 in this commit [4].

This set applies cleanly on top of v4.15.

Best regards,
Mathieu

------
Change for V2:
. Addressing a problem found by Luca Abeni where the mask of a DL task
  isn't modified when cpuset are collapsed.

[1]. https://groups.google.com/forum/#!topic/linux.kernel/uakbvOQE6rc
[2]. https://lkml.org/lkml/2016/2/3/966
[3]. https://git.linaro.org/people/mathieu.poirier/linux.git/log/?h=v4.15-bandwidth-accounting-v2
[4]. af68563a6c21 ("sched/debug: Add 'rq_debug' proc entry")

Mathieu Poirier (7):
  sched/topology: Adding function partition_sched_domains_locked()
  cpuset: Rebuild root domain deadline accounting information
  sched/deadline: Keep new DL task within root domain's boundary
  cgroup: Constrain 'sched_load_balance' flag when DL tasks are present
  cgroup: Constrain the addition of CPUs to a new CPUset
  sched/core: Don't change the affinity of DL tasks
  sched/deadline: Prevent CPU hotplug operation if DL task on CPU

 include/linux/cpuset.h         |   6 ++
 include/linux/sched.h          |   3 +
 include/linux/sched/deadline.h |   8 ++
 include/linux/sched/topology.h |   9 ++
 kernel/cgroup/cpuset.c         | 232 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/core.c            |  32 +++++-
 kernel/sched/deadline.c        |  36 +++++++
 kernel/sched/sched.h           |   3 -
 kernel/sched/topology.c        |  31 +++++-
 9 files changed, 346 insertions(+), 14 deletions(-)

-- 
2.7.4
