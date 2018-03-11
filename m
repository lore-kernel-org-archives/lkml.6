Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932399AbeCKVFt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 17:05:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38991 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932344AbeCKVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 17:05:46 -0400
X-Google-Smtp-Source: AG47ELtzi2WGDt8eyjbbyvb0V9+Vwo1qNJ86TFNPkXwU4PRgLa8AT1XNmnV7V2DbkphbPmQmVOPohQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/3 v2] devpts: handle /dev/ptmx bind-mounts
Date: Sun, 11 Mar 2018 22:05:34 +0100
Message-Id: <20180311210537.3674-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey everyone,

This is the second iteration of this patch. Please note, that I added a
selftest for correct /proc/<pid>/fd/{0,1,2} symlinks and added it to
tools/testing/selftests/filesystem because the root cause of the problem is
located in the devpts filesystem. But I'm not sure if this is the right place.
It might also be argued that this should be under
tools/testing/selftests/drivers/pty.

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
walk up the bind-mounts for /dev/ptmx in devpts_mntget(). This also means
we need to remove the
"if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)" check from
devpts_mntget(). However, devpts_acquire() needs to perform that check.
The reason is that while the devpts mounted at /dev/pts has devtmpfs
mounted at /dev as its parent mount:

21 -- -- / /dev
-- 21 -- / /dev/pts

they are on different devices

-- -- 0:6  / /dev
-- -- 0:20 / /dev/pts

which has the consequence that the pathname of the directory which forms
the root of the /dev/pts mount is /. So if we bind-mount /dev/pts/ptmx to
/dev/ptmx we will end up on the same device as the devtmpfs mount on
/dev/pts

-- -- 0:20 /ptmx /dev/ptmx

but given that / is the pathname of the directory which forms the root of
the /dev/pts bind-mount, the resulting source will be /ptmx. So in
devpts_acquire() we still need to check if
"(path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)" and exit early before
we try to call path_pts(). If we call path_pts() in the bind-mount case we
will hit path_parent_directory() which will **not** yield /dev as parent
directory but rather / which will cause path_pts() to fail since it will
not find a "pts" directory underneath /. We should still perform the
path_pts() check in devpts_acquire() if we haven't found a suitable devpts
filesystem at open time but we should always try to exit early in
devpts_acquire() and defer resolving bind-mounts until devpts_mntget(). If
we fail in devpts_mntget() we will end up with a wrong
/proc/<pid>/fd/{0,1,2} symlink, if we fail in devpts_acquire() we will end
up with a failed open("/dev/ptmx") which is more troublesome.

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

 fs/devpts/inode.c                                |  32 ++--
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/filesystems/.gitignore   |   1 +
 tools/testing/selftests/filesystems/Makefile     |   3 +-
 tools/testing/selftests/filesystems/devpts_pts.c | 191 +++++++++++++++++++++++
 5 files changed, 217 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/devpts_pts.c

---
ChangeLog v1->v2:
* patch for non-functional changes added
* patch for tests added
ChangeLog v0->v1:
* remove
        /* Has the devpts filesystem already been found? */
        if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
	                return 0
  from devpts_ptmx_path()
* check superblock after devpts_ptmx_path() returned

-- 
2.15.1
