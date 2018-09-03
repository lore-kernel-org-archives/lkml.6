Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E93C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DDD2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKrRczf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DDD2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeICTNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICTNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:13:11 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90D020862;
        Mon,  3 Sep 2018 14:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535986360;
        bh=n3ao6tDkzt+5ajzGmVF5mFvNh5Kza3Nzg78fJAggamU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKrRczf65nPQC5QGi+xPvRmOdzrhqxsFCGnZeOEjuPQ0VsM+YNhOAQr3lFifSGZOz
         Vd1gA2T65EuGy3B3D7C4WDjsqXqTSFIn6KMG+cEa8q8vcdt6YFow7E0foy4L9H6QRG
         bJcnY8sKEJGALtU7dlAl41qdQo/MLvdAa4LPI428=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/13] perf tests: Add breakpoint modify tests
Date:   Mon,  3 Sep 2018 11:52:13 -0300
Message-Id: <20180903145224.12318-3-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180903145224.12318-1-acme@kernel.org>
References: <20180903145224.12318-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding to tests that aims on kernel breakpoint modification bugs.

First test creates HW breakpoint, tries to change it and checks it was
properly changed. It aims on kernel issue that prevents HW breakpoint to
be changed via ptrace interface.

The first test forks, the child sets itself as ptrace tracee and waits
in signal for parent to trace it, then it calls bp_1 and quits.

The parent does following steps:

 - creates a new breakpoint (id 0) for bp_2 function
 - changes that breakpoint to bp_1 function
 - waits for the breakpoint to hit and checks
   it has proper rip of bp_1 function

This test aims on an issue in kernel preventing to change disabled
breakpoints

Second test mimics the first one except for few steps
in the parent:
 - creates a new breakpoint (id 0) for bp_1 function
 - changes that breakpoint to bogus (-1) address
 - waits for the breakpoint to hit and checks
   it has proper rip of bp_1 function

This test aims on an issue in kernel disabling enabled
breakpoint after unsuccesful change.

Committer testing:

  # uname -a
  Linux jouet 4.18.0-rc8-00002-g1236568ee3cb #12 SMP Tue Aug 7 14:08:26 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # perf test -v "bp modify"
  62: x86 bp modify                                         :
  --- start ---
  test child forked, pid 25671
  in bp_1
  tracee exited prematurely 2
  FAILED arch/x86/tests/bp-modify.c:209 modify test 1 failed

  test child finished with -1
  ---- end ----
  x86 bp modify: FAILED!
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milind Chabbi <chabbi.milind@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180827091228.2878-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/include/arch-tests.h |   1 +
 tools/perf/arch/x86/tests/Build          |   1 +
 tools/perf/arch/x86/tests/arch-tests.c   |   6 +
 tools/perf/arch/x86/tests/bp-modify.c    | 213 +++++++++++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 tools/perf/arch/x86/tests/bp-modify.c

diff --git a/tools/perf/arch/x86/include/arch-tests.h b/tools/perf/arch/x86/include/arch-tests.h
index c1bd979b957b..613709cfbbd0 100644
--- a/tools/perf/arch/x86/include/arch-tests.h
+++ b/tools/perf/arch/x86/include/arch-tests.h
@@ -9,6 +9,7 @@ struct test;
 int test__rdpmc(struct test *test __maybe_unused, int subtest);
 int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest);
 int test__insn_x86(struct test *test __maybe_unused, int subtest);
+int test__bp_modify(struct test *test, int subtest);
 
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
 struct thread;
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index 8e2c5a38c3b9..586849ff83a0 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -5,3 +5,4 @@ libperf-y += arch-tests.o
 libperf-y += rdpmc.o
 libperf-y += perf-time-to-tsc.o
 libperf-$(CONFIG_AUXTRACE) += insn-x86.o
+libperf-$(CONFIG_X86_64) += bp-modify.o
diff --git a/tools/perf/arch/x86/tests/arch-tests.c b/tools/perf/arch/x86/tests/arch-tests.c
index cc1802ff5410..d47d3f8e3c8e 100644
--- a/tools/perf/arch/x86/tests/arch-tests.c
+++ b/tools/perf/arch/x86/tests/arch-tests.c
@@ -23,6 +23,12 @@ struct test arch_tests[] = {
 		.desc = "x86 instruction decoder - new instructions",
 		.func = test__insn_x86,
 	},
