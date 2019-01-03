Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F4CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06B821479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbfACNOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:14:53 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42307 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfACNOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:14:53 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DEhHv1384187
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:14:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DEh7h1384184;
        Thu, 3 Jan 2019 05:14:43 -0800
Date:   Thu, 3 Jan 2019 05:14:43 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hzvpe3qwafe6sqcq3bhtbxds@git.kernel.org>
Cc:     adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, acme@redhat.com, mingo@kernel.org,
        hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org,
        lclaudio@redhat.com, tglx@linutronix.de
Reply-To: wangnan0@huawei.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, namhyung@kernel.org, hpa@zytor.com,
          mingo@kernel.org, acme@redhat.com, lclaudio@redhat.com,
          jolsa@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Move the files table resizing to
 outside set_pathname()
Git-Commit-ID: d7e134845d6b19288dec5582ce91d6c6052fcdad
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

Commit-ID:  d7e134845d6b19288dec5582ce91d6c6052fcdad
Gitweb:     https://git.kernel.org/tip/d7e134845d6b19288dec5582ce91d6c6052fcdad
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 27 Dec 2018 11:05:18 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:03 -0300

perf trace: Move the files table resizing to outside set_pathname()

So that we can have that table expanded when setting other attributes.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hzvpe3qwafe6sqcq3bhtbxds@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d4bca74f282c..41ab524e128b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1040,15 +1040,13 @@ void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
 
 static const size_t trace__entry_str_size = 2048;
 
-static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
+static struct file *thread_trace__files_entry(struct thread_trace *ttrace, int fd)
 {
-	struct thread_trace *ttrace = thread__priv(thread);
-
 	if (fd > ttrace->files.max) {
 		struct file *nfiles = realloc(ttrace->files.table, (fd + 1) * sizeof(struct file));
 
 		if (nfiles == NULL)
-			return -1;
+			return NULL;
 
 		if (ttrace->files.max != -1) {
 			memset(nfiles + ttrace->files.max + 1, 0,
@@ -1061,9 +1059,21 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 		ttrace->files.max   = fd;
 	}
 
-	ttrace->files.table[fd].pathname = strdup(pathname);
+	return ttrace->files.table + fd;
+}
+
+static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
+{
+	struct thread_trace *ttrace = thread__priv(thread);
+	struct file *file = thread_trace__files_entry(ttrace, fd);
+
+	if (file != NULL) {
+		file->pathname = strdup(pathname);
+		if (file->pathname)
+			return 0;
+	}
 
-	return ttrace->files.table[fd].pathname != NULL ? 0 : -1;
+	return -1;
 }
 
 static int thread__read_fd_path(struct thread *thread, int fd)
