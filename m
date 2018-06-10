Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wl4QEHrEHFsgeQAAmS7hNA
	; Sun, 10 Jun 2018 06:26:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0D92D60850; Sun, 10 Jun 2018 06:26:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 24D37604D4;
	Sun, 10 Jun 2018 06:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24D37604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbeFJGZu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:25:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35766 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753669AbeFJGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:25:48 -0400
Received: from [217.76.163.81] (helo=nanos.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fRtnN-0007rI-2d; Sun, 10 Jun 2018 08:25:45 +0200
Date: Sun, 10 Jun 2018 08:25:43 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] core: Restartable sequence syscall
Message-ID: <alpine.DEB.2.21.1806100816310.1606@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core-rseq-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rseq-for-linus

The restartable sequences syscall (finally):

  After a lot of back and forth discussion and massive delays caused by the
  speculative distraction of maintainers, the core set of restartable
  sequences has finally reached a consensus.

  It comes with the basic non disputed core implementation along with
  support for arm, powerpc and x86 and a full set of selftests

  It was exposed to linux-next earlier this week, so it does not fully
  comply with the merge window requirements, but there is really no point
  to drag it out for yet another cycle.

Thanks,

	tglx

------------------>
Boqun Feng (3):
      powerpc: Add support for restartable sequences
      powerpc: Add syscall detection for restartable sequences
      powerpc: Wire up restartable sequences system call

Mathieu Desnoyers (13):
      uapi/headers: Provide types_32_64.h
      rseq: Introduce restartable sequences system call
      arm: Add restartable sequences support
      arm: Add syscall detection for restartable sequences
      arm: Wire up restartable sequences system call
      x86: Add support for restartable sequences
      x86: Wire up restartable sequence system call
      selftests/lib.mk: Introduce OVERRIDE_TARGETS
      rseq/selftests: Provide rseq library
      rseq/selftests: Provide basic test
      rseq/selftests: Provide basic percpu ops test
      rseq/selftests: Provide parametrized tests
      rseq/selftests: Provide Makefile, scripts, gitignore


 MAINTAINERS                                        |   12 +
 arch/Kconfig                                       |    7 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/kernel/entry-common.S                     |   25 +-
 arch/arm/kernel/signal.c                           |   14 +
 arch/arm/tools/syscall.tbl                         |    1 +
 arch/powerpc/Kconfig                               |    1 +
 arch/powerpc/include/asm/systbl.h                  |    1 +
 arch/powerpc/include/asm/unistd.h                  |    2 +-
 arch/powerpc/include/uapi/asm/unistd.h             |    1 +
 arch/powerpc/kernel/entry_32.S                     |    7 +
 arch/powerpc/kernel/entry_64.S                     |    8 +
 arch/powerpc/kernel/signal.c                       |    3 +
 arch/x86/Kconfig                                   |    1 +
 arch/x86/entry/common.c                            |    3 +
 arch/x86/entry/syscalls/syscall_32.tbl             |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |    1 +
 arch/x86/kernel/signal.c                           |    6 +
 fs/exec.c                                          |    1 +
 include/linux/sched.h                              |  134 +++
 include/linux/syscalls.h                           |    4 +-
 include/trace/events/rseq.h                        |   57 +
 include/uapi/linux/rseq.h                          |  133 +++
 include/uapi/linux/types_32_64.h                   |   50 +
 init/Kconfig                                       |   23 +
 kernel/Makefile                                    |    1 +
 kernel/fork.c                                      |    2 +
 kernel/rseq.c                                      |  357 ++++++
 kernel/sched/core.c                                |    2 +
 kernel/sys_ni.c                                    |    3 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/lib.mk                     |    4 +
 tools/testing/selftests/rseq/.gitignore            |    6 +
 tools/testing/selftests/rseq/Makefile              |   30 +
 .../testing/selftests/rseq/basic_percpu_ops_test.c |  312 +++++
 tools/testing/selftests/rseq/basic_test.c          |   56 +
 tools/testing/selftests/rseq/param_test.c          | 1260 ++++++++++++++++++++
 tools/testing/selftests/rseq/rseq-arm.h            |  715 +++++++++++
 tools/testing/selftests/rseq/rseq-ppc.h            |  671 +++++++++++
 tools/testing/selftests/rseq/rseq-skip.h           |   65 +
 tools/testing/selftests/rseq/rseq-x86.h            | 1132 ++++++++++++++++++
 tools/testing/selftests/rseq/rseq.c                |  117 ++
 tools/testing/selftests/rseq/rseq.h                |  147 +++
 tools/testing/selftests/rseq/run_param_test.sh     |  121 ++
 44 files changed, 5491 insertions(+), 8 deletions(-)
 create mode 100644 include/trace/events/rseq.h
 create mode 100644 include/uapi/linux/rseq.h
 create mode 100644 include/uapi/linux/types_32_64.h
 create mode 100644 kernel/rseq.c
 create mode 100644 tools/testing/selftests/rseq/.gitignore
 create mode 100644 tools/testing/selftests/rseq/Makefile
 create mode 100644 tools/testing/selftests/rseq/basic_percpu_ops_test.c
 create mode 100644 tools/testing/selftests/rseq/basic_test.c
 create mode 100644 tools/testing/selftests/rseq/param_test.c
 create mode 100644 tools/testing/selftests/rseq/rseq-arm.h
 create mode 100644 tools/testing/selftests/rseq/rseq-ppc.h
 create mode 100644 tools/testing/selftests/rseq/rseq-skip.h
 create mode 100644 tools/testing/selftests/rseq/rseq-x86.h
 create mode 100644 tools/testing/selftests/rseq/rseq.c
 create mode 100644 tools/testing/selftests/rseq/rseq.h
 create mode 100644 tools/testing/selftests/rseq/run_param_test.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index aa635837a6af..e743b9dab0c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11976,6 +11976,18 @@ F:	include/dt-bindings/reset/
 F:	include/linux/reset.h
 F:	include/linux/reset-controller.h
 
+RESTARTABLE SEQUENCES SUPPORT
+M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+M:	Boqun Feng <boqun.feng@gmail.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	kernel/rseq.c
+F:	include/uapi/linux/rseq.h
+F:	include/trace/events/rseq.h
+F:	tools/testing/selftests/rseq/
+
 RFKILL
 M:	Johannes Berg <johannes@sipsolutions.net>
 L:	linux-wireless@vger.kernel.org
diff --git a/arch/Kconfig b/arch/Kconfig
index b695a3e3e922..095ba99968c1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -272,6 +272,13 @@ config HAVE_REGS_AND_STACK_ACCESS_API
 	  declared in asm/ptrace.h
 	  For example the kprobes-based event tracer needs this API.
 
+config HAVE_RSEQ
+	bool
+	depends on HAVE_REGS_AND_STACK_ACCESS_API
+	help
+	  This symbol should be selected by an architecture if it
+	  supports an implementation of restartable sequences.
+
 config HAVE_CLK
 	bool
 	help
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c43f5bb55ac8..4fb45365c0ea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -90,6 +90,7 @@ config ARM
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE if (SMP && ARM_LPAE)
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 3c4f88701f22..b427ef8ec8c6 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -39,12 +39,13 @@ saved_pc	.req	lr
 
 	.section .entry.text,"ax",%progbits
 	.align	5
-#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING))
+#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING) || \
+	IS_ENABLED(CONFIG_DEBUG_RSEQ))
 /*
  * This is the fast syscall return path.  We do as little as possible here,
  * such as avoiding writing r0 to the stack.  We only use this path if we
- * have tracing and context tracking disabled - the overheads from those
- * features make this path too inefficient.
+ * have tracing, context tracking and rseq debug disabled - the overheads
+ * from those features make this path too inefficient.
  */
 ret_fast_syscall:
  UNWIND(.fnstart	)
@@ -71,14 +72,20 @@ fast_work_pending:
 	/* fall through to work_pending */
 #else
 /*
- * The "replacement" ret_fast_syscall for when tracing or context tracking
- * is enabled.  As we will need to call out to some C functions, we save
- * r0 first to avoid needing to save registers around each C function call.
+ * The "replacement" ret_fast_syscall for when tracing, context tracking,
+ * or rseq debug is enabled.  As we will need to call out to some C functions,
+ * we save r0 first to avoid needing to save registers around each C function
+ * call.
  */
 ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
+#if IS_ENABLED(CONFIG_DEBUG_RSEQ)
+	/* do_rseq_syscall needs interrupts enabled. */
+	mov	r0, sp				@ 'regs'
+	bl	do_rseq_syscall
+#endif
 	disable_irq_notrace			@ disable interrupts
 	ldr	r2, [tsk, #TI_ADDR_LIMIT]
 	cmp	r2, #TASK_SIZE
@@ -113,6 +120,12 @@ ENDPROC(ret_fast_syscall)
  */
 ENTRY(ret_to_user)
 ret_slow_syscall:
+#if IS_ENABLED(CONFIG_DEBUG_RSEQ)
+	/* do_rseq_syscall needs interrupts enabled. */
+	enable_irq_notrace			@ enable interrupts
+	mov	r0, sp				@ 'regs'
+	bl	do_rseq_syscall
+#endif
 	disable_irq_notrace			@ disable interrupts
 ENTRY(ret_to_user_from_irq)
 	ldr	r2, [tsk, #TI_ADDR_LIMIT]
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index bd8810d4acb3..f09e9d66d605 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -540,6 +540,12 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *oldset = sigmask_to_save();
 	int ret;
 
+	/*
+	 * Increment event counter and perform fixup for the pre-signal
+	 * frame.
+	 */
+	rseq_signal_deliver(regs);
+
 	/*
 	 * Set up the stack frame
 	 */
@@ -660,6 +666,7 @@ do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 			} else {
 				clear_thread_flag(TIF_NOTIFY_RESUME);
 				tracehook_notify_resume(regs);
+				rseq_handle_notify_resume(regs);
 			}
 		}
 		local_irq_disable();
@@ -703,3 +710,10 @@ asmlinkage void addr_limit_check_failed(void)
 {
 	addr_limit_user_check();
 }
+
+#ifdef CONFIG_DEBUG_RSEQ
+asmlinkage void do_rseq_syscall(struct pt_regs *regs)
+{
+	rseq_syscall(regs);
+}
+#endif
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 0bb0e9c6376c..fbc74b5fa3ed 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -412,3 +412,4 @@
 395	common	pkey_alloc		sys_pkey_alloc
 396	common	pkey_free		sys_pkey_free
 397	common	statx			sys_statx
+398	common	rseq			sys_rseq
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f674006dea2f..b6c0029389fe 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -216,6 +216,7 @@ config PPC
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_RSEQ
 	select IOMMU_HELPER			if PPC64
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index d61f9c96d916..45d4d37495fd 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -392,3 +392,4 @@ SYSCALL(statx)
 SYSCALL(pkey_alloc)
 SYSCALL(pkey_free)
 SYSCALL(pkey_mprotect)
+SYSCALL(rseq)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index daf1ba97a00c..1e9708632dce 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		387
+#define NR_syscalls		388
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 389c36fd8299..ac5ba55066dd 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -398,5 +398,6 @@
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
+#define __NR_rseq		387
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index eb8d01bae8c6..973577f2141c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -365,6 +365,13 @@ syscall_dotrace_cont:
 	blrl			/* Call handler */
 	.globl	ret_from_syscall
 ret_from_syscall:
+#ifdef CONFIG_DEBUG_RSEQ
+	/* Check whether the syscall is issued inside a restartable sequence */
+	stw	r3,GPR3(r1)
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl      rseq_syscall
+	lwz	r3,GPR3(r1)
+#endif
 	mr	r6,r3
 	CURRENT_THREAD_INFO(r12, r1)
 	/* disable interrupts so current_thread_info()->flags can't change */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 51695608c68b..1c374387656a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -184,6 +184,14 @@ system_call:			/* label this so stack traces look sane */
 
 .Lsyscall_exit:
 	std	r3,RESULT(r1)
+
+#ifdef CONFIG_DEBUG_RSEQ
+	/* Check whether the syscall is issued inside a restartable sequence */
+	addi    r3,r1,STACK_FRAME_OVERHEAD
+	bl      rseq_syscall
+	ld	r3,RESULT(r1)
+#endif
+
 	CURRENT_THREAD_INFO(r12, r1)
 
 	ld	r8,_MSR(r1)
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 61db86ecd318..d3bb3aaaf5ac 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -133,6 +133,8 @@ static void do_signal(struct task_struct *tsk)
 	/* Re-enable the breakpoints for the signal stack */
 	thread_change_pc(tsk, tsk->thread.regs);
 
+	rseq_signal_deliver(tsk->thread.regs);
+
 	if (is32) {
         	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
 			ret = handle_rt_signal32(&ksig, oldset, tsk);
@@ -164,6 +166,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(regs);
 	}
 
 	user_enter();
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1fe24b624d44..c320ce005b02 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -182,6 +182,7 @@ config X86
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && UNWINDER_FRAME_POINTER && STACK_VALIDATION
 	select HAVE_STACK_VALIDATION		if X86_64
+	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index fbf6a6c3fd2d..92190879b228 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -164,6 +164,7 @@ static void exit_to_usermode_loop(struct pt_regs *regs, u32 cached_flags)
 		if (cached_flags & _TIF_NOTIFY_RESUME) {
 			clear_thread_flag(TIF_NOTIFY_RESUME);
 			tracehook_notify_resume(regs);
+			rseq_handle_notify_resume(regs);
 		}
 
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
@@ -254,6 +255,8 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
 	    WARN(irqs_disabled(), "syscall %ld left IRQs disabled", regs->orig_ax))
 		local_irq_enable();
 
+	rseq_syscall(regs);
+
 	/*
 	 * First do one-time work.  If these work items are enabled, we
 	 * want to run them exactly once per syscall exit with IRQs on.
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 14a2f996e543..3cf7b533b3d1 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -397,3 +397,4 @@
 383	i386	statx			sys_statx			__ia32_sys_statx
 384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents		__ia32_compat_sys_io_pgetevents
+386	i386	rseq			sys_rseq			__ia32_sys_rseq
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index cd36232ab62f..f0b1709a5ffb 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -342,6 +342,7 @@
 331	common	pkey_free		__x64_sys_pkey_free
 332	common	statx			__x64_sys_statx
 333	common	io_pgetevents		__x64_sys_io_pgetevents
+334	common	rseq			__x64_sys_rseq
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index da270b95fe4d..445ca11ff863 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -688,6 +688,12 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *set = sigmask_to_save();
 	compat_sigset_t *cset = (compat_sigset_t *) set;
 
+	/*
+	 * Increment event counter and perform fixup for the pre-signal
+	 * frame.
+	 */
+	rseq_signal_deliver(regs);
+
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
diff --git a/fs/exec.c b/fs/exec.c
index 183059c427b9..2c3911612b22 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1822,6 +1822,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 	membarrier_execve(current);
+	rseq_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current);
 	free_bprm(bprm);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 14e4f9c12337..3aa4fcb74e76 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -27,6 +27,7 @@
 #include <linux/signal_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
+#include <linux/rseq.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -1047,6 +1048,17 @@ struct task_struct {
 	unsigned long			numa_pages_migrated;
 #endif /* CONFIG_NUMA_BALANCING */
 
+#ifdef CONFIG_RSEQ
+	struct rseq __user *rseq;
+	u32 rseq_len;
+	u32 rseq_sig;
+	/*
+	 * RmW on rseq_event_mask must be performed atomically
+	 * with respect to preemption.
+	 */
+	unsigned long rseq_event_mask;
+#endif
+
 	struct tlbflush_unmap_batch	tlb_ubc;
 
 	struct rcu_head			rcu;
@@ -1757,4 +1769,126 @@ extern long sched_getaffinity(pid_t pid, struct cpumask *mask);
 #define TASK_SIZE_OF(tsk)	TASK_SIZE
 #endif
 
