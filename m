Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8A9C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B27D20848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUFPEcGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B27D20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbeKCEAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:42 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38CA02084A;
        Fri,  2 Nov 2018 18:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184746;
        bh=zWlPt1tY5JoVVn2dEdkquNVMAoZe7/35reV1TUkefG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dUFPEcGTXWpjHwUJ5F4+/e/qipwFCbxoApBJDHXNBbZt60Aj8uZrJSELmQM9wQAaV
         a0k1TgoRNPrSekOBLcox99aKuWVL8WcE1827iUl2mivo8ShftcrQO1NnOXXdlIoNtx
         hv9NnJPfOu5G3CI4a/qoWmd1nqrCVTkR2e478VOs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 086/143] selftests/powerpc: Add ptrace hw breakpoint test
Date:   Fri,  2 Nov 2018 19:34:31 +0100
Message-Id: <20181102182904.629680375@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9c2ddfe55c42bf4b9bc336a0650ab78f9222a159 ]

This test the ptrace hw breakpoints via PTRACE_SET_DEBUGREG and
PPC_PTRACE_SETHWDEBUG.  This test was use to find the bugs fixed by
these recent commits:

  4f7c06e26e powerpc/ptrace: Fix setting 512B aligned breakpoints with PTRACE_SET_DEBUGREG
  cd6ef7eebf powerpc/ptrace: Fix enforcement of DAWR constraints

Signed-off-by: Michael Neuling <mikey@neuling.org>
[mpe: Add SPDX tag, clang format it]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/powerpc/ptrace/.gitignore       |   1 +
 .../testing/selftests/powerpc/ptrace/Makefile |   2 +-
 .../selftests/powerpc/ptrace/ptrace-hwbreak.c | 342 ++++++++++++++++++
 3 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c

diff --git a/tools/testing/selftests/powerpc/ptrace/.gitignore b/tools/testing/selftests/powerpc/ptrace/.gitignore
index 349acfafc95b..9dcc16ea8179 100644
--- a/tools/testing/selftests/powerpc/ptrace/.gitignore
+++ b/tools/testing/selftests/powerpc/ptrace/.gitignore
@@ -8,3 +8,4 @@ ptrace-vsx
 ptrace-tm-vsx
 ptrace-tm-spd-vsx
 ptrace-tm-spr
+ptrace-hwbreak
diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index 480305266504..0e2f4601d1a8 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_PROGS := ptrace-gpr ptrace-tm-gpr ptrace-tm-spd-gpr \
               ptrace-tar ptrace-tm-tar ptrace-tm-spd-tar ptrace-vsx ptrace-tm-vsx \
