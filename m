Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751174AbeBQLbX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 06:31:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48695 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeBQLbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 06:31:22 -0500
Date: Sat, 17 Feb 2018 03:21:00 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d9c5f32240f503481291a6d4e7246ee0a128d76d@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        dsahern@gmail.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org
Reply-To: jolsa@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
        hpa@zytor.com, acme@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org
In-Reply-To: <20180206181813.10943-6-jolsa@kernel.org>
References: <20180206181813.10943-6-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib api fs: Add sysfs__read_xll function
Git-Commit-ID: d9c5f32240f503481291a6d4e7246ee0a128d76d
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

Commit-ID:  d9c5f32240f503481291a6d4e7246ee0a128d76d
Gitweb:     https://git.kernel.org/tip/d9c5f32240f503481291a6d4e7246ee0a128d76d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 6 Feb 2018 19:18:01 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Feb 2018 10:09:23 -0300

tools lib api fs: Add sysfs__read_xll function

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
index 8b0e4a4..6a12bbf 100644
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
index 8ebee35..92d03b8 100644
--- a/tools/lib/api/fs/fs.h
+++ b/tools/lib/api/fs/fs.h
@@ -40,6 +40,7 @@ int procfs__read_str(const char *entry, char **buf, size_t *sizep);
 int sysctl__read_int(const char *sysctl, int *value);
 int sysfs__read_int(const char *entry, int *value);
 int sysfs__read_ull(const char *entry, unsigned long long *value);
+int sysfs__read_xll(const char *entry, unsigned long long *value);
 int sysfs__read_str(const char *entry, char **buf, size_t *sizep);
 int sysfs__read_bool(const char *entry, bool *value);
 
