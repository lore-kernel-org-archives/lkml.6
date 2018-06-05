Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeFETWC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 15:22:02 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:42194 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbeFETWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 15:22:00 -0400
X-Google-Smtp-Source: ADUXVKJGW9HKBUxSYdz+se09AwAqOFElera1aPmL2KSWQmu22QFazcc6pyZNLzWWpbWsVQP4xRxWqw==
Date: Tue, 5 Jun 2018 12:21:57 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v4.18-rc1
Message-ID: <20180605192157.GG1351649@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

cgroup changes for v4.18.

* For cpustat, cgroup has a percpu hierarchical stat mechanism which
  propagates up the hierarchy lazily.  This pull request contains
  commits to factor out and generalize the mechanism so that it can be
  used for other cgroup stats too.  The original intention was to
  update memcg stats to use it but memcg went for a different
  approach, so still the only user is cpustat.  The factoring out and
  generalization still make sense and it's likely that this can be
  used for other purposes in the future.

* cgroup uses file modified events to notify certain events.  A rate
  limiting mechanism is added.

* Other misc changes.

Thanks.

The following changes since commit fe03a7594d86e0754f05e604cd803a6a9aae3c1c:

  Merge tag 'acpi-4.17-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2018-04-26 11:06:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-4.18

for you to fetch changes up to d8742e22902186e30c346b1ba881cb52942ae3e4:

  cgroup: css_set_lock should nest inside tasklist_lock (2018-05-23 11:04:54 -0700)

----------------------------------------------------------------
Andy Shevchenko (1):
      rdmacg: Convert to use match_string() helper

Tejun Heo (12):
      cgroup: Explicitly remove core interface files
      cgroup: Limit event generation frequency
      cgroup: Rename kernel/cgroup/stat.c to kernel/cgroup/rstat.c
      cgroup: Rename stat to rstat
      cgroup: Distinguish base resource stat implementation from rstat
      cgroup: Reorganize kernel/cgroup/rstat.c
      cgroup: Factor out and expose cgroup_rstat_*() interface functions
      cgroup: Replace cgroup_rstat_mutex with a spinlock
      cgroup: Add cgroup_subsys->css_rstat_flush()
      cgroup: Add memory barriers to plug cgroup_rstat_updated() race window
      cgroup: Make cgroup_rstat_updated() ready for root cgroup usage
      cgroup: css_set_lock should nest inside tasklist_lock

 include/linux/cgroup-defs.h     |  52 +++--
 include/linux/cgroup.h          |  12 +-
 kernel/cgroup/Makefile          |   2 +-
 kernel/cgroup/cgroup-internal.h |  11 +-
 kernel/cgroup/cgroup.c          | 105 +++++++---
 kernel/cgroup/rdma.c            |  35 ++--
 kernel/cgroup/rstat.c           | 416 ++++++++++++++++++++++++++++++++++++++++
 kernel/cgroup/stat.c            | 338 --------------------------------
 8 files changed, 554 insertions(+), 417 deletions(-)
 create mode 100644 kernel/cgroup/rstat.c
 delete mode 100644 kernel/cgroup/stat.c

-- 
tejun
