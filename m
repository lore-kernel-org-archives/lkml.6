Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932206AbeCCVvg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 16:51:36 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52501 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeCCVvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 16:51:35 -0500
X-Google-Smtp-Source: AG47ELsGwB066ELnussuE5qZQuFMUjkqsT+r+xpr9lx4xguzODJgT0z4LBZRRmXb4cyeRRnMmClurA==
Date: Sun, 4 Mar 2018 00:51:30 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, xemul@parallels.com, gorcunov@openvz.org
Subject: [PATCH v2] proc: fix /proc/*/map_files lookup some more
Message-ID: <20180303215130.GA23480@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I totally forgot that _parse_integer() accepts arbitrary amount of
leading zeroes leading to the following lookups:

		OK
	# readlink /proc/1/map_files/56427ecba000-56427eddc000
	/lib/systemd/systemd

		bogus
	# readlink /proc/1/map_files/00000000000056427ecba000-56427eddc000
	/lib/systemd/systemd
	# readlink /proc/1/map_files/56427ecba000-00000000000056427eddc000
	/lib/systemd/systemd

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/base.c                                         |    4 
 tools/testing/selftests/proc/.gitignore                |    4 
 tools/testing/selftests/proc/Makefile                  |    2 
 tools/testing/selftests/proc/proc-self-map-files-001.c |   82 ++++++++++++++++
 tools/testing/selftests/proc/proc-self-map-files-002.c |   85 +++++++++++++++++
 5 files changed, 176 insertions(+), 1 deletion(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1916,6 +1916,8 @@ static int dname_to_vma_addr(struct dentry *dentry,
 	unsigned long long sval, eval;
 	unsigned int len;
 
+	if (str[0] == '0' && str[1] != '-')
+		return -EINVAL;
 	len = _parse_integer(str, 16, &sval);
 	if (len & KSTRTOX_OVERFLOW)
 		return -EINVAL;
@@ -1927,6 +1929,8 @@ static int dname_to_vma_addr(struct dentry *dentry,
 		return -EINVAL;
 	str++;
 
+	if (str[0] == '0' && str[1])
+		return -EINVAL;
 	len = _parse_integer(str, 16, &eval);
 	if (len & KSTRTOX_OVERFLOW)
 		return -EINVAL;
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -1,2 +1,4 @@
-/proc-self-mem
+/proc-self-map-files-001
+/proc-self-map-files-002
 /proc-self-syscall
+/proc-self-wchan
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,8 @@
 CFLAGS += -Wall -O2
 
 TEST_GEN_PROGS :=
+TEST_GEN_PROGS += proc-self-map-files-001
+TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
 TEST_GEN_PROGS += proc-self-wchan
 
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-self-map-files-001.c
@@ -0,0 +1,82 @@
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
+/* Test readlink /proc/self/map_files/... */
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <stdlib.h>
+
+static void pass(const char *fmt, unsigned long a, unsigned long b)
+{
+	char name[64];
+	char buf[64];
+
+	snprintf(name, sizeof(name), fmt, a, b);
+	if (readlink(name, buf, sizeof(buf)) == -1)
+		exit(1);
+}
+
+static void fail(const char *fmt, unsigned long a, unsigned long b)
+{
+	char name[64];
+	char buf[64];
+
+	snprintf(name, sizeof(name), fmt, a, b);
+	if (readlink(name, buf, sizeof(buf)) == -1 && errno == ENOENT)
+		return;
+	exit(1);
+}
+
+int main(void)
+{
+	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
+	void *p;
+	int fd;
+	unsigned long a, b;
+
+	fd = open("/dev/zero", O_RDONLY);
+	if (fd == -1)
+		return 1;
+
+	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE, fd, 0);
+	if (p == MAP_FAILED)
+		return 1;
+
+	a = (unsigned long)p;
+	b = (unsigned long)p + PAGE_SIZE;
+
+	pass("/proc/self/map_files/%lx-%lx", a, b);
+	fail("/proc/self/map_files/ %lx-%lx", a, b);
+	fail("/proc/self/map_files/%lx -%lx", a, b);
+	fail("/proc/self/map_files/%lx- %lx", a, b);
+	fail("/proc/self/map_files/%lx-%lx ", a, b);
+	fail("/proc/self/map_files/0%lx-%lx", a, b);
+	fail("/proc/self/map_files/%lx-0%lx", a, b);
+	if (sizeof(long) == 4) {
+		fail("/proc/self/map_files/100000000%lx-%lx", a, b);
+		fail("/proc/self/map_files/%lx-100000000%lx", a, b);
+	} else if (sizeof(long) == 8) {
+		fail("/proc/self/map_files/10000000000000000%lx-%lx", a, b);
+		fail("/proc/self/map_files/%lx-10000000000000000%lx", a, b);
+	} else
+		return 1;
+
+	return 0;
+}
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -0,0 +1,85 @@
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
+/* Test readlink /proc/self/map_files/... with address 0. */
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <stdlib.h>
+
+static void pass(const char *fmt, unsigned long a, unsigned long b)
+{
+	char name[64];
+	char buf[64];
+
+	snprintf(name, sizeof(name), fmt, a, b);
+	if (readlink(name, buf, sizeof(buf)) == -1)
+		exit(1);
+}
+
+static void fail(const char *fmt, unsigned long a, unsigned long b)
+{
+	char name[64];
+	char buf[64];
+
+	snprintf(name, sizeof(name), fmt, a, b);
+	if (readlink(name, buf, sizeof(buf)) == -1 && errno == ENOENT)
+		return;
+	exit(1);
+}
+
+int main(void)
+{
+	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
+	void *p;
+	int fd;
+	unsigned long a, b;
+
+	fd = open("/dev/zero", O_RDONLY);
+	if (fd == -1)
+		return 1;
+
+	p = mmap(NULL, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
+	if (p == MAP_FAILED) {
+		if (errno == EPERM)
+			return 2;
+		return 1;
+	}
+
+	a = (unsigned long)p;
+	b = (unsigned long)p + PAGE_SIZE;
+
+	pass("/proc/self/map_files/%lx-%lx", a, b);
+	fail("/proc/self/map_files/ %lx-%lx", a, b);
+	fail("/proc/self/map_files/%lx -%lx", a, b);
+	fail("/proc/self/map_files/%lx- %lx", a, b);
+	fail("/proc/self/map_files/%lx-%lx ", a, b);
+	fail("/proc/self/map_files/0%lx-%lx", a, b);
+	fail("/proc/self/map_files/%lx-0%lx", a, b);
+	if (sizeof(long) == 4) {
+		fail("/proc/self/map_files/100000000%lx-%lx", a, b);
+		fail("/proc/self/map_files/%lx-100000000%lx", a, b);
+	} else if (sizeof(long) == 8) {
+		fail("/proc/self/map_files/10000000000000000%lx-%lx", a, b);
+		fail("/proc/self/map_files/%lx-10000000000000000%lx", a, b);
+	} else
+		return 1;
+
+	return 0;
+}
