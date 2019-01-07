Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A67C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2E320838
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfAGCzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 21:55:04 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:56666 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfAGCzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 21:55:03 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4DE3C72CC73;
        Mon,  7 Jan 2019 05:55:01 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 3F2AB8E5C51; Mon,  7 Jan 2019 05:55:01 +0300 (MSK)
Date:   Mon, 7 Jan 2019 05:55:01 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 22/22] selftests/ptrace: add a test case for
 PTRACE_GET_SYSCALL_INFO
Message-ID: <20190107025501.GV1207@altlinux.org>
References: <20190107025101.GA1182@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check whether PTRACE_GET_SYSCALL_INFO semantics implemented in the kernel
matches userspace expectations.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v7: unchanged
    v6: made PTRACE_GET_SYSCALL_INFO return value checks strict

 tools/testing/selftests/ptrace/.gitignore     |   1 +
 tools/testing/selftests/ptrace/Makefile       |   2 +-
 .../selftests/ptrace/get_syscall_info.c       | 271 ++++++++++++++++++
 3 files changed, 273 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptrace/get_syscall_info.c

diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
index b3e59d41fd82..cfcc49a7def7 100644
--- a/tools/testing/selftests/ptrace/.gitignore
+++ b/tools/testing/selftests/ptrace/.gitignore
@@ -1 +1,2 @@
+get_syscall_info
 peeksiginfo
diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
index 8a2bc5562179..4bc550b6b845 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,5 +1,5 @@
 CFLAGS += -iquote../../../../include/uapi -Wall
 