-              ptrace-tm-spd-vsx ptrace-tm-spr
+              ptrace-tm-spd-vsx ptrace-tm-spr ptrace-hwbreak
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
new file mode 100644
index 000000000000..3066d310f32b
--- /dev/null
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-hwbreak.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Ptrace test for hw breakpoints
+ *
+ * Based on tools/testing/selftests/breakpoints/breakpoint_test.c
+ *
+ * This test forks and the parent then traces the child doing various
+ * types of ptrace enabled breakpoints
+ *
+ * Copyright (C) 2018 Michael Neuling, IBM Corporation.
+ */
+
+#include <sys/ptrace.h>
+#include <unistd.h>
+#include <stddef.h>
+#include <sys/user.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "ptrace.h"
+
+/* Breakpoint access modes */
+enum {
+	BP_X = 1,
+	BP_RW = 2,
+	BP_W = 4,
+};
+
+static pid_t child_pid;
+static struct ppc_debug_info dbginfo;
+
+static void get_dbginfo(void)
+{
+	int ret;
+
+	ret = ptrace(PPC_PTRACE_GETHWDBGINFO, child_pid, NULL, &dbginfo);
+	if (ret) {
+		perror("Can't get breakpoint info\n");
+		exit(-1);
+	}
+}
+
+static bool hwbreak_present(void)
+{
+	return (dbginfo.num_data_bps != 0);
+}
+
+static bool dawr_present(void)
+{
+	return !!(dbginfo.features & PPC_DEBUG_FEATURE_DATA_BP_DAWR);
+}
+
+static void set_breakpoint_addr(void *addr)
+{
+	int ret;
+
+	ret = ptrace(PTRACE_SET_DEBUGREG, child_pid, 0, addr);
+	if (ret) {
+		perror("Can't set breakpoint addr\n");
+		exit(-1);
+	}
+}
+
+static int set_hwbreakpoint_addr(void *addr, int range)
+{
+	int ret;
+
+	struct ppc_hw_breakpoint info;
+
+	info.version = 1;
+	info.trigger_type = PPC_BREAKPOINT_TRIGGER_RW;
+	info.addr_mode = PPC_BREAKPOINT_MODE_EXACT;
+	if (range > 0)
+		info.addr_mode = PPC_BREAKPOINT_MODE_RANGE_INCLUSIVE;
+	info.condition_mode = PPC_BREAKPOINT_CONDITION_NONE;
+	info.addr = (__u64)addr;
+	info.addr2 = (__u64)addr + range;
+	info.condition_value = 0;
+
+	ret = ptrace(PPC_PTRACE_SETHWDEBUG, child_pid, 0, &info);
+	if (ret < 0) {
+		perror("Can't set breakpoint\n");
+		exit(-1);
+	}
+	return ret;
+}
+
+static int del_hwbreakpoint_addr(int watchpoint_handle)
+{
+	int ret;
+
+	ret = ptrace(PPC_PTRACE_DELHWDEBUG, child_pid, 0, watchpoint_handle);
+	if (ret < 0) {
+		perror("Can't delete hw breakpoint\n");
+		exit(-1);
+	}
+	return ret;
+}
+
+#define DAWR_LENGTH_MAX 512
+
+/* Dummy variables to test read/write accesses */
+static unsigned long long
+	dummy_array[DAWR_LENGTH_MAX / sizeof(unsigned long long)]
+	__attribute__((aligned(512)));
+static unsigned long long *dummy_var = dummy_array;
+
+static void write_var(int len)
+{
+	long long *plval;
+	char *pcval;
+	short *psval;
+	int *pival;
+
+	switch (len) {
+	case 1:
+		pcval = (char *)dummy_var;
+		*pcval = 0xff;
+		break;
+	case 2:
+		psval = (short *)dummy_var;
+		*psval = 0xffff;
+		break;
+	case 4:
+		pival = (int *)dummy_var;
+		*pival = 0xffffffff;
+		break;
+	case 8:
+		plval = (long long *)dummy_var;
+		*plval = 0xffffffffffffffffLL;
+		break;
+	}
+}
+
+static void read_var(int len)
+{
+	char cval __attribute__((unused));
+	short sval __attribute__((unused));
+	int ival __attribute__((unused));
+	long long lval __attribute__((unused));
+
+	switch (len) {
+	case 1:
+		cval = *(char *)dummy_var;
+		break;
+	case 2:
+		sval = *(short *)dummy_var;
+		break;
+	case 4:
+		ival = *(int *)dummy_var;
+		break;
+	case 8:
+		lval = *(long long *)dummy_var;
+		break;
+	}
+}
+
+/*
+ * Do the r/w accesses to trigger the breakpoints. And run
+ * the usual traps.
+ */
+static void trigger_tests(void)
+{
+	int len, ret;
+
+	ret = ptrace(PTRACE_TRACEME, 0, NULL, 0);
+	if (ret) {
+		perror("Can't be traced?\n");
+		return;
+	}
+
+	/* Wake up father so that it sets up the first test */
+	kill(getpid(), SIGUSR1);
+
+	/* Test write watchpoints */
+	for (len = 1; len <= sizeof(long); len <<= 1)
+		write_var(len);
+
+	/* Test read/write watchpoints (on read accesses) */
+	for (len = 1; len <= sizeof(long); len <<= 1)
+		read_var(len);
+
+	/* Test when breakpoint is unset */
+
+	/* Test write watchpoints */
+	for (len = 1; len <= sizeof(long); len <<= 1)
+		write_var(len);
+
+	/* Test read/write watchpoints (on read accesses) */
+	for (len = 1; len <= sizeof(long); len <<= 1)
+		read_var(len);
+}
+
+static void check_success(const char *msg)
+{
+	const char *msg2;
+	int status;
+
+	/* Wait for the child to SIGTRAP */
+	wait(&status);
+
+	msg2 = "Failed";
+
+	if (WIFSTOPPED(status) && WSTOPSIG(status) == SIGTRAP) {
+		msg2 = "Child process hit the breakpoint";
+	}
+
+	printf("%s Result: [%s]\n", msg, msg2);
+}
+
+static void launch_watchpoints(char *buf, int mode, int len,
+			       struct ppc_debug_info *dbginfo, bool dawr)
+{
+	const char *mode_str;
+	unsigned long data = (unsigned long)(dummy_var);
+	int wh, range;
+
+	data &= ~0x7UL;
+
+	if (mode == BP_W) {
+		data |= (1UL << 1);
+		mode_str = "write";
+	} else {
+		data |= (1UL << 0);
+		data |= (1UL << 1);
+		mode_str = "read";
+	}
+
+	/* Set DABR_TRANSLATION bit */
+	data |= (1UL << 2);
+
+	/* use PTRACE_SET_DEBUGREG breakpoints */
+	set_breakpoint_addr((void *)data);
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	sprintf(buf, "Test %s watchpoint with len: %d ", mode_str, len);
+	check_success(buf);
+	/* Unregister hw brkpoint */
+	set_breakpoint_addr(NULL);
+
+	data = (data & ~7); /* remove dabr control bits */
+
+	/* use PPC_PTRACE_SETHWDEBUG breakpoint */
+	if (!(dbginfo->features & PPC_DEBUG_FEATURE_DATA_BP_RANGE))
+		return; /* not supported */
+	wh = set_hwbreakpoint_addr((void *)data, 0);
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	sprintf(buf, "Test %s watchpoint with len: %d ", mode_str, len);
+	check_success(buf);
+	/* Unregister hw brkpoint */
+	del_hwbreakpoint_addr(wh);
+
+	/* try a wider range */
+	range = 8;
+	if (dawr)
+		range = 512 - ((int)data & (DAWR_LENGTH_MAX - 1));
+	wh = set_hwbreakpoint_addr((void *)data, range);
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+	sprintf(buf, "Test %s watchpoint with len: %d ", mode_str, len);
+	check_success(buf);
+	/* Unregister hw brkpoint */
+	del_hwbreakpoint_addr(wh);
+}
+
+/* Set the breakpoints and check the child successfully trigger them */
+static int launch_tests(bool dawr)
+{
+	char buf[1024];
+	int len, i, status;
+
+	struct ppc_debug_info dbginfo;
+
+	i = ptrace(PPC_PTRACE_GETHWDBGINFO, child_pid, NULL, &dbginfo);
+	if (i) {
+		perror("Can't set breakpoint info\n");
+		exit(-1);
+	}
+	if (!(dbginfo.features & PPC_DEBUG_FEATURE_DATA_BP_RANGE))
+		printf("WARNING: Kernel doesn't support PPC_PTRACE_SETHWDEBUG\n");
+
+	/* Write watchpoint */
+	for (len = 1; len <= sizeof(long); len <<= 1)
+		launch_watchpoints(buf, BP_W, len, &dbginfo, dawr);
+
+	/* Read-Write watchpoint */
+	for (len = 1; len <= sizeof(long); len <<= 1)
+		launch_watchpoints(buf, BP_RW, len, &dbginfo, dawr);
+
+	ptrace(PTRACE_CONT, child_pid, NULL, 0);
+
+	/*
+	 * Now we have unregistered the breakpoint, access by child
+	 * should not cause SIGTRAP.
+	 */
+
+	wait(&status);
+
+	if (WIFSTOPPED(status) && WSTOPSIG(status) == SIGTRAP) {
+		printf("FAIL: Child process hit the breakpoint, which is not expected\n");
+		ptrace(PTRACE_CONT, child_pid, NULL, 0);
+		return TEST_FAIL;
+	}
+
+	if (WIFEXITED(status))
+		printf("Child exited normally\n");
+
+	return TEST_PASS;
+}
+
+static int ptrace_hwbreak(void)
+{
+	pid_t pid;
+	int ret;
+	bool dawr;
+
+	pid = fork();
+	if (!pid) {
+		trigger_tests();
+		return 0;
+	}
+
+	wait(NULL);
+
+	child_pid = pid;
+
+	get_dbginfo();
+	SKIP_IF(!hwbreak_present());
+	dawr = dawr_present();
+
+	ret = launch_tests(dawr);
+
+	wait(NULL);
+
+	return ret;
+}
+
+int main(int argc, char **argv, char **envp)
+{
+	return test_harness(ptrace_hwbreak, "ptrace-hwbreak");
+}
-- 
2.17.1



