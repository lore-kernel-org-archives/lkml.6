Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9262FECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F77208D9
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F77208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392312AbeIVGQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:16:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44129 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391924AbeIVGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BO-0d; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdp-0000uH-4Z; Sat, 22 Sep 2018 01:19:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Andy Lutomirski" <luto@amacapital.net>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Kees Cook" <keescook@chromium.org>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.25773851@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 57/63] seccomp: add "seccomp" syscall
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 48dc92b9fc3926844257316e75ba11eb5c742b2c upstream.

This adds the new "seccomp" syscall with both an "operation" and "flags"
parameter for future expansion. The third argument is a pointer value,
used with the SECCOMP_SET_MODE_FILTER operation. Currently, flags must
be 0. This is functionally equivalent to prctl(PR_SET_SECCOMP, ...).

In addition to the TSYNC flag later in this patch series, there is a
non-zero chance that this syscall could be used for configuring a fixed
argument area for seccomp-tracer-aware processes to pass syscall arguments
in the future. Hence, the use of "seccomp" not simply "seccomp_add_filter"
for this syscall. Additionally, this syscall uses operation, flags,
and user pointer for arguments because strictly passing arguments via
a user pointer would mean seccomp itself would be unable to trivially
filter the seccomp syscall itself.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/Kconfig                      |  1 +
 arch/x86/syscalls/syscall_32.tbl  |  1 +
 arch/x86/syscalls/syscall_64.tbl  |  1 +
 include/linux/syscalls.h          |  2 ++
 include/uapi/asm-generic/unistd.h |  4 ++-
 include/uapi/linux/seccomp.h      |  4 +++
 kernel/seccomp.c                  | 55 ++++++++++++++++++++++++++++---
 kernel/sys_ni.c                   |  3 ++
 8 files changed, 65 insertions(+), 6 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -321,6 +321,7 @@ config HAVE_ARCH_SECCOMP_FILTER
 	  - secure_computing is called from a ptrace_event()-safe context
 	  - secure_computing return value is checked and a return value of -1
 	    results in the system call being skipped immediately.
+	  - seccomp syscall wired up
 
 config SECCOMP_FILTER
 	def_bool y
--- a/arch/x86/syscalls/syscall_32.tbl
+++ b/arch/x86/syscalls/syscall_32.tbl
@@ -360,3 +360,4 @@
 351	i386	sched_setattr		sys_sched_setattr
 352	i386	sched_getattr		sys_sched_getattr
 353	i386	renameat2		sys_renameat2
+354	i386	seccomp			sys_seccomp
--- a/arch/x86/syscalls/syscall_64.tbl
+++ b/arch/x86/syscalls/syscall_64.tbl
@@ -323,6 +323,7 @@
 314	common	sched_setattr		sys_sched_setattr
 315	common	sched_getattr		sys_sched_getattr
 316	common	renameat2		sys_renameat2
