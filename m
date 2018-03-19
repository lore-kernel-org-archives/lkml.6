Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970661AbeCSV34 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:29:56 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:44791 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965234AbeCSV3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:29:50 -0400
X-Google-Smtp-Source: AG47ELu/KPH09XtZrd2quugu2sFLH6UNOtqMm5gVDjhU304RCgIkwlViQjfEz2UgPcGXHlAGefrtnA==
Date: Mon, 19 Mar 2018 14:29:46 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Subject: [GIT PULL] percpu fixes for v4.16-rc6
Message-ID: <20180319212946.GI519464@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Late percpu pull request for v4.16-rc6.

* percpu allocator pool replenishing no longer triggers OOM or warning
  messages.  Also, the alloc interface now understands __GFP_NORETRY
  and __GFP_NOWARN.  This is to allow avoiding OOMs from userland
  triggered actions like bpf map creation.  Also added cond_resched()
  in alloc loop.

* perpcu allocation now can be interrupted by kill sigs to avoid
  deadlocking OOM killer.

* Added Dennis Zhou as a co-maintainer.  He has rewritten the area map
  allocator, understands most of the code base and has been responsive
  for all bug reports.

Thanks.

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git for-4.16-fixes

for you to fetch changes up to b3a5d111994450909158929560906f2c1c6c1d85:

  percpu_ref: Update doc to dissuade users from depending on internal RCU grace periods (2018-03-19 10:09:44 -0700)

----------------------------------------------------------------
Dennis Zhou (3):
      percpu: match chunk allocator declarations with definitions
      percpu: add __GFP_NORETRY semantics to the percpu balancing path
      percpu: allow select gfp to be passed to underlying allocators

Eric Dumazet (1):
      percpu: add a schedule point in pcpu_balance_workfn()

Kirill Tkhai (1):
      mm: Allow to kill tasks doing pcpu_alloc() and waiting for pcpu_balance_workfn()

Tejun Heo (3):
      percpu: add Dennis Zhou as a percpu co-maintainer
      percpu: include linux/sched.h for cond_resched()
      percpu_ref: Update doc to dissuade users from depending on internal RCU grace periods

 MAINTAINERS                     |  1 +
 include/linux/percpu-refcount.h | 18 +++++++----
 lib/percpu-refcount.c           |  2 ++
 mm/percpu-km.c                  |  8 ++---
 mm/percpu-vm.c                  | 18 ++++++-----
 mm/percpu.c                     | 67 +++++++++++++++++++++++++++--------------
 6 files changed, 74 insertions(+), 40 deletions(-)
