Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeCMABm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:01:42 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46954 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbeCMABl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:01:41 -0400
X-Google-Smtp-Source: AG47ELtWsZvIurZUrVP5JV4L0t6Pt6TdnfWfO14c3l1w8HEBzsBWR3vnGY9LSlY+A4J4XiQlqEeriw==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/3 v4] devpts: handle bind-mounts
Date: Tue, 13 Mar 2018 01:01:28 +0100
Message-Id: <20180313000131.28971-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This is the fourth iteration of this patch. Relevant changes are.
ChangeLog v3->v4:
* small logical simplifications
* add test that  bind-mounts of /dev/pts/ptmx to locations that do not
  resolve to a valid slave pty path under the originating devpts mount
  fail
ChangeLog v2->v3:
* rewritten commit message to thoroughly analyse the problem for
  posterity in Subject: [PATCH 2/3 v3] devpts: resolve devpts bind-mounts
  and in this cover letter.
* extended selftests to test for correct handling of /dev/pts/ptmx
  bind-mounts to /dev/ptmx and non-standard devpts mounts such as
  mount -t devpts devpts /mnt

Most libcs will still look at /dev/ptmx when opening the master fd of a pty
device. When /dev/ptmx is a bind-mount of /dev/pts/ptmx and the TIOCGPTPEER
ioctl() is used to safely retrieve a file descriptor for the slave side of
the pty based on the master fd, the /proc/self/fd/{0,1,2} symlinks will
point to /.

When the kernel tries to look up the root mount of the dentry for the slave
file descriptor it will detect that the dentry is escaping its bind-mount
since the root mount of the dentry is /dev/pts where the devpts is mounted
but the root mount of /dev/ptmx is /dev.

Having bind-mounts of /dev/pts/ptmx to /dev/ptmx not working correctly is a
regression. In addition, it is also a fairly common scenario in containers
employing user namespaces.

To handle bind-mounts of /dev/pts/ptmx to /dev/ptmx correctly we need to
walk up the bind-mounts for /dev/ptmx in devpts_mntget(). Since the
contents of /proc/<pid>/fd/<nr> symlinks attached to the slave side of a
file descriptor will always point to a path under the devpts mount we need
to try and ensure that the kernel doesn't falsely get the impression that a
pty slave file descriptor retrieved via TIOCGPTPEER based on a pty master
file descriptor opened via a bind-mount of the ptmx device escapes its
bind-mount. To clarify in pseudo code:

* bind-mount /dev/pts/ptmx to /dev/ptmx
* master = open("/dev/ptmx", O_RDWR | O_NOCTTY | O_CLOEXEC);
* slave = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY | O_CLOEXEC);

would cause the kernel to think that slave is escaping its bind-mount. The
reason is that while the devpts mounted at /dev/pts has devtmpfs mounted at
/dev as its parent mount:

21 -- -- / /dev
-- 21 -- / /dev/pts

they are on different devices

-- -- 0:6  / /dev
-- -- 0:20 / /dev/pts

which has the consequence that the pathname of the directory which forms
the root of the /dev/pts mount is /. So if we bind-mount /dev/pts/ptmx to
/dev/ptmx we will end up on the same device as the devtmpfs mount at
/dev/pts

-- -- 0:20 /ptmx /dev/ptmx

Without the bind-mount resolution patch here the kernel will now perform
the bind-mount escape check directly on /dev/ptmx. When it hits
devpts_ptmx_path()  calls pts_path() which in turn calls
path_parent_directory(). While one would expect that
path_parent_directory() *should* yield /dev it will yield / since
/dev and /dev/pts are on different devices. This will cause path_pts() to
fail finding a "pts" directory since there is none under /. Thus, the
kernel detects that /dev/ptmx is escaping its bind-mount and will set
/proc/<pid>/fd/<nr> to /.

This patch changes the logic to do bind-mount resolution and after the
bind-mount has been resolved (i.e. we have traced it back to the devpts
mount) we can safely perform devpts_ptmx_path() and check whether we find a
"pts" directory in the parent directory of the devpts mount. Since
path_parent_directory() will now correctly yield /dev as parent directory
for the devpts mount at /dev/pts.

However, we can only perform devpts_ptmx_path() devpts_mntget() if we
either did resolve a bind-mount or did not find a suitable devpts
filesystem. The reason is that we want and need to support non-standard
mountpoints for the devpts filesystem. If we call devpts_ptmx_path()
although we did already find a devpts filesystem and did not resolve
bind-mounts we will fail on devpts mounts such as:

mount -t devpts devpts /mnt

where no "pts" directory will be under /. So change the logic to account
for this.

Here's a little reproducer that presupposes a libc that uses TIOCGPTPEER in
its openpty() implementation:

unshare --mount
mount --bind /dev/pts/ptmx /dev/ptmx
chmod 666 /dev/ptmx
script
ls -al /proc/self/fd/0

with output:

lrwx------ 1 chb chb 64 Mar  7 16:41 /proc/self/fd/0 -> /

Christian Brauner (3):
  devpts: hoist out check for DEVPTS_SUPER_MAGIC
  devpts: resolve devpts bind-mounts
  selftests: add devpts selftests

 fs/devpts/inode.c                                |  33 ++-
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/filesystems/.gitignore   |   1 +
 tools/testing/selftests/filesystems/Makefile     |   2 +-
 tools/testing/selftests/filesystems/devpts_pts.c | 313 +++++++++++++++++++++++
 5 files changed, 338 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/devpts_pts.c

-- 
2.15.1
