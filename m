Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0472C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5848B20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5848B20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeICRjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:39:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeICRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:39:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83DIdc63313870
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 06:18:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83DIdx43313867;
        Mon, 3 Sep 2018 06:18:39 -0700
Date:   Mon, 3 Sep 2018 06:18:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jann Horn <tipbot@zytor.com>
Message-ID: <tip-9da3f2b74054406f87dff7101a569217ffceb29b@git.kernel.org>
Cc:     naveen.n.rao@linux.vnet.ibm.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, davem@davemloft.net, jannh@google.com,
        mhiramat@kernel.org, anil.s.keshavamurthy@intel.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, mingo@kernel.org
Reply-To: keescook@chromium.org, viro@zeniv.linux.org.uk,
          naveen.n.rao@linux.vnet.ibm.com, hpa@zytor.com,
          tglx@linutronix.de, luto@kernel.org,
          anil.s.keshavamurthy@intel.com, davem@davemloft.net,
          mhiramat@kernel.org, jannh@google.com, bp@alien8.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180828201421.157735-7-jannh@google.com>
References: <20180828201421.157735-7-jannh@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] x86/fault: BUG() when uaccess helpers fault on
 kernel addresses
Git-Commit-ID: 9da3f2b74054406f87dff7101a569217ffceb29b
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

Commit-ID:  9da3f2b74054406f87dff7101a569217ffceb29b
Gitweb:     https://git.kernel.org/tip/9da3f2b74054406f87dff7101a569217ffceb29b
Author:     Jann Horn <jannh@google.com>
AuthorDate: Tue, 28 Aug 2018 22:14:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 15:12:09 +0200

x86/fault: BUG() when uaccess helpers fault on kernel addresses

There have been multiple kernel vulnerabilities that permitted userspace to
pass completely unchecked pointers through to userspace accessors:

 - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
   access_ok() checks")
 - the sg/bsg read/write APIs
 - the infiniband read/write APIs

These don't happen all that often, but when they do happen, it is hard to
test for them properly; and it is probably also hard to discover them with
fuzzing. Even when an unmapped kernel address is supplied to such buggy
code, it just returns -EFAULT instead of doing a proper BUG() or at least
WARN().

Try to make such misbehaving code a bit more visible by refusing to do a
fixup in the pagefault handler code when a userspace accessor causes a #PF
on a kernel address and the current context isn't whitelisted.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: kernel-hardening@lists.openwall.com
Cc: dvyukov@google.com
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/20180828201421.157735-7-jannh@google.com

