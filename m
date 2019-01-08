Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA725C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA730218A1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977611;
	bh=XG7xZ9lhDDd+gCY8DO7nDOccPvQMmC3oOnJvRhJ53rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DCZ+O20KWuIET5Pm1dzz1Ozj6gvovcXU8H0/y3mOzI1GmuUf/K1+4HuNBA3ORHY3y
	 xfwHinmLejucGBFwJYk1R7B9PEZkpQVgr8r2r74wXjnC5Chek9CrmVZqXyW9xh5JWF
	 mLdkJmGJwpkiAAu/Kb7u1dgAsTamYDMyC8bk3TJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbfAHUAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:00:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733052AbfAHUAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:00:07 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A512120883;
        Tue,  8 Jan 2019 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977606;
        bh=XG7xZ9lhDDd+gCY8DO7nDOccPvQMmC3oOnJvRhJ53rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h529ORsNr0ARU7r/8PZZuARUB+TZUAJz9eWeTD9Eb4XoIPwl3xquqR+GbxgPH8iSJ
         j2HOFzqyg0yUVeNt96ObYKXBF46vFMm+/sGJE+MFLz/vTTknDZFgVTgPC7ahQQLTnR
         /9KdzvNZLNDHMycrBIL2UMj4kYkQ8sy/OINywN2I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Howells <dhowells@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 13/16] tools include uapi: Grab a copy of linux/mount.h
Date:   Tue,  8 Jan 2019 16:59:07 -0300
Message-Id: <20190108195910.17726-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were using a copy of uapi/linux/fs.h to create the mount syscall
'flags' string table to use in 'perf trace', to convert from the number
obtained via the raw_syscalls:sys_enter into a string, using
tools/perf/trace/beauty/mount_flags.sh, but in e262e32d6bde ("vfs:
Suppress MS_* flag defs within the kernel unless explicitly enabled")
those defines got moved to linux/mount.h, so grab a copy of mount.h too.

Keep the uapi/linux/fs.h as we'll use it for the SEEK_ constants.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-i2ricmpwpdrpukfq3298jr1z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/mount.h | 58 ++++++++++++++++++++++++++++++++
 tools/perf/check-headers.sh      |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 tools/include/uapi/linux/mount.h

diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
new file mode 100644
index 000000000000..3f9ec42510b0
--- /dev/null
+++ b/tools/include/uapi/linux/mount.h
@@ -0,0 +1,58 @@
+#ifndef _UAPI_LINUX_MOUNT_H
+#define _UAPI_LINUX_MOUNT_H
+
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
+#endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 6cb98f8570a2..b51e952ab35f 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -10,6 +10,7 @@ include/uapi/linux/fs.h
 include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
+include/uapi/linux/mount.h
 include/uapi/linux/perf_event.h
 include/uapi/linux/prctl.h
 include/uapi/linux/sched.h
-- 
2.20.1

