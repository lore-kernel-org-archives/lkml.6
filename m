Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC97C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA83E21764
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA83E21764
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbeHROcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:32:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56047 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:32:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBPJoR1285550
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:25:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBPJe11285547;
        Sat, 18 Aug 2018 04:25:19 -0700
Date:   Sat, 18 Aug 2018 04:25:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2po9jcqv1qgj0koxlg8kkg30@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        wangnan0@huawei.com, tglx@linutronix.de, namhyung@kernel.org,
        dsahern@gmail.com, hpa@zytor.com
Reply-To: hpa@zytor.com, namhyung@kernel.org, dsahern@gmail.com,
          tglx@linutronix.de, wangnan0@huawei.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Add 'syscall_enter' probe helper for
 syscall enter tracepoints
Git-Commit-ID: dda9ac966d39cec5a501b0b4d0210b3c2a167e6c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dda9ac966d39cec5a501b0b4d0210b3c2a167e6c
Gitweb:     https://git.kernel.org/tip/dda9ac966d39cec5a501b0b4d0210b3c2a167e6c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 3 Aug 2018 16:28:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:44 -0300

perf bpf: Add 'syscall_enter' probe helper for syscall enter tracepoints

Allowing one to hook into the syscalls:sys_enter_NAME tracepoints,
an example is provided that hooks into the 'openat' syscall.

Using it with the probe:vfs_getname probe into getname_flags to get the
filename args as it is copied from userspace:

  # perf probe -l
  probe:vfs_getname    (on getname_flags:73@acme/git/linux/fs/namei.c with pathname)
  # perf trace -e probe:*getname,tools/perf/examples/bpf/sys_enter_openat.c cat /etc/passwd > /dev/null
     0.000 probe:vfs_getname:(ffffffffbd2a8983) pathname="/etc/ld.so.preload"
     0.022 syscalls:sys_enter_openat:dfd: CWD, filename: 0xafbe8da8, flags: CLOEXEC
     0.027 probe:vfs_getname:(ffffffffbd2a8983) pathname="/etc/ld.so.cache"
     0.054 syscalls:sys_enter_openat:dfd: CWD, filename: 0xafdf0ce0, flags: CLOEXEC
     0.057 probe:vfs_getname:(ffffffffbd2a8983) pathname="/lib64/libc.so.6"
     0.316 probe:vfs_getname:(ffffffffbd2a8983) pathname="/usr/lib/locale/locale-archive"
     0.375 syscalls:sys_enter_openat:dfd: CWD, filename: 0xe2b2b0b4
     0.379 probe:vfs_getname:(ffffffffbd2a8983) pathname="/etc/passwd"
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-2po9jcqv1qgj0koxlg8kkg30@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/sys_enter_openat.c | 33 ++++++++++++++++++++++++++++++
 tools/perf/include/bpf/bpf.h               |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/tools/perf/examples/bpf/sys_enter_openat.c b/tools/perf/examples/bpf/sys_enter_openat.c
new file mode 100644
index 000000000000..9cd124b09392
--- /dev/null
+++ b/tools/perf/examples/bpf/sys_enter_openat.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hook into 'openat' syscall entry tracepoint
+ *
+ * Test it with:
+ *
+ * perf trace -e tools/perf/examples/bpf/sys_enter_openat.c cat /etc/passwd > /dev/null
+ *
+ * It'll catch some openat syscalls related to the dynamic linked and
+ * the last one should be the one for '/etc/passwd'.
+ *
+ * The syscall_enter_openat_args can be used to get the syscall fields
+ * and use them for filtering calls, i.e. use in expressions for
+ * the return value.
+ */
+
+#include <bpf.h>
+
+struct syscall_enter_openat_args {
+	unsigned long long unused;
+	long		   syscall_nr;
+	long		   dfd;
+	char		   *filename_ptr;
+	long		   flags;
+	long		   mode;
+};
+
+int syscall_enter(openat)(struct syscall_enter_openat_args *args)
+{
+	return 1;
+}
+
+license(GPL);
diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index a63aa6241b7f..2873cdde293f 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -9,6 +9,9 @@
 #define probe(function, vars) \
 	SEC(#function "=" #function " " #vars) function
 
+#define syscall_enter(name) \
+	SEC("syscalls:sys_enter_" #name) syscall_enter_ ## name
+
 #define license(name) \
 char _license[] SEC("license") = #name; \
 int _version SEC("version") = LINUX_VERSION_CODE;
