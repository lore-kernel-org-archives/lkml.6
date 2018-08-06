Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A99DC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4DC219F4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4DC219F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeHFMVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:21:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726746AbeHFMVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:21:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5FB938011454;
        Mon,  6 Aug 2018 10:12:46 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 980DD2156897;
        Mon,  6 Aug 2018 10:12:44 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/2] perf tests: Add breakpoint modify test
Date:   Mon,  6 Aug 2018 12:12:40 +0200
Message-Id: <20180806101241.6444-2-jolsa@kernel.org>
In-Reply-To: <20180806101241.6444-1-jolsa@kernel.org>
References: <20180806101241.6444-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 10:12:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 06 Aug 2018 10:12:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test creates HW breakpoint, tries to change
it and checks it was properly changed. It aims
on kernel issue that prevents HW breakpoint to
be changed via ptrace interface.

The test forks and the child sets itself as ptrace
tracee and waits in signal for parent to trace it,
then it calls bp_1 and quits.

The parent does following steps:
 - creates a new breakpoint (id 0) for bp_2 function
 - changes that breakponit to bp_1 function
 - waits for the breakpoint to hit and checks
   it has proper rip of bp_1 function
 - detaches the child

Link: http://lkml.kernel.org/n/tip-8a3x8utnljw8xtumkxkxkt18@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/include/arch-tests.h |   1 +
 tools/perf/arch/x86/tests/Build          |   1 +
 tools/perf/arch/x86/tests/arch-tests.c   |   6 ++
 tools/perf/arch/x86/tests/bp-modify.c    | 119 +++++++++++++++++++++++
 4 files changed, 127 insertions(+)
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
index 000000000000..a7aa6d39021c
--- /dev/null
+++ b/tools/perf/arch/x86/tests/bp-modify.c
@@ -0,0 +1,119 @@
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
+	return 0;
+}
+
+static noinline int bp_2(void)
+{
+	return 0;
+}
+
+/*
+ * This tests creates HW breakpoint, tries to
+ * change it and checks it was properly changed.
+ */
+int test__bp_modify(struct test *test __maybe_unused,
+		    int subtest __maybe_unused)
+{
+	pid_t child;
+	int status;
+	unsigned long rip, dr7 = 1;
+
+	child = fork();
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
+	waitpid(child, &status, 0);
+	if (WIFEXITED(status)) {
+		pr_debug("tracee exited prematurely\n");
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
+		pr_debug("tracee exited prematurely\n");
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
-- 
2.17.1

