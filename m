Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbeBZVVu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:21:50 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36381 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBZVVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:21:49 -0500
X-Google-Smtp-Source: AG47ELtPzhMkVCc+Lc6SYqx5Npv7dqdutaYSmDakVI3udmKwQdaxj+vXFszYl/8bop/tX+7AMxCISg==
Date: Tue, 27 Feb 2018 00:21:45 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] proc: test /proc/self/syscall
Message-ID: <20180226212145.GB742@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read from /proc/self/syscall should yield read system call and correct
args in the output as current is reading /proc/self/syscall.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore          |    3 +
 tools/testing/selftests/proc/Makefile            |    1 
 tools/testing/selftests/proc/proc-self-syscall.c |   45 +++++++++++++++++++++++
 3 files changed, 48 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -1 +1,2 @@
-/proc-self-wchan
+/proc-self-mem
+/proc-self-syscall
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,7 @@
 CFLAGS += -Wall -O2
 
 TEST_GEN_PROGS :=
+TEST_GEN_PROGS += proc-self-syscall
 TEST_GEN_PROGS += proc-self-wchan
 
 include ../lib.mk
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-self-syscall.c
@@ -0,0 +1,45 @@
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+
+static inline ssize_t sys_read(int fd, void *buf, size_t len)
+{
+	return syscall(SYS_read, fd, buf, len);
+}
+
+int main(void)
+{
+	char buf1[64];
+	char buf2[64];
+	int fd;
+	ssize_t rv;
+
+	fd = open("/proc/self/syscall", O_RDONLY);
+	if (fd == -1) {
+		if (errno == ENOENT)
+			return 2;
+		return 1;
+	}
+
+	/* Do direct system call as libc can wrap anything. */
+	snprintf(buf1, sizeof(buf1), "%ld 0x%lx 0x%lx 0x%lx",
+		 (long)SYS_read, (long)fd, (long)buf2, (long)sizeof(buf2));
+
+	memset(buf2, 0, sizeof(buf2));
+	rv = sys_read(fd, buf2, sizeof(buf2));
+	if (rv < 0)
+		return 1;
+	if (rv < strlen(buf1))
+		return 1;
+	if (strncmp(buf1, buf2, strlen(buf1)) != 0)
+		return 1;
+
+	return 0;
+}
