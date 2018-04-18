Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx49PyZLlikjpCuNRA9A7BWqHjRs12wvGP0zQ2lcD/PQhGalhh6VcICSOZQvDguTEDoZV9YJs
ARC-Seal: i=1; a=rsa-sha256; t=1524038016; cv=none;
        d=google.com; s=arc-20160816;
        b=luVZfZodi5Mj33Y8X82Bj+iTgE4qV9f2jBhUZLnFOwTePiHOvSrDitJjTValnzq6/v
         j2xdMek3MGW3+0tDkYJIWUTGpSc5OTokVf6Vd52Z+RnMCtVEkrzzQq6PK0B8oUYe0JjC
         D3NH14begMc2MuVUvdl6nOpTgqrdCT9BOVrtZSGwxQtAA5HPD32tFAIA3Wl03TnXJNza
         1+rrLRfp2eVCOHkM6IyjlNwcluximRXei3Kpnt+yG41v6qhSeUpF7djSMp6+nqVwXLAw
         t5tsEDAWOTNw2cONn/wAP/FITVSBJ+LqwPWNgA/wpPTfT+Exq99IaiObZ3IC8UL04PLA
         xcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=KYIxqT+AdeTGwxwWIAAmCoKFkUU1GObQgX1l+KgjwLE=;
        b=yIgKZbmFMC+t8paKYopVK2AGXfZInFivIkyTx9yC6rgQ7KzgKbm0gIuDMWLqZh4qzl
         1G4ny+vLAIXpUu/va1U/u4DX4Ct9F3PHqa+kh+2Y8JsIBLd+AFg/uFrgnh6DM/aPEx4W
         wUUpsiD/prdIEI0dzPtSEEHndnU/MaQvGim9enQCnY4gNvzHtkK3HNvTWlodRXkVcBDO
         /cKri9w5tcm07/VDgDkAbZFG3LPLd3XG5s5LiSXHTpe72FXirG7QnRZpxYVZx2i0oeoZ
         KwqCFUvpDQm8udkhfn1vPp/JDmLe4ufOnA7AwCLtptRrATHs647PGY7jgzc/zfEI8zvc
         /sWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=jBX3Z7Lk;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=jBX3Z7Lk;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeDRHxM (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 18 Apr 2018 03:53:12 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43529 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751865AbeDRHxL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Apr 2018 03:53:11 -0400
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org, christian.brauner@ubuntu.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/2] selftests/filesystems: devpts_pts included wrong header
Date: Wed, 18 Apr 2018 09:52:55 +0200
Message-Id: <20180418075256.300-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598069687315933024?=
X-GMAIL-MSGID: =?utf-8?q?1598069687315933024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We were picking up the wrong header should use asm/ioctls.h form the kernel
and not the header from the system (sys/ioctl.h). In the current code we
added the correct include and we added the kernel headers path to the CFLAGS.

Fixes: ce290a19609d ("selftests: add devpts selftests")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

Hi,

I've been running devpts_pts on a mainline kernel (4.16+git0+60cc43fc88) and
the verify_invalid_ptmx_bind_mount() test failes with this failure:

root@intel-core2-32:~# ./devpts_pts
Failed to perform TIOCGPTPEER ioctl

However, I'm still confused why I'm not able to get the test to pass.  Strace
showes that -ENOENT return in the TIOCGPTPEER implementation in the
kernel. I think the -ENOENT gets returned from this path
devpts_mntget()->devpts_ptmx_path->path_pts().

See the strace issue below:
root@intel-core2-32:~# strace ./devpts_pts
execve("./devpts_pts", ["./devpts_pts"], [/* 17 vars */]) = 0
brk(NULL)                               = 0x5634e0092000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f459d338000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=16726, ...}) = 0
mmap(NULL, 16726, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f459d333000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\260\3\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1681056, ...}) = 0
mmap(NULL, 3787168, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f459cd7b000
mprotect(0x7f459cf0f000, 2093056, PROT_NONE) = 0
mmap(0x7f459d10e000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x193000) = 0x7f459d10e000
mmap(0x7f459d114000, 14752, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f459d114000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f459d331000
arch_prctl(ARCH_SET_FS, 0x7f459d331700) = 0
mprotect(0x7f459d10e000, 16384, PROT_READ) = 0
mprotect(0x5634debe3000, 4096, PROT_READ) = 0
mprotect(0x7f459d33a000, 4096, PROT_READ) = 0
munmap(0x7f459d333000, 16726)           = 0
ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
unshare(CLONE_NEWNS)                    = 0
mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL) = 0
mount("/dev/pts/ptmx", "/dev/ptmx", NULL, MS_BIND, NULL) = 0
open("/dev/ptmx", O_RDWR|O_NOCTTY|O_CLOEXEC) = 3
ioctl(3, TIOCSPTLCK, [0])               = 0
ioctl(3, _IOC(0, 0x54, 0x41, 0x00), 0x80102) = 4
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f459d3319d0) = 4377
wait4(4377, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 4377
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=4377, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
close(3)                                = 0
close(4)                                = 0
getpid()                                = 4376
open("/tmp/devpts_ptmx_Z6aEvy", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
mount("/dev/pts/ptmx", "/tmp/devpts_ptmx_Z6aEvy", NULL, MS_BIND, NULL) = 0
close(3)                                = 0
open("/tmp/devpts_ptmx_Z6aEvy", O_RDWR|O_NOCTTY|O_CLOEXEC) = 3
ioctl(3, TIOCSPTLCK, [0])               = 0
ioctl(3, _IOC(0, 0x54, 0x41, 0x00), 0x80102) = -1 ENOENT (No such file or directory)
write(2, "Failed to perform TIOCGPTPEER io"..., 36Failed to perform TIOCGPTPEER ioctl
) = 36
close(3)                                = 0
umount2("/dev/pts", 0)                  = 0
umount2("/dev/ptmx", 0)                 = 0
mkdir("/tmp/devpts_fs_w22bR6", 0700)    = 0
mount("devpts", "/tmp/devpts_fs_w22bR6", "devpts", MS_NOSUID|MS_NOEXEC, "newinstance,ptmxmode=0666,mode=0"...) = 0
open("/tmp/devpts_fs_w22bR6/ptmx", O_RDWR|O_NOCTTY|O_CLOEXEC) = 3
ioctl(3, TIOCSPTLCK, [0])               = 0
ioctl(3, _IOC(0, 0x54, 0x41, 0x00), 0x80102) = 4
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f459d3319d0) = 4378
wait4(4378, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 4378
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=4378, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
close(3)                                = 0
close(4)                                = 0
unlink("/tmp/devpts_fs_w22bR6")         = -1 EISDIR (Is a directory)
exit_group(0)                           = ?
+++ exited with 0 +++
root@intel-core2-32:~# 

 tools/testing/selftests/filesystems/Makefile     | 1 +
 tools/testing/selftests/filesystems/devpts_pts.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 4e6d09fb166f..427a401aae5c 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_PROGS := dnotify_test devpts_pts
+CFLAGS += -I../../../../usr/include/
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
index b9055e974289..79420b9d00c7 100644
--- a/tools/testing/selftests/filesystems/devpts_pts.c
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -8,7 +8,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <sys/ioctl.h>
+#include <asm/ioctls.h>
 #include <sys/mount.h>
 #include <sys/wait.h>
 
-- 
2.11.0

