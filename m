Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448CDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C1E208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=python.org header.i=@python.org header.b="wgEkZVHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C1E208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=python.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbeH1HvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 03:51:03 -0400
Received: from mail.python.org ([188.166.95.178]:56400 "EHLO mail.python.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbeH1HvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 03:51:03 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2018 03:51:01 EDT
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com [66.111.4.227])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.python.org (Postfix) with ESMTPSA id 41zvxt0xDbzFqSX;
        Mon, 27 Aug 2018 23:53:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
        t=1535428434; bh=6D0I9mjGke1nkimANtjcm9V0W0RFoHHX5ljJBKi+LG0=;
        h=From:To:Cc:Subject:Date:From;
        b=wgEkZVHIJzatGyIMvOY5LA42EYjWq+LV6Md9LolVJLWqLZ/5k7J5K1mFbLdrcbOcN
         YknaMfpuRBl4s9sxOMpvJLJPIu8NoIsiIwfhkMbZAT+cSr7VRj5WR9Kj3xXa0/BVE/
         rKRugjlcfdnljIY0L3oO3dfycjVuqmAujYUtHzYk=
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 636D621B01;
        Mon, 27 Aug 2018 23:53:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Aug 2018 23:53:52 -0400
X-ME-Proxy: <xmx:TseEW5kVryxQadDA3-FM2s7LWrB6PoXZQoD1I3xhOjejixsmiJc7cA>
    <xmx:TseEW9QCwzMT2URrWDWZx53NEEivjtYT61oqqxIk09vdtpWmZOWEtA>
    <xmx:TseEWwEc8JWbjVk15mxMKfvvpGgEpvu9oF11W_Z6QXJ2fTACuqoKSQ>
    <xmx:TseEW6GhxqUFIRoN1IMkQCz3kBZIVw6m5lDKbDqidR5ix2qZW4GT7g>
    <xmx:TseEW2SWZTi0digs-TXOznQ_LNNwYxgarim2a0jeJ08j6Rqeh9H9hw>
    <xmx:UMeEWx5LYe13OGONBKSPB4nqJTUPJfjIXCUk4LlqbYOfwrFYcUUrmA>
X-ME-Sender: <xms:TseEW8qVpA2J11vAj4MmLT8RpZNo4tTZ8iJTHae0JJgM0YVNQGS46Q>
Received: from germain.hsd1.ca.comcast.net (236.sub-174-214-0.myvzw.com [174.214.0.236])
        by mail.messagingengine.com (Postfix) with ESMTPA id A9078E4014;
        Mon, 27 Aug 2018 23:53:48 -0400 (EDT)
From:   Benjamin Peterson <benjamin@python.org>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf trace beautify: Beautify flags of mount(2) and umount(2).
Date:   Mon, 27 Aug 2018 20:53:44 -0700
Message-Id: <20180828035344.31500-1-benjamin@python.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example output of perf trace -e mount,umount2:

  6243.930 ( 0.052 ms): mount/30976 mount(dev_name: 0x55dc541bb920, dir_name: 0x55dc541bc960, type: 0x55dc541b9c40, flags: BIND) = 0
  7851.821 (26.015 ms): umount/30983 umount2(name: 0x558daa82cf50, flags: MNT_FORCE                        ) = 0

Signed-off-by: Benjamin Peterson <benjamin@python.org>
---
 tools/perf/builtin-trace.c            |  5 ++
 tools/perf/trace/beauty/mount_flags.c | 79 +++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 tools/perf/trace/beauty/mount_flags.c

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 22ab8e67c760..3cffb25d1928 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -603,6 +603,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #include "trace/beauty/futex_val3.c"
 #include "trace/beauty/mmap.c"
 #include "trace/beauty/mode_t.c"
+#include "trace/beauty/mount_flags.c"
 #include "trace/beauty/msg_flags.c"
 #include "trace/beauty/open_flags.c"
 #include "trace/beauty/perf_event_open.c"
@@ -722,6 +723,8 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* addr */ },
 		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
 		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
+	{ .name     = "mount",
+	  .arg = { [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "mprotect",
 	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
 		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
@@ -830,6 +833,8 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "tkill",
 	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
+	{ .name     = "umount2", .alias = "umount",
+	  .arg = { [1] = { .scnprintf = SCA_UMOUNT_FLAGS, /* flags */ }, }, },
 	{ .name	    = "uname", .alias = "newuname", },
 	{ .name	    = "unlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
diff --git a/tools/perf/trace/beauty/mount_flags.c b/tools/perf/trace/beauty/mount_flags.c
new file mode 100644
index 000000000000..86790b82c869
--- /dev/null
+++ b/tools/perf/trace/beauty/mount_flags.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/mount.h>
+
+static size_t syscall_arg__scnprintf_mount_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	size_t printed = 0;
+	int flags = arg->val;
+
+	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
+		flags &= ~MS_MGC_MSK;
+
+#define	P_FLAG(n) \
+	if (flags & MS_##n) { \
+		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", #n); \
+		flags &= ~MS_##n; \
+	}
+
+	P_FLAG(RDONLY);
+	P_FLAG(NOSUID);
+	P_FLAG(NODEV);
+	P_FLAG(NOEXEC);
+	P_FLAG(SYNCHRONOUS);
+	P_FLAG(REMOUNT);
+	P_FLAG(MANDLOCK);
+	P_FLAG(DIRSYNC);
+	P_FLAG(NOATIME);
+	P_FLAG(NODIRATIME);
+	P_FLAG(BIND);
+	P_FLAG(MOVE);
+	P_FLAG(REC);
+	P_FLAG(SILENT);
+	P_FLAG(POSIXACL);
+	P_FLAG(UNBINDABLE);
+	P_FLAG(PRIVATE);
+	P_FLAG(SLAVE);
+	P_FLAG(SHARED);
+	P_FLAG(RELATIME);
+	P_FLAG(KERNMOUNT);
+	P_FLAG(I_VERSION);
+	P_FLAG(STRICTATIME);
+	P_FLAG(LAZYTIME);
+	P_FLAG(ACTIVE);
+	P_FLAG(NOUSER);
+
+#undef P_FLAG
+
+	if (flags)
+		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
+
+	return printed;
+}
+
+#define SCA_MOUNT_FLAGS syscall_arg__scnprintf_mount_flags
+
+static size_t syscall_arg__scnprintf_umount_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	size_t printed = 0;
+	int flags = arg->val;
+
+#define	P_FLAG(n) \
+	if (flags & n) { \
+		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", #n); \
+		flags &= ~n; \
+	}
+
+	P_FLAG(MNT_FORCE);
+	P_FLAG(MNT_DETACH);
+	P_FLAG(MNT_EXPIRE);
+	P_FLAG(UMOUNT_NOFOLLOW);
+
+#undef P_FLAG
+
+	if (flags)
+		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
+
+	return printed;
+}
+
+#define SCA_UMOUNT_FLAGS syscall_arg__scnprintf_umount_flags
-- 
2.17.1

