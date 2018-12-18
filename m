Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C0FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F87D218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170942;
	bh=gcouTUlaYJTqTClXrnR/7wqRbLVPRu/y4WsldgyVEBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ASDqVtEO39svRe7hd+RHjHPQJfjS/+oxFvdbqyG+ebaQs5KkSeD+Qs54/VbHNG6sf
	 6hHOKEUEAz8VXw8MKtPrTB8bCb+sWVCjadLkpce8SZRDxJrmGj/z/hHzsn4opLBlg3
	 gEi2KbH803s4r9pMpA1ZnjVYH/6rTkh7IFQg++BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeLRWJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbeLRWJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:00 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FBF0218A2;
        Tue, 18 Dec 2018 22:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170938;
        bh=gcouTUlaYJTqTClXrnR/7wqRbLVPRu/y4WsldgyVEBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xrgyUnYjPVaMo+B+ALUfuAXJdlH+KX2YhDu2AXGkPfVbQ5095FiscR7yqIKYRZGH/
         I5GmkXjGZrHymug7qECNa4dFNH4atcKj+vMak/LD2zQfMJlMT40b8mAxvW9QvDgCU/
         aj3TtdSDvvbxiMOWFLg7AeYdWE0RzLcxUxfJjUT4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 11/63] perf trace: Beautify renameat2's flags argument
Date:   Tue, 18 Dec 2018 19:06:41 -0300
Message-Id: <20181218220733.15839-12-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  # strace -e renameat2 -f perf trace -e rename* mv c /tmp
  strace: Process 10824 attached
  [pid 10824] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp", RENAME_NOREPLACE) = -1 EXDEV (Invalid cross-device link)
  [pid 10824] renameat2(AT_FDCWD, "c", AT_FDCWD, "/tmp/c", RENAME_NOREPLACE) = -1 EEXIST (File exists)
       1.857 ( 0.008 ms): mv/10824 renameat2(olddfd: CWD, oldname: 0x7ffc72ff3d81, newdfd: CWD, newname: 0x7ffc72ff3d83, flags: NOREPLACE) = -1 EXDEV Invalid cross-device link
       2.002 ( 0.006 ms): mv/10824 renameat2(olddfd: CWD, oldname: 0x7ffc72ff3d81, newdfd: CWD, newname: 0x55ad609efcc0, flags: NOREPLACE) = -1 EEXIST File exists
  mv: 'c' and '/tmp/c' are the same file
  [pid 10824] +++ exited with 1 +++
  --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=10824, si_uid=0, si_status=1, si_utime=0, si_stime=0} ---
  +++ exited with 0 +++
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-glyt6nzlt1yx56m5bshy6g83@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c         |  3 ++-
 tools/perf/trace/beauty/Build      |  1 +
 tools/perf/trace/beauty/beauty.h   |  3 +++
 tools/perf/trace/beauty/renameat.c | 19 +++++++++++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/trace/beauty/renameat.c

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 60c61a89436f..4b3f8407f8d5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -801,7 +801,8 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "renameat2",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
-		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
+		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
+		   [4] = { .scnprintf = SCA_RENAMEAT2_FLAGS, /* flags */ }, }, },
 	{ .name	    = "rt_sigaction",
 	  .arg = { [0] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "rt_sigprocmask",
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 304313073242..10c85cd3eb4f 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -8,6 +8,7 @@ libperf-y += kcmp.o
 libperf-y += mount_flags.o
 libperf-y += pkey_alloc.o
 libperf-y += prctl.o
+libperf-y += renameat.o
 libperf-y += sockaddr.o
 libperf-y += socket.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 039c29039b2c..48ff3ce05325 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -144,6 +144,9 @@ size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_a
 size_t syscall_arg__scnprintf_prctl_arg3(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_ARG3 syscall_arg__scnprintf_prctl_arg3
 
+size_t syscall_arg__scnprintf_renameat2_flags(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_RENAMEAT2_FLAGS syscall_arg__scnprintf_renameat2_flags
+
 size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_SOCKADDR syscall_arg__scnprintf_sockaddr
 
diff --git a/tools/perf/trace/beauty/renameat.c b/tools/perf/trace/beauty/renameat.c
new file mode 100644
index 000000000000..02c7207faee6
--- /dev/null
+++ b/tools/perf/trace/beauty/renameat.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: LGPL-2.1
+// Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+
+#include "trace/beauty/beauty.h"
+#include <uapi/linux/fs.h>
+
+static size_t renameat2__scnprintf_flags(unsigned long flags, char *bf, size_t size)
+{
+#include "trace/beauty/generated/rename_flags_array.c"
+       static DEFINE_STRARRAY(rename_flags);
+
+       return strarray__scnprintf_flags(&strarray__rename_flags, bf, size, flags);
+}
+
+size_t syscall_arg__scnprintf_renameat2_flags(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long flags = arg->val;
+	return renameat2__scnprintf_flags(flags, bf, size);
+}
-- 
2.19.2

