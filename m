Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeCOMgX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:36:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49192 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeCOMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:35:44 -0400
Message-Id: <20180315121902.942902000@infradead.org>
User-Agent: quilt/0.63-1
Date: Thu, 15 Mar 2018 13:19:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Chris Mason <clm@fb.com>, Anna Schumaker <anna.schumaker@netapp.com>,
        Joel Becker <jlbec@evilplan.org>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        George Spelvin <linux@sciencehorizons.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 00/11] sched/wait: Replace wait_on_atomic_t() with wait_var_event()
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I never really liked the whole wait_on_atomic_t() because of the hard-coded
type and condition. And when Dan proposed to add 50+ lines of duplication to
implement wait_on_atomic_one() I figured that was it.

Instead implement wait_var_event(), which at the fundamental level is much the
same hashed-waitqueue as wait_on_atomic_t() is, but it doesn't care about the
type or condition.

It is further modelled on the existing wait_event() API and is otherwise
consistent with that.

The existing:

  wait_for_atomic_t(&my_atomic, wait_atomic_t, TASK_UNINTERRUPTIBLE);
  wake_up_atomic_t(&my_atomic);

can be replaced with:

  wait_var_event(&my_atomic, !atomic_read(&my_atomic));
  wake_up_var(&my_atomic);

And Dan can do what he needs done using:

  wait_var_event(&my_atomic, atomic_read(&my_atomic) == 1);


---
 arch/mips/kernel/process.c                         |   2 +
 arch/mips/kernel/traps.c                           |   4 +-
 drivers/gpu/drm/drm_dp_aux_dev.c                   |  13 +--
 drivers/gpu/drm/i915/selftests/intel_breadcrumbs.c |  14 +--
 drivers/media/platform/qcom/venus/hfi.c            |   8 +-
 fs/afs/cell.c                                      |   6 +-
 fs/afs/rxrpc.c                                     |   6 +-
 fs/afs/server.c                                    |   6 +-
 fs/btrfs/extent-tree.c                             |  14 ++-
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/fscache/cookie.c                                |   7 +-
 fs/nfs/inode.c                                     |   5 -
 fs/nfs/pagelist.c                                  |   6 +-
 fs/nfs/pnfs_nfs.c                                  |   2 +-
 fs/nfs/write.c                                     |   6 +-
 fs/ocfs2/filecheck.c                               |   9 +-
 include/linux/fscache-cache.h                      |   2 +-
 include/linux/wait_bit.h                           |  95 +++++++++++++-----
 kernel/sched/wait_bit.c                            | 110 +++++----------------
 19 files changed, 147 insertions(+), 170 deletions(-)
