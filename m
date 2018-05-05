Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751849AbeEEAEU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 20:04:20 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42927 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeEEAES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 20:04:18 -0400
X-Google-Smtp-Source: AB8JxZrzblmqaM0a0MXSzb0iAqBuLLZsB9sci30NVmGuUQKPV58KnFQTOwwVmS+5dNXbjFRyJ6w3mg==
Date: Sat, 5 May 2018 03:04:14 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] proc: test /proc/*/fd a bit (+ PF_KTHREAD is ABI!)
Message-ID: <20180505000414.GA15090@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Test lookup in /proc/self/fd.
  "map_files" lookup story showed that lookup is not that simple.

* Test that all those symlinks open the same file.
  Check with (st_dev, st_info).

* Test that kernel threads do not have anything in their /proc/*/fd/
  directory.

Now this is where things get interesting.

First, kernel threads aren't pinned by /proc/self or equivalent,
thus some "atomicity" is required.

Second, ->comm can contain whitespace and ')'.
No, they are not escaped.

Third, the only reliable way to check if process is kernel thread
appears to be field #9 in /proc/*/stat.

This field is struct task_struct::flags in decimal!
Check is done by testing PF_KTHREAD flags like we do in kernel.

	PF_KTREAD value is a part of userspace ABI !!!

Other methods for determining kernel threadness are not reliable:
* RSS can be 0 if everything is swapped, even while reading
  from /proc/self.

* ->total_vm CAN BE ZERO if process is finishing

	munmap(NULL, whole address space);