---
 arch/x86/mm/extable.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c        |  2 ++
 include/linux/sched.h |  6 ++++++
 mm/maccess.c          |  6 ++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 856fa409c536..6521134057e8 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -117,11 +117,67 @@ __visible bool ex_handler_fprestore(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL_GPL(ex_handler_fprestore);
 
+/* Helper to check whether a uaccess fault indicates a kernel bug. */
+static bool bogus_uaccess(struct pt_regs *regs, int trapnr,
+			  unsigned long fault_addr)
+{
+	/* This is the normal case: #PF with a fault address in userspace. */
+	if (trapnr == X86_TRAP_PF && fault_addr < TASK_SIZE_MAX)
+		return false;
+
+	/*
+	 * This code can be reached for machine checks, but only if the #MC
+	 * handler has already decided that it looks like a candidate for fixup.
+	 * This e.g. happens when attempting to access userspace memory which
+	 * the CPU can't access because of uncorrectable bad memory.
+	 */
+	if (trapnr == X86_TRAP_MC)
+		return false;
+
+	/*
+	 * There are two remaining exception types we might encounter here:
+	 *  - #PF for faulting accesses to kernel addresses
+	 *  - #GP for faulting accesses to noncanonical addresses
+	 * Complain about anything else.
+	 */
+	if (trapnr != X86_TRAP_PF && trapnr != X86_TRAP_GP) {
+		WARN(1, "unexpected trap %d in uaccess\n", trapnr);
+		return false;
+	}
+
+	/*
+	 * This is a faulting memory access in kernel space, on a kernel
+	 * address, in a usercopy function. This can e.g. be caused by improper
+	 * use of helpers like __put_user and by improper attempts to access
+	 * userspace addresses in KERNEL_DS regions.
+	 * The one (semi-)legitimate exception are probe_kernel_{read,write}(),
+	 * which can be invoked from places like kgdb, /dev/mem (for reading)
+	 * and privileged BPF code (for reading).
+	 * The probe_kernel_*() functions set the kernel_uaccess_faults_ok flag
+	 * to tell us that faulting on kernel addresses, and even noncanonical
+	 * addresses, in a userspace accessor does not necessarily imply a
+	 * kernel bug, root might just be doing weird stuff.
+	 */
+	if (current->kernel_uaccess_faults_ok)
+		return false;
+
+	/* This is bad. Refuse the fixup so that we go into die(). */
+	if (trapnr == X86_TRAP_PF) {
+		pr_emerg("BUG: pagefault on kernel address 0x%lx in non-whitelisted uaccess\n",
+			 fault_addr);
+	} else {
+		pr_emerg("BUG: GPF in non-whitelisted uaccess (non-canonical address?)\n");
+	}
+	return true;
+}
+
 __visible bool ex_handler_uaccess(const struct exception_table_entry *fixup,
 				  struct pt_regs *regs, int trapnr,
 				  unsigned long error_code,
 				  unsigned long fault_addr)
 {
+	if (bogus_uaccess(regs, trapnr, fault_addr))
+		return false;
 	regs->ip = ex_fixup_addr(fixup);
 	return true;
 }
@@ -132,6 +188,8 @@ __visible bool ex_handler_ext(const struct exception_table_entry *fixup,
 			      unsigned long error_code,
 			      unsigned long fault_addr)
 {
+	if (bogus_uaccess(regs, trapnr, fault_addr))
+		return false;
 	/* Special hack for uaccess_err */
 	current->thread.uaccess_err = 1;
 	regs->ip = ex_fixup_addr(fixup);
diff --git a/fs/namespace.c b/fs/namespace.c
index 99186556f8d3..d86830c86ce8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2642,6 +2642,7 @@ static long exact_copy_from_user(void *to, const void __user * from,
 	if (!access_ok(VERIFY_READ, from, n))
 		return n;
 
+	current->kernel_uaccess_faults_ok++;
 	while (n) {
 		if (__get_user(c, f)) {
 			memset(t, 0, n);
@@ -2651,6 +2652,7 @@ static long exact_copy_from_user(void *to, const void __user * from,
 		f++;
 		n--;
 	}
+	current->kernel_uaccess_faults_ok--;
 	return n;
 }
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 977cb57d7bc9..56dd65f1be4f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -739,6 +739,12 @@ struct task_struct {
 	unsigned			use_memdelay:1;
 #endif
 
+	/*
+	 * May usercopy functions fault on kernel addresses?
+	 * This is not just a single bit because this can potentially nest.
+	 */
+	unsigned int			kernel_uaccess_faults_ok;
+
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
 	struct restart_block		restart_block;
diff --git a/mm/maccess.c b/mm/maccess.c
index ec00be51a24f..f3416632e5a4 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -30,8 +30,10 @@ long __probe_kernel_read(void *dst, const void *src, size_t size)
 
 	set_fs(KERNEL_DS);
 	pagefault_disable();
+	current->kernel_uaccess_faults_ok++;
 	ret = __copy_from_user_inatomic(dst,
 			(__force const void __user *)src, size);
+	current->kernel_uaccess_faults_ok--;
 	pagefault_enable();
 	set_fs(old_fs);
 
@@ -58,7 +60,9 @@ long __probe_kernel_write(void *dst, const void *src, size_t size)
 
 	set_fs(KERNEL_DS);
 	pagefault_disable();
+	current->kernel_uaccess_faults_ok++;
 	ret = __copy_to_user_inatomic((__force void __user *)dst, src, size);
+	current->kernel_uaccess_faults_ok--;
 	pagefault_enable();
 	set_fs(old_fs);
 
@@ -94,11 +98,13 @@ long strncpy_from_unsafe(char *dst, const void *unsafe_addr, long count)
 
 	set_fs(KERNEL_DS);
 	pagefault_disable();
+	current->kernel_uaccess_faults_ok++;
 
 	do {
 		ret = __get_user(*dst++, (const char __user __force *)src++);
 	} while (dst[-1] && ret == 0 && src - unsafe_addr < count);
 
+	current->kernel_uaccess_faults_ok--;
 	dst[-1] = '\0';
 	pagefault_enable();
 	set_fs(old_fs);