+#ifdef CONFIG_RSEQ
+
+/*
+ * Map the event mask on the user-space ABI enum rseq_cs_flags
+ * for direct mask checks.
+ */
+enum rseq_event_mask_bits {
+	RSEQ_EVENT_PREEMPT_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT,
+	RSEQ_EVENT_SIGNAL_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT,
+	RSEQ_EVENT_MIGRATE_BIT	= RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT,
+};
+
+enum rseq_event_mask {
+	RSEQ_EVENT_PREEMPT	= (1U << RSEQ_EVENT_PREEMPT_BIT),
+	RSEQ_EVENT_SIGNAL	= (1U << RSEQ_EVENT_SIGNAL_BIT),
+	RSEQ_EVENT_MIGRATE	= (1U << RSEQ_EVENT_MIGRATE_BIT),
+};
+
+static inline void rseq_set_notify_resume(struct task_struct *t)
+{
+	if (t->rseq)
+		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+}
+
+void __rseq_handle_notify_resume(struct pt_regs *regs);
+
+static inline void rseq_handle_notify_resume(struct pt_regs *regs)
+{
+	if (current->rseq)
+		__rseq_handle_notify_resume(regs);
+}
+
+static inline void rseq_signal_deliver(struct pt_regs *regs)
+{
+	preempt_disable();
+	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
+	preempt_enable();
+	rseq_handle_notify_resume(regs);
+}
+
+/* rseq_preempt() requires preemption to be disabled. */
+static inline void rseq_preempt(struct task_struct *t)
+{
+	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
+	rseq_set_notify_resume(t);
+}
+
+/* rseq_migrate() requires preemption to be disabled. */
+static inline void rseq_migrate(struct task_struct *t)
+{
+	__set_bit(RSEQ_EVENT_MIGRATE_BIT, &t->rseq_event_mask);
+	rseq_set_notify_resume(t);
+}
+
+/*
+ * If parent process has a registered restartable sequences area, the
+ * child inherits. Only applies when forking a process, not a thread. In
+ * case a parent fork() in the middle of a restartable sequence, set the
+ * resume notifier to force the child to retry.
+ */
+static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
+{
+	if (clone_flags & CLONE_THREAD) {
+		t->rseq = NULL;
+		t->rseq_len = 0;
+		t->rseq_sig = 0;
+		t->rseq_event_mask = 0;
+	} else {
+		t->rseq = current->rseq;
+		t->rseq_len = current->rseq_len;
+		t->rseq_sig = current->rseq_sig;
+		t->rseq_event_mask = current->rseq_event_mask;
+		rseq_preempt(t);
+	}
+}
+
+static inline void rseq_execve(struct task_struct *t)
+{
+	t->rseq = NULL;
+	t->rseq_len = 0;
+	t->rseq_sig = 0;
+	t->rseq_event_mask = 0;
+}
+
+#else
+
+static inline void rseq_set_notify_resume(struct task_struct *t)
+{
+}
+static inline void rseq_handle_notify_resume(struct pt_regs *regs)
+{
+}
+static inline void rseq_signal_deliver(struct pt_regs *regs)
+{
+}
+static inline void rseq_preempt(struct task_struct *t)
+{
+}
+static inline void rseq_migrate(struct task_struct *t)
+{
+}
+static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
+{
+}
+static inline void rseq_execve(struct task_struct *t)
+{
+}
+
+#endif
+
+#ifdef CONFIG_DEBUG_RSEQ
+
+void rseq_syscall(struct pt_regs *regs);
+
+#else
+
+static inline void rseq_syscall(struct pt_regs *regs)
+{
+}
+
+#endif
+
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 390e814fdc8d..73810808cdf2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -66,6 +66,7 @@ struct old_linux_dirent;
 struct perf_event_attr;
 struct file_handle;
 struct sigaltstack;
+struct rseq;
 union bpf_attr;
 
 #include <linux/types.h>
@@ -897,7 +898,8 @@ asmlinkage long sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 asmlinkage long sys_pkey_free(int pkey);
 asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
-
+asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
+			 int flags, uint32_t sig);
 
 /*
  * Architecture-specific system calls
diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
new file mode 100644
index 000000000000..a04a64bc1a00
--- /dev/null
+++ b/include/trace/events/rseq.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rseq
+
+#if !defined(_TRACE_RSEQ_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RSEQ_H
+
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+
+TRACE_EVENT(rseq_update,
+
+	TP_PROTO(struct task_struct *t),
+
+	TP_ARGS(t),
+
+	TP_STRUCT__entry(
+		__field(s32, cpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = raw_smp_processor_id();
+	),
+
+	TP_printk("cpu_id=%d", __entry->cpu_id)
+);
+
+TRACE_EVENT(rseq_ip_fixup,
+
+	TP_PROTO(unsigned long regs_ip, unsigned long start_ip,
+		unsigned long post_commit_offset, unsigned long abort_ip),
+
+	TP_ARGS(regs_ip, start_ip, post_commit_offset, abort_ip),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, regs_ip)
+		__field(unsigned long, start_ip)
+		__field(unsigned long, post_commit_offset)
+		__field(unsigned long, abort_ip)
+	),
+
+	TP_fast_assign(
+		__entry->regs_ip = regs_ip;
+		__entry->start_ip = start_ip;
+		__entry->post_commit_offset = post_commit_offset;
+		__entry->abort_ip = abort_ip;
+	),
+
+	TP_printk("regs_ip=0x%lx start_ip=0x%lx post_commit_offset=%lu abort_ip=0x%lx",
+		__entry->regs_ip, __entry->start_ip,
+		__entry->post_commit_offset, __entry->abort_ip)
+);
+
+#endif /* _TRACE_SOCK_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
new file mode 100644
index 000000000000..d620fa43756c
--- /dev/null
+++ b/include/uapi/linux/rseq.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_RSEQ_H
+#define _UAPI_LINUX_RSEQ_H
+
+/*
+ * linux/rseq.h
+ *
+ * Restartable sequences system call API
+ *
+ * Copyright (c) 2015-2018 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifdef __KERNEL__
+# include <linux/types.h>
+#else
+# include <stdint.h>
+#endif
+
+#include <linux/types_32_64.h>
+
+enum rseq_cpu_id_state {
+	RSEQ_CPU_ID_UNINITIALIZED		= -1,
+	RSEQ_CPU_ID_REGISTRATION_FAILED		= -2,
+};
+
+enum rseq_flags {
+	RSEQ_FLAG_UNREGISTER = (1 << 0),
+};
+
+enum rseq_cs_flags_bit {
+	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
+	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
+	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+};
+
+enum rseq_cs_flags {
+	RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT	=
+		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT),
+	RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL	=
+		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
+	RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE	=
+		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+};
+
+/*
+ * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line. It is usually declared as
+ * link-time constant data.
+ */
+struct rseq_cs {
+	/* Version of this structure. */
+	__u32 version;
+	/* enum rseq_cs_flags */
+	__u32 flags;
+	LINUX_FIELD_u32_u64(start_ip);
+	/* Offset from start_ip. */
+	LINUX_FIELD_u32_u64(post_commit_offset);
+	LINUX_FIELD_u32_u64(abort_ip);
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+/*
+ * struct rseq is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line.
+ *
+ * A single struct rseq per thread is allowed.
+ */
+struct rseq {
+	/*
+	 * Restartable sequences cpu_id_start field. Updated by the
+	 * kernel, and read by user-space with single-copy atomicity
+	 * semantics. Aligned on 32-bit. Always contains a value in the
+	 * range of possible CPUs, although the value may not be the
+	 * actual current CPU (e.g. if rseq is not initialized). This
+	 * CPU number value should always be compared against the value
+	 * of the cpu_id field before performing a rseq commit or
+	 * returning a value read from a data structure indexed using
+	 * the cpu_id_start value.
+	 */
+	__u32 cpu_id_start;
+	/*
+	 * Restartable sequences cpu_id field. Updated by the kernel,
+	 * and read by user-space with single-copy atomicity semantics.
+	 * Aligned on 32-bit. Values RSEQ_CPU_ID_UNINITIALIZED and
+	 * RSEQ_CPU_ID_REGISTRATION_FAILED have a special semantic: the
+	 * former means "rseq uninitialized", and latter means "rseq
+	 * initialization failed". This value is meant to be read within
+	 * rseq critical sections and compared with the cpu_id_start
+	 * value previously read, before performing the commit instruction,
+	 * or read and compared with the cpu_id_start value before returning
+	 * a value loaded from a data structure indexed using the
+	 * cpu_id_start value.
+	 */
+	__u32 cpu_id;
+	/*
+	 * Restartable sequences rseq_cs field.
+	 *
+	 * Contains NULL when no critical section is active for the current
+	 * thread, or holds a pointer to the currently active struct rseq_cs.
+	 *
+	 * Updated by user-space, which sets the address of the currently
+	 * active rseq_cs at the beginning of assembly instruction sequence
+	 * block, and set to NULL by the kernel when it restarts an assembly
+	 * instruction sequence block, as well as when the kernel detects that
+	 * it is preempting or delivering a signal outside of the range
+	 * targeted by the rseq_cs. Also needs to be set to NULL by user-space
+	 * before reclaiming memory that contains the targeted struct rseq_cs.
+	 *
+	 * Read and set by the kernel with single-copy atomicity semantics.
+	 * Set by user-space with single-copy atomicity semantics. Aligned
+	 * on 64-bit.
+	 */
+	LINUX_FIELD_u32_u64(rseq_cs);
+	/*
+	 * - RSEQ_DISABLE flag:
+	 *
+	 * Fallback fast-track flag for single-stepping.
+	 * Set by user-space if lack of progress is detected.
+	 * Cleared by user-space after rseq finish.
+	 * Read by the kernel.
+	 * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
+	 *     Inhibit instruction sequence block restart and event
+	 *     counter increment on preemption for this thread.
+	 * - RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
+	 *     Inhibit instruction sequence block restart and event
+	 *     counter increment on signal delivery for this thread.
+	 * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
+	 *     Inhibit instruction sequence block restart and event
+	 *     counter increment on migration for this thread.
+	 */
+	__u32 flags;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+#endif /* _UAPI_LINUX_RSEQ_H */
diff --git a/include/uapi/linux/types_32_64.h b/include/uapi/linux/types_32_64.h
new file mode 100644
index 000000000000..0a87ace34a57
--- /dev/null
+++ b/include/uapi/linux/types_32_64.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_TYPES_32_64_H
+#define _UAPI_LINUX_TYPES_32_64_H
+
+/*
+ * linux/types_32_64.h
+ *
+ * Integer type declaration for pointers across 32-bit and 64-bit systems.
+ *
+ * Copyright (c) 2015-2018 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifdef __KERNEL__
+# include <linux/types.h>
+#else
+# include <stdint.h>
+#endif
+
+#include <asm/byteorder.h>
+
+#ifdef __BYTE_ORDER
+# if (__BYTE_ORDER == __BIG_ENDIAN)
+#  define LINUX_BYTE_ORDER_BIG_ENDIAN
+# else
+#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
+# endif
+#else
+# ifdef __BIG_ENDIAN
+#  define LINUX_BYTE_ORDER_BIG_ENDIAN
+# else
+#  define LINUX_BYTE_ORDER_LITTLE_ENDIAN
+# endif
+#endif
+
+#ifdef __LP64__
+# define LINUX_FIELD_u32_u64(field)			__u64 field
+# define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	field = (intptr_t)v
+#else
+# ifdef LINUX_BYTE_ORDER_BIG_ENDIAN
+#  define LINUX_FIELD_u32_u64(field)	__u32 field ## _padding, field
+#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
+	field ## _padding = 0, field = (intptr_t)v
+# else
+#  define LINUX_FIELD_u32_u64(field)	__u32 field, field ## _padding
+#  define LINUX_FIELD_u32_u64_INIT_ONSTACK(field, v)	\
+	field = (intptr_t)v, field ## _padding = 0
+# endif
+#endif
+
+#endif /* _UAPI_LINUX_TYPES_32_64_H */
diff --git a/init/Kconfig b/init/Kconfig
index 18b151f0ddc1..33ec06fddaaa 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1417,6 +1417,29 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
 config ARCH_HAS_MEMBARRIER_SYNC_CORE
 	bool
 
+config RSEQ
+	bool "Enable rseq() system call" if EXPERT
+	default y
+	depends on HAVE_RSEQ
+	select MEMBARRIER
+	help
+	  Enable the restartable sequences system call. It provides a
+	  user-space cache for the current CPU number value, which
+	  speeds up getting the current CPU number from user-space,
+	  as well as an ABI to speed up user-space operations on
+	  per-CPU data.
+
+	  If unsure, say Y.
+
+config DEBUG_RSEQ
+	default n
+	bool "Enabled debugging of rseq() system call" if EXPERT
+	depends on RSEQ && DEBUG_KERNEL
+	help
+	  Enable extra debugging checks for the rseq system call.
+
+	  If unsure, say N.
+
 config EMBEDDED
 	bool "Embedded system"
 	option allnoconfig_y
diff --git a/kernel/Makefile b/kernel/Makefile
index f85ae5dfa474..7085c841c413 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -113,6 +113,7 @@ obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
 
 obj-$(CONFIG_HAS_IOMEM) += memremap.o
+obj-$(CONFIG_RSEQ) += rseq.o
 
 $(obj)/configs.o: $(obj)/config_data.h
 
diff --git a/kernel/fork.c b/kernel/fork.c
index a5d21c42acfc..70992bfeba81 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1899,6 +1899,8 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	copy_seccomp(p);
 
+	rseq_fork(p, clone_flags);
+
 	/*
 	 * Process group and session signals need to be delivered to just the
 	 * parent before the fork or both the parent and the child after the
diff --git a/kernel/rseq.c b/kernel/rseq.c
new file mode 100644
index 000000000000..ae306f90c514
--- /dev/null
+++ b/kernel/rseq.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Restartable sequences system call
+ *
+ * Copyright (C) 2015, Google, Inc.,
+ * Paul Turner <pjt@google.com> and Andrew Hunter <ahh@google.com>
+ * Copyright (C) 2015-2018, EfficiOS Inc.,
+ * Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/syscalls.h>
+#include <linux/rseq.h>
+#include <linux/types.h>
+#include <asm/ptrace.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/rseq.h>
+
+#define RSEQ_CS_PREEMPT_MIGRATE_FLAGS (RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE | \
+				       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT)
+
+/*
+ *
+ * Restartable sequences are a lightweight interface that allows
+ * user-level code to be executed atomically relative to scheduler
+ * preemption and signal delivery. Typically used for implementing
+ * per-cpu operations.
+ *
+ * It allows user-space to perform update operations on per-cpu data
+ * without requiring heavy-weight atomic operations.
+ *
+ * Detailed algorithm of rseq user-space assembly sequences:
+ *
+ *                     init(rseq_cs)
+ *                     cpu = TLS->rseq::cpu_id_start
+ *   [1]               TLS->rseq::rseq_cs = rseq_cs
+ *   [start_ip]        ----------------------------
+ *   [2]               if (cpu != TLS->rseq::cpu_id)
+ *                             goto abort_ip;
+ *   [3]               <last_instruction_in_cs>
+ *   [post_commit_ip]  ----------------------------
+ *
+ *   The address of jump target abort_ip must be outside the critical
+ *   region, i.e.:
+ *
+ *     [abort_ip] < [start_ip]  || [abort_ip] >= [post_commit_ip]
+ *
+ *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
+ *   userspace that can handle being interrupted between any of those
+ *   instructions, and then resumed to the abort_ip.
+ *
+ *   1.  Userspace stores the address of the struct rseq_cs assembly
+ *       block descriptor into the rseq_cs field of the registered
+ *       struct rseq TLS area. This update is performed through a single
+ *       store within the inline assembly instruction sequence.
+ *       [start_ip]
+ *
+ *   2.  Userspace tests to check whether the current cpu_id field match
+ *       the cpu number loaded before start_ip, branching to abort_ip
+ *       in case of a mismatch.
+ *
+ *       If the sequence is preempted or interrupted by a signal
+ *       at or after start_ip and before post_commit_ip, then the kernel
+ *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
+ *       ip to abort_ip before returning to user-space, so the preempted
+ *       execution resumes at abort_ip.
+ *
+ *   3.  Userspace critical section final instruction before
+ *       post_commit_ip is the commit. The critical section is
+ *       self-terminating.
+ *       [post_commit_ip]
+ *
+ *   4.  <success>
+ *
+ *   On failure at [2], or if interrupted by preempt or signal delivery
+ *   between [1] and [3]:
+ *
+ *       [abort_ip]
+ *   F1. <failure>
+ */
+
+static int rseq_update_cpu_id(struct task_struct *t)
+{
+	u32 cpu_id = raw_smp_processor_id();
+
+	if (__put_user(cpu_id, &t->rseq->cpu_id_start))
+		return -EFAULT;
+	if (__put_user(cpu_id, &t->rseq->cpu_id))
+		return -EFAULT;
+	trace_rseq_update(t);
+	return 0;
+}
+
+static int rseq_reset_rseq_cpu_id(struct task_struct *t)
+{
+	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
+
+	/*
+	 * Reset cpu_id_start to its initial state (0).
+	 */
+	if (__put_user(cpu_id_start, &t->rseq->cpu_id_start))
+		return -EFAULT;
+	/*
+	 * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user coming
+	 * in after unregistration can figure out that rseq needs to be
+	 * registered again.
+	 */
+	if (__put_user(cpu_id, &t->rseq->cpu_id))
+		return -EFAULT;
+	return 0;
+}
+
+static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
+{
+	struct rseq_cs __user *urseq_cs;
+	unsigned long ptr;
+	u32 __user *usig;
+	u32 sig;
+	int ret;
+
+	ret = __get_user(ptr, &t->rseq->rseq_cs);
+	if (ret)
+		return ret;
+	if (!ptr) {
+		memset(rseq_cs, 0, sizeof(*rseq_cs));
+		return 0;
+	}
+	urseq_cs = (struct rseq_cs __user *)ptr;
+	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
+		return -EFAULT;
+	if (rseq_cs->version > 0)
+		return -EINVAL;
+
+	/* Ensure that abort_ip is not in the critical section. */
+	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
+		return -EINVAL;
+
+	usig = (u32 __user *)(rseq_cs->abort_ip - sizeof(u32));
+	ret = get_user(sig, usig);
+	if (ret)
+		return ret;
+
+	if (current->rseq_sig != sig) {
+		printk_ratelimited(KERN_WARNING
+			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x (pid=%d, addr=%p).\n",
+			sig, current->rseq_sig, current->pid, usig);
+		return -EPERM;
+	}
+	return 0;
+}
+
+static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
+{
+	u32 flags, event_mask;
+	int ret;
+
+	/* Get thread flags. */
+	ret = __get_user(flags, &t->rseq->flags);
+	if (ret)
+		return ret;
+
+	/* Take critical section flags into account. */
+	flags |= cs_flags;
+
+	/*
+	 * Restart on signal can only be inhibited when restart on
+	 * preempt and restart on migrate are inhibited too. Otherwise,
+	 * a preempted signal handler could fail to restart the prior
+	 * execution context on sigreturn.
+	 */
+	if (unlikely((flags & RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL) &&
+		     (flags & RSEQ_CS_PREEMPT_MIGRATE_FLAGS) !=
+		     RSEQ_CS_PREEMPT_MIGRATE_FLAGS))
+		return -EINVAL;
+
+	/*
+	 * Load and clear event mask atomically with respect to
+	 * scheduler preemption.
+	 */
+	preempt_disable();
+	event_mask = t->rseq_event_mask;
+	t->rseq_event_mask = 0;
+	preempt_enable();
+
+	return !!(event_mask & ~flags);
+}
+
+static int clear_rseq_cs(struct task_struct *t)
+{
+	/*
+	 * The rseq_cs field is set to NULL on preemption or signal
+	 * delivery on top of rseq assembly block, as well as on top
+	 * of code outside of the rseq assembly block. This performs
+	 * a lazy clear of the rseq_cs field.
+	 *
+	 * Set rseq_cs to NULL with single-copy atomicity.
+	 */
+	return __put_user(0UL, &t->rseq->rseq_cs);
+}
+
+/*
+ * Unsigned comparison will be true when ip >= start_ip, and when
+ * ip < start_ip + post_commit_offset.
+ */
+static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
+{
+	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
+}
+
+static int rseq_ip_fixup(struct pt_regs *regs)
+{
+	unsigned long ip = instruction_pointer(regs);
+	struct task_struct *t = current;
+	struct rseq_cs rseq_cs;
+	int ret;
+
+	ret = rseq_get_rseq_cs(t, &rseq_cs);
+	if (ret)
+		return ret;
+
+	/*
+	 * Handle potentially not being within a critical section.
+	 * If not nested over a rseq critical section, restart is useless.
+	 * Clear the rseq_cs pointer and return.
+	 */
+	if (!in_rseq_cs(ip, &rseq_cs))
+		return clear_rseq_cs(t);
+	ret = rseq_need_restart(t, rseq_cs.flags);
+	if (ret <= 0)
+		return ret;
+	ret = clear_rseq_cs(t);
+	if (ret)
+		return ret;
+	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
+			    rseq_cs.abort_ip);
+	instruction_pointer_set(regs, (unsigned long)rseq_cs.abort_ip);
+	return 0;
+}
+
+/*
+ * This resume handler must always be executed between any of:
+ * - preemption,
+ * - signal delivery,
+ * and return to user-space.
+ *
+ * This is how we can ensure that the entire rseq critical section,
+ * consisting of both the C part and the assembly instruction sequence,
+ * will issue the commit instruction only if executed atomically with
+ * respect to other threads scheduled on the same CPU, and with respect
+ * to signal handlers.
+ */
+void __rseq_handle_notify_resume(struct pt_regs *regs)
+{
+	struct task_struct *t = current;
+	int ret;
+
+	if (unlikely(t->flags & PF_EXITING))
+		return;
+	if (unlikely(!access_ok(VERIFY_WRITE, t->rseq, sizeof(*t->rseq))))
+		goto error;
+	ret = rseq_ip_fixup(regs);
+	if (unlikely(ret < 0))
+		goto error;
+	if (unlikely(rseq_update_cpu_id(t)))
+		goto error;
+	return;
+
+error:
+	force_sig(SIGSEGV, t);
+}
+
+#ifdef CONFIG_DEBUG_RSEQ
+
+/*
+ * Terminate the process if a syscall is issued within a restartable
+ * sequence.
+ */
+void rseq_syscall(struct pt_regs *regs)
+{
+	unsigned long ip = instruction_pointer(regs);
+	struct task_struct *t = current;
+	struct rseq_cs rseq_cs;
+
+	if (!t->rseq)
+		return;
+	if (!access_ok(VERIFY_READ, t->rseq, sizeof(*t->rseq)) ||
+	    rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
+		force_sig(SIGSEGV, t);
+}
+
+#endif
+
+/*
+ * sys_rseq - setup restartable sequences for caller thread.
+ */
+SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
+		int, flags, u32, sig)
+{
+	int ret;
+
+	if (flags & RSEQ_FLAG_UNREGISTER) {
+		/* Unregister rseq for current thread. */
+		if (current->rseq != rseq || !current->rseq)
+			return -EINVAL;
+		if (current->rseq_len != rseq_len)
+			return -EINVAL;
+		if (current->rseq_sig != sig)
+			return -EPERM;
+		ret = rseq_reset_rseq_cpu_id(current);
+		if (ret)
+			return ret;
+		current->rseq = NULL;
+		current->rseq_len = 0;
+		current->rseq_sig = 0;
+		return 0;
+	}
+
+	if (unlikely(flags))
+		return -EINVAL;
+
+	if (current->rseq) {
+		/*
+		 * If rseq is already registered, check whether
+		 * the provided address differs from the prior
+		 * one.
+		 */
+		if (current->rseq != rseq || current->rseq_len != rseq_len)
+			return -EINVAL;
+		if (current->rseq_sig != sig)
+			return -EPERM;
+		/* Already registered. */
+		return -EBUSY;
+	}
+
+	/*
+	 * If there was no rseq previously registered,
+	 * ensure the provided rseq is properly aligned and valid.
+	 */
+	if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
+	    rseq_len != sizeof(*rseq))
+		return -EINVAL;
+	if (!access_ok(VERIFY_WRITE, rseq, rseq_len))
+		return -EFAULT;
+	current->rseq = rseq;
+	current->rseq_len = rseq_len;
+	current->rseq_sig = sig;
+	/*
+	 * If rseq was previously inactive, and has just been
+	 * registered, ensure the cpu_id_start and cpu_id fields
+	 * are updated before returning to user-space.
+	 */
+	rseq_set_notify_resume(current);
+
+	return 0;
+}
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e9866f86f304..a98d54cd5535 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1191,6 +1191,7 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 		if (p->sched_class->migrate_task_rq)
 			p->sched_class->migrate_task_rq(p);
 		p->se.nr_migrations++;
