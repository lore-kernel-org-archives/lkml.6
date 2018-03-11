Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932445AbeCKVGF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 17:06:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33913 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932383AbeCKVFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 17:05:49 -0400
X-Google-Smtp-Source: AG47ELun5eVV09b/qT+a6AvcdA1bNJr8yILgjuFgza+vWVZPO2kNvLsWo9uiB7EO9wwtUofFFV6JvQ==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 3/3 v2] selftests: add devpts selftests
Date: Sun, 11 Mar 2018 22:05:37 +0100
Message-Id: <20180311210537.3674-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180311210537.3674-1-christian.brauner@ubuntu.com>
References: <20180311210537.3674-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a simple test to check whether /proc/<pid>/fd/<nr> symlinks are
correctly pointing to /dev/pts/<idx> devices when attached to a terminal.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
ChangeLog v1->v2:
* patch added
ChangeLog v0->v1:
* patch not present
---
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/filesystems/.gitignore   |   1 +
 tools/testing/selftests/filesystems/Makefile     |   3 +-
 tools/testing/selftests/filesystems/devpts_pts.c | 191 +++++++++++++++++++++++
 4 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/devpts_pts.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 7442dfb73b7f..dbda89c9d9b9 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -7,6 +7,7 @@ TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += efivarfs
 TARGETS += exec
+TARGETS += filesystems
 TARGETS += firmware
 TARGETS += ftrace
 TARGETS += futex
diff --git a/tools/testing/selftests/filesystems/.gitignore b/tools/testing/selftests/filesystems/.gitignore
index 31d6e426b6d4..8449cf6716ce 100644
--- a/tools/testing/selftests/filesystems/.gitignore
+++ b/tools/testing/selftests/filesystems/.gitignore
@@ -1 +1,2 @@
 dnotify_test
+devpts_pts
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 13a73bf725b5..b9b5d2f68990 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := dnotify_test
+TEST_PROGS := dnotify_test \
+	devpts_pts
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
new file mode 100644
index 000000000000..10a73e422600
--- /dev/null
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/mount.h>
+#include <sys/wait.h>
+
+static bool terminal_dup2(int duplicate, int original)
+{
+	int ret;
+
+	ret = dup2(duplicate, original);
+	if (ret < 0)
+		return false;
+
+	return true;
+}
+
+static int lxc_terminal_set_stdfds(int fd)
+{
+	int i;
+
+	if (fd < 0)
+		return 0;
+
+	for (i = 0; i < 3; i++)
+		if (!terminal_dup2(fd, (int[]){STDIN_FILENO, STDOUT_FILENO,
+					       STDERR_FILENO}[i]))
+			return -1;
+
+	return 0;
+}
+
+static int login_pty(int fd)
+{
+	int ret;
+
+	setsid();
+
+	ret = ioctl(fd, TIOCSCTTY, NULL);
+	if (ret < 0)
+		return -1;
+
+	ret = lxc_terminal_set_stdfds(fd);
+	if (ret < 0)
+		return -1;
+
+	if (fd > STDERR_FILENO)
+		close(fd);
+
+	return 0;
+}
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+		return -1;
+	}
+	if (ret != pid)
+		goto again;
+
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		return -1;
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int master = -1, ret = -1, slave = -1;
+	int fret = EXIT_FAILURE;
+
+	if (!isatty(STDIN_FILENO)) {
+		fprintf(stderr, "Standard input file desciptor is not attached "
+				"to a terminal. Skipping test\n");
+		goto do_cleanup;
+	}
+
+	ret = unshare(CLONE_NEWNS);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to unshare mount namespace\n");
+		goto do_cleanup;
+	}
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to make \"/\" MS_PRIVATE in new mount "
+				"namespace\n");
+		goto do_cleanup;
+	}
+
+	ret = mount("/dev/pts/ptmx", "/dev/ptmx", NULL, MS_BIND, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to bind mount \"/dev/pts/ptmx\" to "
+				"\"/dev/ptmx\" mount namespace\n");
+		goto do_cleanup;
+	}
+
+	master = open("/dev/ptmx", O_RDWR | O_NOCTTY | O_CLOEXEC);
+	if (master < 0) {
+		fprintf(stderr, "Failed to open \"/dev/ptmx\"\n");
+		goto do_cleanup;
+	}
+
+	ret = grantpt(master);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to grant access to terminal\n");
+		goto do_cleanup;
+	}
+
+	ret = unlockpt(master);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to unlock terminal\n");
+		goto do_cleanup;
+	}
+
+#ifdef TIOCGPTPEER
+	slave = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY | O_CLOEXEC);
+#endif
+	if (slave < 0) {
+		if (errno == EINVAL) {
+			fprintf(stderr, "TIOCGPTPEER is not supported. "
+					"Skipping test.\n");
+			fret = EXIT_SUCCESS;
+		}
+
+		fprintf(stderr, "Failed to perform TIOCGPTPEER ioctl\n");
+		goto do_cleanup;
+	}
+
+	pid_t pid = fork();
+	if (pid < 0)
+		goto do_cleanup;
+
+	if (pid == 0) {
+                char buf[4096];
+
+		ret = login_pty(slave);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to setup terminal\n");
+			_exit(EXIT_FAILURE);
+		}
+
+		ret = readlink("/proc/self/fd/0", buf, sizeof(buf));
+		if (ret < 0 || (size_t)ret >= sizeof(buf)) {
+			fprintf(stderr, "Failed to retrieve pathname of pts "
+					"slave file descriptor\n");
+			_exit(EXIT_FAILURE);
+		}
+		buf[ret] = '\0';
+
+		if (strncmp(buf, "/dev/pts/", strlen("/dev/pts/"))) {
+			fprintf(stderr, "Received invalid contents for "
+					"\"/proc/<pid>/fd/<nr>\" symlink: %s\n",
+					buf);
+			_exit(-1);
+		}
+
+		fprintf(stderr, "Contents of \"/proc/<pid>/fd/<nr>\" "
+				"symlink are valid: %s\n", buf);
+
+		_exit(EXIT_SUCCESS);
+	}
+
+	ret = wait_for_pid(pid);
+	if (ret < 0)
+		goto do_cleanup;
+
+	fret = EXIT_SUCCESS;
+
+do_cleanup:
+	if (master >= 0)
+		close(master);
+	if (slave >= 0)
+		close(slave);
+
+	return ret;
+}
-- 
2.15.1
