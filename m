Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932259AbeCKPWr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:22:47 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:36396 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbeCKPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:22:46 -0400
X-Google-Smtp-Source: AG47ELuuygbRXhfEhbD3FVuQicLZ6WWUmVn/4rWcC7o0jaH+qePu9DXeF4HaXp4AGhuihiohHQrpKw==
Date: Sun, 11 Mar 2018 18:22:41 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] proc: test last field of /proc/loadavg
Message-ID: <20180311152241.GA26247@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test fork counter formerly known as ->last_pid, the only part of
/proc/loadavg which can be tested.

Testing in init pid namespace is not reliable because of
background activity.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore         |    1 
 tools/testing/selftests/proc/Makefile           |    1 
 tools/testing/selftests/proc/proc-loadavg-001.c |   83 ++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -1,3 +1,4 @@
+/proc-loadavg-001
 /proc-self-map-files-001
 /proc-self-map-files-002
 /proc-self-syscall
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,7 @@
 CFLAGS += -Wall -O2
 
 TEST_GEN_PROGS :=
+TEST_GEN_PROGS += proc-loadavg-001
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-loadavg-001.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright © 2018 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+/* Test that /proc/loadavg correctly reports last pid in pid namespace. */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sched.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+int main(void)
+{
+	pid_t pid;
+	int wstatus;
+
+	if (unshare(CLONE_NEWPID) == -1) {
+		if (errno == ENOSYS || errno == EPERM)
+			return 2;
+		return 1;
+	}
+
+	pid = fork();
+	if (pid == -1)
+		return 1;
+	if (pid == 0) {
+		char buf[128], *p;
+		int fd;
+		ssize_t rv;
+
+		fd = open("/proc/loadavg" , O_RDONLY);
+		if (fd == -1)
+			return 1;
+		rv = read(fd, buf, sizeof(buf));
+		if (rv < 3)
+			return 1;
+		p = buf + rv;
+
+		/* pid 1 */
+		if (!(p[-3] == ' ' && p[-2] == '1' && p[-1] == '\n'))
+			return 1;
+
+		pid = fork();
+		if (pid == -1)
+			return 1;
+		if (pid == 0)
+			return 0;
+		if (waitpid(pid, NULL, 0) == -1)
+			return 1;
+
+		lseek(fd, 0, SEEK_SET);
+		rv = read(fd, buf, sizeof(buf));
+		if (rv < 3)
+			return 1;
+		p = buf + rv;
+
+		/* pid 2 */
+		if (!(p[-3] == ' ' && p[-2] == '2' && p[-1] == '\n'))
+			return 1;
+
+		return 0;
+	}
+
+	if (waitpid(pid, &wstatus, 0) == -1)
+		return 1;
+	if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) == 0)
+		return 0;
+	return 1;
+}
