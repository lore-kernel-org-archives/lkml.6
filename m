Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752101AbeBZCrI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:47:08 -0500
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:12867 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752048AbeBZCrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:47:05 -0500
Date: Mon, 26 Feb 2018 13:47:01 +1100
From: Dave Chinner <david@fromorbit.com>
To: Waiman Long <longman@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <andi@firstfloor.org>, Dave Chinner <dchinner@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v8 0/6] vfs: Use dlock list for SB's s_inodes list
Message-ID: <20180226024701.GO7000@dastard>
References: <1509475860-16139-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509475860-16139-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

What's happened to this patchset? Any plans to repost a more recent
version?

FYI, I just ran a workload that hit 60% CPU usage on sb inode list
lock contention - a multithreaded bulkstat scan of an XFS filesystem
with millions of inodes on SSDs. last time I ran this (about 18
months ago now!) I saw rates of about 600,000 inodes/s being scanned
from userspace. The run I did earlier today made 300,000 inodes/s on
the same 16p machine and was completely CPU bound....

Cheers,

Dave.

On Tue, Oct 31, 2017 at 02:50:54PM -0400, Waiman Long wrote:
> v7->v8:
>  - Integrate the additional patches 8, 9 and 10 sent to fix issues in
>    the original v7 patchset into patch 1 and adjust the other patches
>    accordingly.
> 
> v6->v7:
>  - Fix outdated email address.
>  - Add a comment to patch 4 to explain allocation issue & fix a
>    compilation problem with cpumask.
>  - Replace patch 6 with another one that adds an irqsafe mode argument 
>    in alloc_dlock_list_heads() instead of adding new APIs.
> 
> v5->v6:
>  - Rebased the patch to 4.14-rc3.
>  - Drop the fsnotify patch as it had been merged somehow.
>  - Add a new patch 5 with alternative way of selecting list by hashing
>    instead of cpu #.
>  - Add a new patch 6 to proivde a set irq safe APIs to be used in
>    interrupt context.
>  - Update the CPU to index mapping code.
> 
> v4->v5:
>  - Rebased the patch to 4.8-rc1 (changes to fs/fs-writeback.c was
>    dropped).
>  - Use kcalloc() instead of percpu_alloc() to allocate the dlock list
>    heads structure as suggested by Christoph Lameter.
>  - Replaced patch 5 by another one that made sibling CPUs use the same
>    dlock list head thus reducing the number of list heads that needed
>    to be maintained.
> 
> v3->v4:
>  - As suggested by Al, encapsulate the dlock list mechanism into
>    the dlist_for_each_entry() and dlist_for_each_entry_safe()
>    which are the equivalent of list_for_each_entry() and
>    list_for_each_entry_safe() for regular linked list. That simplifies
>    the changes in the call sites that perform dlock list iterations.
>  - Add a new patch to make the percpu head structure cacheline aligned
>    to prevent cacheline contention from disrupting the performance
>    of nearby percpu variables.
> 
> v2->v3:
>  - Remove the 2 persubnode API patches.
>  - Merge __percpu tag patch 2 into patch 1.
>  - As suggested by Tejun Heo, restructure the dlock_list_head data
>    structure to hide the __percpu tag and rename some of the functions
>    and structures.
>  - Move most of the code from dlock_list.h to dlock_list.c and export
>    the symbols.
> 
> v1->v2:
>  - Add a set of simple per-subnode APIs that is between percpu and
>    per-node in granularity.
>  - Make dlock list to use the per-subnode APIs so as to reduce the
>    total number of separate linked list that needs to be managed
>    and iterated.
>  - There is no change in patches 1-5.
> 
> This patchset provides new APIs for a set of distributed locked lists
> (one/CPU core) to minimize lock and cacheline contention. Insertion
> and deletion to the list will be cheap and relatively contention free.
> Lookup, on the other hand, may be a bit more costly as there are
> multiple lists to iterate. This is not really a problem for the
> replacement of superblock's inode list by dlock list included in
> the patchset as lookup isn't needed.
> 
> For use cases that need to do lookup, the dlock list can also be
> treated as a set of hashed lists that scales with the number of CPU
> cores in the system.
> 
> Both patches 5 and 6 are added to support other use cases like epoll
> nested callbacks, for example, which could use the dlock-list to
> reduce lock contention problem.
> 
> Patch 1 introduces the dlock list. The list heads are allocated
> by kcalloc() instead of percpu_alloc(). Each list head entry is
> cacheline aligned to minimize contention.
> 
> Patch 2 replaces the use of list_for_each_entry_safe() in
> evict_inodes() and invalidate_inodes() by list_for_each_entry().
> 
> Patch 3 modifies the superblock and inode structures to use the dlock
> list. The corresponding functions that reference those structures
> are modified.
> 
> Patch 4 makes the sibling CPUs use the same dlock list head to reduce
> the number of list heads that need to be iterated.
> 
> Patch 5 enables alternative use case of as a set of hashed lists.
> 
> Patch 6 provides an irq safe mode specified at dlock-list allocation
> time so that it can be used within interrupt context.
> 
> Jan Kara (1):
>   vfs: Remove unnecessary list_for_each_entry_safe() variants
> 
> Waiman Long (5):
>   lib/dlock-list: Distributed and lock-protected lists
>   vfs: Use dlock list for superblock's inode list
>   lib/dlock-list: Make sibling CPUs share the same linked list
>   lib/dlock-list: Enable faster lookup with hashing
>   lib/dlock-list: Add an IRQ-safe mode to be used in interrupt handler
> 
>  fs/block_dev.c             |   9 +-
>  fs/drop_caches.c           |   9 +-
>  fs/inode.c                 |  38 ++----
>  fs/notify/fsnotify.c       |   9 +-
>  fs/quota/dquot.c           |  14 +-
>  fs/super.c                 |   7 +-
>  include/linux/dlock-list.h | 263 +++++++++++++++++++++++++++++++++++
>  include/linux/fs.h         |   8 +-
>  lib/Makefile               |   2 +-
>  lib/dlock-list.c           | 333 +++++++++++++++++++++++++++++++++++++++++++++
>  10 files changed, 638 insertions(+), 54 deletions(-)
>  create mode 100644 include/linux/dlock-list.h
>  create mode 100644 lib/dlock-list.c
> 
> -- 
> 1.8.3.1
> 
> 

-- 
Dave Chinner
david@fromorbit.com
