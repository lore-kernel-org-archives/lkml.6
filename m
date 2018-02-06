Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeBFS2Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:28:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753106AbeBFS1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:27:40 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 04/17] tools lib api fs: Add filename__read_xll function
Date: Tue,  6 Feb 2018 19:18:00 +0100
Message-Id: <20180206181813.10943-5-jolsa@kernel.org>
In-Reply-To: <20180206181813.10943-1-jolsa@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding filename__read_xll function to be able to read files
with hex numbers in, which do not have 0x prefix.

Link: http://lkml.kernel.org/n/tip-d9qv8n8xlmkywsb9vdrcj796@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/api/fs/fs.c | 29 ++++++++++++++++++++++-------
 tools/lib/api/fs/fs.h |  1 +
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index b24afc0e6e81..8b0e4a4315bd 100644
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
index dda49deefb52..8ebee35a6395 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -30,6 +30,7 @@ FS(bpf_fs)
 
 int filename__read_int(const char *filename, int *value);
 int filename__read_ull(const char *filename, unsigned long long *value);
+int filename__read_xll(const char *filename, unsigned long long *value);
 int filename__read_str(const char *filename, char **buf, size_t *sizep);
 
 int filename__write_int(const char *filename, int value);
-- 
2.13.6
