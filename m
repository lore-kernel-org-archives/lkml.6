Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeBVXw2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:52:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:40108 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbeBVXvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:51:13 -0500
From: John Ogness <john.ogness@linutronix.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] fs/dcache: avoid trylock loops
Date: Fri, 23 Feb 2018 00:50:19 +0100
Message-Id: <20180222235025.28662-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Al Viro, Linus Torvalds, Peter Zijlstra, Amir Goldstein
for the detailed feedback.

Changes in v2:
. dentry_lock_inode()
  - added quick out on trylock success
  - added comments to rcu section
  - expanded rcu coverage to all inode usage
  - if inode changes during d_lock window,
    restart the function (do not return)
  - track the dentry refcount and return false if it changes
. dentry_kill()
  - do not expect refcount=1 from caller
  - if refcount changes during d_lock window,
    return ERR_PTR(-EINTR) and do not drop d_lock
. dentry_put_kill() [new helper function]
  - dentry_kill() wrapper to implement the v1 dentry_kill()
    semantics needed by dput() and shrink_dentry_list()
. dput()
  - use new dentry_put_kill() instead of dentry_kill()
. d_delete()
  - refactor code flow using reworked dentry_lock_inode()
. shrink_dentry_list()
  - use dentry_kill() for dispose list killing
  - use dentry_put_kill() for ancestor pruning

This patchset removes all trylock loops from within the dcache code.

The functions d_delete(), dentry_kill(), and shrink_dentry_list()
hold dentry->d_lock while needing to acquire dentry->d_inode->i_lock.
The latter 2 functions also need to acquire dentry->d_parent->d_lock.
This cannot be done directly with spin_lock() operations because it
is the reverse of the regular lock order. To avoid ABBA deadlocks it
is done using trylock loops.

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

John Ogness (6):
  fs/dcache: Remove stale comment from dentry_kill()
  fs/dcache: Move dentry_kill() below lock_parent()
  fs/dcache: Avoid the try_lock loop in d_delete()
  fs/dcache: Avoid the try_lock loops in dentry_kill()
  fs/dcache: Avoid a try_lock loop in shrink_dentry_list()
  fs/dcache: Avoid remaining try_lock loop in shrink_dentry_list()

 fs/dcache.c | 273 ++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 183 insertions(+), 90 deletions(-)

-- 
2.11.0
