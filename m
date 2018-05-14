Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbeENJsA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:48:00 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38330 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752611AbeENJr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:47:56 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        dave.martin@arm.com, james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk, will.deacon@arm.com
Subject: [PATCH 13/18] kernel: add kcompat_sys_{f,}statfs64()
Date: Mon, 14 May 2018 10:46:35 +0100
Message-Id: <20180514094640.27569-14-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180514094640.27569-1-mark.rutland@arm.com>
References: <20180514094640.27569-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this helper allows us to avoid the in-kernel calls to the
compat_sys_{f,}statfs64() sycalls, as are necessary for parameter
mangling in arm64's compat handling.

Following the example of ksys_* functions, kcompat_sys_* functions are
intended to be a drop-in replacement for their compat_sys_*
counterparts, with the same calling convention.

This is necessary to enable conversion of arm64's syscall handling to
use pt_regs wrappers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/statfs.c              | 14 ++++++++++++--
 include/linux/syscalls.h |  8 ++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/statfs.c b/fs/statfs.c
index 5b2a24f0f263..f0216629621d 100644
--- a/fs/statfs.c
+++ b/fs/statfs.c
@@ -335,7 +335,7 @@ static int put_compat_statfs64(struct compat_statfs64 __user *ubuf, struct kstat
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz, struct compat_statfs64 __user * buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -349,7 +349,12 @@ COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, s
 	return error;
 }
 
-COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+COMPAT_SYSCALL_DEFINE3(statfs64, const char __user *, pathname, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+{
+	return kcompat_sys_statfs64(pathname, sz, buf);
+}
+
+int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz, struct compat_statfs64 __user * buf)
 {
 	struct kstatfs tmp;
 	int error;
@@ -363,6 +368,11 @@ COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct co
 	return error;
 }
 
+COMPAT_SYSCALL_DEFINE3(fstatfs64, unsigned int, fd, compat_size_t, sz, struct compat_statfs64 __user *, buf)
+{
+	return kcompat_sys_fstatfs64(fd, sz, buf);
+}
+
 /*
  * This is a copy of sys_ustat, just dealing with a structure layout.
  * Given how simple this syscall is that apporach is more maintainable
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 6723ea51ec99..e0bf3e4bb897 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -59,6 +59,7 @@ struct tms;
 struct utimbuf;
 struct mq_attr;
 struct compat_stat;
+struct compat_statfs64;
 struct compat_timeval;
 struct robust_list_head;
 struct getcpu_cache;
@@ -1150,6 +1151,13 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 ssize_t ksys_readahead(int fd, loff_t offset, size_t count);
 unsigned int ksys_personality(unsigned int personality);
 
+#ifdef CONFIG_COMPAT
+int kcompat_sys_statfs64(const char __user * pathname, compat_size_t sz,
+		     struct compat_statfs64 __user * buf);
+int kcompat_sys_fstatfs64(unsigned int fd, compat_size_t sz,
+			  struct compat_statfs64 __user * buf);
+#endif
+
 /*
  * The following kernel syscall equivalents are just wrappers to fs-internal
  * functions. Therefore, provide stubs to be inlined at the callsites.
-- 
2.11.0