-TEST_GEN_PROGS := peeksiginfo
+TEST_GEN_PROGS := get_syscall_info peeksiginfo
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/get_syscall_info.c b/tools/testing/selftests/ptrace/get_syscall_info.c
new file mode 100644
index 000000000000..28e972825b74
--- /dev/null
+++ b/tools/testing/selftests/ptrace/get_syscall_info.c
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2018 Dmitry V. Levin <ldv@altlinux.org>
+ * All rights reserved.
+ *
+ * Check whether PTRACE_GET_SYSCALL_INFO semantics implemented in the kernel
+ * matches userspace expectations.
+ */
+
+#include "../kselftest_harness.h"
+#include <err.h>
+#include <signal.h>
+#include <asm/unistd.h>
+#include "linux/ptrace.h"
+
+static int
+kill_tracee(pid_t pid)
+{
+	if (!pid)
+		return 0;
+
+	int saved_errno = errno;
+
+	int rc = kill(pid, SIGKILL);
+
+	errno = saved_errno;
+	return rc;
+}
+
+static long
+sys_ptrace(int request, pid_t pid, unsigned long addr, unsigned long data)
+{
+	return syscall(__NR_ptrace, request, pid, addr, data);
+}
+
+#define LOG_KILL_TRACEE(fmt, ...)				\
+	do {							\
+		kill_tracee(pid);				\
+		TH_LOG("wait #%d: " fmt,			\
+		       ptrace_stop, ##__VA_ARGS__);		\
+	} while (0)
+
+TEST(get_syscall_info)
+{
+	static const unsigned long args[][7] = {
+		/* a sequence of architecture-agnostic syscalls */
+		{
+			__NR_chdir,
+			(unsigned long) "",
+			0xbad1fed1,
+			0xbad2fed2,
+			0xbad3fed3,
+			0xbad4fed4,
+			0xbad5fed5
+		},
+		{
+			__NR_gettid,
+			0xcaf0bea0,
+			0xcaf1bea1,
+			0xcaf2bea2,
+			0xcaf3bea3,
+			0xcaf4bea4,
+			0xcaf5bea5
+		},
+		{
+			__NR_exit_group,
+			0,
+			0xfac1c0d1,
+			0xfac2c0d2,
+			0xfac3c0d3,
+			0xfac4c0d4,
+			0xfac5c0d5
+		}
+	};
+	const unsigned long *exp_args;
+
+	pid_t pid = fork();
+
+	ASSERT_LE(0, pid) {
+		TH_LOG("fork: %m");
+	}
+
+	if (pid == 0) {
+		/* get the pid before PTRACE_TRACEME */
+		pid = getpid();
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		ASSERT_EQ(0, kill(pid, SIGSTOP)) {
+			/* cannot happen */
+			TH_LOG("kill SIGSTOP: %m");
+		}
+		for (unsigned int i = 0; i < ARRAY_SIZE(args); ++i) {
+			syscall(args[i][0],
+				args[i][1], args[i][2], args[i][3],
+				args[i][4], args[i][5], args[i][6]);
+		}
+		/* unreachable */
+		_exit(1);
+	}
+
+	const struct {
+		unsigned int is_error;
+		int rval;
+	} *exp_param, exit_param[] = {
+		{ 1, -ENOENT },	/* chdir */
+		{ 0, pid }	/* gettid */
+	};
+
+	unsigned int ptrace_stop;
+
+	for (ptrace_stop = 0; ; ++ptrace_stop) {
+		struct ptrace_syscall_info info = {
+			.op = 0xff	/* invalid PTRACE_SYSCALL_INFO_* op */
+		};
+		const size_t size = sizeof(info);
+		const int expected_none_size =
+			(void *) &info.entry - (void *) &info;
+		const int expected_entry_size =
+			(void *) &info.entry.args[6] - (void *) &info;
+		const int expected_exit_size =
+			(void *) (&info.exit.is_error + 1) -
+			(void *) &info;
+		int status;
+		long rc;
+
+		ASSERT_EQ(pid, wait(&status)) {
+			/* cannot happen */
+			LOG_KILL_TRACEE("wait: %m");
+		}
+		if (WIFEXITED(status)) {
+			pid = 0;	/* the tracee is no more */
+			ASSERT_EQ(0, WEXITSTATUS(status));
+			break;
+		}
+		ASSERT_FALSE(WIFSIGNALED(status)) {
+			pid = 0;	/* the tracee is no more */
+			LOG_KILL_TRACEE("unexpected signal %u",
+					WTERMSIG(status));
+		}
+		ASSERT_TRUE(WIFSTOPPED(status)) {
+			/* cannot happen */
+			LOG_KILL_TRACEE("unexpected wait status %#x", status);
+		}
+
+		switch (WSTOPSIG(status)) {
+		case SIGSTOP:
+			ASSERT_EQ(0, ptrace_stop) {
+				LOG_KILL_TRACEE("unexpected signal stop");
+			}
+			ASSERT_EQ(0, sys_ptrace(PTRACE_SETOPTIONS, pid, 0,
+						PTRACE_O_TRACESYSGOOD)) {
+				LOG_KILL_TRACEE("PTRACE_SETOPTIONS: %m");
+			}
+			ASSERT_LT(0, (rc = sys_ptrace(PTRACE_GET_SYSCALL_INFO,
+						      pid, size,
+						      (unsigned long) &info))) {
+				LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO: %m");
+			}
+			ASSERT_EQ(expected_none_size, rc) {
+				LOG_KILL_TRACEE("signal stop mismatch");
+			}
+			ASSERT_EQ(PTRACE_SYSCALL_INFO_NONE, info.op) {
+				LOG_KILL_TRACEE("signal stop mismatch");
+			}
+			ASSERT_TRUE(info.arch) {
+				LOG_KILL_TRACEE("signal stop mismatch");
+			}
+			ASSERT_TRUE(info.instruction_pointer) {
+				LOG_KILL_TRACEE("signal stop mismatch");
+			}
+			ASSERT_TRUE(info.stack_pointer) {
+				LOG_KILL_TRACEE("signal stop mismatch");
+			}
+			break;
+
+		case SIGTRAP | 0x80:
+			ASSERT_LT(0, (rc = sys_ptrace(PTRACE_GET_SYSCALL_INFO,
+						      pid, size,
+						      (unsigned long) &info))) {
+				LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO: %m");
+			}
+			switch (ptrace_stop) {
+			case 1: /* entering chdir */
+			case 3: /* entering gettid */
+			case 5: /* entering exit_group */
+				exp_args = args[ptrace_stop / 2];
+				ASSERT_EQ(expected_entry_size, rc) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(PTRACE_SYSCALL_INFO_ENTRY, info.op) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_TRUE(info.arch) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_TRUE(info.instruction_pointer) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_TRUE(info.stack_pointer) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(exp_args[0], info.entry.nr) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(exp_args[1], info.entry.args[0]) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(exp_args[2], info.entry.args[1]) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(exp_args[3], info.entry.args[2]) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(exp_args[4], info.entry.args[3]) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(exp_args[5], info.entry.args[4]) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(exp_args[6], info.entry.args[5]) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				break;
+			case 2: /* exiting chdir */
+			case 4: /* exiting gettid */
+				exp_param = &exit_param[ptrace_stop / 2 - 1];
+				ASSERT_EQ(expected_exit_size, rc) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_EQ(PTRACE_SYSCALL_INFO_EXIT, info.op) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_TRUE(info.arch) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_TRUE(info.instruction_pointer) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_TRUE(info.stack_pointer) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_EQ(exp_param->is_error,
+					  info.exit.is_error) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_EQ(exp_param->rval, info.exit.rval) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				break;
+			default:
+				LOG_KILL_TRACEE("unexpected syscall stop");
+				abort();
+			}
+			break;
+
+		default:
+			LOG_KILL_TRACEE("unexpected stop signal %#x",
+					WSTOPSIG(status));
+			abort();
+		}
+
+		ASSERT_EQ(0, sys_ptrace(PTRACE_SYSCALL, pid, 0, 0)) {
+			LOG_KILL_TRACEE("PTRACE_SYSCALL: %m");
+		}
+	}
+
+	ASSERT_EQ(ARRAY_SIZE(args) * 2, ptrace_stop);
+}
+
+TEST_HARNESS_MAIN
-- 
ldv
