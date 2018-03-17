Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeCQQwk (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 12:52:40 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37915 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeCQQwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 12:52:39 -0400
X-Google-Smtp-Source: AG47ELtoM/vu2tPQ2bHdHxyPANDRUcFA6l9ytByHjBcWGdAft/BupmE0tPRnrG2qzr6mMnXKzBCQUA==
Date: Sat, 17 Mar 2018 19:52:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] proc: test /proc/uptime
Message-ID: <20180317165235.GB3445@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only tests I could come up with for /proc/uptime are:
* test that values increase monotonically for 1 second,
* bounce around CPUs and test the same thing.

Avoid glibc like plague for affinity given patches like this:
https://marc.info/?l=linux-kernel&m=152130031912594&w=4

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore        |    2 
 tools/testing/selftests/proc/Makefile          |    2 
 tools/testing/selftests/proc/proc-uptime-001.c |   45 ++++++++++++++
 tools/testing/selftests/proc/proc-uptime-002.c |   79 +++++++++++++++++++++++++
 tools/testing/selftests/proc/proc-uptime.h     |   74 +++++++++++++++++++++++
 5 files changed, 202 insertions(+)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -4,4 +4,6 @@
 /proc-self-map-files-002
 /proc-self-syscall
 /proc-self-wchan
+/proc-uptime-001
+/proc-uptime-002
 /read
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -7,6 +7,8 @@ TEST_GEN_PROGS += proc-self-map-files-001
 TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
 TEST_GEN_PROGS += proc-self-wchan
+TEST_GEN_PROGS += proc-uptime-001
+TEST_GEN_PROGS += proc-uptime-002
 TEST_GEN_PROGS += read
 
 include ../lib.mk
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-uptime-001.c
@@ -0,0 +1,45 @@
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
+// Test that values in /proc/uptime increment monotonically.
+#undef NDEBUG
+#include <assert.h>
+#include <stdint.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "proc-uptime.h"
+
+int main(void)
+{
+	uint64_t start, u0, u1, i0, i1;
+	int fd;
+
+	fd = open("/proc/uptime", O_RDONLY);
+	assert(fd >= 0);
+
+	proc_uptime(fd, &u0, &i0);
+	start = u0;
+	do {
+		proc_uptime(fd, &u1, &i1);
+		assert(u1 >= u0);
+		assert(i1 >= i0);
+		u0 = u1;
+		i0 = i1;
+	} while (u1 - start < 100);
+
+	return 0;
+}
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-uptime-002.c
@@ -0,0 +1,79 @@
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
+// Test that values in /proc/uptime increment monotonically
+// while shifting across CPUs.
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <stdint.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include "proc-uptime.h"
+
+static inline int sys_sched_getaffinity(pid_t pid, unsigned int len, unsigned long *m)
+{
+	return syscall(SYS_sched_getaffinity, pid, len, m);
+}
+
+static inline int sys_sched_setaffinity(pid_t pid, unsigned int len, unsigned long *m)
+{
+	return syscall(SYS_sched_setaffinity, pid, len, m);
+}
+
+int main(void)
+{
+	unsigned int len;
+	unsigned long *m;
+	unsigned int cpu;
+	uint64_t u0, u1, i0, i1;
+	int fd;
+
+	/* find out "nr_cpu_ids" */
+	m = NULL;
+	len = 0;
+	do {
+		len += sizeof(unsigned long);
+		free(m);
+		m = malloc(len);
+	} while (sys_sched_getaffinity(0, len, m) == -EINVAL);
+
+	fd = open("/proc/uptime", O_RDONLY);
+	assert(fd >= 0);
+
+	proc_uptime(fd, &u0, &i0);
+	for (cpu = 0; cpu < len * 8; cpu++) {
+		memset(m, 0, len);
+		m[cpu / (8 * sizeof(unsigned long))] |= 1UL << (cpu % (8 * sizeof(unsigned long)));
+
+		/* CPU might not exist, ignore error */
+		sys_sched_setaffinity(0, len, m);
+
+		proc_uptime(fd, &u1, &i1);
+		assert(u1 >= u0);
+		assert(i1 >= i0);
+		u0 = u1;
+		i0 = i1;
+	}
+
+	return 0;
+}
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-uptime.h
@@ -0,0 +1,74 @@
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
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
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
+static void proc_uptime(int fd, uint64_t *uptime, uint64_t *idle)
+{
+	uint64_t val1, val2;
+	char buf[64], *p;
+	ssize_t rv;
+
+	/* save "p < end" checks */
+	memset(buf, 0, sizeof(buf));
+	rv = pread(fd, buf, sizeof(buf), 0);
+	assert(0 <= rv && rv <= sizeof(buf));
+	buf[sizeof(buf) - 1] = '\0';
+
+	p = buf;
+
+	val1 = xstrtoull(p, &p);
+	assert(p[0] == '.');
+	assert('0' <= p[1] && p[1] <= '9');
+	assert('0' <= p[2] && p[2] <= '9');
+	assert(p[3] == ' ');
+
+	val2 = (p[1] - '0') * 10 + p[2] - '0';
+	*uptime = val1 * 100 + val2;
+
+	p += 4;
+
+	val1 = xstrtoull(p, &p);
+	assert(p[0] == '.');
+	assert('0' <= p[1] && p[1] <= '9');
+	assert('0' <= p[2] && p[2] <= '9');
+	assert(p[3] == '\n');
+
+	val2 = (p[1] - '0') * 10 + p[2] - '0';
+	*idle = val1 * 100 + val2;
+
+	assert(p + 4 == buf + rv);
+}
