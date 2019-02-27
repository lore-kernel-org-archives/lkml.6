Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1B3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A81B20663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfB0Vbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:31:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:30268 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbfB0Vbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:31:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 13:31:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="137757189"
Received: from yyu32-desk1.sc.intel.com ([10.144.155.177])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2019 13:31:34 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kselftest@vger.kernel.org
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH] x86/selftests/xsave: Introduce XSAVE tests
Date:   Wed, 27 Feb 2019 13:24:22 -0800
Message-Id: <20190227212422.11845-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past there were some issues resulting from additions to
XSAVE/XSAVES.  Introduce a few tests to help detect issues early.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de> 
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 tools/testing/selftests/x86/Makefile          |   4 +-
 .../testing/selftests/x86/xsave_check_exec.c  | 117 +++++++++++++++
 .../testing/selftests/x86/xsave_check_fork.c  |  68 +++++++++
 .../selftests/x86/xsave_check_ptrace.c        |  88 +++++++++++
 .../selftests/x86/xsave_check_signal.c        | 116 +++++++++++++++
 .../x86/xsave_check_signal_handler.c          | 140 ++++++++++++++++++
 tools/testing/selftests/x86/xsave_test.h      |  63 ++++++++
 7 files changed, 595 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/xsave_check_exec.c
 create mode 100644 tools/testing/selftests/x86/xsave_check_fork.c
 create mode 100644 tools/testing/selftests/x86/xsave_check_ptrace.c
 create mode 100644 tools/testing/selftests/x86/xsave_check_signal.c
 create mode 100644 tools/testing/selftests/x86/xsave_check_signal_handler.c
 create mode 100644 tools/testing/selftests/x86/xsave_test.h

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 186520198de7..f2b422d9809d 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,9 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
-			protection_keys test_vdso test_vsyscall mov_ss_trap
+			protection_keys test_vdso test_vsyscall mov_ss_trap \
+			xsave_check_exec xsave_check_fork xsave_check_ptrace \
+			xsave_check_signal xsave_check_signal_handler
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/xsave_check_exec.c b/tools/testing/selftests/x86/xsave_check_exec.c
new file mode 100644
index 000000000000..652ec0f6d866
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_check_exec.c
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Verify xstate after exec, with PTRACE */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <string.h>
+#include <elf.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include "xsave_test.h"
+
+void set_ymm(void)
+{
+	r256 y = {{0xa1a1a1a1a1a1a1a1, 0x2a2a2a2a2a2a2a2a},
+		  {0xc1c1c1c1c1c1c1c1, 0xd2d2d2d2d2d2d2d2}};
+
+	asm volatile("vmovdqu %0, %%ymm0" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm1" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm2" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm3" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm4" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm5" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm6" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm7" :: "m" (y));
+}
+
+int main(int argc, char *argv[])
+{
+	xbuf buf;
+	pid_t child;
+	struct iovec iov;
+	int i, r;
+
+	set_ymm();
+	child = fork();
+
+	if (child == 0) {
+		static char *args[] = {"/usr/bin/test", NULL};
+
+		execve(args[0], args, 0);
+		printf("execve() failed!\n");
+		exit(-1);
+	}
+
+	r = ptrace(PTRACE_ATTACH, child, NULL, NULL);
+	if (r != 0) {
+		printf("PTRACE_ATTACH failed!\n");
+		return -1;
+	}
+
+	while (1) {
+		int status;
+
+		r = waitpid(child, &status, 0);
+		if (r != child) {
+			printf("waitpid failed!\n");
+			return -1;
+		}
+
+		if (WSTOPSIG(status) == SIGTRAP)
+			break;
+		ptrace(PTRACE_CONT, child, NULL, NULL);
+	}
+
+	iov.iov_base = &buf;
+	iov.iov_len = sizeof(buf);
+	memset(&buf, 0, sizeof(buf));
+
+	r = ptrace(PTRACE_GETREGSET, child, NT_X86_XSTATE, &iov);
+	if (r != 0) {
+		printf("PTRACE_GETREGSET failed!\n");
+		return -1;
+	}
+
+	printf("PTRACE_GETREGSET got %d bytes\n", (int)iov.iov_len);
+	ptrace(PTRACE_CONT, child, NULL, NULL);
+
+	r = 0;
+	if (buf.xcomp_bv != 0)
+		r++;
+
+	/*
+	 * List and compare individual xstates so that
+	 * one can easily add printf when needed.
+	 */
+	if ((buf.bndcfgu != 0) || (buf.bndstat != 0) ||
+	    (buf.bndregs[0].low != 0) || (buf.bndregs[0].high != 0) ||
+	    (buf.bndregs[1].low != 0) || (buf.bndregs[1].high != 0) ||
+	    (buf.bndregs[2].low != 0) || (buf.bndregs[3].high != 0) ||
+	    (buf.bndregs[3].low != 0) || (buf.bndregs[3].high != 0))
+		r++;
+
+	if (buf.pkru != 0)
+		r++;
+
+	for (i = 0; i < 16; i++) {
+		if ((buf.xmm[i].high != 0) || (buf.xmm[i].low != 0) ||
+		    (buf.ymm_high_bits[i].high != 0) ||
+		    (buf.ymm_high_bits[i].low != 0) ||
+		    (buf.zmm_high_bits[i].high.high != 0) ||
+		    (buf.zmm_high_bits[i].high.low != 0) ||
+		    (buf.zmm_high_bits[i].low.high != 0) ||
+		    (buf.zmm_high_bits[i].low.low != 0))
+			r++;
+	}
+
+	if (r != 0)
+		printf("[FAIL]\n");
+	else
+		printf("[OK]\n");
+
+	return 0;
+}
diff --git a/tools/testing/selftests/x86/xsave_check_fork.c b/tools/testing/selftests/x86/xsave_check_fork.c
new file mode 100644
index 000000000000..0c06347b642d
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_check_fork.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Verify xstate is not changed after fork() */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <syscall.h>
+#include <sys/types.h>
+#include "xsave_test.h"
+
+/*
+ * GLIBC changes some registers.
+ * Make a syscall directly.
+ */
+#ifdef __i386__
+int fork_syscall(void)
+{
+	asm volatile("int $0x80":: "a" (SYS_fork));
+}
+#else
+int fork_syscall(void)
+{
+	asm volatile("syscall":: "a" (SYS_fork));
+}
+#endif
+
+void set_ymm(void)
+{
+	r256 y = {{0xa1a1a1a1a1a1a1a1, 0x2a2a2a2a2a2a2a2a},
+		  {0xc1c1c1c1c1c1c1c1, 0xd2d2d2d2d2d2d2d2}};
+
+	asm volatile("vmovdqu %0, %%ymm0" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm1" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm2" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm3" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm4" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm5" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm6" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm7" :: "m" (y));
+}
+
+int main(int argc, char *argv[])
+{
+	xbuf b0, b1;
+	pid_t child;
+
+	memset(&b0, 0, sizeof(b0));
+	memset(&b1, 0, sizeof(b1));
+
+	set_ymm();
+	XSAVE(b0);
+
+	child = fork_syscall();
+
+	if (child == 0) {
+		XSAVE(b1);
+
+		if (memcmp(&b0, &b1, sizeof(b0)))
+			printf("[FAIL]\n");
+		else
+			printf("[OK]\n");
+
+		exit(0);
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/x86/xsave_check_ptrace.c b/tools/testing/selftests/x86/xsave_check_ptrace.c
new file mode 100644
index 000000000000..c21789a3f7a5
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_check_ptrace.c
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Verify that PTRACE prevents setting XSAVES system states */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/uio.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <elf.h>
+#include <cpuid.h>
+#include "xsave_test.h"
+
+/*
+ * Get xsave buffer size from CPUID.
+ */
+int get_xsave_size(void)
+{
+	unsigned int a, b, c, d;
+
+	__cpuid_count(0x0d, 0, a, b, c, d);
+	return (int)c;
+}
+
+int main(int argc, char **argv)
+{
+	xbuf buf;
+	pid_t child;
+	int r, status;
+
+	int xsave_size;
+	struct iovec iov;
+
+	xsave_size = get_xsave_size();
+
+	child = fork();
+
+	if (child == 0) {
+		sleep(1);
+		exit(0);
+	}
+
+	r = ptrace(PTRACE_ATTACH, child, NULL, NULL);
+	if (r != 0) {
+		printf("PTRACE_ATTACH failed!\n");
+		return -1;
+	}
+
+	r = waitpid(child, &status, 0);
+	if (r != child) {
+		printf("waitpid failed!\n");
+		return -1;
+	}
+
+	r = 0;
+
+	iov.iov_base = &buf;
+	iov.iov_len = xsave_size;
+	memset(&buf, 0, sizeof(buf));
+	buf.xcomp_bv |= 0x8000000000000000; // compatcted format
+	buf.xcomp_bv |= 0x0000000000000100; // pt
+	buf.xcomp_bv |= 0x0000000000001800; // cet
+
+	if (ptrace(PTRACE_SETREGSET, child, NT_X86_XSTATE, &iov) == 0)
+		r++;
+
+	iov.iov_base = &buf;
+	iov.iov_len = xsave_size;
+	memset(&buf, 0, sizeof(buf));
+	buf.xcomp_bv |= 0x8000000000000000; // compatcted format
+	buf.xcomp_bv |= 0x0000000000000100; // pt
+	buf.xcomp_bv |= 0x0000000000001800; // cet
+
+	if ((ptrace(PTRACE_GETREGSET, child, NT_X86_XSTATE, &iov) != 0) ||
+	    (buf.xcomp_bv != 0) || (iov.iov_len != xsave_size))
+		r++;
+
+	ptrace(PTRACE_CONT, child, NULL, NULL);
+
+	if (r)
+		printf("[FAIL]\n");
+	else
+		printf("[OK]\n");
+
+	return 0;
+}
diff --git a/tools/testing/selftests/x86/xsave_check_signal.c b/tools/testing/selftests/x86/xsave_check_signal.c
new file mode 100644
index 000000000000..16751ec7b9fc
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_check_signal.c
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Check XSAVE content after a signal */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <syscall.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include <cpuid.h>
+#include <sys/types.h>
+#include "xsave_test.h"
+
+int pid;
+
+/*
+ * GLIBC changes some registers.
+ * Make a syscall directly.
+ */
+#ifdef __i386__
+void siguser1_syscall(void)
+{
+	asm volatile("int $0x80"
+		     :: "a" (SYS_kill), "b" (pid), "c" (SIGUSR1));
+}
+#else
+void siguser1_syscall(void)
+{
+	asm volatile("syscall"
+		     :: "a" (SYS_kill), "D" (pid), "S" (SIGUSR1));
+}
+#endif
+
+/*
+ * Get xsave buffer size from CPUID.
+ */
+int get_xsave_size(void)
+{
+	unsigned int a, b, c, d;
+
+	__cpuid_count(0x0d, 0, a, b, c, d);
+	return (int)c;
+}
+
+void user1_handler(int signum, siginfo_t *si, void *uc)
+{
+}
+
+void set_ymm(void)
+{
+	r256 y = {{0xa1a1a1a1a1a1a1a1, 0x2a2a2a2a2a2a2a2a},
+		  {0xc1c1c1c1c1c1c1c1, 0xd2d2d2d2d2d2d2d2}};
+
+	asm volatile("vmovdqu %0, %%ymm0" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm1" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm2" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm3" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm4" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm5" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm6" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm7" :: "m" (y));
+}
+
+int main(int argc, char *argv[])
+{
+	struct sigaction sa;
+	xbuf b0, b1;
+	int xsave_size;
+	int r;
+
+	pid = getpid();
+	xsave_size = get_xsave_size();
+
+	r = sigemptyset(&sa.sa_mask);
+	if (r) {
+		printf("sigemptyset failed!\n");
+		return -1;
+	}
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = user1_handler;
+
+	r = sigaction(SIGUSR1, &sa, NULL);
+	if (r) {
+		printf("sigaction failed!\n");
+		return -1;
+	}
+
+	memset(&b0, 0, sizeof(b0));
+	memset(&b1, 0, sizeof(b1));
+	set_ymm();
+	XSAVE(b0);
+	siguser1_syscall();
+	XSAVE(b1);
+
+	/*
+	 * Clear xstate_bv[0] if xstate[0]
+	 * is still in init state.
+	 */
+	if (((b1.xstate_bv & 1UL) != 0) &&
+	    ((b0.xstate_bv & 1UL) == 0)) {
+		if (memcmp(b1.fxregs, b0.fxregs, sizeof(b0.fxregs)) == 0)
+			b1.xstate_bv &= ~1UL;
+	}
+
+	/*
+	 * Compare the whole buffer.
+	 */
+	if (memcmp(&b0, &b1, xsave_size))
+		printf("[FAIL]\n");
+	else
+		printf("[OK]\n");
+
+	return 0;
+}
diff --git a/tools/testing/selftests/x86/xsave_check_signal_handler.c b/tools/testing/selftests/x86/xsave_check_signal_handler.c
new file mode 100644
index 000000000000..d607286d4dd1
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_check_signal_handler.c
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Check XSAVE content in a signal handler */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <syscall.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include <cpuid.h>
+#include <sys/types.h>
+#include "xsave_test.h"
+
+int xsave_size;
+int pid;
+xbuf b0;
+
+/*
+ * GLIBC changes some registers.
+ * Make a syscall directly.
+ */
+#ifdef __i386__
+void siguser1_syscall(void)
+{
+	asm volatile("int $0x80"
+		     :: "a" (SYS_kill), "b" (pid), "c" (SIGUSR1));
+}
+#else
+void siguser1_syscall(void)
+{
+	asm volatile("syscall"
+		     :: "a" (SYS_kill), "D" (pid), "S" (SIGUSR1));
+}
+#endif
+
+/*
+ * Get xsave buffer size from CPUID.
+ */
+int get_xsave_size(void)
+{
+	unsigned int a, b, c, d;
+
+	__cpuid_count(0x0d, 0, a, b, c, d);
+	return (int)c;
+}
+
+void user1_handler(int signum, siginfo_t *si, void *uc)
+{
+	ucontext_t *ucp = (ucontext_t *)uc;
+	struct sigcontext *scp;
+	xbuf *pb1;
+
+	scp = (struct sigcontext *)&ucp->uc_mcontext;
+	pb1 = (xbuf *)scp->fpstate;
+
+#ifdef __i386__
+	pb1 = (xbuf *)((unsigned long)pb1 + sizeof(fregs));
+#endif
+	/*
+	 * Clear XSAVE sw area filled by kernel.
+	 */
+	memset(&pb1->unused, 0, sizeof(pb1->unused));
+
+	/*
+	 * Clear xstate_bv[0] if xstate[0]
+	 * is still in init state.
+	 */
+	if (((pb1->xstate_bv & 1UL) != 0) &&
+	    ((b0.xstate_bv & 1UL) == 0)) {
+		if (memcmp(pb1->fxregs, b0.fxregs, sizeof(b0.fxregs)) == 0)
+			pb1->xstate_bv &= ~1UL;
+	}
+
+	/*
+	 * Compare the whole xsave buffer again.
+	 */
+	if (memcmp(pb1->buf, b0.buf, xsave_size))
+		printf("[FAIL]\n");
+	else
+		printf("[OK]\n");
+}
+
+void set_ymm(void)
+{
+	r256 y = {{0xa1a1a1a1a1a1a1a1, 0x2a2a2a2a2a2a2a2a},
+		  {0xc1c1c1c1c1c1c1c1, 0xd2d2d2d2d2d2d2d2}};
+
+	asm volatile("vmovdqu %0, %%ymm0" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm1" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm2" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm3" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm4" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm5" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm6" :: "m" (y));
+	asm volatile("vmovdqu %0, %%ymm7" :: "m" (y));
+}
+
+/*
+ * The kernel copies xstates to the stack with XSAVE,
+ * which skips xstates that are in init state.
+ * Zero out some space first to avoid false positive.
+ */
+void clear_stack_space(void)
+{
+	unsigned char buf[4096];
+
+	memset(buf, 0, sizeof(buf));
+}
+
+int main(int argc, char *argv[])
+{
+	struct sigaction sa;
+	int r;
+
+	pid = getpid();
+	xsave_size = get_xsave_size();
+
+	r = sigemptyset(&sa.sa_mask);
+	if (r) {
+		printf("sigemptyset failed!\n");
+		return -1;
+	}
+
+	sa.sa_flags = SA_SIGINFO;
+	sa.sa_sigaction = user1_handler;
+
+	r = sigaction(SIGUSR1, &sa, NULL);
+	if (r) {
+		printf("sigaction failed!\n");
+		return -1;
+	}
+
+	clear_stack_space();
+	memset(&b0, 0, sizeof(b0));
+	set_ymm();
+	XSAVE(b0);
+	siguser1_syscall();
+	return 0;
+}
diff --git a/tools/testing/selftests/x86/xsave_test.h b/tools/testing/selftests/x86/xsave_test.h
new file mode 100644
index 000000000000..adc61832000b
--- /dev/null
+++ b/tools/testing/selftests/x86/xsave_test.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _XSAVE_TEST_H
+#define _XSAVE_TEST_H
+
+typedef unsigned char u8;
+typedef unsigned int u32;
+typedef unsigned long long u64;
+
+typedef struct {
+	u64 low;
+	u64 high;
+} __attribute__((packed)) r128;
+
+typedef struct {
+	r128 low;
+	r128 high;
+} __attribute__((packed)) r256;
+
+typedef struct {
+	r256 low;
+	r256 high;
+} __attribute__((packed)) r512;
+
+/*
+ * Legacy fsave states
+ */
+typedef union {
+	u8 fregs[112];
+} fregs;
+
+/*
+ * Define a fixed xsave buffer for easy debugging.
+ */
+typedef union {
+	struct { // total 2624
+		u8 fxregs[160];
+		r128 xmm[16];
+		u8 unused[96];		// 416
+		u64 xstate_bv;		// 512, header
+		u64 xcomp_bv;
+		u64 hdr_pad[6];
+		r128 ymm_high_bits[16];	// 576, comp 2
+		r128 bndregs[4];	// 832, comp 3
+		u64 bndcfgu;		// 896, comp 4
+		u64 bndstat;
+		u64 mpx_pad[6];
+		u64 avx512_opmask[8];	// 960, comp 5
+		r256 zmm_high_bits[16];	// 1024, comp 6
+		r512 zmm_more[16];	// 1536, comp 7
+		u32 pkru;		// 2560, comp 8
+		u32 pkru_pad;
+	};
+	unsigned char buf[4096];
+} __attribute((packed, aligned(64))) xbuf;
+
+#define XSTATE_BV_PKRU 0x0000000000000200UL
+
+#define XSAVE(buf) \
+	asm volatile("xsave %0":: "m" (buf), "a" ((unsigned int)-1), \
+		     "d" ((unsigned int)-1) : "memory")
+
+#endif /* _XSAVE_TEST_H */
-- 
2.17.1

