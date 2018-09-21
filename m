Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E688C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D465121550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D465121550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390772AbeIUWUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:20:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390076AbeIUWUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:20:23 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2822C4E4E6;
        Fri, 21 Sep 2018 16:30:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-123-84.rdu2.redhat.com [10.10.123.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47818308BE75;
        Fri, 21 Sep 2018 16:30:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/34] vfs: Suppress MS_* flag defs within the kernel unless
 explicitly enabled [ver #12]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Date:   Fri, 21 Sep 2018 17:30:42 +0100
Message-ID: <153754744256.17872.10913452428919009143.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 21 Sep 2018 16:30:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the mount namespace code that implements mount(2) should be using the
MS_* flags.  Suppress them inside the kernel unless uapi/linux/mount.h is
included.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/arc/kernel/setup.c       |    1 +
 arch/arm/kernel/atags_parse.c |    1 +
 arch/sh/kernel/setup.c        |    1 +
 arch/sparc/kernel/setup_32.c  |    1 +
 arch/sparc/kernel/setup_64.c  |    1 +
 arch/x86/kernel/setup.c       |    1 +
 drivers/base/devtmpfs.c       |    1 +
 fs/f2fs/super.c               |    2 +
 fs/pnode.c                    |    1 +
 fs/super.c                    |    1 +
 include/uapi/linux/fs.h       |   56 ++++-------------------------------------
 include/uapi/linux/mount.h    |   54 ++++++++++++++++++++++++++++++++++++++++
 init/do_mounts.c              |    1 +
 init/do_mounts_initrd.c       |    1 +
 security/apparmor/lsm.c       |    1 +
 security/apparmor/mount.c     |    1 +
 security/selinux/hooks.c      |    1 +
 security/tomoyo/mount.c       |    1 +
 18 files changed, 75 insertions(+), 52 deletions(-)

diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
index b2cae79a25d7..714dc5c2baf1 100644
--- a/arch/arc/kernel/setup.c
+++ b/arch/arc/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <linux/of_fdt.h>
 #include <linux/of.h>
 #include <linux/cache.h>
+#include <uapi/linux/mount.h>
 #include <asm/sections.h>
 #include <asm/arcregs.h>
 #include <asm/tlb.h>
diff --git a/arch/arm/kernel/atags_parse.c b/arch/arm/kernel/atags_parse.c
index c10a3e8ee998..a8a4333929f5 100644
--- a/arch/arm/kernel/atags_parse.c
+++ b/arch/arm/kernel/atags_parse.c
@@ -24,6 +24,7 @@
 #include <linux/root_dev.h>
 #include <linux/screen_info.h>
 #include <linux/memblock.h>
+#include <uapi/linux/mount.h>
 
 #include <asm/setup.h>
 #include <asm/system_info.h>
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index c286cf5da6e7..2c0e0f37a318 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -32,6 +32,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/uaccess.h>
+#include <uapi/linux/mount.h>
 #include <asm/io.h>
 #include <asm/page.h>
 #include <asm/elf.h>
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 13664c377196..7df3d704284c 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -34,6 +34,7 @@
 #include <linux/kdebug.h>
 #include <linux/export.h>
 #include <linux/start_kernel.h>
+#include <uapi/linux/mount.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 7944b3ca216a..206bf81eedaf 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/start_kernel.h>
 #include <linux/bootmem.h>
+#include <uapi/linux/mount.h>
 
 #include <asm/io.h>
 #include <asm/processor.h>
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b4866badb235..e493202bf265 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -51,6 +51,7 @@
 #include <linux/kvm_para.h>
 #include <linux/dma-contiguous.h>
 #include <xen/xen.h>
+#include <uapi/linux/mount.h>
 
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 9c0126ad7de1..1b87a1e03b45 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -25,6 +25,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/kthread.h>
+#include <uapi/linux/mount.h>
 #include "base.h"
 
 static struct task_struct *thread;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 2b110139420c..89970dd81b0e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1486,7 +1486,7 @@ static int f2fs_remount(struct super_block *sb, int *flags,
 		err = dquot_suspend(sb, -1);
 		if (err < 0)
 			goto restore_opts;
-	} else if (f2fs_readonly(sb) && !(*flags & MS_RDONLY)) {
+	} else if (f2fs_readonly(sb) && !(*flags & SB_RDONLY)) {
 		/* dquot_resume needs RW */
 		sb->s_flags &= ~SB_RDONLY;
 		if (sb_any_quota_suspended(sb)) {
diff --git a/fs/pnode.c b/fs/pnode.c
index 53d411a371ce..1100e810d855 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -10,6 +10,7 @@
 #include <linux/mount.h>
 #include <linux/fs.h>
 #include <linux/nsproxy.h>
+#include <uapi/linux/mount.h>
 #include "internal.h"
 #include "pnode.h"
 
diff --git a/fs/super.c b/fs/super.c
index 3941f19828b4..67f88c055967 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -35,6 +35,7 @@
 #include <linux/fsnotify.h>
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
+#include <uapi/linux/mount.h>
 #include "internal.h"
 
 static int thaw_super_locked(struct super_block *sb);
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 73e01918f996..1c982eb44ff4 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -14,6 +14,11 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
+#if !defined(__KERNEL__)
+#include <linux/mount.h>
+#endif
+
 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
  * the file limit at runtime and only root can increase the per-process
@@ -101,57 +106,6 @@ struct inodes_stat_t {
 
 #define NR_FILE  8192	/* this can well be larger on a larger system */
 
-
-/*
- * These are the fs-independent mount-flags: up to 32 flags are supported
- */
-#define MS_RDONLY	 1	/* Mount read-only */
-#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
-#define MS_NODEV	 4	/* Disallow access to device special files */
-#define MS_NOEXEC	 8	/* Disallow program execution */
-#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
-#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
-#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
-#define MS_NOATIME	1024	/* Do not update access times. */
-#define MS_NODIRATIME	2048	/* Do not update directory access times */
-#define MS_BIND		4096
-#define MS_MOVE		8192
-#define MS_REC		16384
-#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
-				   MS_VERBOSE is deprecated. */
-#define MS_SILENT	32768
-#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
-#define MS_PRIVATE	(1<<18)	/* change to private */
-#define MS_SLAVE	(1<<19)	/* change to slave */
-#define MS_SHARED	(1<<20)	/* change to shared */
-#define MS_RELATIME	(1<<21)	/* Update atime relative to mtime/ctime. */
-#define MS_KERNMOUNT	(1<<22) /* this is a kern_mount call */
-#define MS_I_VERSION	(1<<23) /* Update inode I_version field */
-#define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
-#define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-
-/* These sb flags are internal to the kernel */
-#define MS_SUBMOUNT     (1<<26)
-#define MS_NOREMOTELOCK	(1<<27)
-#define MS_NOSEC	(1<<28)
-#define MS_BORN		(1<<29)
-#define MS_ACTIVE	(1<<30)
-#define MS_NOUSER	(1<<31)
-
-/*
- * Superblock flags that can be altered by MS_REMOUNT
- */
-#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_I_VERSION|\
-			 MS_LAZYTIME)
-
-/*
- * Old magic mount flag and mask
- */
-#define MS_MGC_VAL 0xC0ED0000
-#define MS_MGC_MSK 0xffff0000
-
 /*
  * Structure for FS_IOC_FSGETXATTR[A] and FS_IOC_FSSETXATTR.
  */
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 89adf0d731ab..3634e065836c 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -1,6 +1,60 @@
 #ifndef _UAPI_LINUX_MOUNT_H
 #define _UAPI_LINUX_MOUNT_H
 
+/*
+ * These are the fs-independent mount-flags: up to 32 flags are supported
+ *
+ * Usage of these is restricted within the kernel to core mount(2) code and
+ * callers of sys_mount() only.  Filesystems should be using the SB_*
+ * equivalent instead.
+ */
+#define MS_RDONLY	 1	/* Mount read-only */
+#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
+#define MS_NODEV	 4	/* Disallow access to device special files */
+#define MS_NOEXEC	 8	/* Disallow program execution */
+#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
+#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
+#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
+#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define MS_NOATIME	1024	/* Do not update access times. */
+#define MS_NODIRATIME	2048	/* Do not update directory access times */
+#define MS_BIND		4096
+#define MS_MOVE		8192
+#define MS_REC		16384
+#define MS_VERBOSE	32768	/* War is peace. Verbosity is silence.
+				   MS_VERBOSE is deprecated. */
+#define MS_SILENT	32768
+#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define MS_UNBINDABLE	(1<<17)	/* change to unbindable */
+#define MS_PRIVATE	(1<<18)	/* change to private */
+#define MS_SLAVE	(1<<19)	/* change to slave */
+#define MS_SHARED	(1<<20)	/* change to shared */
+#define MS_RELATIME	(1<<21)	/* Update atime relative to mtime/ctime. */
+#define MS_KERNMOUNT	(1<<22) /* this is a kern_mount call */
+#define MS_I_VERSION	(1<<23) /* Update inode I_version field */
+#define MS_STRICTATIME	(1<<24) /* Always perform atime updates */
+#define MS_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
+
+/* These sb flags are internal to the kernel */
+#define MS_SUBMOUNT     (1<<26)
+#define MS_NOREMOTELOCK	(1<<27)
+#define MS_NOSEC	(1<<28)
+#define MS_BORN		(1<<29)
+#define MS_ACTIVE	(1<<30)
+#define MS_NOUSER	(1<<31)
+
+/*
+ * Superblock flags that can be altered by MS_REMOUNT
+ */
+#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_I_VERSION|\
+			 MS_LAZYTIME)
+
+/*
+ * Old magic mount flag and mask
+ */
+#define MS_MGC_VAL 0xC0ED0000
+#define MS_MGC_MSK 0xffff0000
+
 /*
  * open_tree() flags.
  */
diff --git a/init/do_mounts.c b/init/do_mounts.c
index d512dd615682..d95435fd37b5 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -22,6 +22,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
+#include <uapi/linux/mount.h>
 
 #include "do_mounts.h"
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d1a5d885ce13..56a557403d39 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -8,6 +8,7 @@
 #include <linux/sched.h>
 #include <linux/freezer.h>
 #include <linux/kmod.h>
+#include <uapi/linux/mount.h>
 
 #include "do_mounts.h"
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index a7bb2f5377f7..3d98ace5b898 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -24,6 +24,7 @@
 #include <linux/audit.h>
 #include <linux/user_namespace.h>
 #include <net/sock.h>
+#include <uapi/linux/mount.h>
 
 #include "include/apparmor.h"
 #include "include/apparmorfs.h"
diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index c1da22482bfb..8c3787399356 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <uapi/linux/mount.h>
 
 #include "include/apparmor.h"
 #include "include/audit.h"
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 48704d5a15af..9102a8fecb15 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -88,6 +88,7 @@
 #include <linux/msg.h>
 #include <linux/shm.h>
 #include <linux/bpf.h>
+#include <uapi/linux/mount.h>
 
 #include "avc.h"
 #include "objsec.h"
diff --git a/security/tomoyo/mount.c b/security/tomoyo/mount.c
index 807fd91dbb54..7dc7f59b7dde 100644
--- a/security/tomoyo/mount.c
+++ b/security/tomoyo/mount.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/slab.h>
+#include <uapi/linux/mount.h>
 #include "common.h"
 
 /* String table for special mount operations. */

