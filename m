Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966722AbeBPPKM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 10:10:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56541 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966483AbeBPPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 10:10:10 -0500
From: John Ogness <john.ogness@linutronix.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] fs/dcache: avoid trylock loops
Date: Fri, 16 Feb 2018 16:09:29 +0100
Message-Id: <20180216150933.971-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes all trylock loops from within the dcache code.

Both d_delete() and dentry_kill() hold dentry->d_lock while needing
to acquire dentry->d_inode->i_lock. dentry_kill() also needs to
acquire dentry->d_parent->d_lock. This cannot be done directly with
spin_lock() operations because it is the reverse of the regular lock
order. To avoid ABBA deadlocks it is done using trylock loops.

Trylock loops are problematic in two scenarios:

  1) PREEMPT_RT converts spinlocks to 'sleeping' spinlocks, which are
     preemptible. As a consequence the i_lock holder can be preempted
     by a higher priority task. If that task executes the trylock
     loop it will do so forever and live lock.

  2) In virtual machines trylock loops are problematic as well. The
     VCPU on which the i_lock holder runs can be scheduled out and a
     task on a different VCPU can loop for a whole time slice. In the
     worst case this can lead to starvation. Commits 47be61845c77
     ("fs/dcache.c: avoid soft-lockup in dput()") and 046b961b45f9
     ("shrink_dentry_list(): take parent's d_lock earlier") are
     addressing exactly those symptoms.

The trylock loops can be avoided with functionality similar to
lock_parent(); temporarily dropping dentry->d_lock while holding
the rcu_read_lock so that the desired locks can be acquired in the
correct order. After the locks are acquired it is necessary to verify
that the relevant dentry members did not change while dentry->d_lock
was dropped. If they changed, the whole operation must be repeated.

John Ogness (4):
  fs/dcache: Remove stale comment from dentry_kill()
  fs/dcache: Move dentry_kill() below lock_parent()
  fs/dcache: Avoid the try_lock loop in d_delete()
  fs/dcache: Avoid the try_lock loops in dentry_kill()

 fs/dcache.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 139 insertions(+), 40 deletions(-)

-- 
2.11.0