+#endif
+#if defined(__x86_64__)
+	{
+		.desc = "x86 bp modify",
+		.func = test__bp_modify,
+	},
 #endif
 	{
 		.func = NULL,
diff --git a/tools/perf/arch/x86/tests/bp-modify.c b/tools/perf/arch/x86/tests/bp-modify.c
new file mode 100644
index 000000000000..f53e4406709f
--- /dev/null
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/user.h>
+#include <syscall.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ptrace.h>
+#include <asm/ptrace.h>
+#include <errno.h>
+#include "debug.h"
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+static noinline int bp_1(void)
+{
+	pr_debug("in %s\n", __func__);
+	return 0;
+}
+
+static noinline int bp_2(void)
+{
+	pr_debug("in %s\n", __func__);
+	return 0;
+}
+
+static int spawn_child(void)
+{
+	int child = fork();
+
+	if (child == 0) {
+		/*
+		 * The child sets itself for as tracee and
+		 * waits in signal for parent to trace it,
+		 * then it calls bp_1 and quits.
+		 */
+		int err = ptrace(PTRACE_TRACEME, 0, NULL, NULL);
+
+		if (err) {
+			pr_debug("failed to PTRACE_TRACEME\n");
+			exit(1);
+		}
+
+		raise(SIGCONT);
+		bp_1();
+		exit(0);
+	}
+
+	return child;
+}
+
+/*
+ * This tests creates HW breakpoint, tries to
+ * change it and checks it was properly changed.
+ */
+static int bp_modify1(void)
+{
+	pid_t child;
+	int status;
+	unsigned long rip = 0, dr7 = 1;
+
+	child = spawn_child();
+
+	waitpid(child, &status, 0);
+	if (WIFEXITED(status)) {
+		pr_debug("tracee exited prematurely 1\n");
+		return TEST_FAIL;
+	}
+
+	/*
+	 * The parent does following steps:
+	 *  - creates a new breakpoint (id 0) for bp_2 function
+	 *  - changes that breakponit to bp_1 function
+	 *  - waits for the breakpoint to hit and checks
+	 *    it has proper rip of bp_1 function
+	 *  - detaches the child
+	 */
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[0]), bp_2)) {
+		pr_debug("failed to set breakpoint, 1st time: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[0]), bp_1)) {
+		pr_debug("failed to set breakpoint, 2nd time: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[7]), dr7)) {
+		pr_debug("failed to set dr7: %s\n", strerror(errno));
+		goto out;
+	}
+
+	if (ptrace(PTRACE_CONT, child, NULL, NULL)) {
+		pr_debug("failed to PTRACE_CONT: %s\n", strerror(errno));
+		goto out;
+	}
+
+	waitpid(child, &status, 0);
+	if (WIFEXITED(status)) {
+		pr_debug("tracee exited prematurely 2\n");
+		return TEST_FAIL;
+	}
+
+	rip = ptrace(PTRACE_PEEKUSER, child,
+		     offsetof(struct user_regs_struct, rip), NULL);
+	if (rip == (unsigned long) -1) {
+		pr_debug("failed to PTRACE_PEEKUSER: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	pr_debug("rip %lx, bp_1 %p\n", rip, bp_1);
+
+out:
+	if (ptrace(PTRACE_DETACH, child, NULL, NULL)) {
+		pr_debug("failed to PTRACE_DETACH: %s", strerror(errno));
+		return TEST_FAIL;
+	}
+
+	return rip == (unsigned long) bp_1 ? TEST_OK : TEST_FAIL;
+}
+
+/*
+ * This tests creates HW breakpoint, tries to
+ * change it to bogus value and checks the original
+ * breakpoint is hit.
+ */
+static int bp_modify2(void)
+{
+	pid_t child;
+	int status;
+	unsigned long rip = 0, dr7 = 1;
+
+	child = spawn_child();
+
+	waitpid(child, &status, 0);
+	if (WIFEXITED(status)) {
+		pr_debug("tracee exited prematurely 1\n");
+		return TEST_FAIL;
+	}
+
+	/*
+	 * The parent does following steps:
+	 *  - creates a new breakpoint (id 0) for bp_1 function
+	 *  - tries to change that breakpoint to (-1) address
+	 *  - waits for the breakpoint to hit and checks
+	 *    it has proper rip of bp_1 function
+	 *  - detaches the child
+	 */
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[0]), bp_1)) {
+		pr_debug("failed to set breakpoint: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	if (ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[7]), dr7)) {
+		pr_debug("failed to set dr7: %s\n", strerror(errno));
+		goto out;
+	}
+
+	if (!ptrace(PTRACE_POKEUSER, child,
+		   offsetof(struct user, u_debugreg[0]), (unsigned long) (-1))) {
+		pr_debug("failed, breakpoint set to bogus address\n");
+		goto out;
+	}
+
+	if (ptrace(PTRACE_CONT, child, NULL, NULL)) {
+		pr_debug("failed to PTRACE_CONT: %s\n", strerror(errno));
+		goto out;
+	}
+
+	waitpid(child, &status, 0);
+	if (WIFEXITED(status)) {
+		pr_debug("tracee exited prematurely 2\n");
+		return TEST_FAIL;
+	}
+
+	rip = ptrace(PTRACE_PEEKUSER, child,
+		     offsetof(struct user_regs_struct, rip), NULL);
+	if (rip == (unsigned long) -1) {
+		pr_debug("failed to PTRACE_PEEKUSER: %s\n",
+			 strerror(errno));
+		goto out;
+	}
+
+	pr_debug("rip %lx, bp_1 %p\n", rip, bp_1);
+
+out:
+	if (ptrace(PTRACE_DETACH, child, NULL, NULL)) {
+		pr_debug("failed to PTRACE_DETACH: %s", strerror(errno));
+		return TEST_FAIL;
+	}
+
+	return rip == (unsigned long) bp_1 ? TEST_OK : TEST_FAIL;
+}
+
+int test__bp_modify(struct test *test __maybe_unused,
+		    int subtest __maybe_unused)
+{
+	TEST_ASSERT_VAL("modify test 1 failed\n", !bp_modify1());
+	TEST_ASSERT_VAL("modify test 2 failed\n", !bp_modify2());
+
+	return 0;
+}
-- 
2.14.4