* /proc/*/maps and similar files can be empty because unmapping
  everything works. Read returning 0 can't distinguish between
  kernel thread and such suicide process.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore        |    3 
 tools/testing/selftests/proc/Makefile          |    5 
 tools/testing/selftests/proc/fd-001-lookup.c   |  168 +++++++++++++++++++++++
 tools/testing/selftests/proc/fd-002-posix-eq.c |   57 ++++++++
 tools/testing/selftests/proc/fd-003-kthread.c  |  178 +++++++++++++++++++++++++
 tools/testing/selftests/proc/proc-uptime.h     |   16 --
 tools/testing/selftests/proc/proc.h            |   39 +++++
 tools/testing/selftests/proc/read.c            |   17 --
 8 files changed, 451 insertions(+), 32 deletions(-)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -1,3 +1,6 @@
+/fd-001-lookup
+/fd-002-posix-eq
+/fd-003-kthread
 /proc-loadavg-001
 /proc-self-map-files-001
 /proc-self-map-files-002
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,9 @@
-CFLAGS += -Wall -O2
+CFLAGS += -Wall -O2 -Wno-unused-function
 
 TEST_GEN_PROGS :=
+TEST_GEN_PROGS += fd-001-lookup
+TEST_GEN_PROGS += fd-002-posix-eq
+TEST_GEN_PROGS += fd-003-kthread
 TEST_GEN_PROGS += proc-loadavg-001
 TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/fd-001-lookup.c
@@ -0,0 +1,168 @@
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
+// Test /proc/*/fd lookup.
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <dirent.h>
+#include <errno.h>
+#include <limits.h>
+#include <sched.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "proc.h"
+
+/* lstat(2) has more "coverage" in case non-symlink pops up somehow. */
+static void test_lookup_pass(const char *pathname)
+{
+	struct stat st;
+	ssize_t rv;
+
+	memset(&st, 0, sizeof(struct stat));
+	rv = lstat(pathname, &st);
+	assert(rv == 0);
+	assert(S_ISLNK(st.st_mode));
+}
+
+static void test_lookup_fail(const char *pathname)
+{
+	struct stat st;
+	ssize_t rv;
+
+	rv = lstat(pathname, &st);
+	assert(rv == -1 && errno == ENOENT);
+}
+
+static void test_lookup(unsigned int fd)
+{
+	char buf[64];
+	unsigned int c;
+	unsigned int u;
+	int i;
+
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%u", fd);
+	test_lookup_pass(buf);
+
+	/* leading junk */
+	for (c = 1; c <= 255; c++) {
+		if (c == '/')
+			continue;
+		snprintf(buf, sizeof(buf), "/proc/self/fd/%c%u", c, fd);
+		test_lookup_fail(buf);
+	}
+
+	/* trailing junk */
+	for (c = 1; c <= 255; c++) {
+		if (c == '/')
+			continue;
+		snprintf(buf, sizeof(buf), "/proc/self/fd/%u%c", fd, c);
+		test_lookup_fail(buf);
+	}
+
+	for (i = INT_MIN; i < INT_MIN + 1024; i++) {
+		snprintf(buf, sizeof(buf), "/proc/self/fd/%d", i);
+		test_lookup_fail(buf);
+	}
+	for (i = -1024; i < 0; i++) {
+		snprintf(buf, sizeof(buf), "/proc/self/fd/%d", i);
+		test_lookup_fail(buf);
+	}
+	for (u = INT_MAX - 1024; u <= (unsigned int)INT_MAX + 1024; u++) {
+		snprintf(buf, sizeof(buf), "/proc/self/fd/%u", u);
+		test_lookup_fail(buf);
+	}
+	for (u = UINT_MAX - 1024; u != 0; u++) {
+		snprintf(buf, sizeof(buf), "/proc/self/fd/%u", u);
+		test_lookup_fail(buf);
+	}
+
+
+}
+
+int main(void)
+{
+	struct dirent *de;
+	unsigned int fd, target_fd;
+
+	if (unshare(CLONE_FILES) == -1)
+		return 1;
+
+	/* Wipe fdtable. */
+	do {
+		DIR *d;
+
+		d = opendir("/proc/self/fd");
+		if (!d)
+			return 1;
+
+		de = xreaddir(d);
+		assert(de->d_type == DT_DIR);
+		assert(streq(de->d_name, "."));
+
+		de = xreaddir(d);
+		assert(de->d_type == DT_DIR);
+		assert(streq(de->d_name, ".."));
+next:
+		de = xreaddir(d);
+		if (de) {
+			unsigned long long fd_ull;
+			unsigned int fd;
+			char *end;
+
+			assert(de->d_type == DT_LNK);
+
+			fd_ull = xstrtoull(de->d_name, &end);
+			assert(*end == '\0');
+			assert(fd_ull == (unsigned int)fd_ull);
+
+			fd = fd_ull;
+			if (fd == dirfd(d))
+				goto next;
+			close(fd);
+		}
+
+		closedir(d);
+	} while (de);
+
+	/* Now fdtable is clean. */
+
+	fd = open("/", O_PATH|O_DIRECTORY);
+	assert(fd == 0);
+	test_lookup(fd);
+	close(fd);
+
+	/* Clean again! */
+
+	fd = open("/", O_PATH|O_DIRECTORY);
+	assert(fd == 0);
+	/* Default RLIMIT_NOFILE-1 */
+	target_fd = 1023;
+	while (target_fd > 0) {
+		if (dup2(fd, target_fd) == target_fd)
+			break;
+		target_fd /= 2;
+	}
+	assert(target_fd > 0);
+	close(fd);
+	test_lookup(target_fd);
+	close(target_fd);
+
+	return 0;
+}
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/fd-002-posix-eq.c
@@ -0,0 +1,57 @@
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
+// Test that open(/proc/*/fd/*) opens the same file.
+#undef NDEBUG
+#include <assert.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+int main(void)
+{
+	int fd0, fd1, fd2;
+	struct stat st0, st1, st2;
+	char buf[64];
+	int rv;
+
+	fd0 = open("/", O_DIRECTORY|O_RDONLY);
+	assert(fd0 >= 0);
+
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%u", fd0);
+	fd1 = open(buf, O_RDONLY);
+	assert(fd1 >= 0);
+
+	snprintf(buf, sizeof(buf), "/proc/thread-self/fd/%u", fd0);
+	fd2 = open(buf, O_RDONLY);
+	assert(fd2 >= 0);
+
+	rv = fstat(fd0, &st0);
+	assert(rv == 0);
+	rv = fstat(fd1, &st1);
+	assert(rv == 0);
+	rv = fstat(fd2, &st2);
+	assert(rv == 0);
+
+	assert(st0.st_dev == st1.st_dev);
+	assert(st0.st_ino == st1.st_ino);
+
+	assert(st0.st_dev == st2.st_dev);
+	assert(st0.st_ino == st2.st_ino);
+
+	return 0;
+}
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/fd-003-kthread.c
@@ -0,0 +1,178 @@
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
+// Test that /proc/$KERNEL_THREAD/fd/ is empty.
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <sys/syscall.h>
+#include <assert.h>
+#include <dirent.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "proc.h"
+
+#define PF_KHTREAD 0x00200000
+
+/*
+ * Test for kernel threadness atomically with openat().
+ *
+ * Return /proc/$PID/fd descriptor if process is kernel thread.
+ * Return -1 if a process is userspace process.
+ */
+static int kernel_thread_fd(unsigned int pid)
+{
+	unsigned int flags = 0;
+	char buf[4096];
+	int dir_fd, fd;
+	ssize_t rv;
+
+	snprintf(buf, sizeof(buf), "/proc/%u", pid);
+	dir_fd = open(buf, O_RDONLY|O_DIRECTORY);
+	if (dir_fd == -1)
+		return -1;
+
+	/*
+	 * Believe it or not, struct task_struct::flags is directly exposed
+	 * to userspace!
+	 */
+	fd = openat(dir_fd, "stat", O_RDONLY);
+	if (fd == -1) {
+		close(dir_fd);
+		return -1;
+	}
+	rv = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (0 < rv && rv <= sizeof(buf)) {
+		unsigned long long flags_ull;
+		char *p, *end;
+		int i;
+
+		assert(buf[rv - 1] == '\n');
+		buf[rv - 1] = '\0';
+
+		/* Search backwards: ->comm can contain whitespace and ')'. */
+		for (i = 0; i < 43; i++) {
+			p = strrchr(buf, ' ');
+			assert(p);
+			*p = '\0';
+		}
+
+		p = strrchr(buf, ' ');
+		assert(p);
+
+		flags_ull = xstrtoull(p + 1, &end);
+		assert(*end == '\0');
+		assert(flags_ull == (unsigned int)flags_ull);
+
+		flags = flags_ull;
+	}
+
+	fd = -1;
+	if (flags & PF_KHTREAD) {
+		fd = openat(dir_fd, "fd", O_RDONLY|O_DIRECTORY);
+	}
+	close(dir_fd);
+	return fd;
+}
+
+static void test_readdir(int fd)
+{
+	DIR *d;
+	struct dirent *de;
+
+	d = fdopendir(fd);
+	assert(d);
+
+	de = xreaddir(d);
+	assert(streq(de->d_name, "."));
+	assert(de->d_type == DT_DIR);
+
+	de = xreaddir(d);
+	assert(streq(de->d_name, ".."));
+	assert(de->d_type == DT_DIR);
+
+	de = xreaddir(d);
+	assert(!de);
+}
+
+static inline int sys_statx(int dirfd, const char *pathname, int flags,
+			    unsigned int mask, void *stx)
+{
+	return syscall(SYS_statx, dirfd, pathname, flags, mask, stx);
+}
+
+static void test_lookup_fail(int fd, const char *pathname)
+{
+	char stx[256] __attribute__((aligned(8)));
+	int rv;
+
+	rv = sys_statx(fd, pathname, AT_SYMLINK_NOFOLLOW, 0, (void *)stx);
+	assert(rv == -1 && errno == ENOENT);
+}
+
+static void test_lookup(int fd)
+{
+	char buf[64];
+	unsigned int u;
+	int i;
+
+	for (i = INT_MIN; i < INT_MIN + 1024; i++) {
+		snprintf(buf, sizeof(buf), "%d", i);
+		test_lookup_fail(fd, buf);
+	}
+	for (i = -1024; i < 1024; i++) {
+		snprintf(buf, sizeof(buf), "%d", i);
+		test_lookup_fail(fd, buf);
+	}
+	for (u = INT_MAX - 1024; u < (unsigned int)INT_MAX + 1024; u++) {
+		snprintf(buf, sizeof(buf), "%u", u);
+		test_lookup_fail(fd, buf);
+	}
+	for (u = UINT_MAX - 1024; u != 0; u++) {
+		snprintf(buf, sizeof(buf), "%u", u);
+		test_lookup_fail(fd, buf);
+	}
+}
+
+int main(void)
+{
+	unsigned int pid;
+	int fd;
+
+	/*
+	 * In theory this will loop indefinitely if kernel threads are exiled
+	 * from /proc.
+	 *
+	 * Start with kthreadd.
+	 */
+	pid = 2;
+	while ((fd = kernel_thread_fd(pid)) == -1 && pid < 1024) {
+		pid++;
+	}
+	/* EACCES if run as non-root. */
+	if (pid >= 1024)
+		return 1;
+
+	test_readdir(fd);
+	test_lookup(fd);
+
+	return 0;
+}
--- a/tools/testing/selftests/proc/proc-uptime.h
+++ b/tools/testing/selftests/proc/proc-uptime.h
@@ -20,21 +20,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 
-static unsigned long long xstrtoull(const char *p, char **end)
-{
-	if (*p == '0') {
-		*end = (char *)p + 1;
-		return 0;
-	} else if ('1' <= *p && *p <= '9') {
-		unsigned long long val;
-
-		errno = 0;
-		val = strtoull(p, end, 10);
-		assert(errno == 0);
-		return val;
-	} else
-		assert(0);
-}
+#include "proc.h"
 
 static void proc_uptime(int fd, uint64_t *uptime, uint64_t *idle)
 {
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc.h
@@ -0,0 +1,39 @@
+#pragma once
+#undef NDEBUG
+#include <assert.h>
+#include <dirent.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+
+static inline bool streq(const char *s1, const char *s2)
+{
+	return strcmp(s1, s2) == 0;
+}
+
+static unsigned long long xstrtoull(const char *p, char **end)
+{
+	if (*p == '0') {
+		*end = (char *)p + 1;
+		return 0;
+	} else if ('1' <= *p && *p <= '9') {
+		unsigned long long val;
+
+		errno = 0;
+		val = strtoull(p, end, 10);
+		assert(errno == 0);
+		return val;
+	} else
+		assert(0);
+}
+
+static struct dirent *xreaddir(DIR *d)
+{
+	struct dirent *de;
+
+	errno = 0;
+	de = readdir(d);
+	assert(de || errno == 0);
+	return de;
+}
--- a/tools/testing/selftests/proc/read.c
+++ b/tools/testing/selftests/proc/read.c
@@ -31,22 +31,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 
-static inline bool streq(const char *s1, const char *s2)
-{
-	return strcmp(s1, s2) == 0;
-}
-
-static struct dirent *xreaddir(DIR *d)
-{
-	struct dirent *de;
-
-	errno = 0;
-	de = readdir(d);
-	if (!de && errno != 0) {
-		exit(1);
-	}
-	return de;
-}
+#include "proc.h"
 
 static void f_reg(DIR *d, const char *filename)
 {
