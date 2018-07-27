Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33B8C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BB2208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BB2208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbeG0Syp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389096AbeG0Syp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FD8A40241CC;
        Fri, 27 Jul 2018 17:31:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79A0B1C5BD;
        Fri, 27 Jul 2018 17:31:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/38] vfs: Suppress MS_* flag defs within the kernel unless
 explicitly enabled [ver #10]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Jul 2018 18:31:50 +0100
Message-ID: <153271271000.9458.5038628202846881479.stgit@warthog.procyon.org.uk>
In-Reply-To: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:31:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 27 Jul 2018 17:31:51 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
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
index 2f86d883dd95..3413f53e0a35 100644
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
index 1c56a9f2598d..3dbf69209fe2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1454,7 +1454,7 @@ static int f2fs_remount(struct super_block *sb, int *flags,
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
index c9333d317b5f..c9d208b7999e 100644
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
index 7e26be00c444..d4fc2a5afdb6 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -32,6 +32,7 @@
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
+#include <uapi/linux/mount.h>
 
 #include "do_mounts.h"
 
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 5a91aefa7305..65de0412f80f 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -18,6 +18,7 @@
 #include <linux/sched.h>
 #include <linux/freezer.h>
 #include <linux/kmod.h>
+#include <uapi/linux/mount.h>
 
 #include "do_mounts.h"
 
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index bc3e209d2bd4..84e644ce3583 100644
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
index f5e5c8a087ae..ef0428311a5c 100644
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

