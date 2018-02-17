Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeBQLaw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:30:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34735 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeBQLau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:30:50 -0500
Date: Sat, 17 Feb 2018 03:20:28 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6baddfc6900eca7f6b360c91ff737890ab4f1d55@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        dsahern@gmail.com, namhyung@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, jolsa@kernel.org
Reply-To: jolsa@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        namhyung@kernel.org, dsahern@gmail.com, hpa@zytor.com, acme@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180206181813.10943-5-jolsa@kernel.org>
References: <20180206181813.10943-5-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib api fs: Add filename__read_xll function
Git-Commit-ID: 6baddfc6900eca7f6b360c91ff737890ab4f1d55
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6baddfc6900eca7f6b360c91ff737890ab4f1d55
Gitweb:     https://git.kernel.org/tip/6baddfc6900eca7f6b360c91ff737890ab4f1d55
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 6 Feb 2018 19:18:00 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 10:09:23 -0300

tools lib api fs: Add filename__read_xll function

Adding filename__read_xll function to be able to read files with hex
numbers in, which do not have 0x prefix.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180206181813.10943-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/fs.c | 29 ++++++++++++++++++++++-------
 tools/lib/api/fs/fs.h |  1 +
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index b24afc0..8b0e4a4 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -315,12 +315,8 @@ int filename__read_int(const char *filename, int *value)
 	return err;
 }
 
-/*
- * Parses @value out of @filename with strtoull.
- * By using 0 for base, the strtoull detects the
- * base automatically (see man strtoull).
- */
-int filename__read_ull(const char *filename, unsigned long long *value)
+static int filename__read_ull_base(const char *filename,
+				   unsigned long long *value, int base)
 {
 	char line[64];
 	int fd = open(filename, O_RDONLY), err = -1;
@@ -329,7 +325,7 @@ int filename__read_ull(const char *filename, unsigned long long *value)
 		return -1;
 
 	if (read(fd, line, sizeof(line)) > 0) {
-		*value = strtoull(line, NULL, 0);
+		*value = strtoull(line, NULL, base);
 		if (*value != ULLONG_MAX)
 			err = 0;
 	}
@@ -338,6 +334,25 @@ int filename__read_ull(const char *filename, unsigned long long *value)
 	return err;
 }
 
+/*
+ * Parses @value out of @filename with strtoull.
+ * By using 16 for base to treat the number as hex.
+ */
+int filename__read_xll(const char *filename, unsigned long long *value)
+{
+	return filename__read_ull_base(filename, value, 16);
+}
+
+/*
+ * Parses @value out of @filename with strtoull.
+ * By using 0 for base, the strtoull detects the
+ * base automatically (see man strtoull).
+ */
+int filename__read_ull(const char *filename, unsigned long long *value)
+{
+	return filename__read_ull_base(filename, value, 0);
+}
+
 #define STRERR_BUFSIZE  128     /* For the buffer size of strerror_r */
 
 int filename__read_str(const char *filename, char **buf, size_t *sizep)
diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
index dda49de..8ebee35 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -30,6 +30,7 @@ FS(bpf_fs)
 
 int filename__read_int(const char *filename, int *value);
 int filename__read_ull(const char *filename, unsigned long long *value);
+int filename__read_xll(const char *filename, unsigned long long *value);
 int filename__read_str(const char *filename, char **buf, size_t *sizep);
 
 int filename__write_int(const char *filename, int value);