+317	common	seccomp			sys_seccomp
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -866,4 +866,6 @@ asmlinkage long sys_process_vm_writev(pi
 asmlinkage long sys_kcmp(pid_t pid1, pid_t pid2, int type,
 			 unsigned long idx1, unsigned long idx2);
 asmlinkage long sys_finit_module(int fd, const char __user *uargs, int flags);
+asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
+			    const char __user *uargs);
 #endif
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -699,9 +699,11 @@ __SYSCALL(__NR_sched_setattr, sys_sched_
 __SYSCALL(__NR_sched_getattr, sys_sched_getattr)
 #define __NR_renameat2 276
 __SYSCALL(__NR_renameat2, sys_renameat2)
+#define __NR_seccomp 277
+__SYSCALL(__NR_seccomp, sys_seccomp)
 
 #undef __NR_syscalls
-#define __NR_syscalls 277
+#define __NR_syscalls 278
 
 /*
  * All syscalls below here should go away really,
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -10,6 +10,10 @@
 #define SECCOMP_MODE_STRICT	1 /* uses hard-coded filter. */
 #define SECCOMP_MODE_FILTER	2 /* uses user-supplied filter. */
 
+/* Valid operations for seccomp syscall. */
+#define SECCOMP_SET_MODE_STRICT	0
+#define SECCOMP_SET_MODE_FILTER	1
+
 /*
  * All BPF programs must return a 32-bit value.
  * The bottom 16-bits are for optional return data.
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -18,6 +18,7 @@
 #include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/seccomp.h>
+#include <linux/syscalls.h>
 
 /* #define SECCOMP_DEBUG 1 */
 
@@ -314,7 +315,7 @@ free_prog:
  *
  * Returns 0 on success and non-zero otherwise.
  */
-static long seccomp_attach_user_filter(char __user *user_filter)
+static long seccomp_attach_user_filter(const char __user *user_filter)
 {
 	struct sock_fprog fprog;
 	long ret = -EFAULT;
@@ -517,6 +518,7 @@ out:
 #ifdef CONFIG_SECCOMP_FILTER
 /**
  * seccomp_set_mode_filter: internal function for setting seccomp filter
+ * @flags:  flags to change filter behavior
  * @filter: struct sock_fprog containing filter
  *
  * This function may be called repeatedly to install additional filters.
@@ -527,11 +529,16 @@ out:
  *
  * Returns 0 on success or -EINVAL on failure.
  */
-static long seccomp_set_mode_filter(char __user *filter)
+static long seccomp_set_mode_filter(unsigned int flags,
+				    const char __user *filter)
 {
 	const unsigned long seccomp_mode = SECCOMP_MODE_FILTER;
 	long ret = -EINVAL;
 
+	/* Validate flags. */
+	if (flags != 0)
+		goto out;
+
 	if (!seccomp_may_assign_mode(seccomp_mode))
 		goto out;
 
@@ -544,12 +551,35 @@ out:
 	return ret;
 }
 #else
-static inline long seccomp_set_mode_filter(char __user *filter)
+static inline long seccomp_set_mode_filter(unsigned int flags,
+					   const char __user *filter)
 {
 	return -EINVAL;
 }
 #endif
 
+/* Common entry point for both prctl and syscall. */
+static long do_seccomp(unsigned int op, unsigned int flags,
+		       const char __user *uargs)
+{
+	switch (op) {
+	case SECCOMP_SET_MODE_STRICT:
+		if (flags != 0 || uargs != NULL)
+			return -EINVAL;
+		return seccomp_set_mode_strict();
+	case SECCOMP_SET_MODE_FILTER:
+		return seccomp_set_mode_filter(flags, uargs);
+	default:
+		return -EINVAL;
+	}
+}
+
+SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
+			 const char __user *, uargs)
+{
+	return do_seccomp(op, flags, uargs);
+}
+
 /**
  * prctl_set_seccomp: configures current->seccomp.mode
  * @seccomp_mode: requested mode to use
@@ -559,12 +589,27 @@ static inline long seccomp_set_mode_filt
  */
 long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
 {
+	unsigned int op;
+	char __user *uargs;
+
 	switch (seccomp_mode) {
 	case SECCOMP_MODE_STRICT:
-		return seccomp_set_mode_strict();
+		op = SECCOMP_SET_MODE_STRICT;
+		/*
+		 * Setting strict mode through prctl always ignored filter,
+		 * so make sure it is always NULL here to pass the internal
+		 * check in do_seccomp().
+		 */
+		uargs = NULL;
+		break;
 	case SECCOMP_MODE_FILTER:
-		return seccomp_set_mode_filter(filter);
+		op = SECCOMP_SET_MODE_FILTER;
+		uargs = filter;
+		break;
 	default:
 		return -EINVAL;
 	}
+
+	/* prctl interface doesn't have flags, so they are always zero. */
+	return do_seccomp(op, 0, uargs);
 }
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -213,3 +213,6 @@ cond_syscall(compat_sys_open_by_handle_a
 
 /* compare kernel pointers */
 cond_syscall(sys_kcmp);
+
+/* operate on Secure Computing state */
+cond_syscall(sys_seccomp);