+		rseq_migrate(p);
 		perf_event_task_migrate(p);
 	}
 
@@ -2634,6 +2635,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
 {
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
+	rseq_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
 	prepare_task(next);
 	prepare_arch_switch(next);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 183169c2a75b..86f832d6ff6f 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -432,3 +432,6 @@ COND_SYSCALL(setresgid16);
 COND_SYSCALL(setresuid16);
 COND_SYSCALL(setreuid16);
 COND_SYSCALL(setuid16);
+
+/* restartable sequence */
+COND_SYSCALL(rseq);
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 32aafa92074c..593fb44c9cd4 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -28,6 +28,7 @@ TARGETS += powerpc
 TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
+TARGETS += rseq
 TARGETS += seccomp
 TARGETS += sigaltstack
 TARGETS += size
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index c1b1a4dc6a96..ceb6c7c48547 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -106,6 +106,9 @@ COMPILE.S = $(CC) $(ASFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
 LINK.S = $(CC) $(ASFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)
 endif
 
+# Selftest makefiles can override those targets by setting
+# OVERRIDE_TARGETS = 1.
+ifeq ($(OVERRIDE_TARGETS),)
 $(OUTPUT)/%:%.c
 	$(LINK.c) $^ $(LDLIBS) -o $@
 
@@ -114,5 +117,6 @@ $(OUTPUT)/%.o:%.S
 
 $(OUTPUT)/%:%.S
 	$(LINK.S) $^ $(LDLIBS) -o $@
+endif
 
 .PHONY: run_tests all clean install emit_tests
diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
new file mode 100644
index 000000000000..cc610da7e369
--- /dev/null
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -0,0 +1,6 @@
+basic_percpu_ops_test
+basic_test
+basic_rseq_op_test
+param_test
+param_test_benchmark
+param_test_compare_twice
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
new file mode 100644
index 000000000000..c30c52e1d0d2
--- /dev/null
+++ b/tools/testing/selftests/rseq/Makefile
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0+ OR MIT
+CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
+LDLIBS += -lpthread
+
+# Own dependencies because we only want to build against 1st prerequisite, but
+# still track changes to header files and depend on shared object.
+OVERRIDE_TARGETS = 1
+
+TEST_GEN_PROGS = basic_test basic_percpu_ops_test param_test \
+		param_test_benchmark param_test_compare_twice
+
+TEST_GEN_PROGS_EXTENDED = librseq.so
+
+TEST_PROGS = run_param_test.sh
+
+include ../lib.mk
+
+$(OUTPUT)/librseq.so: rseq.c rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -shared -fPIC $< $(LDLIBS) -o $@
+
+$(OUTPUT)/%: %.c $(TEST_GEN_PROGS_EXTENDED) rseq.h rseq-*.h
+	$(CC) $(CFLAGS) $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_benchmark: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DBENCHMARK $< $(LDLIBS) -lrseq -o $@
+
+$(OUTPUT)/param_test_compare_twice: param_test.c $(TEST_GEN_PROGS_EXTENDED) \
+					rseq.h rseq-*.h
+	$(CC) $(CFLAGS) -DRSEQ_COMPARE_TWICE $< $(LDLIBS) -lrseq -o $@
diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
new file mode 100644
index 000000000000..eb3f6db36d36
--- /dev/null
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stddef.h>
+
+#include "rseq.h"
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+struct percpu_lock_entry {
+	intptr_t v;
+} __attribute__((aligned(128)));
+
+struct percpu_lock {
+	struct percpu_lock_entry c[CPU_SETSIZE];
+};
+
+struct test_data_entry {
+	intptr_t count;
+} __attribute__((aligned(128)));
+
+struct spinlock_test_data {
+	struct percpu_lock lock;
+	struct test_data_entry c[CPU_SETSIZE];
+	int reps;
+};
+
+struct percpu_list_node {
+	intptr_t data;
+	struct percpu_list_node *next;
+};
+
+struct percpu_list_entry {
+	struct percpu_list_node *head;
+} __attribute__((aligned(128)));
+
+struct percpu_list {
+	struct percpu_list_entry c[CPU_SETSIZE];
+};
+
+/* A simple percpu spinlock.  Returns the cpu lock was acquired on. */
+int rseq_this_cpu_lock(struct percpu_lock *lock)
+{
+	int cpu;
+
+	for (;;) {
+		int ret;
+
+		cpu = rseq_cpu_start();
+		ret = rseq_cmpeqv_storev(&lock->c[cpu].v,
+					 0, 1, cpu);
+		if (rseq_likely(!ret))
+			break;
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	/*
+	 * Acquire semantic when taking lock after control dependency.
+	 * Matches rseq_smp_store_release().
+	 */
+	rseq_smp_acquire__after_ctrl_dep();
+	return cpu;
+}
+
+void rseq_percpu_unlock(struct percpu_lock *lock, int cpu)
+{
+	assert(lock->c[cpu].v == 1);
+	/*
+	 * Release lock, with release semantic. Matches
+	 * rseq_smp_acquire__after_ctrl_dep().
+	 */
+	rseq_smp_store_release(&lock->c[cpu].v, 0);
+}
+
+void *test_percpu_spinlock_thread(void *arg)
+{
+	struct spinlock_test_data *data = arg;
+	int i, cpu;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	for (i = 0; i < data->reps; i++) {
+		cpu = rseq_this_cpu_lock(&data->lock);
+		data->c[cpu].count++;
+		rseq_percpu_unlock(&data->lock, cpu);
+	}
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	return NULL;
+}
+
+/*
+ * A simple test which implements a sharded counter using a per-cpu
+ * lock.  Obviously real applications might prefer to simply use a
+ * per-cpu increment; however, this is reasonable for a test and the
+ * lock can be extended to synchronize more complicated operations.
+ */
+void test_percpu_spinlock(void)
+{
+	const int num_threads = 200;
+	int i;
+	uint64_t sum;
+	pthread_t test_threads[num_threads];
+	struct spinlock_test_data data;
+
+	memset(&data, 0, sizeof(data));
+	data.reps = 5000;
+
+	for (i = 0; i < num_threads; i++)
+		pthread_create(&test_threads[i], NULL,
+			       test_percpu_spinlock_thread, &data);
+
+	for (i = 0; i < num_threads; i++)
+		pthread_join(test_threads[i], NULL);
+
+	sum = 0;
+	for (i = 0; i < CPU_SETSIZE; i++)
+		sum += data.c[i].count;
+
+	assert(sum == (uint64_t)data.reps * num_threads);
+}
+
+void this_cpu_list_push(struct percpu_list *list,
+			struct percpu_list_node *node,
+			int *_cpu)
+{
+	int cpu;
+
+	for (;;) {
+		intptr_t *targetptr, newval, expect;
+		int ret;
+
+		cpu = rseq_cpu_start();
+		/* Load list->c[cpu].head with single-copy atomicity. */
+		expect = (intptr_t)RSEQ_READ_ONCE(list->c[cpu].head);
+		newval = (intptr_t)node;
+		targetptr = (intptr_t *)&list->c[cpu].head;
+		node->next = (struct percpu_list_node *)expect;
+		ret = rseq_cmpeqv_storev(targetptr, expect, newval, cpu);
+		if (rseq_likely(!ret))
+			break;
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	if (_cpu)
+		*_cpu = cpu;
+}
+
+/*
+ * Unlike a traditional lock-less linked list; the availability of a
+ * rseq primitive allows us to implement pop without concerns over
+ * ABA-type races.
+ */
+struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
+					   int *_cpu)
+{
+	for (;;) {
+		struct percpu_list_node *head;
+		intptr_t *targetptr, expectnot, *load;
+		off_t offset;
+		int ret, cpu;
+
+		cpu = rseq_cpu_start();
+		targetptr = (intptr_t *)&list->c[cpu].head;
+		expectnot = (intptr_t)NULL;
+		offset = offsetof(struct percpu_list_node, next);
+		load = (intptr_t *)&head;
+		ret = rseq_cmpnev_storeoffp_load(targetptr, expectnot,
+						 offset, load, cpu);
+		if (rseq_likely(!ret)) {
+			if (_cpu)
+				*_cpu = cpu;
+			return head;
+		}
+		if (ret > 0)
+			return NULL;
+		/* Retry if rseq aborts. */
+	}
+}
+
+/*
+ * __percpu_list_pop is not safe against concurrent accesses. Should
+ * only be used on lists that are not concurrently modified.
+ */
+struct percpu_list_node *__percpu_list_pop(struct percpu_list *list, int cpu)
+{
+	struct percpu_list_node *node;
+
+	node = list->c[cpu].head;
+	if (!node)
+		return NULL;
+	list->c[cpu].head = node->next;
+	return node;
+}
+
+void *test_percpu_list_thread(void *arg)
+{
+	int i;
+	struct percpu_list *list = (struct percpu_list *)arg;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	for (i = 0; i < 100000; i++) {
+		struct percpu_list_node *node;
+
+		node = this_cpu_list_pop(list, NULL);
+		sched_yield();  /* encourage shuffling */
+		if (node)
+			this_cpu_list_push(list, node, NULL);
+	}
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	return NULL;
+}
+
+/* Simultaneous modification to a per-cpu linked list from many threads.  */
+void test_percpu_list(void)
+{
+	int i, j;
+	uint64_t sum = 0, expected_sum = 0;
+	struct percpu_list list;
+	pthread_t test_threads[200];
+	cpu_set_t allowed_cpus;
+
+	memset(&list, 0, sizeof(list));
+
+	/* Generate list entries for every usable cpu. */
+	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+		for (j = 1; j <= 100; j++) {
+			struct percpu_list_node *node;
+
+			expected_sum += j;
+
+			node = malloc(sizeof(*node));
+			assert(node);
+			node->data = j;
+			node->next = list.c[i].head;
+			list.c[i].head = node;
+		}
+	}
+
+	for (i = 0; i < 200; i++)
+		pthread_create(&test_threads[i], NULL,
+		       test_percpu_list_thread, &list);
+
+	for (i = 0; i < 200; i++)
+		pthread_join(test_threads[i], NULL);
+
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_list_node *node;
+
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+
+		while ((node = __percpu_list_pop(&list, i))) {
+			sum += node->data;
+			free(node);
+		}
+	}
+
+	/*
+	 * All entries should now be accounted for (unless some external
+	 * actor is interfering with our allowed affinity while this
+	 * test is running).
+	 */
+	assert(sum == expected_sum);
+}
+
+int main(int argc, char **argv)
+{
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	printf("spinlock\n");
+	test_percpu_spinlock();
+	printf("percpu_list\n");
+	test_percpu_list();
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	return 0;
+
+error:
+	return -1;
+}
diff --git a/tools/testing/selftests/rseq/basic_test.c b/tools/testing/selftests/rseq/basic_test.c
new file mode 100644
index 000000000000..d8efbfb89193
--- /dev/null
+++ b/tools/testing/selftests/rseq/basic_test.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Basic test coverage for critical regions and rseq_current_cpu().
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+void test_cpu_pointer(void)
+{
+	cpu_set_t affinity, test_affinity;
+	int i;
+
+	sched_getaffinity(0, sizeof(affinity), &affinity);
+	CPU_ZERO(&test_affinity);
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (CPU_ISSET(i, &affinity)) {
+			CPU_SET(i, &test_affinity);
+			sched_setaffinity(0, sizeof(test_affinity),
+					&test_affinity);
+			assert(sched_getcpu() == i);
+			assert(rseq_current_cpu() == i);
+			assert(rseq_current_cpu_raw() == i);
+			assert(rseq_cpu_start() == i);
+			CPU_CLR(i, &test_affinity);
+		}
+	}
+	sched_setaffinity(0, sizeof(affinity), &affinity);
+}
+
+int main(int argc, char **argv)
+{
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto init_thread_error;
+	}
+	printf("testing current cpu\n");
+	test_cpu_pointer();
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto init_thread_error;
+	}
+	return 0;
+
+init_thread_error:
+	return -1;
+}
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
new file mode 100644
index 000000000000..6a9f602a8718
--- /dev/null
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -0,0 +1,1260 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include <unistd.h>
+#include <poll.h>
+#include <sys/types.h>
+#include <signal.h>
+#include <errno.h>
+#include <stddef.h>
+
+static inline pid_t gettid(void)
+{
+	return syscall(__NR_gettid);
+}
+
+#define NR_INJECT	9
+static int loop_cnt[NR_INJECT + 1];
+
+static int loop_cnt_1 asm("asm_loop_cnt_1") __attribute__((used));
+static int loop_cnt_2 asm("asm_loop_cnt_2") __attribute__((used));
+static int loop_cnt_3 asm("asm_loop_cnt_3") __attribute__((used));
+static int loop_cnt_4 asm("asm_loop_cnt_4") __attribute__((used));
+static int loop_cnt_5 asm("asm_loop_cnt_5") __attribute__((used));
+static int loop_cnt_6 asm("asm_loop_cnt_6") __attribute__((used));
+
+static int opt_modulo, verbose;
+
+static int opt_yield, opt_signal, opt_sleep,
+		opt_disable_rseq, opt_threads = 200,
+		opt_disable_mod = 0, opt_test = 's', opt_mb = 0;
+
+#ifndef RSEQ_SKIP_FASTPATH
+static long long opt_reps = 5000;
+#else
+static long long opt_reps = 100;
+#endif
+
+static __thread __attribute__((tls_model("initial-exec")))
+unsigned int signals_delivered;
+
+#ifndef BENCHMARK
+
+static __thread __attribute__((tls_model("initial-exec"), unused))
+unsigned int yield_mod_cnt, nr_abort;
+
+#define printf_verbose(fmt, ...)			\
+	do {						\
+		if (verbose)				\
+			printf(fmt, ## __VA_ARGS__);	\
+	} while (0)
+
+#if defined(__x86_64__) || defined(__i386__)
+
+#define INJECT_ASM_REG	"eax"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG
+
+#ifdef __i386__
+
+#define RSEQ_INJECT_ASM(n) \
+	"mov asm_loop_cnt_" #n ", %%" INJECT_ASM_REG "\n\t" \
+	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
+	"jz 333f\n\t" \
+	"222:\n\t" \
+	"dec %%" INJECT_ASM_REG "\n\t" \
+	"jnz 222b\n\t" \
+	"333:\n\t"
+
+#elif defined(__x86_64__)
+
+#define RSEQ_INJECT_ASM(n) \
+	"lea asm_loop_cnt_" #n "(%%rip), %%" INJECT_ASM_REG "\n\t" \
+	"mov (%%" INJECT_ASM_REG "), %%" INJECT_ASM_REG "\n\t" \
+	"test %%" INJECT_ASM_REG ",%%" INJECT_ASM_REG "\n\t" \
+	"jz 333f\n\t" \
+	"222:\n\t" \
+	"dec %%" INJECT_ASM_REG "\n\t" \
+	"jnz 222b\n\t" \
+	"333:\n\t"
+
+#else
+#error "Unsupported architecture"
+#endif
+
+#elif defined(__ARMEL__)
+
+#define RSEQ_INJECT_INPUT \
+	, [loop_cnt_1]"m"(loop_cnt[1]) \
+	, [loop_cnt_2]"m"(loop_cnt[2]) \
+	, [loop_cnt_3]"m"(loop_cnt[3]) \
+	, [loop_cnt_4]"m"(loop_cnt[4]) \
+	, [loop_cnt_5]"m"(loop_cnt[5]) \
+	, [loop_cnt_6]"m"(loop_cnt[6])
+
+#define INJECT_ASM_REG	"r4"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG
+
+#define RSEQ_INJECT_ASM(n) \
+	"ldr " INJECT_ASM_REG ", %[loop_cnt_" #n "]\n\t" \
+	"cmp " INJECT_ASM_REG ", #0\n\t" \
+	"beq 333f\n\t" \
+	"222:\n\t" \
+	"subs " INJECT_ASM_REG ", #1\n\t" \
+	"bne 222b\n\t" \
+	"333:\n\t"
+
+#elif __PPC__
+
+#define RSEQ_INJECT_INPUT \
+	, [loop_cnt_1]"m"(loop_cnt[1]) \
+	, [loop_cnt_2]"m"(loop_cnt[2]) \
+	, [loop_cnt_3]"m"(loop_cnt[3]) \
+	, [loop_cnt_4]"m"(loop_cnt[4]) \
+	, [loop_cnt_5]"m"(loop_cnt[5]) \
+	, [loop_cnt_6]"m"(loop_cnt[6])
+
+#define INJECT_ASM_REG	"r18"
+
+#define RSEQ_INJECT_CLOBBER \
+	, INJECT_ASM_REG
+
+#define RSEQ_INJECT_ASM(n) \
+	"lwz %%" INJECT_ASM_REG ", %[loop_cnt_" #n "]\n\t" \
+	"cmpwi %%" INJECT_ASM_REG ", 0\n\t" \
+	"beq 333f\n\t" \
+	"222:\n\t" \
+	"subic. %%" INJECT_ASM_REG ", %%" INJECT_ASM_REG ", 1\n\t" \
+	"bne 222b\n\t" \
+	"333:\n\t"
+#else
+#error unsupported target
+#endif
+
+#define RSEQ_INJECT_FAILED \
+	nr_abort++;
+
+#define RSEQ_INJECT_C(n) \
+{ \
+	int loc_i, loc_nr_loops = loop_cnt[n]; \
+	\
+	for (loc_i = 0; loc_i < loc_nr_loops; loc_i++) { \
+		rseq_barrier(); \
+	} \
+	if (loc_nr_loops == -1 && opt_modulo) { \
+		if (yield_mod_cnt == opt_modulo - 1) { \
+			if (opt_sleep > 0) \
+				poll(NULL, 0, opt_sleep); \
+			if (opt_yield) \
+				sched_yield(); \
+			if (opt_signal) \
+				raise(SIGUSR1); \
+			yield_mod_cnt = 0; \
+		} else { \
+			yield_mod_cnt++; \
+		} \
+	} \
+}
+
+#else
+
+#define printf_verbose(fmt, ...)
+
+#endif /* BENCHMARK */
+
+#include "rseq.h"
+
+struct percpu_lock_entry {
+	intptr_t v;
+} __attribute__((aligned(128)));
+
+struct percpu_lock {
+	struct percpu_lock_entry c[CPU_SETSIZE];
+};
+
+struct test_data_entry {
+	intptr_t count;
+} __attribute__((aligned(128)));
+
+struct spinlock_test_data {
+	struct percpu_lock lock;
+	struct test_data_entry c[CPU_SETSIZE];
+};
+
+struct spinlock_thread_test_data {
+	struct spinlock_test_data *data;
+	long long reps;
+	int reg;
+};
+
+struct inc_test_data {
+	struct test_data_entry c[CPU_SETSIZE];
+};
+
+struct inc_thread_test_data {
+	struct inc_test_data *data;
+	long long reps;
+	int reg;
+};
+
+struct percpu_list_node {
+	intptr_t data;
+	struct percpu_list_node *next;
+};
+
+struct percpu_list_entry {
+	struct percpu_list_node *head;
+} __attribute__((aligned(128)));
+
+struct percpu_list {
+	struct percpu_list_entry c[CPU_SETSIZE];
+};
+
+#define BUFFER_ITEM_PER_CPU	100
+
+struct percpu_buffer_node {
+	intptr_t data;
+};
+
+struct percpu_buffer_entry {
+	intptr_t offset;
+	intptr_t buflen;
+	struct percpu_buffer_node **array;
+} __attribute__((aligned(128)));
+
+struct percpu_buffer {
+	struct percpu_buffer_entry c[CPU_SETSIZE];
+};
+
+#define MEMCPY_BUFFER_ITEM_PER_CPU	100
+
+struct percpu_memcpy_buffer_node {
+	intptr_t data1;
+	uint64_t data2;
+};
+
+struct percpu_memcpy_buffer_entry {
+	intptr_t offset;
+	intptr_t buflen;
+	struct percpu_memcpy_buffer_node *array;
+} __attribute__((aligned(128)));
+
+struct percpu_memcpy_buffer {
+	struct percpu_memcpy_buffer_entry c[CPU_SETSIZE];
+};
+
+/* A simple percpu spinlock. Grabs lock on current cpu. */
+static int rseq_this_cpu_lock(struct percpu_lock *lock)
+{
+	int cpu;
+
+	for (;;) {
+		int ret;
+
+		cpu = rseq_cpu_start();
+		ret = rseq_cmpeqv_storev(&lock->c[cpu].v,
+					 0, 1, cpu);
+		if (rseq_likely(!ret))
+			break;
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	/*
+	 * Acquire semantic when taking lock after control dependency.
+	 * Matches rseq_smp_store_release().
+	 */
+	rseq_smp_acquire__after_ctrl_dep();
+	return cpu;
+}
+
+static void rseq_percpu_unlock(struct percpu_lock *lock, int cpu)
+{
+	assert(lock->c[cpu].v == 1);
+	/*
+	 * Release lock, with release semantic. Matches
+	 * rseq_smp_acquire__after_ctrl_dep().
+	 */
+	rseq_smp_store_release(&lock->c[cpu].v, 0);
+}
+
+void *test_percpu_spinlock_thread(void *arg)
+{
+	struct spinlock_thread_test_data *thread_data = arg;
+	struct spinlock_test_data *data = thread_data->data;
+	long long i, reps;
+
+	if (!opt_disable_rseq && thread_data->reg &&
+	    rseq_register_current_thread())
+		abort();
+	reps = thread_data->reps;
+	for (i = 0; i < reps; i++) {
+		int cpu = rseq_cpu_start();
+
+		cpu = rseq_this_cpu_lock(&data->lock);
+		data->c[cpu].count++;
+		rseq_percpu_unlock(&data->lock, cpu);
+#ifndef BENCHMARK
+		if (i != 0 && !(i % (reps / 10)))
+			printf_verbose("tid %d: count %lld\n", (int) gettid(), i);
+#endif
+	}
+	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
+		       (int) gettid(), nr_abort, signals_delivered);
+	if (!opt_disable_rseq && thread_data->reg &&
+	    rseq_unregister_current_thread())
+		abort();
+	return NULL;
+}
+
+/*
+ * A simple test which implements a sharded counter using a per-cpu
+ * lock.  Obviously real applications might prefer to simply use a
+ * per-cpu increment; however, this is reasonable for a test and the
+ * lock can be extended to synchronize more complicated operations.
+ */
+void test_percpu_spinlock(void)
+{
+	const int num_threads = opt_threads;
+	int i, ret;
+	uint64_t sum;
+	pthread_t test_threads[num_threads];
+	struct spinlock_test_data data;
+	struct spinlock_thread_test_data thread_data[num_threads];
+
+	memset(&data, 0, sizeof(data));
+	for (i = 0; i < num_threads; i++) {
+		thread_data[i].reps = opt_reps;
+		if (opt_disable_mod <= 0 || (i % opt_disable_mod))
+			thread_data[i].reg = 1;
+		else
+			thread_data[i].reg = 0;
+		thread_data[i].data = &data;
+		ret = pthread_create(&test_threads[i], NULL,
+				     test_percpu_spinlock_thread,
+				     &thread_data[i]);
+		if (ret) {
+			errno = ret;
+			perror("pthread_create");
+			abort();
+		}
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_join(test_threads[i], NULL);
+		if (ret) {
+			errno = ret;
+			perror("pthread_join");
+			abort();
+		}
+	}
+
+	sum = 0;
+	for (i = 0; i < CPU_SETSIZE; i++)
+		sum += data.c[i].count;
+
+	assert(sum == (uint64_t)opt_reps * num_threads);
+}
+
+void *test_percpu_inc_thread(void *arg)
+{
+	struct inc_thread_test_data *thread_data = arg;
+	struct inc_test_data *data = thread_data->data;
+	long long i, reps;
+
+	if (!opt_disable_rseq && thread_data->reg &&
+	    rseq_register_current_thread())
+		abort();
+	reps = thread_data->reps;
+	for (i = 0; i < reps; i++) {
+		int ret;
+
+		do {
+			int cpu;
+
+			cpu = rseq_cpu_start();
+			ret = rseq_addv(&data->c[cpu].count, 1, cpu);
+		} while (rseq_unlikely(ret));
+#ifndef BENCHMARK
+		if (i != 0 && !(i % (reps / 10)))
+			printf_verbose("tid %d: count %lld\n", (int) gettid(), i);
+#endif
+	}
+	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
+		       (int) gettid(), nr_abort, signals_delivered);
+	if (!opt_disable_rseq && thread_data->reg &&
+	    rseq_unregister_current_thread())
+		abort();
+	return NULL;
+}
+
+void test_percpu_inc(void)
+{
+	const int num_threads = opt_threads;
+	int i, ret;
+	uint64_t sum;
+	pthread_t test_threads[num_threads];
+	struct inc_test_data data;
+	struct inc_thread_test_data thread_data[num_threads];
+
+	memset(&data, 0, sizeof(data));
+	for (i = 0; i < num_threads; i++) {
+		thread_data[i].reps = opt_reps;
+		if (opt_disable_mod <= 0 || (i % opt_disable_mod))
+			thread_data[i].reg = 1;
+		else
+			thread_data[i].reg = 0;
+		thread_data[i].data = &data;
+		ret = pthread_create(&test_threads[i], NULL,
+				     test_percpu_inc_thread,
+				     &thread_data[i]);
+		if (ret) {
+			errno = ret;
+			perror("pthread_create");
+			abort();
+		}
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_join(test_threads[i], NULL);
+		if (ret) {
+			errno = ret;
+			perror("pthread_join");
+			abort();
+		}
+	}
+
+	sum = 0;
+	for (i = 0; i < CPU_SETSIZE; i++)
+		sum += data.c[i].count;
+
+	assert(sum == (uint64_t)opt_reps * num_threads);
+}
+
+void this_cpu_list_push(struct percpu_list *list,
+			struct percpu_list_node *node,
+			int *_cpu)
+{
+	int cpu;
+
+	for (;;) {
+		intptr_t *targetptr, newval, expect;
+		int ret;
+
+		cpu = rseq_cpu_start();
+		/* Load list->c[cpu].head with single-copy atomicity. */
+		expect = (intptr_t)RSEQ_READ_ONCE(list->c[cpu].head);
+		newval = (intptr_t)node;
+		targetptr = (intptr_t *)&list->c[cpu].head;
+		node->next = (struct percpu_list_node *)expect;
+		ret = rseq_cmpeqv_storev(targetptr, expect, newval, cpu);
+		if (rseq_likely(!ret))
+			break;
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	if (_cpu)
+		*_cpu = cpu;
+}
+
+/*
+ * Unlike a traditional lock-less linked list; the availability of a
+ * rseq primitive allows us to implement pop without concerns over
+ * ABA-type races.
+ */
+struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
+					   int *_cpu)
+{
+	struct percpu_list_node *node = NULL;
+	int cpu;
+
+	for (;;) {
+		struct percpu_list_node *head;
+		intptr_t *targetptr, expectnot, *load;
+		off_t offset;
+		int ret;
+
+		cpu = rseq_cpu_start();
+		targetptr = (intptr_t *)&list->c[cpu].head;
+		expectnot = (intptr_t)NULL;
+		offset = offsetof(struct percpu_list_node, next);
+		load = (intptr_t *)&head;
+		ret = rseq_cmpnev_storeoffp_load(targetptr, expectnot,
+						   offset, load, cpu);
+		if (rseq_likely(!ret)) {
+			node = head;
+			break;
+		}
+		if (ret > 0)
+			break;
+		/* Retry if rseq aborts. */
+	}
+	if (_cpu)
+		*_cpu = cpu;
+	return node;
+}
+
+/*
+ * __percpu_list_pop is not safe against concurrent accesses. Should
+ * only be used on lists that are not concurrently modified.
+ */
+struct percpu_list_node *__percpu_list_pop(struct percpu_list *list, int cpu)
+{
+	struct percpu_list_node *node;
+
+	node = list->c[cpu].head;
+	if (!node)
+		return NULL;
+	list->c[cpu].head = node->next;
+	return node;
+}
+
+void *test_percpu_list_thread(void *arg)
+{
+	long long i, reps;
+	struct percpu_list *list = (struct percpu_list *)arg;
+
+	if (!opt_disable_rseq && rseq_register_current_thread())
+		abort();
+
+	reps = opt_reps;
+	for (i = 0; i < reps; i++) {
+		struct percpu_list_node *node;
+
+		node = this_cpu_list_pop(list, NULL);
+		if (opt_yield)
+			sched_yield();  /* encourage shuffling */
+		if (node)
+			this_cpu_list_push(list, node, NULL);
+	}
+
+	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
+		       (int) gettid(), nr_abort, signals_delivered);
+	if (!opt_disable_rseq && rseq_unregister_current_thread())
+		abort();
+
+	return NULL;
+}
+
+/* Simultaneous modification to a per-cpu linked list from many threads.  */
+void test_percpu_list(void)
+{
+	const int num_threads = opt_threads;
+	int i, j, ret;
+	uint64_t sum = 0, expected_sum = 0;
+	struct percpu_list list;
+	pthread_t test_threads[num_threads];
+	cpu_set_t allowed_cpus;
+
+	memset(&list, 0, sizeof(list));
+
+	/* Generate list entries for every usable cpu. */
+	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+		for (j = 1; j <= 100; j++) {
+			struct percpu_list_node *node;
+
+			expected_sum += j;
+
+			node = malloc(sizeof(*node));
+			assert(node);
+			node->data = j;
+			node->next = list.c[i].head;
+			list.c[i].head = node;
+		}
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_create(&test_threads[i], NULL,
+				     test_percpu_list_thread, &list);
+		if (ret) {
+			errno = ret;
+			perror("pthread_create");
+			abort();
+		}
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_join(test_threads[i], NULL);
+		if (ret) {
+			errno = ret;
+			perror("pthread_join");
+			abort();
+		}
+	}
+
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_list_node *node;
+
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+
+		while ((node = __percpu_list_pop(&list, i))) {
+			sum += node->data;
+			free(node);
+		}
+	}
+
+	/*
+	 * All entries should now be accounted for (unless some external
+	 * actor is interfering with our allowed affinity while this
+	 * test is running).
+	 */
+	assert(sum == expected_sum);
+}
+
+bool this_cpu_buffer_push(struct percpu_buffer *buffer,
+			  struct percpu_buffer_node *node,
+			  int *_cpu)
+{
+	bool result = false;
+	int cpu;
+
+	for (;;) {
+		intptr_t *targetptr_spec, newval_spec;
+		intptr_t *targetptr_final, newval_final;
+		intptr_t offset;
+		int ret;
+
+		cpu = rseq_cpu_start();
+		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
+		if (offset == buffer->c[cpu].buflen)
+			break;
+		newval_spec = (intptr_t)node;
+		targetptr_spec = (intptr_t *)&buffer->c[cpu].array[offset];
+		newval_final = offset + 1;
+		targetptr_final = &buffer->c[cpu].offset;
+		if (opt_mb)
+			ret = rseq_cmpeqv_trystorev_storev_release(
+				targetptr_final, offset, targetptr_spec,
+				newval_spec, newval_final, cpu);
+		else
+			ret = rseq_cmpeqv_trystorev_storev(targetptr_final,
+				offset, targetptr_spec, newval_spec,
+				newval_final, cpu);
+		if (rseq_likely(!ret)) {
+			result = true;
+			break;
+		}
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	if (_cpu)
+		*_cpu = cpu;
+	return result;
+}
+
+struct percpu_buffer_node *this_cpu_buffer_pop(struct percpu_buffer *buffer,
+					       int *_cpu)
+{
+	struct percpu_buffer_node *head;
+	int cpu;
+
+	for (;;) {
+		intptr_t *targetptr, newval;
+		intptr_t offset;
+		int ret;
+
+		cpu = rseq_cpu_start();
+		/* Load offset with single-copy atomicity. */
+		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
+		if (offset == 0) {
+			head = NULL;
+			break;
+		}
+		head = RSEQ_READ_ONCE(buffer->c[cpu].array[offset - 1]);
+		newval = offset - 1;
+		targetptr = (intptr_t *)&buffer->c[cpu].offset;
+		ret = rseq_cmpeqv_cmpeqv_storev(targetptr, offset,
+			(intptr_t *)&buffer->c[cpu].array[offset - 1],
+			(intptr_t)head, newval, cpu);
+		if (rseq_likely(!ret))
+			break;
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	if (_cpu)
+		*_cpu = cpu;
+	return head;
+}
+
+/*
+ * __percpu_buffer_pop is not safe against concurrent accesses. Should
+ * only be used on buffers that are not concurrently modified.
+ */
+struct percpu_buffer_node *__percpu_buffer_pop(struct percpu_buffer *buffer,
+					       int cpu)
+{
+	struct percpu_buffer_node *head;
+	intptr_t offset;
+
+	offset = buffer->c[cpu].offset;
+	if (offset == 0)
+		return NULL;
+	head = buffer->c[cpu].array[offset - 1];
+	buffer->c[cpu].offset = offset - 1;
+	return head;
+}
+
+void *test_percpu_buffer_thread(void *arg)
+{
+	long long i, reps;
+	struct percpu_buffer *buffer = (struct percpu_buffer *)arg;
+
+	if (!opt_disable_rseq && rseq_register_current_thread())
+		abort();
+
+	reps = opt_reps;
+	for (i = 0; i < reps; i++) {
+		struct percpu_buffer_node *node;
+
+		node = this_cpu_buffer_pop(buffer, NULL);
+		if (opt_yield)
+			sched_yield();  /* encourage shuffling */
+		if (node) {
+			if (!this_cpu_buffer_push(buffer, node, NULL)) {
+				/* Should increase buffer size. */
+				abort();
+			}
+		}
+	}
+
+	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
+		       (int) gettid(), nr_abort, signals_delivered);
+	if (!opt_disable_rseq && rseq_unregister_current_thread())
+		abort();
+
+	return NULL;
+}
+
+/* Simultaneous modification to a per-cpu buffer from many threads.  */
+void test_percpu_buffer(void)
+{
+	const int num_threads = opt_threads;
+	int i, j, ret;
+	uint64_t sum = 0, expected_sum = 0;
+	struct percpu_buffer buffer;
+	pthread_t test_threads[num_threads];
+	cpu_set_t allowed_cpus;
+
+	memset(&buffer, 0, sizeof(buffer));
+
+	/* Generate list entries for every usable cpu. */
+	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+		/* Worse-case is every item in same CPU. */
+		buffer.c[i].array =
+			malloc(sizeof(*buffer.c[i].array) * CPU_SETSIZE *
+			       BUFFER_ITEM_PER_CPU);
+		assert(buffer.c[i].array);
+		buffer.c[i].buflen = CPU_SETSIZE * BUFFER_ITEM_PER_CPU;
+		for (j = 1; j <= BUFFER_ITEM_PER_CPU; j++) {
+			struct percpu_buffer_node *node;
+
+			expected_sum += j;
+
+			/*
+			 * We could theoretically put the word-sized
+			 * "data" directly in the buffer. However, we
+			 * want to model objects that would not fit
+			 * within a single word, so allocate an object
+			 * for each node.
+			 */
+			node = malloc(sizeof(*node));
+			assert(node);
+			node->data = j;
+			buffer.c[i].array[j - 1] = node;
+			buffer.c[i].offset++;
+		}
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_create(&test_threads[i], NULL,
+				     test_percpu_buffer_thread, &buffer);
+		if (ret) {
+			errno = ret;
+			perror("pthread_create");
+			abort();
+		}
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_join(test_threads[i], NULL);
+		if (ret) {
+			errno = ret;
+			perror("pthread_join");
+			abort();
+		}
+	}
+
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_buffer_node *node;
+
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+
+		while ((node = __percpu_buffer_pop(&buffer, i))) {
+			sum += node->data;
+			free(node);
+		}
+		free(buffer.c[i].array);
+	}
+
+	/*
+	 * All entries should now be accounted for (unless some external
+	 * actor is interfering with our allowed affinity while this
+	 * test is running).
+	 */
+	assert(sum == expected_sum);
+}
+
+bool this_cpu_memcpy_buffer_push(struct percpu_memcpy_buffer *buffer,
+				 struct percpu_memcpy_buffer_node item,
+				 int *_cpu)
+{
+	bool result = false;
+	int cpu;
+
+	for (;;) {
+		intptr_t *targetptr_final, newval_final, offset;
+		char *destptr, *srcptr;
+		size_t copylen;
+		int ret;
+
+		cpu = rseq_cpu_start();
+		/* Load offset with single-copy atomicity. */
+		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
+		if (offset == buffer->c[cpu].buflen)
+			break;
+		destptr = (char *)&buffer->c[cpu].array[offset];
+		srcptr = (char *)&item;
+		/* copylen must be <= 4kB. */
+		copylen = sizeof(item);
+		newval_final = offset + 1;
+		targetptr_final = &buffer->c[cpu].offset;
+		if (opt_mb)
+			ret = rseq_cmpeqv_trymemcpy_storev_release(
+				targetptr_final, offset,
+				destptr, srcptr, copylen,
+				newval_final, cpu);
+		else
+			ret = rseq_cmpeqv_trymemcpy_storev(targetptr_final,
+				offset, destptr, srcptr, copylen,
+				newval_final, cpu);
+		if (rseq_likely(!ret)) {
+			result = true;
+			break;
+		}
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	if (_cpu)
+		*_cpu = cpu;
+	return result;
+}
+
+bool this_cpu_memcpy_buffer_pop(struct percpu_memcpy_buffer *buffer,
+				struct percpu_memcpy_buffer_node *item,
+				int *_cpu)
+{
+	bool result = false;
+	int cpu;
+
+	for (;;) {
+		intptr_t *targetptr_final, newval_final, offset;
+		char *destptr, *srcptr;
+		size_t copylen;
+		int ret;
+
+		cpu = rseq_cpu_start();
+		/* Load offset with single-copy atomicity. */
+		offset = RSEQ_READ_ONCE(buffer->c[cpu].offset);
+		if (offset == 0)
+			break;
+		destptr = (char *)item;
+		srcptr = (char *)&buffer->c[cpu].array[offset - 1];
+		/* copylen must be <= 4kB. */
+		copylen = sizeof(*item);
+		newval_final = offset - 1;
+		targetptr_final = &buffer->c[cpu].offset;
+		ret = rseq_cmpeqv_trymemcpy_storev(targetptr_final,
+			offset, destptr, srcptr, copylen,
+			newval_final, cpu);
+		if (rseq_likely(!ret)) {
+			result = true;
+			break;
+		}
+		/* Retry if comparison fails or rseq aborts. */
+	}
+	if (_cpu)
+		*_cpu = cpu;
+	return result;
+}
+
+/*
+ * __percpu_memcpy_buffer_pop is not safe against concurrent accesses. Should
+ * only be used on buffers that are not concurrently modified.
+ */
+bool __percpu_memcpy_buffer_pop(struct percpu_memcpy_buffer *buffer,
+				struct percpu_memcpy_buffer_node *item,
+				int cpu)
+{
+	intptr_t offset;
+
+	offset = buffer->c[cpu].offset;
+	if (offset == 0)
+		return false;
+	memcpy(item, &buffer->c[cpu].array[offset - 1], sizeof(*item));
+	buffer->c[cpu].offset = offset - 1;
+	return true;
+}
+
+void *test_percpu_memcpy_buffer_thread(void *arg)
+{
+	long long i, reps;
+	struct percpu_memcpy_buffer *buffer = (struct percpu_memcpy_buffer *)arg;
+
+	if (!opt_disable_rseq && rseq_register_current_thread())
+		abort();
+
+	reps = opt_reps;
+	for (i = 0; i < reps; i++) {
+		struct percpu_memcpy_buffer_node item;
+		bool result;
+
+		result = this_cpu_memcpy_buffer_pop(buffer, &item, NULL);
+		if (opt_yield)
+			sched_yield();  /* encourage shuffling */
+		if (result) {
+			if (!this_cpu_memcpy_buffer_push(buffer, item, NULL)) {
+				/* Should increase buffer size. */
+				abort();
+			}
+		}
+	}
+
+	printf_verbose("tid %d: number of rseq abort: %d, signals delivered: %u\n",
+		       (int) gettid(), nr_abort, signals_delivered);
+	if (!opt_disable_rseq && rseq_unregister_current_thread())
+		abort();
+
+	return NULL;
+}
+
+/* Simultaneous modification to a per-cpu buffer from many threads.  */
+void test_percpu_memcpy_buffer(void)
+{
+	const int num_threads = opt_threads;
+	int i, j, ret;
+	uint64_t sum = 0, expected_sum = 0;
+	struct percpu_memcpy_buffer buffer;
+	pthread_t test_threads[num_threads];
+	cpu_set_t allowed_cpus;
+
+	memset(&buffer, 0, sizeof(buffer));
+
+	/* Generate list entries for every usable cpu. */
+	sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus);
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+		/* Worse-case is every item in same CPU. */
+		buffer.c[i].array =
+			malloc(sizeof(*buffer.c[i].array) * CPU_SETSIZE *
+			       MEMCPY_BUFFER_ITEM_PER_CPU);
+		assert(buffer.c[i].array);
+		buffer.c[i].buflen = CPU_SETSIZE * MEMCPY_BUFFER_ITEM_PER_CPU;
+		for (j = 1; j <= MEMCPY_BUFFER_ITEM_PER_CPU; j++) {
+			expected_sum += 2 * j + 1;
+
+			/*
+			 * We could theoretically put the word-sized
+			 * "data" directly in the buffer. However, we
+			 * want to model objects that would not fit
+			 * within a single word, so allocate an object
+			 * for each node.
+			 */
+			buffer.c[i].array[j - 1].data1 = j;
+			buffer.c[i].array[j - 1].data2 = j + 1;
+			buffer.c[i].offset++;
+		}
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_create(&test_threads[i], NULL,
+				     test_percpu_memcpy_buffer_thread,
+				     &buffer);
+		if (ret) {
+			errno = ret;
+			perror("pthread_create");
+			abort();
+		}
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_join(test_threads[i], NULL);
+		if (ret) {
+			errno = ret;
+			perror("pthread_join");
+			abort();
+		}
+	}
+
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_memcpy_buffer_node item;
+
+		if (!CPU_ISSET(i, &allowed_cpus))
+			continue;
+
+		while (__percpu_memcpy_buffer_pop(&buffer, &item, i)) {
+			sum += item.data1;
+			sum += item.data2;
+		}
+		free(buffer.c[i].array);
+	}
+
+	/*
+	 * All entries should now be accounted for (unless some external
+	 * actor is interfering with our allowed affinity while this
+	 * test is running).
+	 */
+	assert(sum == expected_sum);
+}
+
+static void test_signal_interrupt_handler(int signo)
+{
+	signals_delivered++;
+}
+
+static int set_signal_handler(void)
+{
+	int ret = 0;
+	struct sigaction sa;
+	sigset_t sigset;
+
+	ret = sigemptyset(&sigset);
+	if (ret < 0) {
+		perror("sigemptyset");
+		return ret;
+	}
+
+	sa.sa_handler = test_signal_interrupt_handler;
+	sa.sa_mask = sigset;
+	sa.sa_flags = 0;
+	ret = sigaction(SIGUSR1, &sa, NULL);
+	if (ret < 0) {
+		perror("sigaction");
+		return ret;
+	}
+
+	printf_verbose("Signal handler set for SIGUSR1\n");
+
+	return ret;
+}
+
+static void show_usage(int argc, char **argv)
+{
+	printf("Usage : %s <OPTIONS>\n",
+		argv[0]);
+	printf("OPTIONS:\n");
+	printf("	[-1 loops] Number of loops for delay injection 1\n");
+	printf("	[-2 loops] Number of loops for delay injection 2\n");
+	printf("	[-3 loops] Number of loops for delay injection 3\n");
+	printf("	[-4 loops] Number of loops for delay injection 4\n");
+	printf("	[-5 loops] Number of loops for delay injection 5\n");
+	printf("	[-6 loops] Number of loops for delay injection 6\n");
+	printf("	[-7 loops] Number of loops for delay injection 7 (-1 to enable -m)\n");
+	printf("	[-8 loops] Number of loops for delay injection 8 (-1 to enable -m)\n");
+	printf("	[-9 loops] Number of loops for delay injection 9 (-1 to enable -m)\n");
+	printf("	[-m N] Yield/sleep/kill every modulo N (default 0: disabled) (>= 0)\n");
+	printf("	[-y] Yield\n");
+	printf("	[-k] Kill thread with signal\n");
+	printf("	[-s S] S: =0: disabled (default), >0: sleep time (ms)\n");
+	printf("	[-t N] Number of threads (default 200)\n");
+	printf("	[-r N] Number of repetitions per thread (default 5000)\n");
+	printf("	[-d] Disable rseq system call (no initialization)\n");
+	printf("	[-D M] Disable rseq for each M threads\n");
+	printf("	[-T test] Choose test: (s)pinlock, (l)ist, (b)uffer, (m)emcpy, (i)ncrement\n");
+	printf("	[-M] Push into buffer and memcpy buffer with memory barriers.\n");
+	printf("	[-v] Verbose output.\n");
+	printf("	[-h] Show this help.\n");
+	printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		if (argv[i][0] != '-')
+			continue;
+		switch (argv[i][1]) {
+		case '1':
+		case '2':
+		case '3':
+		case '4':
+		case '5':
+		case '6':
+		case '7':
+		case '8':
+		case '9':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			loop_cnt[argv[i][1] - '0'] = atol(argv[i + 1]);
+			i++;
+			break;
+		case 'm':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			opt_modulo = atol(argv[i + 1]);
+			if (opt_modulo < 0) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			i++;
+			break;
+		case 's':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			opt_sleep = atol(argv[i + 1]);
+			if (opt_sleep < 0) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			i++;
+			break;
+		case 'y':
+			opt_yield = 1;
+			break;
+		case 'k':
+			opt_signal = 1;
+			break;
+		case 'd':
+			opt_disable_rseq = 1;
+			break;
+		case 'D':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			opt_disable_mod = atol(argv[i + 1]);
+			if (opt_disable_mod < 0) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			i++;
+			break;
+		case 't':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			opt_threads = atol(argv[i + 1]);
+			if (opt_threads < 0) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			i++;
+			break;
+		case 'r':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			opt_reps = atoll(argv[i + 1]);
+			if (opt_reps < 0) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			i++;
+			break;
+		case 'h':
+			show_usage(argc, argv);
+			goto end;
+		case 'T':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				goto error;
+			}
+			opt_test = *argv[i + 1];
+			switch (opt_test) {
+			case 's':
+			case 'l':
+			case 'i':
+			case 'b':
+			case 'm':
+				break;
+			default:
+				show_usage(argc, argv);
+				goto error;
+			}
+			i++;
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		case 'M':
+			opt_mb = 1;
+			break;
+		default:
+			show_usage(argc, argv);
+			goto error;
+		}
+	}
+
+	loop_cnt_1 = loop_cnt[1];
+	loop_cnt_2 = loop_cnt[2];
+	loop_cnt_3 = loop_cnt[3];
+	loop_cnt_4 = loop_cnt[4];
+	loop_cnt_5 = loop_cnt[5];
+	loop_cnt_6 = loop_cnt[6];
+
+	if (set_signal_handler())
+		goto error;
+
+	if (!opt_disable_rseq && rseq_register_current_thread())
+		goto error;
+	switch (opt_test) {
+	case 's':
+		printf_verbose("spinlock\n");
+		test_percpu_spinlock();
+		break;
+	case 'l':
+		printf_verbose("linked list\n");
+		test_percpu_list();
+		break;
+	case 'b':
+		printf_verbose("buffer\n");
+		test_percpu_buffer();
+		break;
+	case 'm':
+		printf_verbose("memcpy buffer\n");
+		test_percpu_memcpy_buffer();
+		break;
+	case 'i':
+		printf_verbose("counter increment\n");
+		test_percpu_inc();
+		break;
+	}
+	if (!opt_disable_rseq && rseq_unregister_current_thread())
+		abort();
+end:
+	return 0;
+
+error:
+	return -1;
+}
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
new file mode 100644
index 000000000000..3b055f9aeaab
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -0,0 +1,715 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-arm.h
+ *
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#define RSEQ_SIG	0x53053053
+
+#define rseq_smp_mb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
+#define rseq_smp_rmb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
+#define rseq_smp_wmb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_smp_mb();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_smp_mb();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#define __RSEQ_ASM_DEFINE_TABLE(version, flags,	start_ip,		\
+				post_commit_offset, abort_ip)		\
+		".pushsection __rseq_table, \"aw\"\n\t"			\
+		".balign 32\n\t"					\
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_TABLE(start_ip, post_commit_ip, abort_ip)	\
+	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip,			\
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+		RSEQ_INJECT_ASM(1)					\
+		"adr r0, " __rseq_str(cs_label) "\n\t"			\
+		"str r0, %[" __rseq_str(rseq_cs) "]\n\t"		\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+		RSEQ_INJECT_ASM(2)					\
+		"ldr r0, %[" __rseq_str(current_cpu_id) "]\n\t"	\
+		"cmp %[" __rseq_str(cpu_id) "], r0\n\t"		\
+		"bne " __rseq_str(label) "\n\t"
+
+#define __RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,		\
+				abort_label, version, flags,		\
+				start_ip, post_commit_offset, abort_ip)	\
+		__rseq_str(table_label) ":\n\t"				\
+		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
+		".word " __rseq_str(RSEQ_SIG) "\n\t"			\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"b %l[" __rseq_str(abort_label) "]\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown, abort_label, \
+			      start_ip, post_commit_ip, abort_ip)	\
+	__RSEQ_ASM_DEFINE_ABORT(table_label, label, teardown,		\
+				abort_label, 0x0, 0x0, start_ip,	\
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)		\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
+
+#define rseq_workaround_gcc_asm_size_guess()	__asm__ __volatile__("")
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+#endif
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expectnot], r0\n\t"
+		"beq %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expectnot], r0\n\t"
+		"beq %l[error2]\n\t"
+#endif
+		"str r0, %[load]\n\t"
+		"add r0, %[voffp]\n\t"
+		"ldr r0, [r0]\n\t"
+		/* final store */
+		"str r0, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"Ir" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		"ldr r0, %[v]\n\t"
+		"add r0, %[count]\n\t"
+		/* final store */
+		"str r0, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [count]		"Ir" (count)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+#endif
+		/* try store */
+		"str %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+#endif
+		/* try store */
+		"str %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		"dmb\n\t"	/* full mb provides store-release */
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"ldr r0, %[v2]\n\t"
+		"cmp %[expect2], r0\n\t"
+		"bne %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne %l[error2]\n\t"
+		"ldr r0, %[v2]\n\t"
+		"cmp %[expect2], r0\n\t"
+		"bne %l[error3]\n\t"
+#endif
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		"b 5f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4, "", abort, 1b, 2b, 4f)
+		"5:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		"str %[src], %[rseq_scratch0]\n\t"
+		"str %[dst], %[rseq_scratch1]\n\t"
+		"str %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 7f\n\t"
+#endif
+		/* try memcpy */
+		"cmp %[len], #0\n\t" \
+		"beq 333f\n\t" \
+		"222:\n\t" \
+		"ldrb %%r0, [%[src]]\n\t" \
+		"strb %%r0, [%[dst]]\n\t" \
+		"adds %[src], #1\n\t" \
+		"adds %[dst], #1\n\t" \
+		"subs %[len], #1\n\t" \
+		"bne 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"ldr %[len], %[rseq_scratch2]\n\t"
+		"ldr %[dst], %[rseq_scratch1]\n\t"
+		"ldr %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      "ldr %[len], %[rseq_scratch2]\n\t"
+				      "ldr %[dst], %[rseq_scratch1]\n\t"
+				      "ldr %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_workaround_gcc_asm_size_guess();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_workaround_gcc_asm_size_guess();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	rseq_workaround_gcc_asm_size_guess();
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		"str %[src], %[rseq_scratch0]\n\t"
+		"str %[dst], %[rseq_scratch1]\n\t"
+		"str %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		"ldr r0, %[v]\n\t"
+		"cmp %[expect], r0\n\t"
+		"bne 7f\n\t"
+#endif
+		/* try memcpy */
+		"cmp %[len], #0\n\t" \
+		"beq 333f\n\t" \
+		"222:\n\t" \
+		"ldrb %%r0, [%[src]]\n\t" \
+		"strb %%r0, [%[dst]]\n\t" \
+		"adds %[src], #1\n\t" \
+		"adds %[dst], #1\n\t" \
+		"subs %[len], #1\n\t" \
+		"bne 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		"dmb\n\t"	/* full mb provides store-release */
+		/* final store */
+		"str %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"ldr %[len], %[rseq_scratch2]\n\t"
+		"ldr %[dst], %[rseq_scratch1]\n\t"
+		"ldr %[src], %[rseq_scratch0]\n\t"
+		"b 8f\n\t"
+		RSEQ_ASM_DEFINE_ABORT(3, 4,
+				      /* teardown */
+				      "ldr %[len], %[rseq_scratch2]\n\t"
+				      "ldr %[dst], %[rseq_scratch1]\n\t"
+				      "ldr %[src], %[rseq_scratch0]\n\t",
+				      abort, 1b, 2b, 4f)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+					/* teardown */
+					"ldr %[len], %[rseq_scratch2]\n\t"
+					"ldr %[dst], %[rseq_scratch1]\n\t"
+					"ldr %[src], %[rseq_scratch0]\n\t",
+					error2)
+#endif
+		"8:\n\t"
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		  RSEQ_INJECT_INPUT
+		: "r0", "memory", "cc"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	rseq_workaround_gcc_asm_size_guess();
+	return 0;
+abort:
+	rseq_workaround_gcc_asm_size_guess();
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	rseq_workaround_gcc_asm_size_guess();
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_workaround_gcc_asm_size_guess();
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_workaround_gcc_asm_size_guess();
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
new file mode 100644
index 000000000000..52630c9f42be
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -0,0 +1,671 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-ppc.h
+ *
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ * (C) Copyright 2016-2018 - Boqun Feng <boqun.feng@gmail.com>
+ */
+
+#define RSEQ_SIG	0x53053053
+
+#define rseq_smp_mb()		__asm__ __volatile__ ("sync"	::: "memory", "cc")
+#define rseq_smp_lwsync()	__asm__ __volatile__ ("lwsync"	::: "memory", "cc")
+#define rseq_smp_rmb()		rseq_smp_lwsync()
+#define rseq_smp_wmb()		rseq_smp_lwsync()
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_smp_lwsync();						\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_lwsync()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_smp_lwsync();						\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+/*
+ * The __rseq_table section can be used by debuggers to better handle
+ * single-stepping through the restartable critical sections.
+ */
+
+#ifdef __PPC64__
+
+#define STORE_WORD	"std "
+#define LOAD_WORD	"ld "
+#define LOADX_WORD	"ldx "
+#define CMP_WORD	"cmpd "
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
+			start_ip, post_commit_offset, abort_ip)			\
+		".pushsection __rseq_table, \"aw\"\n\t"				\
+		".balign 32\n\t"						\
+		__rseq_str(label) ":\n\t"					\
+		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t"	\
+		".quad " __rseq_str(start_ip) ", " __rseq_str(post_commit_offset) ", " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
+		RSEQ_INJECT_ASM(1)						\
+		"lis %%r17, (" __rseq_str(cs_label) ")@highest\n\t"		\
+		"ori %%r17, %%r17, (" __rseq_str(cs_label) ")@higher\n\t"	\
+		"rldicr %%r17, %%r17, 32, 31\n\t"				\
+		"oris %%r17, %%r17, (" __rseq_str(cs_label) ")@high\n\t"	\
+		"ori %%r17, %%r17, (" __rseq_str(cs_label) ")@l\n\t"		\
+		"std %%r17, %[" __rseq_str(rseq_cs) "]\n\t"			\
+		__rseq_str(label) ":\n\t"
+
+#else /* #ifdef __PPC64__ */
+
+#define STORE_WORD	"stw "
+#define LOAD_WORD	"lwz "
+#define LOADX_WORD	"lwzx "
+#define CMP_WORD	"cmpw "
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
+			start_ip, post_commit_offset, abort_ip)			\
+		".pushsection __rseq_table, \"aw\"\n\t"				\
+		".balign 32\n\t"						\
+		__rseq_str(label) ":\n\t"					\
+		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t"	\
+		/* 32-bit only supported on BE */				\
+		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
+		RSEQ_INJECT_ASM(1)						\
+		"lis %%r17, (" __rseq_str(cs_label) ")@ha\n\t"			\
+		"addi %%r17, %%r17, (" __rseq_str(cs_label) ")@l\n\t"		\
+		"stw %%r17, %[" __rseq_str(rseq_cs) "]\n\t"			\
+		__rseq_str(label) ":\n\t"
+
+#endif /* #ifdef __PPC64__ */
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
+		__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
+					(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)			\
+		RSEQ_INJECT_ASM(2)						\
+		"lwz %%r17, %[" __rseq_str(current_cpu_id) "]\n\t"		\
+		"cmpw cr7, %[" __rseq_str(cpu_id) "], %%r17\n\t"		\
+		"bne- cr7, " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
+		".pushsection __rseq_failure, \"ax\"\n\t"			\
+		".long " __rseq_str(RSEQ_SIG) "\n\t"				\
+		__rseq_str(label) ":\n\t"					\
+		"b %l[" __rseq_str(abort_label) "]\n\t"				\
+		".popsection\n\t"
+
+/*
+ * RSEQ_ASM_OPs: asm operations for rseq
+ * 	RSEQ_ASM_OP_R_*: has hard-code registers in it
+ * 	RSEQ_ASM_OP_* (else): doesn't have hard-code registers(unless cr7)
+ */
+#define RSEQ_ASM_OP_CMPEQ(var, expect, label)					\
+		LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"			\
+		CMP_WORD "cr7, %%r17, %[" __rseq_str(expect) "]\n\t"		\
+		"bne- cr7, " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_OP_CMPNE(var, expectnot, label)				\
+		LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"			\
+		CMP_WORD "cr7, %%r17, %[" __rseq_str(expectnot) "]\n\t"		\
+		"beq- cr7, " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_OP_STORE(value, var)						\
+		STORE_WORD "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t"
+
+/* Load @var to r17 */
+#define RSEQ_ASM_OP_R_LOAD(var)							\
+		LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"
+
+/* Store r17 to @var */
+#define RSEQ_ASM_OP_R_STORE(var)						\
+		STORE_WORD "%%r17, %[" __rseq_str(var) "]\n\t"
+
+/* Add @count to r17 */
+#define RSEQ_ASM_OP_R_ADD(count)						\
+		"add %%r17, %[" __rseq_str(count) "], %%r17\n\t"
+
+/* Load (r17 + voffp) to r17 */
+#define RSEQ_ASM_OP_R_LOADX(voffp)						\
+		LOADX_WORD "%%r17, %[" __rseq_str(voffp) "], %%r17\n\t"
+
+/* TODO: implement a faster memcpy. */
+#define RSEQ_ASM_OP_R_MEMCPY() \
+		"cmpdi %%r19, 0\n\t" \
+		"beq 333f\n\t" \
+		"addi %%r20, %%r20, -1\n\t" \
+		"addi %%r21, %%r21, -1\n\t" \
+		"222:\n\t" \
+		"lbzu %%r18, 1(%%r20)\n\t" \
+		"stbu %%r18, 1(%%r21)\n\t" \
+		"addi %%r19, %%r19, -1\n\t" \
+		"cmpdi %%r19, 0\n\t" \
+		"bne 222b\n\t" \
+		"333:\n\t" \
+
+#define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)			\
+		STORE_WORD "%%r17, %[" __rseq_str(var) "]\n\t"			\
+		__rseq_str(post_commit_label) ":\n\t"
+
+#define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)			\
+		STORE_WORD "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t" \
+		__rseq_str(post_commit_label) ":\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v not equal to @expectnot */
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v not equal to @expectnot */
+		RSEQ_ASM_OP_CMPNE(v, expectnot, %l[error2])
+#endif
+		/* load the value of @v */
+		RSEQ_ASM_OP_R_LOAD(v)
+		/* store it in @load */
+		RSEQ_ASM_OP_R_STORE(load)
+		/* dereference voffp(v) */
+		RSEQ_ASM_OP_R_LOADX(voffp)
+		/* final store the value at voffp(v) */
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"b" (voffp),
+		  [load]		"m" (*load)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		/* load the value of @v */
+		RSEQ_ASM_OP_R_LOAD(v)
+		/* add @count to it */
+		RSEQ_ASM_OP_R_ADD(count)
+		/* final store */
+		RSEQ_ASM_OP_R_FINAL_STORE(v, 2)
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"r" (count)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try store */
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try store */
+		RSEQ_ASM_OP_STORE(newv2, v2)
+		RSEQ_INJECT_ASM(5)
+		/* for 'release' */
+		"lwsync\n\t"
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+		/* cmp @v2 equal to @expct2 */
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[cmpfail])
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+		/* cmp @v2 equal to @expct2 */
+		RSEQ_ASM_OP_CMPEQ(v2, expect2, %l[error3])
+#endif
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* setup for mempcy */
+		"mr %%r19, %[len]\n\t"
+		"mr %%r20, %[src]\n\t"
+		"mr %%r21, %[dst]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try memcpy */
+		RSEQ_ASM_OP_R_MEMCPY()
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17", "r18", "r19", "r20", "r21"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* setup for mempcy */
+		"mr %%r19, %[len]\n\t"
+		"mr %%r20, %[src]\n\t"
+		"mr %%r21, %[dst]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[cmpfail])
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		/* cmp cpuid */
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		/* cmp @v equal to @expect */
+		RSEQ_ASM_OP_CMPEQ(v, expect, %l[error2])
+#endif
+		/* try memcpy */
+		RSEQ_ASM_OP_R_MEMCPY()
+		RSEQ_INJECT_ASM(5)
+		/* for 'release' */
+		"lwsync\n\t"
+		/* final store */
+		RSEQ_ASM_OP_FINAL_STORE(newv, v, 2)
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		RSEQ_ASM_DEFINE_ABORT(4, abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len)
+		  RSEQ_INJECT_INPUT
+		: "memory", "cc", "r17", "r18", "r19", "r20", "r21"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#undef STORE_WORD
+#undef LOAD_WORD
+#undef LOADX_WORD
+#undef CMP_WORD
+
+#endif /* !RSEQ_SKIP_FASTPATH */
diff --git a/tools/testing/selftests/rseq/rseq-skip.h b/tools/testing/selftests/rseq/rseq-skip.h
new file mode 100644
index 000000000000..72750b5905a9
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-skip.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-skip.h
+ *
+ * (C) Copyright 2017-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	return -1;
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	return -1;
+}
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
new file mode 100644
index 000000000000..089410a314e9
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -0,0 +1,1132 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq-x86.h
+ *
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include <stdint.h>
+
+#define RSEQ_SIG	0x53053053
+
+#ifdef __x86_64__
+
+#define rseq_smp_mb()	\
+	__asm__ __volatile__ ("lock; addl $0,-128(%%rsp)" ::: "memory", "cc")
+#define rseq_smp_rmb()	rseq_barrier()
+#define rseq_smp_wmb()	rseq_barrier()
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_barrier();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_barrier();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
+				start_ip, post_commit_offset, abort_ip)	\
+		".pushsection __rseq_table, \"aw\"\n\t"			\
+		".balign 32\n\t"					\
+		__rseq_str(label) ":\n\t"				\
+		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".quad " __rseq_str(start_ip) ", " __rseq_str(post_commit_offset) ", " __rseq_str(abort_ip) "\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+		RSEQ_INJECT_ASM(1)					\
+		"leaq " __rseq_str(cs_label) "(%%rip), %%rax\n\t"	\
+		"movq %%rax, %[" __rseq_str(rseq_cs) "]\n\t"		\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+		RSEQ_INJECT_ASM(2)					\
+		"cmpl %[" __rseq_str(cpu_id) "], %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"jnz " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		/* Disassembler-friendly signature: nopl <sig>(%rip). */\
+		".byte 0x0f, 0x1f, 0x05\n\t"				\
+		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jmp %l[" __rseq_str(abort_label) "]\n\t"		\
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jmp %l[" __rseq_str(cmpfail_label) "]\n\t"		\
+		".popsection\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"movq %[v], %%rbx\n\t"
+		"cmpq %%rbx, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"movq %[v], %%rbx\n\t"
+		"cmpq %%rbx, %[expectnot]\n\t"
+		"je %l[error2]\n\t"
+#endif
+		"movq %%rbx, %[load]\n\t"
+		"addq %[voffp], %%rbx\n\t"
+		"movq (%%rbx), %%rbx\n\t"
+		/* final store */
+		"movq %%rbx, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"er" (voffp),
+		  [load]		"m" (*load)
+		: "memory", "cc", "rax", "rbx"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		/* final store */
+		"addq %[count], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"er" (count)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movq %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* x86-64 is TSO. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	return rseq_cmpeqv_trystorev_storev(v, expect, v2, newv2, newv, cpu);
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"cmpq %[v2], %[expect2]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"cmpq %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+		"cmpq %[v2], %[expect2]\n\t"
+		"jnz %l[error3]\n\t"
+#endif
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uint64_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		"movq %[src], %[rseq_scratch0]\n\t"
+		"movq %[dst], %[rseq_scratch1]\n\t"
+		"movq %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		"cmpq %[v], %[expect]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movq %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movq %[rseq_scratch2], %[len]\n\t"
+		"movq %[rseq_scratch1], %[dst]\n\t"
+		"movq %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movq %[rseq_scratch2], %[len]\n\t"
+			"movq %[rseq_scratch1], %[dst]\n\t"
+			"movq %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		: "memory", "cc", "rax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* x86-64 is TSO. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	return rseq_cmpeqv_trymemcpy_storev(v, expect, dst, src, len,
+					    newv, cpu);
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
+
+#elif __i386__
+
+#define rseq_smp_mb()	\
+	__asm__ __volatile__ ("lock; addl $0,-128(%%esp)" ::: "memory", "cc")
+#define rseq_smp_rmb()	\
+	__asm__ __volatile__ ("lock; addl $0,-128(%%esp)" ::: "memory", "cc")
+#define rseq_smp_wmb()	\
+	__asm__ __volatile__ ("lock; addl $0,-128(%%esp)" ::: "memory", "cc")
+
+#define rseq_smp_load_acquire(p)					\
+__extension__ ({							\
+	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_smp_mb();							\
+	____p1;								\
+})
+
+#define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
+
+#define rseq_smp_store_release(p, v)					\
+do {									\
+	rseq_smp_mb();							\
+	RSEQ_WRITE_ONCE(*p, v);						\
+} while (0)
+
+#ifdef RSEQ_SKIP_FASTPATH
+#include "rseq-skip.h"
+#else /* !RSEQ_SKIP_FASTPATH */
+
+/*
+ * Use eax as scratch register and take memory operands as input to
+ * lessen register pressure. Especially needed when compiling in O0.
+ */
+#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
+				start_ip, post_commit_offset, abort_ip)	\
+		".pushsection __rseq_table, \"aw\"\n\t"			\
+		".balign 32\n\t"					\
+		__rseq_str(label) ":\n\t"				\
+		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
+		".long " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
+	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
+				(post_commit_ip - start_ip), abort_ip)
+
+#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
+		RSEQ_INJECT_ASM(1)					\
+		"movl $" __rseq_str(cs_label) ", %[rseq_cs]\n\t"	\
+		__rseq_str(label) ":\n\t"
+
+#define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)		\
+		RSEQ_INJECT_ASM(2)					\
+		"cmpl %[" __rseq_str(cpu_id) "], %[" __rseq_str(current_cpu_id) "]\n\t" \
+		"jnz " __rseq_str(label) "\n\t"
+
+#define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		/* Disassembler-friendly signature: nopl <sig>. */	\
+		".byte 0x0f, 0x1f, 0x05\n\t"				\
+		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jmp %l[" __rseq_str(abort_label) "]\n\t"		\
+		".popsection\n\t"
+
+#define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)		\
+		".pushsection __rseq_failure, \"ax\"\n\t"		\
+		__rseq_str(label) ":\n\t"				\
+		teardown						\
+		"jmp %l[" __rseq_str(cmpfail_label) "]\n\t"		\
+		".popsection\n\t"
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/*
+ * Compare @v against @expectnot. When it does _not_ match, load @v
+ * into @load, and store the content of *@v + voffp into @v.
+ */
+static inline __attribute__((always_inline))
+int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
+			       off_t voffp, intptr_t *load, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[v], %%ebx\n\t"
+		"cmpl %%ebx, %[expectnot]\n\t"
+		"je %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"movl %[v], %%ebx\n\t"
+		"cmpl %%ebx, %[expectnot]\n\t"
+		"je %l[error2]\n\t"
+#endif
+		"movl %%ebx, %[load]\n\t"
+		"addl %[voffp], %%ebx\n\t"
+		"movl (%%ebx), %%ebx\n\t"
+		/* final store */
+		"movl %%ebx, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(5)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expectnot]		"r" (expectnot),
+		  [voffp]		"ir" (voffp),
+		  [load]		"m" (*load)
+		: "memory", "cc", "eax", "ebx"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_addv(intptr_t *v, intptr_t count, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+#endif
+		/* final store */
+		"addl %[count], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(4)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [count]		"ir" (count)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
+				 intptr_t *v2, intptr_t newv2,
+				 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movl %[newv2], %%eax\n\t"
+		"movl %%eax, %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"m" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
+					 intptr_t *v2, intptr_t newv2,
+					 intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %[v], %%eax\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"movl %[expect], %%eax\n\t"
+		"cmpl %[v], %%eax\n\t"
+		"jnz %l[error2]\n\t"
+#endif
+		/* try store */
+		"movl %[newv2], %[v2]\n\t"
+		RSEQ_INJECT_ASM(5)
+		"lock; addl $0,-128(%%esp)\n\t"
+		/* final store */
+		"movl %[newv], %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* try store input */
+		  [v2]			"m" (*v2),
+		  [newv2]		"r" (newv2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"r" (newv)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+
+}
+
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
+			      intptr_t *v2, intptr_t expect2,
+			      intptr_t newv, int cpu)
+{
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(4)
+		"cmpl %[expect2], %[v2]\n\t"
+		"jnz %l[cmpfail]\n\t"
+		RSEQ_INJECT_ASM(5)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, %l[error1])
+		"cmpl %[v], %[expect]\n\t"
+		"jnz %l[error2]\n\t"
+		"cmpl %[expect2], %[v2]\n\t"
+		"jnz %l[error3]\n\t"
+#endif
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		RSEQ_ASM_DEFINE_ABORT(4, "", abort)
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* cmp2 input */
+		  [v2]			"m" (*v2),
+		  [expect2]		"r" (expect2),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"r" (expect),
+		  [newv]		"m" (newv)
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2, error3
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("1st expected value comparison failed");
+error3:
+	rseq_bug("2nd expected value comparison failed");
+#endif
+}
+
+/* TODO: implement a faster memcpy. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
+				 void *dst, void *src, size_t len,
+				 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		"movl %[src], %[rseq_scratch0]\n\t"
+		"movl %[dst], %[rseq_scratch1]\n\t"
+		"movl %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movl %[rseq_scratch2], %[len]\n\t"
+		"movl %[rseq_scratch1], %[dst]\n\t"
+		"movl %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"m" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+/* TODO: implement a faster memcpy. */
+static inline __attribute__((always_inline))
+int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
+					 void *dst, void *src, size_t len,
+					 intptr_t newv, int cpu)
+{
+	uint32_t rseq_scratch[3];
+
+	RSEQ_INJECT_C(9)
+
+	__asm__ __volatile__ goto (
+		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		"movl %[src], %[rseq_scratch0]\n\t"
+		"movl %[dst], %[rseq_scratch1]\n\t"
+		"movl %[len], %[rseq_scratch2]\n\t"
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
+		RSEQ_INJECT_ASM(3)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 5f\n\t"
+		RSEQ_INJECT_ASM(4)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 6f)
+		"movl %[expect], %%eax\n\t"
+		"cmpl %%eax, %[v]\n\t"
+		"jnz 7f\n\t"
+#endif
+		/* try memcpy */
+		"test %[len], %[len]\n\t" \
+		"jz 333f\n\t" \
+		"222:\n\t" \
+		"movb (%[src]), %%al\n\t" \
+		"movb %%al, (%[dst])\n\t" \
+		"inc %[src]\n\t" \
+		"inc %[dst]\n\t" \
+		"dec %[len]\n\t" \
+		"jnz 222b\n\t" \
+		"333:\n\t" \
+		RSEQ_INJECT_ASM(5)
+		"lock; addl $0,-128(%%esp)\n\t"
+		"movl %[newv], %%eax\n\t"
+		/* final store */
+		"movl %%eax, %[v]\n\t"
+		"2:\n\t"
+		RSEQ_INJECT_ASM(6)
+		/* teardown */
+		"movl %[rseq_scratch2], %[len]\n\t"
+		"movl %[rseq_scratch1], %[dst]\n\t"
+		"movl %[rseq_scratch0], %[src]\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			abort)
+		RSEQ_ASM_DEFINE_CMPFAIL(5,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			cmpfail)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_CMPFAIL(6,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error1)
+		RSEQ_ASM_DEFINE_CMPFAIL(7,
+			"movl %[rseq_scratch2], %[len]\n\t"
+			"movl %[rseq_scratch1], %[dst]\n\t"
+			"movl %[rseq_scratch0], %[src]\n\t",
+			error2)
+#endif
+		: /* gcc asm goto does not allow outputs */
+		: [cpu_id]		"r" (cpu),
+		  [current_cpu_id]	"m" (__rseq_abi.cpu_id),
+		  [rseq_cs]		"m" (__rseq_abi.rseq_cs),
+		  /* final store input */
+		  [v]			"m" (*v),
+		  [expect]		"m" (expect),
+		  [newv]		"m" (newv),
+		  /* try memcpy input */
+		  [dst]			"r" (dst),
+		  [src]			"r" (src),
+		  [len]			"r" (len),
+		  [rseq_scratch0]	"m" (rseq_scratch[0]),
+		  [rseq_scratch1]	"m" (rseq_scratch[1]),
+		  [rseq_scratch2]	"m" (rseq_scratch[2])
+		: "memory", "cc", "eax"
+		  RSEQ_INJECT_CLOBBER
+		: abort, cmpfail
+#ifdef RSEQ_COMPARE_TWICE
+		  , error1, error2
+#endif
+	);
+	return 0;
+abort:
+	RSEQ_INJECT_FAILED
+	return -1;
+cmpfail:
+	return 1;
+#ifdef RSEQ_COMPARE_TWICE
+error1:
+	rseq_bug("cpu_id comparison failed");
+error2:
+	rseq_bug("expected value comparison failed");
+#endif
+}
+
+#endif /* !RSEQ_SKIP_FASTPATH */
+
+#endif
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
new file mode 100644
index 000000000000..4847e97ed049
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * rseq.c
+ *
+ * Copyright (C) 2016 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; only
+ * version 2.1 of the License.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * Lesser General Public License for more details.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <syscall.h>
+#include <assert.h>
+#include <signal.h>
+
+#include "rseq.h"
+
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]))
+
+__attribute__((tls_model("initial-exec"))) __thread
+volatile struct rseq __rseq_abi = {
+	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
+};
+
+static __attribute__((tls_model("initial-exec"))) __thread
+volatile int refcount;
+
+static void signal_off_save(sigset_t *oldset)
+{
+	sigset_t set;
+	int ret;
+
+	sigfillset(&set);
+	ret = pthread_sigmask(SIG_BLOCK, &set, oldset);
+	if (ret)
+		abort();
+}
+
+static void signal_restore(sigset_t oldset)
+{
+	int ret;
+
+	ret = pthread_sigmask(SIG_SETMASK, &oldset, NULL);
+	if (ret)
+		abort();
+}
+
+static int sys_rseq(volatile struct rseq *rseq_abi, uint32_t rseq_len,
+		    int flags, uint32_t sig)
+{
+	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
+}
+
+int rseq_register_current_thread(void)
+{
+	int rc, ret = 0;
+	sigset_t oldset;
+
+	signal_off_save(&oldset);
+	if (refcount++)
+		goto end;
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
+	if (!rc) {
+		assert(rseq_current_cpu_raw() >= 0);
+		goto end;
+	}
+	if (errno != EBUSY)
+		__rseq_abi.cpu_id = -2;
+	ret = -1;
+	refcount--;
+end:
+	signal_restore(oldset);
+	return ret;
+}
+
+int rseq_unregister_current_thread(void)
+{
+	int rc, ret = 0;
+	sigset_t oldset;
+
+	signal_off_save(&oldset);
+	if (--refcount)
+		goto end;
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
+		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
+	if (!rc)
+		goto end;
+	ret = -1;
+end:
+	signal_restore(oldset);
+	return ret;
+}
+
+int32_t rseq_fallback_current_cpu(void)
+{
+	int32_t cpu;
+
+	cpu = sched_getcpu();
+	if (cpu < 0) {
+		perror("sched_getcpu()");
+		abort();
+	}
+	return cpu;
+}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
new file mode 100644
index 000000000000..0a808575cbc4
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * rseq.h
+ *
+ * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef RSEQ_H
+#define RSEQ_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sched.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <linux/rseq.h>
+
+/*
+ * Empty code injection macros, override when testing.
+ * It is important to consider that the ASM injection macros need to be
+ * fully reentrant (e.g. do not modify the stack).
+ */
+#ifndef RSEQ_INJECT_ASM
+#define RSEQ_INJECT_ASM(n)
+#endif
+
+#ifndef RSEQ_INJECT_C
+#define RSEQ_INJECT_C(n)
+#endif
+
+#ifndef RSEQ_INJECT_INPUT
+#define RSEQ_INJECT_INPUT
+#endif
+
+#ifndef RSEQ_INJECT_CLOBBER
+#define RSEQ_INJECT_CLOBBER
+#endif
+
+#ifndef RSEQ_INJECT_FAILED
+#define RSEQ_INJECT_FAILED
+#endif
+
+extern __thread volatile struct rseq __rseq_abi;
+
+#define rseq_likely(x)		__builtin_expect(!!(x), 1)
+#define rseq_unlikely(x)	__builtin_expect(!!(x), 0)
+#define rseq_barrier()		__asm__ __volatile__("" : : : "memory")
+
+#define RSEQ_ACCESS_ONCE(x)	(*(__volatile__  __typeof__(x) *)&(x))
+#define RSEQ_WRITE_ONCE(x, v)	__extension__ ({ RSEQ_ACCESS_ONCE(x) = (v); })
+#define RSEQ_READ_ONCE(x)	RSEQ_ACCESS_ONCE(x)
+
+#define __rseq_str_1(x)	#x
+#define __rseq_str(x)		__rseq_str_1(x)
+
+#define rseq_log(fmt, args...)						       \
+	fprintf(stderr, fmt "(in %s() at " __FILE__ ":" __rseq_str(__LINE__)"\n", \
+		## args, __func__)
+
+#define rseq_bug(fmt, args...)		\
+	do {				\
+		rseq_log(fmt, ##args);	\
+		abort();		\
+	} while (0)
+
+#if defined(__x86_64__) || defined(__i386__)
+#include <rseq-x86.h>
+#elif defined(__ARMEL__)
+#include <rseq-arm.h>
+#elif defined(__PPC__)
+#include <rseq-ppc.h>
+#else
+#error unsupported target
+#endif
+
+/*
+ * Register rseq for the current thread. This needs to be called once
+ * by any thread which uses restartable sequences, before they start
+ * using restartable sequences, to ensure restartable sequences
+ * succeed. A restartable sequence executed from a non-registered
+ * thread will always fail.
+ */
+int rseq_register_current_thread(void);
+
+/*
+ * Unregister rseq for current thread.
+ */
+int rseq_unregister_current_thread(void);
+
+/*
+ * Restartable sequence fallback for reading the current CPU number.
+ */
+int32_t rseq_fallback_current_cpu(void);
+
+/*
+ * Values returned can be either the current CPU number, -1 (rseq is
+ * uninitialized), or -2 (rseq initialization has failed).
+ */
+static inline int32_t rseq_current_cpu_raw(void)
+{
+	return RSEQ_ACCESS_ONCE(__rseq_abi.cpu_id);
+}
+
+/*
+ * Returns a possible CPU number, which is typically the current CPU.
+ * The returned CPU number can be used to prepare for an rseq critical
+ * section, which will confirm whether the cpu number is indeed the
+ * current one, and whether rseq is initialized.
+ *
+ * The CPU number returned by rseq_cpu_start should always be validated
+ * by passing it to a rseq asm sequence, or by comparing it to the
+ * return value of rseq_current_cpu_raw() if the rseq asm sequence
+ * does not need to be invoked.
+ */
+static inline uint32_t rseq_cpu_start(void)
+{
+	return RSEQ_ACCESS_ONCE(__rseq_abi.cpu_id_start);
+}
+
+static inline uint32_t rseq_current_cpu(void)
+{
+	int32_t cpu;
+
+	cpu = rseq_current_cpu_raw();
+	if (rseq_unlikely(cpu < 0))
+		cpu = rseq_fallback_current_cpu();
+	return cpu;
+}
+
+/*
+ * rseq_prepare_unload() should be invoked by each thread using rseq_finish*()
+ * at least once between their last rseq_finish*() and library unload of the
+ * library defining the rseq critical section (struct rseq_cs). This also
+ * applies to use of rseq in code generated by JIT: rseq_prepare_unload()
+ * should be invoked at least once by each thread using rseq_finish*() before
+ * reclaim of the memory holding the struct rseq_cs.
+ */
+static inline void rseq_prepare_unload(void)
+{
+	__rseq_abi.rseq_cs = 0;
+}
+
+#endif  /* RSEQ_H_ */
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
new file mode 100644
index 000000000000..3acd6d75ff9f
--- /dev/null
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -0,0 +1,121 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+ or MIT
+
+EXTRA_ARGS=${@}
+
+OLDIFS="$IFS"
+IFS=$'\n'
+TEST_LIST=(
+	"-T s"
+	"-T l"
+	"-T b"
+	"-T b -M"
+	"-T m"
+	"-T m -M"
+	"-T i"
+)
+
+TEST_NAME=(
+	"spinlock"
+	"list"
+	"buffer"
+	"buffer with barrier"
+	"memcpy"
+	"memcpy with barrier"
+	"increment"
+)
+IFS="$OLDIFS"
+
+REPS=1000
+SLOW_REPS=100
+
+function do_tests()
+{
+	local i=0
+	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
+		echo "Running test ${TEST_NAME[$i]}"
+		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		echo "Running compare-twice test ${TEST_NAME[$i]}"
+		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
+		let "i++"
+	done
+}
+
+echo "Default parameters"
+do_tests
+
+echo "Loop injection: 10000 loops"
+
+OLDIFS="$IFS"
+IFS=$'\n'
+INJECT_LIST=(
+	"1"
+	"2"
+	"3"
+	"4"
+	"5"
+	"6"
+	"7"
+	"8"
+	"9"
+)
+IFS="$OLDIFS"
+
+NR_LOOPS=10000
+
+i=0
+while [ "$i" -lt "${#INJECT_LIST[@]}" ]; do
+	echo "Injecting at <${INJECT_LIST[$i]}>"
+	do_tests -${INJECT_LIST[i]} ${NR_LOOPS}
+	let "i++"
+done
+NR_LOOPS=
+
+function inject_blocking()
+{
+	OLDIFS="$IFS"
+	IFS=$'\n'
+	INJECT_LIST=(
+		"7"
+		"8"
+		"9"
+	)
+	IFS="$OLDIFS"
+
+	NR_LOOPS=-1
+
+	i=0
+	while [ "$i" -lt "${#INJECT_LIST[@]}" ]; do
+		echo "Injecting at <${INJECT_LIST[$i]}>"
+		do_tests -${INJECT_LIST[i]} -1 ${@}
+		let "i++"
+	done
+	NR_LOOPS=
+}
+
+echo "Yield injection (25%)"
+inject_blocking -m 4 -y
+
+echo "Yield injection (50%)"
+inject_blocking -m 2 -y
+
+echo "Yield injection (100%)"
+inject_blocking -m 1 -y
+
+echo "Kill injection (25%)"
+inject_blocking -m 4 -k
+
+echo "Kill injection (50%)"
+inject_blocking -m 2 -k
+
+echo "Kill injection (100%)"
+inject_blocking -m 1 -k
+
+echo "Sleep injection (1ms, 25%)"
+inject_blocking -m 4 -s 1
+
+echo "Sleep injection (1ms, 50%)"
+inject_blocking -m 2 -s 1
+
+echo "Sleep injection (1ms, 100%)"
+inject_blocking -m 1 -s 1
