Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbeBPTkj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753324AbeBPTSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:18:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81ED0217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/41] tools lib api fs: Add sysfs__read_xll function
Date: Fri, 16 Feb 2018 16:17:09 -0300
Message-Id: <20180216191746.11095-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding sysfs__read_xll function to be able to read sysfs files with hex
numbers in, which do not have 0x prefix.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180206181813.10943-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/fs/fs.c | 15 +++++++++++++--
 tools/lib/api/fs/fs.h |  1 +
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 8b0e4a4315bd..6a12bbf39f7b 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -432,7 +432,8 @@ int procfs__read_str(const char *entry, char **buf, size_t *sizep)
 	return filename__read_str(path, buf, sizep);
 }
 
-int sysfs__read_ull(const char *entry, unsigned long long *value)
+static int sysfs__read_ull_base(const char *entry,
+				unsigned long long *value, int base)
 {
 	char path[PATH_MAX];
 	const char *sysfs = sysfs__mountpoint();
@@ -442,7 +443,17 @@ int sysfs__read_ull(const char *entry, unsigned long long *value)
 
 	snprintf(path, sizeof(path), "%s/%s", sysfs, entry);
 
-	return filename__read_ull(path, value);
+	return filename__read_ull_base(path, value, base);
+}
+
+int sysfs__read_xll(const char *entry, unsigned long long *value)
+{
+	return sysfs__read_ull_base(entry, value, 16);
+}
+
+int sysfs__read_ull(const char *entry, unsigned long long *value)
+{
+	return sysfs__read_ull_base(entry, value, 0);
 }
 
 int sysfs__read_int(const char *entry, int *value)
diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
index 8ebee35a6395..92d03b8396b1 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -40,6 +40,7 @@ int procfs__read_str(const char *entry, char **buf, size_t *sizep);
 int sysctl__read_int(const char *sysctl, int *value);
 int sysfs__read_int(const char *entry, int *value);
 int sysfs__read_ull(const char *entry, unsigned long long *value);
+int sysfs__read_xll(const char *entry, unsigned long long *value);
 int sysfs__read_str(const char *entry, char **buf, size_t *sizep);
 int sysfs__read_bool(const char *entry, bool *value);
 
-- 
2.14.3
