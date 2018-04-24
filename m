Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932798AbeDXCVW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:21:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:36662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932705AbeDXCVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:21:15 -0400
From: jeffm@suse.com
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Mahoney <jeffm@suse.com>
Subject: [RFC] [PATCH 0/5] procfs: reduce duplication by using symlinks
Date: Mon, 23 Apr 2018 22:21:01 -0400
Message-Id: <20180424022106.16952-1-jeffm@suse.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

Hi all -

I recently encountered a customer issue where, on a machine with many TiB
of memory and a few hundred cores, after a task with a few thousand threads
and hundreds of files open exited, the system would softlockup.  That
issue was (is still) being addressed by Nik Borisov's patch to add a
cond_resched call to shrink_dentry_list.  The underlying issue is still
there, though.  We just don't complain as loudly.  When a huge task
exits, now the system is more or less unresponsive for about eight
minutes.  All CPUs are pinned and every one of them is going through
dentry and inode eviction for the procfs files associated with each
thread.  It's made worse by every CPU contending on the super's
inode list lock.

The numbers get big.  My test case was 4096 threads with 16384 files
open.  It's a contrived example, but not that far off from the actual
customer case.  In this case, a simple "find /proc" would create around
300 million dentry/inode pairs.  More practically, lsof(1) does it too,
it just takes longer.  On smaller systems, memory pressure starts pushing
them out. Memory pressure isn't really an issue on this machine, so we
end up using well over 100GB for proc files.  It's the combination of
the wasted CPU cycles in teardown and the wasted memory at runtime that
pushed me to take this approach.

The biggest culprit is the "fd" and "fdinfo" directories, but those are
made worse by there being multiple copies of them even for the same
task without threads getting involved:

- /proc/pid/fd and /proc/pid/task/pid/fd are identical but share no
  resources.

- Every /proc/pid/task/*/fd directory in a thread group has identical
  contents (unless unshare(CLONE_FILES) was called), but share no
  resources.

- If we do a lookup like /proc/pid/fd on a member of a thread group,
  we'll get a valid directory.  Inside, there will be a complete
  copy of /proc/pid/task/* just like in /proc/tgid/task.  Again,
  nothing is shared.

This patch set reduces some (most) of the duplication by conditionally
replacing some of the directories with symbolic links to copies that are
identical.

1) Eliminate the duplication of the task directories between threads.
   The task directory belongs to the thread leader and the threads
   link to it: e.g. /proc/915/task -> ../910/task  This mainly
   reduces duplication when individual threads are looked up directly
   at the tgid level.  The impact varies based on the number of threads.
   The user has to go out of their way in order to mess up their system
   in this way.  But if they were so inclined, they could create ~550
   billion inodes and dentries using the test case.

2) Eliminate the duplication of directories that are created identically
   between the tgid-level pid directory and its task directory: fd,
   fdinfo, ns, net, attr.  There is obviously more duplication between
   the two directories, but replacing a file with a symbolic link
   doesn't get us anything.  This reduces the number of files associated
   with fd and fdinfo by half if threads aren't involved.

3) Eliminate the duplication of fd and fdinfo directories among threads
   that share a files_struct.  We check at directory creation time if
   the task is a group leader and if not, whether it shares ->files with
   the group leader.  If so, we create a symbolic link to ../tgid/fd*.
   We use a d_revalidate callback to check whether the thread has called
   unshare(CLONE_FILES) and, if so, fail the revalidation for the symlink.
   Upon re-lookup, a directory will be created in its place.  This is
   pretty simple, so if the thread group leader calls unshare, all threads
   get directories.

With these patches applied, running the same testcase, the proc_inode
cache only gets to about 600k objects, which is about 99.7% fewer.  I
get that procfs isn't supposed to be scalable, but this is kind of
extreme. :)

Finally, I'm not a procfs expert.  I'm posting this as an RFC for folks
with more knowledge of the details to pick it apart.  The biggest is that
I'm not sure if any tools depend on any of these things being directories
instead of symlinks.  I'd hope not, but I don't have the answer.  I'm
sure there are corner cases I'm missing.  Hopefully, it's not just flat
out broken since this is a problem that does need solving.

Now I'll go put on the fireproof suit.

Thanks,

-Jeff

---

Jeff Mahoney (5):
  procfs: factor out a few helpers
  procfs: factor out inode revalidation work from pid_revalidation
  procfs: use symlinks for /proc/<pid>/task when not thread group leader
  procfs: share common directories between /proc/tgid and
    /proc/tgid/task/tgid
  procfs: share fd/fdinfo with thread group leader when files are shared

 fs/proc/base.c | 487 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 437 insertions(+), 50 deletions(-)

-- 
2.12.3
