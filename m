Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BC2C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA732070C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731181AbfACNRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:17:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33003 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfACNRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:17:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DHd7S1384598
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:17:39 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DHcfx1384595;
        Thu, 3 Jan 2019 05:17:38 -0800
Date:   Thu, 3 Jan 2019 05:17:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wm5o51f206c5pi063dsaeraq@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, wangnan0@huawei.com,
        adrian.hunter@intel.com, jolsa@kernel.org, namhyung@kernel.org,
        mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        lclaudio@redhat.com
Reply-To: namhyung@kernel.org, mingo@kernel.org, jolsa@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, lclaudio@redhat.com,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace beauty: Export function to get the
 files for a thread
Git-Commit-ID: 2d473389f87ace284bda35a5254bc66e24d0caa9
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

Commit-ID:  2d473389f87ace284bda35a5254bc66e24d0caa9
Gitweb:     https://git.kernel.org/tip/2d473389f87ace284bda35a5254bc66e24d0caa9
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 27 Dec 2018 16:19:33 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:05 -0300

perf trace beauty: Export function to get the files for a thread

So that beautifiers can access things like dev_maj.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-wm5o51f206c5pi063dsaeraq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 10 +++++-----
 tools/perf/trace/beauty/beauty.h |  7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4b03f66b1735..adbf28183560 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -958,11 +958,6 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 	return printed + fprintf(fp, "): ");
 }
 
-struct file {
-	char *pathname;
-	int  dev_maj;
-};
-
 /**
  * filename.ptr: The filename char pointer that will be vfs_getname'd
  * filename.entry_str_pos: Where to insert the string translated from
@@ -1064,6 +1059,11 @@ static struct file *thread_trace__files_entry(struct thread_trace *ttrace, int f
 	return ttrace->files.table + fd;
 }
 
+struct file *thread__files_entry(struct thread *thread, int fd)
+{
+	return thread_trace__files_entry(thread__priv(thread), fd);
+}
+
 static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pathname)
 {
 	struct thread_trace *ttrace = thread__priv(thread);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 83c5b202e00e..139d485a6f16 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -32,6 +32,13 @@ size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, boo
 struct trace;
 struct thread;
 
+struct file {
+	char *pathname;
+	int  dev_maj;
+};
+
+struct file *thread__files_entry(struct thread *thread, int fd);
+
 struct strarrays {
 	int		nr_entries;
 	struct strarray **entries;
