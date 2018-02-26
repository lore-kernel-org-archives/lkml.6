Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbeBZVUM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:20:12 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41823 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeBZVUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:20:11 -0500
X-Google-Smtp-Source: AH8x226deCizyhTts0x7YsgVMQarMIAckEVectjKzAgFaVjAYOTsXdJc7SZpE4Zthkgi3nKncjMGcg==
Date: Tue, 27 Feb 2018 00:20:07 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] proc: test /proc/self/wchan
Message-ID: <20180226212006.GA742@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch starts testing /proc. Many more tests to come (I promise).

Read from /proc/self/wchan should always return "0" as
current is in TASK_RUNNING state while reading /proc/self/wchan.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/Makefile               |    1 +
 tools/testing/selftests/proc/.gitignore        |    1 +
 tools/testing/selftests/proc/Makefile          |    6 ++++++
 tools/testing/selftests/proc/config            |    1 +
 tools/testing/selftests/proc/proc-self-wchan.c |   25 +++++++++++++++++++++++++
 6 files changed, 35 insertions(+)

--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -23,6 +23,7 @@ TARGETS += mqueue
 TARGETS += net
 TARGETS += nsfs
 TARGETS += powerpc
+TARGETS += proc
 TARGETS += pstore
 TARGETS += ptrace
 TARGETS += seccomp
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/.gitignore
@@ -0,0 +1 @@
+/proc-self-wchan
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/Makefile
@@ -0,0 +1,6 @@
+CFLAGS += -Wall -O2
+
+TEST_GEN_PROGS :=
+TEST_GEN_PROGS += proc-self-wchan
+
+include ../lib.mk
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/config
@@ -0,0 +1 @@
+CONFIG_PROC_FS=y
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-self-wchan.c
@@ -0,0 +1,25 @@
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+
+int main(void)
+{
+	char buf[64];
+	int fd;
+
+	fd = open("/proc/self/wchan", O_RDONLY);
+	if (fd == -1) {
+		if (errno == ENOENT)
+			return 2;
+		return 1;
+	}
+
+	buf[0] = '\0';
+	if (read(fd, buf, sizeof(buf)) != 1)
+		return 1;
+	if (buf[0] != '0')
+		return 1;
+	return 0;
+}
