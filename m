Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeCOTJ1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:09:27 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:36262 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932668AbeCOTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:23 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
Cc: luto@kernel.org, mingo@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Subject: [PATCH v2 23/36] fs: add ksys_sync_file_range helper(); remove in-kernel calls to syscall
Date: Thu, 15 Mar 2018 20:05:16 +0100
Message-Id: <20180315190529.20943-24-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180315190529.20943-1-linux@dominikbrodowski.net>
References: <20180315190529.20943-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
sys_sync_file_range() syscall.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/mips/kernel/linux32.c      |  2 +-
 arch/parisc/kernel/sys_parisc.c |  2 +-
 arch/powerpc/kernel/sys_ppc32.c |  2 +-
 arch/s390/kernel/compat_linux.c |  2 +-
 arch/sparc/kernel/sys_sparc32.c |  2 +-
 arch/x86/ia32/sys_ia32.c        |  6 +++---
 fs/sync.c                       | 12 +++++++++---
 include/linux/syscalls.h        |  2 ++
 8 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 0ce4f7240f69..db895771ab06 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -139,7 +139,7 @@ asmlinkage long sys32_sync_file_range(int fd, int __pad,
 	unsigned long a4, unsigned long a5,
 	int flags)
 {
-	return sys_sync_file_range(fd,
+	return ksys_sync_file_range(fd,
 			merge_64(a2, a3), merge_64(a4, a5),
 			flags);
 }
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 572feeea834c..0b0e1cfb4bd9 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -360,7 +360,7 @@ asmlinkage long parisc_sync_file_range(int fd,
 			u32 hi_off, u32 lo_off, u32 hi_nbytes, u32 lo_nbytes,
 			unsigned int flags)
 {
-	return sys_sync_file_range(fd, (loff_t)hi_off << 32 | lo_off,
+	return ksys_sync_file_range(fd, (loff_t)hi_off << 32 | lo_off,
 			(loff_t)hi_nbytes << 32 | lo_nbytes, flags);
 }
 
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 93df264ab76c..3871aa9267e6 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -124,5 +124,5 @@ asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int flags,
 	loff_t offset = ((loff_t)offset_hi << 32) | offset_lo;
 	loff_t nbytes = ((loff_t)nbytes_hi << 32) | nbytes_lo;
 
-	return sys_sync_file_range(fd, offset, nbytes, flags);
+	return ksys_sync_file_range(fd, offset, nbytes, flags);
 }
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index a47995a5174c..82e99bf3b00e 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -510,7 +510,7 @@ COMPAT_SYSCALL_DEFINE1(s390_fadvise64_64, struct fadvise64_64_args __user *, arg
 COMPAT_SYSCALL_DEFINE6(s390_sync_file_range, int, fd, u32, offhigh, u32, offlow,
 		       u32, nhigh, u32, nlow, unsigned int, flags)
 {
-	return sys_sync_file_range(fd, ((loff_t)offhigh << 32) + offlow,
+	return ksys_sync_file_range(fd, ((loff_t)offhigh << 32) + offlow,
 				   ((u64)nhigh << 32) + nlow, flags);
 }
 
diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index 08261bc15d30..c56f43893283 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -241,7 +241,7 @@ long compat_sys_fadvise64_64(int fd,
 
 long sys32_sync_file_range(unsigned int fd, unsigned long off_high, unsigned long off_low, unsigned long nb_high, unsigned long nb_low, unsigned int flags)
 {
-	return sys_sync_file_range(fd,
+	return ksys_sync_file_range(fd,
 				   (off_high << 32) | off_low,
 				   (nb_high << 32) | nb_low,
 				   flags);
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index ca28ee07a191..e5b053252a01 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -214,9 +214,9 @@ COMPAT_SYSCALL_DEFINE6(x86_sync_file_range, int, fd, unsigned int, off_low,
 		       unsigned int, off_hi, unsigned int, n_low,
 		       unsigned int, n_hi, int, flags)
 {
-	return sys_sync_file_range(fd,
-				   ((u64)off_hi << 32) | off_low,
-				   ((u64)n_hi << 32) | n_low, flags);
+	return ksys_sync_file_range(fd,
+				    ((u64)off_hi << 32) | off_low,
+				    ((u64)n_hi << 32) | n_low, flags);
 }
 
 COMPAT_SYSCALL_DEFINE5(x86_fadvise64, int, fd, unsigned int, offset_lo,
diff --git a/fs/sync.c b/fs/sync.c
index 6e0a2cbaf6de..ff947c30a6c0 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -280,8 +280,8 @@ SYSCALL_DEFINE1(fdatasync, unsigned int, fd)
  * already-instantiated disk blocks, there are no guarantees here that the data
  * will be available after a crash.
  */
-SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
-				unsigned int, flags)
+int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
+			 unsigned int flags)
 {
 	int ret;
 	struct fd f;
@@ -359,10 +359,16 @@ SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
 	return ret;
 }
 
+SYSCALL_DEFINE4(sync_file_range, int, fd, loff_t, offset, loff_t, nbytes,
+				unsigned int, flags)
+{
+	return ksys_sync_file_range(fd, offset, nbytes, flags);
+}
+
 /* It would be nice if people remember that not all the world's an i386
    when they introduce new system calls */
 SYSCALL_DEFINE4(sync_file_range2, int, fd, unsigned int, flags,
 				 loff_t, offset, loff_t, nbytes)
 {
-	return sys_sync_file_range(fd, offset, nbytes, flags);
+	return ksys_sync_file_range(fd, offset, nbytes, flags);
 }
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 923a4d056137..8f0f99702e7a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -968,5 +968,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			      unsigned long prot, unsigned long flags,
 			      unsigned long fd, unsigned long pgoff);
 int ksys_chdir(const char __user *filename);
+int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
+			 unsigned int flags);
 
 #endif
-- 
2.16.2
