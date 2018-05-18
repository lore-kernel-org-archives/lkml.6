Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeERHtu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:49:50 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40878 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbeERHtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:49:47 -0400
X-Google-Smtp-Source: AB8JxZp9DMnGsSeThwGXMQ6V2n4pulrZompt9s1bI1y5sNK2Ndmayej/0lF/VYlqijke5R1GRCVJXw==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>, darrick.wong@oracle.com,
        tytso@mit.edu, linux-btrfs@vger.kernel.org, clm@fb.com, jbacik@fb.com,
        viro@zeniv.linux.org.uk, willy@infradead.org, peterz@infradead.org
Subject: [PATCH 00/10] RFC: assorted bcachefs patches
Date: Fri, 18 May 2018 03:48:58 -0400
Message-Id: <20180518074918.13816-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are all the remaining patches in my bcachefs tree that touch stuff outside
fs/bcachefs. Not all of them are suitable for inclusion as is, I wanted to get
some discussion first.

 * pagecache add lock

This is the only one that touches existing code in nontrivial ways.  The problem
it's solving is that there is no existing general mechanism for shooting down
pages in the page and keeping them removed, which is a real problem if you're
doing anything that modifies file data and isn't buffered writes.

Historically, the only problematic case has been direct IO, and people have been
willing to say "well, if you mix buffered and direct IO you get what you
deserve", and that's probably not unreasonable. But now we have fallocate insert
range and collapse range, and those are broken in ways I frankly don't want to
think about if they can't ensure consistency with the page cache.

Also, the mechanism truncate uses (i_size and sacrificing a goat) has
historically been rather fragile, IMO it might be a good think if we switched it
to a more general rigorous mechanism.

I need this solved for bcachefs because without this mechanism, the page cache
inconsistencies lead to various assertions popping (primarily when we didn't
think we need to get a disk reservation going by page cache state, but then do
the actual write and disk space accounting says oops, we did need one). And
having to reason about what can happen without a locking mechanism for this is
not something I care to spend brain cycles on.

That said, my patch is kind of ugly, and it requires filesystem changes for
other filesystems to take advantage of it. And unfortunately, since one of the
code paths that needs locking is readahead, I don't see any realistic way of
implementing the locking within just bcachefs code.

So I'm hoping someone has an idea for something cleaner (I think I recall
Matthew Wilcox saying he had an idea for how to use xarray to solve this), but
if not I'll polish up my pagecache add lock patch and see what I can do to make
it less ugly, and hopefully other people find it palatable or at least useful.

 * lglocks

They were removed by Peter Zijlstra when the last in kernel user was removed,
but I've found them useful. His commit message seems to imply he doesn't think
people should be using them, but I'm not sure why. They are a bit niche though,
I can move them to fs/bcachefs if people would prefer. 

 * Generic radix trees

This is a very simple radix tree implementation that can store types of
arbitrary size, not just pointers/unsigned long. It could probably replace
flex arrays.

 * Dynamic fault injection

I've actually had this code sitting in my tree since forever... I know we have
an existing fault injection framework, but I think this one is quite a bit nicer
to actually use.

It works very much like the dynamic debug infrastructure - for those who aren't
familiar, dynamic debug makes it so you can list and individually enable/disable
every pr_debug() callsite in debugfs.

So to add a fault injection site with this, you just stick a call to
dynamic_fault("foobar") somewhere in your code - dynamic_fault() returns true if
you should fail whatever it is you're testing. And then it'll show up in
debugfs, where you can enable/disable faults by file/linenumber, module, name,
etc.

The patch then also adds macros that wrap all the various memory allocation
functions and fail if dynamic_fault("memory") returns true - which means you can
see in debugfs every place you're allocating memory and fail all of them or just
individually (I have tests that iterate over all the faults and flip them on one
by one). I also use it in bcachefs to add fault injection points for uncommon
error paths in the filesystem startup/recovery path, and for various hard to
test slowpaths that only happen if we race in weird ways (race_fault()).

Kent Overstreet (10):
  mm: pagecache add lock
  mm: export find_get_pages()
  locking: bring back lglocks
  locking: export osq_lock()/osq_unlock()
  don't use spin_lock_irqsave() unnecessarily
  Generic radix trees
  bcache: optimize continue_at_nobarrier()
  bcache: move closures to lib/
  closures: closure_wait_event()
  Dynamic fault injection

 drivers/md/bcache/Kconfig                     |  10 +-
 drivers/md/bcache/Makefile                    |   6 +-
 drivers/md/bcache/bcache.h                    |   2 +-
 drivers/md/bcache/super.c                     |   1 -
 drivers/md/bcache/util.h                      |   3 +-
 fs/inode.c                                    |   1 +
 include/asm-generic/vmlinux.lds.h             |   4 +
 .../md/bcache => include/linux}/closure.h     |  50 +-
 include/linux/dynamic_fault.h                 | 117 +++
 include/linux/fs.h                            |  23 +
 include/linux/generic-radix-tree.h            | 131 +++
 include/linux/lglock.h                        |  97 +++
 include/linux/sched.h                         |   4 +
 init/init_task.c                              |   1 +
 kernel/locking/Makefile                       |   1 +
 kernel/locking/lglock.c                       | 105 +++
 kernel/locking/osq_lock.c                     |   2 +
 lib/Kconfig                                   |   3 +
 lib/Kconfig.debug                             |  14 +
 lib/Makefile                                  |   7 +-
 {drivers/md/bcache => lib}/closure.c          |  17 +-
 lib/dynamic_fault.c                           | 760 ++++++++++++++++++
 lib/generic-radix-tree.c                      | 167 ++++
 mm/filemap.c                                  |  92 ++-
 mm/page-writeback.c                           |   5 +-
 25 files changed, 1577 insertions(+), 46 deletions(-)
 rename {drivers/md/bcache => include/linux}/closure.h (92%)
 create mode 100644 include/linux/dynamic_fault.h
 create mode 100644 include/linux/generic-radix-tree.h
 create mode 100644 include/linux/lglock.h
 create mode 100644 kernel/locking/lglock.c
 rename {drivers/md/bcache => lib}/closure.c (95%)
 create mode 100644 lib/dynamic_fault.c
 create mode 100644 lib/generic-radix-tree.c

-- 
2.17.0
