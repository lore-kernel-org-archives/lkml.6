Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeENSwp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:52:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:45332 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbeENSwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244666"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 15/15] x86/split_lock: Add split lock user space test in selftest
Date: Mon, 14 May 2018 11:52:25 -0700
Message-Id: <1526323945-211107-16-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test generates split locked access from user space. If #AC
exception is enabled for split lock, a SIGBUS is delivered
to the test.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/x86/Makefile               |   3 +-
 tools/testing/selftests/x86/split_lock_user_test.c | 187 +++++++++++++++++++++
 2 files changed, 189 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/split_lock_user_test.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d744991c0f4f..19d65729b100 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -11,7 +11,8 @@ CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
-			protection_keys test_vdso test_vsyscall
+			protection_keys test_vdso test_vsyscall	\
+			split_lock_user_test
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/split_lock_user_test.c b/tools/testing/selftests/x86/split_lock_user_test.c
new file mode 100644
index 000000000000..e6f3367dfb6b
--- /dev/null
+++ b/tools/testing/selftests/x86/split_lock_user_test.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Fenghua Yu <fenghua.yu@intel.com>
+ *
+ * Pre-request:
+ * Kernel is built with CONFIG_SPLIT_LOCK_AC=y.
+ * Split lock is enabled. If not, enable it by:
+ * #echo 1 >/sys/kernel/split_lock/enable
+ *
+ * Usage:
+ * Run the test alone and it should show:
+ *      TEST PASS: locked instruction is re-executed.
+ *      TEST PASS: Caught SIGBUS/#AC due to split locked access
+ *
+ * Or launch the test from perf and watch "split_lock_user" event count.
+ * #/perf stat -e exceptions:split_lock* /root/split_lock_user_test_64
+ *      TEST PASS: locked instruction is re-executed.
+ *      TEST PASS: Caught SIGBUS/#AC due to split locked access
+ *
+ * Performance counter stats for '/root/split_lock_user_test_64':
+ *
+ *                1      exceptions:split_lock_user
+ *                0      exceptions:split_lock_kernel
+ *
+ *       1.000893458 seconds time elapsed
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
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
+	fd = open("/sys/kernel/split_lock/enable", O_RDONLY);
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
+	fd = open("/sys/kernel/split_lock/user_mode", O_RDWR);
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
+void do_split_locked_inst(int a, int b, int *iptr)
+{
+	/*
+	 * Since eax is equal to *iptr, the instruction loads value in b
+	 * (i.e. 11) into iptr. If the instruction is executed correctly,
+	 * the content of *iptr is changed * to 11 from previous value 1.
+	 *
+	 * Accessing iptr cross two cache lines will trigger #AC in hardware
+	 * and kernel either delivers SIGBUS to this process or re-execute
+	 * the instruction depending on /sys/kernel/split_lock/user_mode
+	 * setting.
+	 */
+	asm volatile ("movl %1, %%eax\n\t"
+		      "movl %1, %0\n\t"
+		      "lock\n cmpxchgl %2, %0\n\t"
+		      : "=m" (*iptr)
+		      : "r"(a), "r"(b)
+		      : "%eax");
+}
+
+void test_re_execute(int a, int b, int *iptr)
+{
+	setup_user_mode("re-execute");
+
+	/* The locked instruction triggers #AC and then it's re-executed. */
+	do_split_locked_inst(a, b, iptr);
+
+	if (*iptr == b) {
+		printf("TEST PASS: locked instruction is re-executed.\n");
+	} else {
+		printf("TEST FAIL: No #AC exception is caught and ");
+		printf("instruction is not executed correctly.\n");
+	}
+}
+
+void test_sigbus(int a, int b, int *iptr)
+{
+	setup_user_mode("sigbus");
+
+	/*
+	 * The locked instruction triggers #AC and kernel delivers SIGBUS
+	 * to this process.
+	 */
+	do_split_locked_inst(a, b, iptr);
+}
+
+int main(int argc, char **argv)
+{
+	int *iptr, a = 10, b = 11;
+	char *cptr;
+
+	if (!split_lock_ac_enabled()) {
+		printf("#AC exception for split lock is NOT enabled!!\n");
+		printf("Please make sure split lock feature is supported,\n");
+		printf("CONFIG_SPLIT_LOCK_AC is turned on,\n");
+		printf("and /sys/kernel/split_lock/enable is 1 before test!\n");
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
+	/* Increment the pointer by 61, making it misaligned */
+	iptr = (int *)(cptr + 61);
+
+	/* Initial value in iptr is 1. */
+	*iptr = 1;
+
+	test_re_execute(a, b, iptr);
+	/*
+	 * The split lock is disabled after the last locked instruction is
+	 * re-executed.
+	 *
+	 * Wait for the split lock is re-enabled again before next test.
+	 */
+	sleep(1);
+	test_sigbus(a, b, iptr);
+
+	free(cptr);
+
+	return 0;
+}
-- 
2.5.0
