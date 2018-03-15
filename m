Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752854AbeCOTMZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:12:25 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36144 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932475AbeCOTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:21 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 01/36] syscalls: define goal to not call sys_xyzzy() from within the kernel
Date: Thu, 15 Mar 2018 20:04:54 +0100
Message-Id: <20180315190529.20943-2-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
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
 Documentation/process/adding-syscalls.rst | 14 --------------
 include/linux/syscalls.h                  |  7 +++++++
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 8cc25a06f353..35a14b730da9 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -201,12 +201,6 @@ followed by the (type, name) pairs for the parameters as arguments.  Using
 this macro allows metadata about the new system call to be made available for
 other tools.
 
-The new entry point also needs a corresponding function prototype, in
-``include/linux/syscalls.h``, marked as asmlinkage to match the way that system
-calls are invoked::
-
-    asmlinkage long sys_xyzzy(...);
-
 Some architectures (e.g. x86) have their own architecture-specific syscall
 tables, but several other architectures share a generic syscall table. Add your
 new system call to the generic list by adding an entry to the list in
@@ -240,7 +234,6 @@ To summarize, you need a commit that includes:
 
  - ``CONFIG`` option for the new function, normally in ``init/Kconfig``
  - ``SYSCALL_DEFINEn(xyzzy, ...)`` for the entry point
- - corresponding prototype in ``include/linux/syscalls.h``
  - generic table entry in ``include/uapi/asm-generic/unistd.h``
  - fallback stub in ``kernel/sys_ni.c``
 
@@ -302,12 +295,6 @@ needed to deal with them.  (Typically, the ``compat_sys_`` version converts the
 values to 64-bit versions and either calls on to the ``sys_`` version, or both of
 them call a common inner implementation function.)
 
-The compat entry point also needs a corresponding function prototype, in
-``include/linux/compat.h``, marked as asmlinkage to match the way that system
-calls are invoked::
-
-    asmlinkage long compat_sys_xyzzy(...);
-
 If the system call involves a structure that is laid out differently on 32-bit
 and 64-bit systems, say ``struct xyzzy_args``, then the include/linux/compat.h
 header file should also include a compat version of the structure (``struct
@@ -344,7 +331,6 @@ version; the entry in ``include/uapi/asm-generic/unistd.h`` should use
 To summarize, you need:
 
  - a ``COMPAT_SYSCALL_DEFINEn(xyzzy, ...)`` for the compat entry point
- - corresponding prototype in ``include/linux/compat.h``
  - (if needed) 32-bit mapping struct in ``include/linux/compat.h``
  - instance of ``__SC_COMP`` not ``__SYSCALL`` in
    ``include/uapi/asm-generic/unistd.h``
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
-- 
2.16.2
