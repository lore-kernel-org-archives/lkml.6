Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbeCYQZl (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 12:25:41 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:41662 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeCYQZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 12:25:40 -0400
Date: Sun, 25 Mar 2018 18:25:27 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        viro@zeniv.linux.org.uk, x86@kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, luto@amacapital.net
Subject: [PATCH] syscalls: define and explain goal to not call syscalls in
 the kernel
Message-ID: <20180325162527.GA17492@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
through kernel entry points, but not from the kernel itself. This
will allow cleanups and optimizations to the entry paths *and* to
the parts of the kernel code which currently need to pretend to be
userspace in order to make use of syscalls.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

As there have been multiple inquiries on the rationale of my patchsets
removing in-kernel calls to sys_xyzzy(), here is an updated patch 01/NN
which I will push upstream for v4.17-rc1. I will also include a reference
to this mail (and therefore to the explanation below) in all related
patches of the series. Any improvements, hints, suggestions, spelling
fixes, and/or objections?

Thanks,
	Dominik


diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 8cc25a06f353..556613744556 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -487,6 +487,38 @@ patchset, for the convenience of reviewers.
 The man page should be cc'ed to linux-man@vger.kernel.org
 For more details, see https://www.kernel.org/doc/man-pages/patches.html
 
+
+Do not call System Calls in the Kernel
+--------------------------------------
+
+System calls are, as stated above, interaction points between userspace and
+the kernel.  Therefore, system call functions such as ``sys_xyzzy()`` or
+``compat_sys_xyzzy()`` should only be called from userspace via the syscall
+table, but not from elsewhere in the kernel.  If the syscall functionality is
+useful to be used within the kernel, needs to be shared between an old and a
+new syscall, or needs to be shared between a syscall and its compatibility
+variant, it should be implemented by means of a "helper" function (such as
+``kern_xyzzy()``).  This kernel function may then be called within the
+syscall stub (``sys_xyzzy()``), the compatibility syscall stub
+(``compat_sys_xyzzy()``), and/or other kernel code.
+
+At least on 64-bit x86, it will be a hard requirement from v4.17 onwards to not
+call system call functions in the kernel.  It uses a different calling
+convention for system calls where ``struct pt_regs`` is decoded on-the-fly in a
+syscall wrapper which then hands processing over to the actual syscall function.
+This means that only those parameters which are actually needed for a specific
+syscall are passed on during syscall entry, instead of filling in six CPU
+registers with random user space content all the time (which may cause serious
+trouble down the call chain).
+
+Moreover, rules on how data may be accessed may differ between kernel data and
+user data.  This is another reason why calling ``sys_xyzzy()`` is generally a
+bad idea.
+
+Exceptions to this rule are only allowed in architecture-specific overrides,
+architecture-specific compatibility wrappers, or other code in arch/.
+
+
 References and Sources
 ----------------------
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a78186d826d7..0526286a0314 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -941,4 +941,11 @@ asmlinkage long sys_pkey_free(int pkey);
 asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
 			  unsigned mask, struct statx __user *buffer);
 
+
+/*
+ * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
+ * Instead, use one of the functions which work equivalently, such as
+ * the ksys_xyzyyz() functions prototyped below.
+ */
+
 #endif
