Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeBFS3E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 13:29:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753233AbeBFS1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 13:27:48 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 05/17] tools lib api fs: Add sysfs__read_xll function
Date: Tue,  6 Feb 2018 19:18:01 +0100
Message-Id: <20180206181813.10943-6-jolsa@kernel.org>
In-Reply-To: <20180206181813.10943-1-jolsa@kernel.org>
References: <20180206181813.10943-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding sysfs__read_xll function to be able to read sysfs
files with hex numbers in, which do not have 0x prefix.

Link: http://lkml.kernel.org/n/tip-j5ullvrcli5ga3hn6692t2aw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.13.6
