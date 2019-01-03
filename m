Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FFC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05F321479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbfACNPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:15:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35057 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfACNPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:15:30 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x03DFJWg1384458
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Jan 2019 05:15:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x03DFJul1384455;
        Thu, 3 Jan 2019 05:15:19 -0800
Date:   Thu, 3 Jan 2019 05:15:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-qjkds7bnk7v7fk2xhqsb0a4v@git.kernel.org>
Cc:     jolsa@kernel.org, tglx@linutronix.de, adrian.hunter@intel.com,
        namhyung@kernel.org, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        wangnan0@huawei.com, lclaudio@redhat.com
Reply-To: lclaudio@redhat.com, mingo@kernel.org, wangnan0@huawei.com,
          adrian.hunter@intel.com, namhyung@kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, acme@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Store the major number for a file
 when storing its pathname
Git-Commit-ID: 4bcc4cff6a10e5287d4dd3e73b6b4689f9a0c570
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

Commit-ID:  4bcc4cff6a10e5287d4dd3e73b6b4689f9a0c570
Gitweb:     https://git.kernel.org/tip/4bcc4cff6a10e5287d4dd3e73b6b4689f9a0c570
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 27 Dec 2018 13:32:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 28 Dec 2018 16:33:04 -0300

perf trace: Store the major number for a file when storing its pathname

We keep a table for the fds to map them back to pathnames when showing
'fd' based APIs such as write(), store as well the major number for the
device the path is in, to use in things like choosing the right ioctl
'cmd' beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-qjkds7bnk7v7fk2xhqsb0a4v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 41ab524e128b..4b03f66b1735 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -60,6 +60,7 @@
 #include <linux/stringify.h>
 #include <linux/time64.h>
 #include <fcntl.h>
+#include <sys/sysmacros.h>
 
 #include "sane_ctype.h"
 
@@ -959,6 +960,7 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 
 struct file {
 	char *pathname;
+	int  dev_maj;
 };
 
 /**
@@ -1068,6 +1070,9 @@ static int trace__set_fd_pathname(struct thread *thread, int fd, const char *pat
 	struct file *file = thread_trace__files_entry(ttrace, fd);
 
 	if (file != NULL) {
+		struct stat st;
+		if (stat(pathname, &st) == 0)
+			file->dev_maj = major(st.st_rdev);
 		file->pathname = strdup(pathname);
 		if (file->pathname)
 			return 0;
