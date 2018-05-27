Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032998AbeE0Prc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:47:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:28383 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032827AbeE0PqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741117"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "Ashok Raj" <ashok.raj@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, "x86" <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 16/16] x86/split_lock: Add user space split lock test in selftest
Date: Sun, 27 May 2018 08:46:05 -0700
Message-Id: <1527435965-202085-17-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User may use the selftest to test how user space split lock is handled,

If #AC exception is enabled for split lock, the test generates split
locked access from user space and tests how the split lock access is
handled in two ways:

1. A SIGBUS is delivered to the test processor. This is specified by
writing "sigbus" to /sys/kernel/debug/x86/split_lock/user_mode.

2. The faulting instruction is re-executed. This is specified by
writing "re-execute" to /sys/kernel/debug/x86/split_lock/user_mode.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/x86/Makefile               |   3 +-
 tools/testing/selftests/x86/split_lock_user_test.c | 207 +++++++++++++++++++++
 2 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/split_lock_user_test.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 39f66bc29b82..e4bcb72c0ae8 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -11,7 +11,8 @@ CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
-			protection_keys test_vdso test_vsyscall mov_ss_trap
+			protection_keys test_vdso test_vsyscall	mov_ss_trap \
+			split_lock_user_test
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/split_lock_user_test.c b/tools/testing/selftests/x86/split_lock_user_test.c
new file mode 100644
index 000000000000..9ce5fc1af154
--- /dev/null
+++ b/tools/testing/selftests/x86/split_lock_user_test.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Fenghua Yu <fenghua.yu@intel.com>
+ *
+ * Pre-request:
+ * Kernel is built with CONFIG_SPLIT_LOCK_AC=y.
+ * Split lock is enabled. If not, enable it by:
+ * #echo 1 >/sys/kernel/debug/x86/split_lock/enable
+ *
+ * Usage:
+ * Run the test alone and it should show:
+ *      TEST PASS: locked instruction is re-executed.
+ *      TEST PASS: Caught SIGBUS/#AC due to split locked access
+ *
+ * Or launch the test from perf and watch "split_lock_user" event count.
+ * #/perf stat -e sq_misc.split_lock /root/split_lock_user_test_64
+ *      TEST PASS: locked instruction is re-executed.
+ *      TEST PASS: Caught SIGBUS/#AC due to split locked access
+ *
+ * Performance counter stats for 'tools/testing/selftests/x86/
+ * split_lock_user_test_64':
+ *		2      sq_misc.split_lock
+ *
+ *	1.001507372 seconds time elapsed
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+
+int split_lock_exception;
+
+void catch_sigbus(int sig)
+{
+	split_lock_exception = 1;
+	printf("TEST PASS: Caught SIGBUS/#AC due to split locked access\n");
+
+	exit(-1);
+}
+
+int split_lock_ac_enabled(void)
+{
+	int fd, enable, ret;
+	char buf[16];
+
+	fd = open("/sys/kernel/debug/x86/split_lock/enable", O_RDONLY);
+	if (fd < 0)
+		return 0;
+
+	if (read(fd, buf, sizeof(int)) < 0) {
+		ret = 0;
+		goto out;
+	}
+
+	enable = atoi(buf);
+	if (enable == 1)
+		ret = 1;
+	else
+		ret = 0;
+
+out:
+	close(fd);
+
+	return ret;
+}
+
+int setup_user_mode(char *user_mode_reaction)
+{
+	ssize_t count;
+	int fd;
+
+	if (strcmp(user_mode_reaction, "sigbus") &&
+	    strcmp(user_mode_reaction, "re-execute"))
+		return -1;
+
+	fd = open("/sys/kernel/debug/x86/split_lock/user_mode", O_RDWR);
+	if (fd < 0)
+		return -1;
+
+	count = write(fd, user_mode_reaction, strlen(user_mode_reaction));
+	if (count != strlen(user_mode_reaction))
+		return -1;
+
+	close(fd);
+
+	return 0;
+}
+
+/*
+ * Atomically add 1 to *iptr using "lock addl" instruction.
+ * Since *iptr crosses two cache lines, #AC is generated by the split lock.
+ */
+void do_split_locked_inst(int *iptr)
+{
+	/*
+	 * The distance between iptr and next cache line is 3 bytes.
+	 * Operand size in "addl" is 4 bytes. So iptr will span two cache
+	 * lines. "lock addl" instruction will trigger #AC in hardware
+	 * and kernel either delivers SIGBUS to this process or re-execute
+	 * the instruction depending on
+	 * /sys/kernel/debug/x86/split_lock/user_mode setting.
+	 */
+	asm volatile ("lock addl $1, %0\n\t"
+		      : "=m" (*iptr));
+}
+
+/*
+ * Test re-executing a locked instruction after it generates #AC for split lock
+ * operand *iptr.
+ */
+void test_re_execute(int *iptr)
+{
+	setup_user_mode("re-execute");
+
+	/* Initialize *iptr. */
+	*iptr = 0;
+
+	/* The locked instruction triggers #AC and then it's re-executed. */
+	do_split_locked_inst(iptr);
+
+	/* If executed successfully, *iptr should be 1 now. */
+	if (*iptr == 1) {
+		printf("TEST PASS: locked instruction is re-executed.\n");
+	} else {
+		printf("TEST FAIL: No #AC exception is caught and ");
+		printf("instruction is not executed correctly.\n");
+	}
+}
+
+/*
+ * Test SIGBUS delivered after a lock instruction generates #AC for split lock
+ * operand *iptr.
+ */
+void test_sigbus(int *iptr)
+{
+	pid_t pid;
+
+	setup_user_mode("sigbus");
+
+	pid = fork();
+	if (pid) {
+		waitpid(pid, NULL, WIFSIGNALED(NULL));
+		return;
+	}
+
+	/*
+	 * The locked instruction will trigger #AC and kernel will deliver
+	 * SIGBUS to this process. The SIGBUS handler in this process will
+	 * verify that the signal is delivered and the process is killed then.
+	 */
+	do_split_locked_inst(iptr);
+}
+
+int main(int argc, char **argv)
+{
+	int *iptr;
+	char *cptr;
+
+	if (!split_lock_ac_enabled()) {
+		printf("#AC exception for split lock is NOT enabled!!\n");
+		printf("Before test, please make sure:\n");
+		printf("split lock feature is supported on this platform,\n");
+		printf("CONFIG_SPLIT_LOCK_AC is turned on,\n");
+		printf("and /sys/kernel/debug/x86/split_lock/enable is 1.\n");
+
+		return 0;
+	}
+
+	signal(SIGBUS, catch_sigbus);
+
+	/*
+	 * Enable Alignment Checking on x86_64.
+	 * This will generate alignment check on not only split lock but also
+	 * on any misalignment.
+	 * Turn on this for reference only.
+	 */
+	/* __asm__("pushf\norl $0x40000,(%rsp)\npopf"); */
+
+	/* aligned_alloc() provides 64-byte aligned memory */
+	cptr = (char *)aligned_alloc(64, 128);
+
+	/*
+	 * Increment the pointer by 61, making it 3 bytes away from the next
+	 * cache line and 4-byte *iptr across two cache line.
+	 */
+	iptr = (int *)(cptr + 61);
+
+	test_re_execute(iptr);
+	/*
+	 * The split lock is disabled after the last locked instruction is
+	 * re-executed.
+	 *
+	 * Wait for the split lock is re-enabled again before next test.
+	 */
+	sleep(1);
+	test_sigbus(iptr);
+
+	free(cptr);
+
+	return 0;
+}
-- 
2.5.0
