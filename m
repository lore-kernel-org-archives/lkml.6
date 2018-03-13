Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933085AbeCMMSR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:18:17 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:37651 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeCMMSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:18:10 -0400
X-Google-Smtp-Source: AG47ELvpYNz+ZOUf6UUpZURQ9vG0hLXamPTMqqMm5dsQNFAHRTCa8oE2xJTyMyrOu7jpqqiZFhht4g==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org
Cc: containers@lists.linux-foundation.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 4/4 v5] selftests: add devpts selftests
Date: Tue, 13 Mar 2018 13:17:13 +0100
Message-Id: <20180313121713.32551-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180313121713.32551-1-christian.brauner@ubuntu.com>
References: <20180313121713.32551-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds tests to check:
- bind-mounts from /dev/pts/ptmx to /dev/ptmx work
- non-standard mounts of devpts work
- bind-mounts of /dev/pts/ptmx to locations that do not resolve to a valid
  slave pty path under the originating devpts mount fail

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
ChangeLog v4->v5:
* extend tests to verify failure on ptmx devices located outside the
  devpts mount without a common ancestor directory
ChangeLog v3->v4:
* patch unchanged
ChangeLog v2->v3:
* extend test for non-standard devpts mounts such as
  mount -t devpts e devpts /mnt
ChangeLog v1->v2:
* patch added
ChangeLog v0->v1:
* patch not present
---
 tools/testing/selftests/Makefile                 |   1 +
 tools/testing/selftests/filesystems/.gitignore   |   1 +
 tools/testing/selftests/filesystems/Makefile     |   2 +-
 tools/testing/selftests/filesystems/devpts_pts.c | 313 +++++++++++++++++++++++
 4 files changed, 316 insertions(+), 1 deletion(-)
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
index 13a73bf725b5..4e6d09fb166f 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_PROGS := dnotify_test
+TEST_PROGS := dnotify_test devpts_pts
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/devpts_pts.c b/tools/testing/selftests/filesystems/devpts_pts.c
new file mode 100644
index 000000000000..b9055e974289
--- /dev/null
+++ b/tools/testing/selftests/filesystems/devpts_pts.c
@@ -0,0 +1,313 @@
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
+static int terminal_set_stdfds(int fd)
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
+	ret = terminal_set_stdfds(fd);
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
+static int resolve_procfd_symlink(int fd, char *buf, size_t buflen)
+{
+	int ret;
+	char procfd[4096];
+
+	ret = snprintf(procfd, 4096, "/proc/self/fd/%d", fd);
+	if (ret < 0 || ret >= 4096)
+		return -1;
+
+	ret = readlink(procfd, buf, buflen);
+	if (ret < 0 || (size_t)ret >= buflen)
+		return -1;
+
+	buf[ret] = '\0';
+
+	return 0;
+}
+
+static int do_tiocgptpeer(char *ptmx, char *expected_procfd_contents)
+{
+	int ret;
+	int master = -1, slave = -1, fret = -1;
+
+	master = open(ptmx, O_RDWR | O_NOCTTY | O_CLOEXEC);
+	if (master < 0) {
+		fprintf(stderr, "Failed to open \"%s\": %s\n", ptmx,
+			strerror(errno));
+		return -1;
+	}
+
+	/*
+	 * grantpt() makes assumptions about /dev/pts/ so ignore it. It's also
+	 * not really needed.
+	 */
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
+		char buf[4096];
+
+		ret = login_pty(slave);
+		if (ret < 0) {
+			fprintf(stderr, "Failed to setup terminal\n");
+			_exit(EXIT_FAILURE);
+		}
+
+		ret = resolve_procfd_symlink(STDIN_FILENO, buf, sizeof(buf));
+		if (ret < 0) {
+			fprintf(stderr, "Failed to retrieve pathname of pts "
+					"slave file descriptor\n");
+			_exit(EXIT_FAILURE);
+		}
+
+		if (strncmp(expected_procfd_contents, buf,
+			    strlen(expected_procfd_contents)) != 0) {
+			fprintf(stderr, "Received invalid contents for "
+					"\"/proc/<pid>/fd/%d\" symlink: %s\n",
+					STDIN_FILENO, buf);
+			_exit(-1);
+		}
+
+		fprintf(stderr, "Contents of \"/proc/<pid>/fd/%d\" "
+				"symlink are valid: %s\n", STDIN_FILENO, buf);
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
+	return fret;
+}
+
+static int verify_non_standard_devpts_mount(void)
+{
+	char *mntpoint;
+	int ret = -1;
+	char devpts[] = P_tmpdir "/devpts_fs_XXXXXX";
+	char ptmx[] = P_tmpdir "/devpts_fs_XXXXXX/ptmx";
+
+	ret = umount("/dev/pts");
+	if (ret < 0) {
+		fprintf(stderr, "Failed to unmount \"/dev/pts\": %s\n",
+				strerror(errno));
+		return -1;
+	}
+
+	(void)umount("/dev/ptmx");
+
+	mntpoint = mkdtemp(devpts);
+	if (!mntpoint) {
+		fprintf(stderr, "Failed to create temporary mountpoint: %s\n",
+				 strerror(errno));
+		return -1;
+	}
+
+	ret = mount("devpts", mntpoint, "devpts", MS_NOSUID | MS_NOEXEC,
+		    "newinstance,ptmxmode=0666,mode=0620,gid=5");
+	if (ret < 0) {
+		fprintf(stderr, "Failed to mount devpts fs to \"%s\" in new "
+				"mount namespace: %s\n", mntpoint,
+				strerror(errno));
+		unlink(mntpoint);
+		return -1;
+	}
+
+	ret = snprintf(ptmx, sizeof(ptmx), "%s/ptmx", devpts);
+	if (ret < 0 || (size_t)ret >= sizeof(ptmx)) {
+		unlink(mntpoint);
+		return -1;
+	}
+
+	ret = do_tiocgptpeer(ptmx, mntpoint);
+	unlink(mntpoint);
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
+static int verify_ptmx_bind_mount(void)
+{
+	int ret;
+
+	ret = mount("/dev/pts/ptmx", "/dev/ptmx", NULL, MS_BIND, NULL);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to bind mount \"/dev/pts/ptmx\" to "
+				"\"/dev/ptmx\" mount namespace\n");
+		return -1;
+	}
+
+	ret = do_tiocgptpeer("/dev/ptmx", "/dev/pts/");
+	if (ret < 0)
+		return -1;
+
+	return 0;
+}
+
+static int verify_invalid_ptmx_bind_mount(void)
+{
+	int ret;
+	char mntpoint_fd;
+	char ptmx[] = P_tmpdir "/devpts_ptmx_XXXXXX";
+
+	mntpoint_fd = mkstemp(ptmx);
+	if (mntpoint_fd < 0) {
+		fprintf(stderr, "Failed to create temporary directory: %s\n",
+				 strerror(errno));
+		return -1;
+	}
+
+	ret = mount("/dev/pts/ptmx", ptmx, NULL, MS_BIND, NULL);
+	close(mntpoint_fd);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to bind mount \"/dev/pts/ptmx\" to "
+				"\"%s\" mount namespace\n", ptmx);
+		return -1;
+	}
+
+	ret = do_tiocgptpeer(ptmx, "/dev/pts/");
+	if (ret == 0)
+		return -1;
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+
+	if (!isatty(STDIN_FILENO)) {
+		fprintf(stderr, "Standard input file desciptor is not attached "
+				"to a terminal. Skipping test\n");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = unshare(CLONE_NEWNS);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to unshare mount namespace\n");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
+	if (ret < 0) {
+		fprintf(stderr, "Failed to make \"/\" MS_PRIVATE in new mount "
+				"namespace\n");
+		exit(EXIT_FAILURE);
+	}
+
+	ret = verify_ptmx_bind_mount();
+	if (ret < 0)
+		exit(EXIT_FAILURE);
+
+	ret = verify_invalid_ptmx_bind_mount();
+	if (ret < 0)
+		exit(EXIT_FAILURE);
+
+	ret = verify_non_standard_devpts_mount();
+	if (ret < 0)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
+}
-- 
2.15.1
