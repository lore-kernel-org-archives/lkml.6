Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A11FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D244218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389175AbeLTS3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:29:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54871 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733143AbeLTS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:29:46 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKITWfD3686607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:29:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKITWOW3686602;
        Thu, 20 Dec 2018 10:29:32 -0800
Date:   Thu, 20 Dec 2018 10:29:32 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-73a9prs8ktkrt97trtdmdjs8@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, tglx@linutronix.de, lclaudio@redhat.com,
        namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com
Reply-To: namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com,
          lclaudio@redhat.com, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com, jolsa@kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Beautify arch_prctl()'s
 arguments
Git-Commit-ID: fb7068e73d2c24ba381938004ed0f285341ef1ba
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

Commit-ID:  fb7068e73d2c24ba381938004ed0f285341ef1ba
Gitweb:     https://git.kernel.org/tip/fb7068e73d2c24ba381938004ed0f285341ef1ba
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Dec 2018 11:05:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:19 -0300

perf trace beauty: Beautify arch_prctl()'s arguments

This actually so far, AFAIK is available only in x86, so the code was
put in place with x86 prefixes, in arches where it is not available it
will just not be called, so no further mechanisms are needed at this
time.

Later, when other arches wire this up, we'll just look at the uname
(live sessions) or perf_env data in the perf.data header to auto-wire
the right beautifier.

With this the output is the same as produced by 'strace' when used with
the following ~/.perfconfig:

  # cat ~/.perfconfig
  [llvm]
	dump-obj = true
  [trace]
	  add_events = /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
	  show_zeros = yes
	  show_duration = no
	  no_inherit = yes
	  show_timestamp = no
	  show_arg_names = no
	  args_alignment = -40
	  show_prefix = yes
  #

And, on fedora 29, since the string tables are generated from the kernel
sources, we don't know about 0x3001, just like strace:

  --- /tmp/strace 2018-12-17 11:22:08.707586721 -0300
  +++ /tmp/trace  2018-12-18 11:11:32.037512729 -0300
  @@ -1,49 +1,49 @@
  -arch_prctl(0x3001 /* ARCH_??? */, 0x7ffc8a92dc80) = -1 EINVAL (Invalid argument)
  +arch_prctl(0x3001 /* ARCH_??? */, 0x7ffe4eb93ae0) = -1 EINVAL (Invalid argument)
  -arch_prctl(ARCH_SET_FS, 0x7faf6700f540) = 0
  +arch_prctl(ARCH_SET_FS, 0x7fb507364540) = 0

And that seems to be related to the CET/Shadow Stack feature, that
userland in Fedora 29 (glibc 2.28) are querying the kernel about, that
0x3001 seems to be ARCH_CET_STATUS, I'll check the situation and test
with a fedora 29 kernel to see if the other codes are used.

A diff that ignores the different pointers for different runs needs to
be put in place in the upcoming regression tests comparing 'perf trace's
output to strace's.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-73a9prs8ktkrt97trtdmdjs8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c           |  5 ++++-
 tools/perf/trace/beauty/Build        |  1 +
 tools/perf/trace/beauty/arch_prctl.c | 33 +++++++++++++++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h     |  3 +++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6d9be952e3a7..2cc62ca75b2e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -664,6 +664,9 @@ static struct syscall_fmt {
 } syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
+	{ .name	    = "arch_prctl",
+	  .arg = { [0] = { .scnprintf = SCA_X86_ARCH_PRCTL_CODE, /* code */ },
+		   [1] = { .scnprintf = SCA_PTR, /* arg2 */ }, }, },
 	{ .name	    = "bind",
 	  .arg = { [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ }, }, },
 	{ .name	    = "bpf",
@@ -793,7 +796,7 @@ static struct syscall_fmt {
 		   [3] = { .scnprintf = SCA_INT,	/* pkey */ }, }, },
 	{ .name	    = "poll", .timeout = true, },
 	{ .name	    = "ppoll", .timeout = true, },
-	{ .name	    = "prctl", .alias = "arch_prctl",
+	{ .name	    = "prctl",
 	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */ },
 		   [1] = { .scnprintf = SCA_PRCTL_ARG2, /* arg2 */ },
 		   [2] = { .scnprintf = SCA_PRCTL_ARG3, /* arg3 */ }, }, },
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index 10c85cd3eb4f..637365099b7d 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -7,6 +7,7 @@ endif
 libperf-y += kcmp.o
 libperf-y += mount_flags.o
 libperf-y += pkey_alloc.o
+libperf-y += arch_prctl.o
 libperf-y += prctl.o
 libperf-y += renameat.o
 libperf-y += sockaddr.o
diff --git a/tools/perf/trace/beauty/arch_prctl.c b/tools/perf/trace/beauty/arch_prctl.c
new file mode 100644
index 000000000000..fe022ca67e60
--- /dev/null
+++ b/tools/perf/trace/beauty/arch_prctl.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * trace/beauty/arch_prctl.c
+ *
+ *  Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+ */
+
+#include "trace/beauty/beauty.h"
+#include <linux/kernel.h>
+
+#include "trace/beauty/generated/x86_arch_prctl_code_array.c"
+
+static DEFINE_STRARRAY_OFFSET(x86_arch_prctl_codes_1, "ARCH_", x86_arch_prctl_codes_1_offset);
+static DEFINE_STRARRAY_OFFSET(x86_arch_prctl_codes_2, "ARCH_", x86_arch_prctl_codes_2_offset);
+
+static struct strarray *x86_arch_prctl_codes[] = {
+	&strarray__x86_arch_prctl_codes_1,
+	&strarray__x86_arch_prctl_codes_2,
+};
+
+static DEFINE_STRARRAYS(x86_arch_prctl_codes);
+
+static size_t x86_arch_prctl__scnprintf_code(int option, char *bf, size_t size, bool show_prefix)
+{
+	return strarrays__scnprintf(&strarrays__x86_arch_prctl_codes, bf, size, "%#x", show_prefix, option);
+}
+
+size_t syscall_arg__scnprintf_x86_arch_prctl_code(char *bf, size_t size, struct syscall_arg *arg)
+{
+	unsigned long code = arg->val;
+
+	return x86_arch_prctl__scnprintf_code(code, bf, size, arg->show_string_prefix);
+}
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 58e734b27958..83c5b202e00e 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -155,6 +155,9 @@ size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, st
 size_t syscall_arg__scnprintf_open_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_OPEN_FLAGS syscall_arg__scnprintf_open_flags
 
+size_t syscall_arg__scnprintf_x86_arch_prctl_code(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_X86_ARCH_PRCTL_CODE syscall_arg__scnprintf_x86_arch_prctl_code
+
 size_t syscall_arg__scnprintf_prctl_option(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_OPTION syscall_arg__scnprintf_prctl_option
 
