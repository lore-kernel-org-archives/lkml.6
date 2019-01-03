Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973D7C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D4F2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbfACNOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:14:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46415 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbfACNOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:14:23 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DE96x1384149
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:14:09 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DE9Ft1384146;
        Thu, 3 Jan 2019 05:14:09 -0800
Date:   Thu, 3 Jan 2019 05:14:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1895cmhrdz2dkl5prf2cj2yj@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, lclaudio@redhat.com, wangnan0@huawei.com,
        tglx@linutronix.de, mingo@kernel.org, namhyung@kernel.org,
        hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
          lclaudio@redhat.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@kernel.org,
          hpa@zytor.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Rename thread_thread->paths to
 thread_trace->files
Git-Commit-ID: f4a74fcbfd943e128bbd464dc31b4405e1514d63
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f4a74fcbfd943e128bbd464dc31b4405e1514d63
Gitweb:     https://git.kernel.org/tip/f4a74fcbfd943e128bbd464dc31b4405e1514d63
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 27 Dec 2018 10:56:12 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:03 -0300

perf trace: Rename thread_thread->paths to thread_trace->files

So that we can add more per file attributes besides the pathname, such
as which ioctl beautifier to use, for cases such as the sound and
usbdeffs ioctls, that both use the 'U' command, so we have to
differentiate at the major number for the device file.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1895cmhrdz2dkl5prf2cj2yj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1e9e886b2811..d4bca74f282c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -957,6 +957,10 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 	return printed + fprintf(fp, "): ");
 }
 
+struct file {
+	char *pathname;
+};
+
 /**
  * filename.ptr: The filename char pointer that will be vfs_getname'd
  * filename.entry_str_pos: Where to insert the string translated from
@@ -980,9 +984,9 @@ struct thread_trace {
 		char	      *name;
 	} filename;
 	struct {
-		int	  max;
-		char	  **table;
-	} paths;
+		int	      max;
+		struct file   *table;
+	} files;
 
 	struct intlist *syscall_stats;
 };
@@ -992,7 +996,7 @@ static struct thread_trace *thread_trace__new(void)
 	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
 
 	if (ttrace)
-		ttrace->paths.max = -1;
+		ttrace->files.max = -1;
 
 	ttrace->syscall_stats = intlist__new(NULL);
 
@@ -1040,26 +1044,26 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 {
 	struct thread_trace *ttrace = thread__priv(thread);
 
-	if (fd > ttrace->paths.max) {
-		char **npath = realloc(ttrace->paths.table, (fd + 1) * sizeof(char *));
+	if (fd > ttrace->files.max) {
+		struct file *nfiles = realloc(ttrace->files.table, (fd + 1) * sizeof(struct file));
 
-		if (npath == NULL)
+		if (nfiles == NULL)
 			return -1;
 
-		if (ttrace->paths.max != -1) {
-			memset(npath + ttrace->paths.max + 1, 0,
-			       (fd - ttrace->paths.max) * sizeof(char *));
+		if (ttrace->files.max != -1) {
+			memset(nfiles + ttrace->files.max + 1, 0,
+			       (fd - ttrace->files.max) * sizeof(struct file));
 		} else {
-			memset(npath, 0, (fd + 1) * sizeof(char *));
+			memset(nfiles, 0, (fd + 1) * sizeof(struct file));
 		}
 
-		ttrace->paths.table = npath;
-		ttrace->paths.max   = fd;
+		ttrace->files.table = nfiles;
+		ttrace->files.max   = fd;
 	}
 
-	ttrace->paths.table[fd] = strdup(pathname);
+	ttrace->files.table[fd].pathname = strdup(pathname);
 
-	return ttrace->paths.table[fd] != NULL ? 0 : -1;
+	return ttrace->files.table[fd].pathname != NULL ? 0 : -1;
 }
 
 static int thread__read_fd_path(struct thread *thread, int fd)
@@ -1099,7 +1103,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 	if (fd < 0)
 		return NULL;
 
-	if ((fd > ttrace->paths.max || ttrace->paths.table[fd] == NULL)) {
+	if ((fd > ttrace->files.max || ttrace->files.table[fd].pathname == NULL)) {
 		if (!trace->live)
 			return NULL;
 		++trace->stats.proc_getname;
@@ -1107,7 +1111,7 @@ static const char *thread__fd_path(struct thread *thread, int fd,
 			return NULL;
 	}
 
-	return ttrace->paths.table[fd];
+	return ttrace->files.table[fd].pathname;
 }
 
 size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg)
@@ -1146,8 +1150,8 @@ static size_t syscall_arg__scnprintf_close_fd(char *bf, size_t size,
 	size_t printed = syscall_arg__scnprintf_fd(bf, size, arg);
 	struct thread_trace *ttrace = thread__priv(arg->thread);
 
-	if (ttrace && fd >= 0 && fd <= ttrace->paths.max)
-		zfree(&ttrace->paths.table[fd]);
+	if (ttrace && fd >= 0 && fd <= ttrace->files.max)
+		zfree(&ttrace->files.table[fd].pathname);
 
 	return printed;
 }
