Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90992C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D349218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389031AbeLTS2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:28:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732986AbeLTS2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:28:31 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKISNSg3686490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:28:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKISMlu3686487;
        Thu, 20 Dec 2018 10:28:22 -0800
Date:   Thu, 20 Dec 2018 10:28:22 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6e4tj2fjen8qa73gy4u49vav@git.kernel.org>
Cc:     adrian.hunter@intel.com, jolsa@kernel.org, mingo@kernel.org,
        namhyung@kernel.org, lclaudio@redhat.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, wangnan0@huawei.com,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: wangnan0@huawei.com, hpa@zytor.com, tglx@linutronix.de,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, jolsa@kernel.org, mingo@kernel.org,
          namhyung@kernel.org, lclaudio@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Move strarrays to beauty.h for further
 reuse
Git-Commit-ID: 1f2d085e0f25a40eeb0ac032fd399be94f866adb
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

Commit-ID:  1f2d085e0f25a40eeb0ac032fd399be94f866adb
Gitweb:     https://git.kernel.org/tip/1f2d085e0f25a40eeb0ac032fd399be94f866adb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Dec 2018 10:25:28 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:19 -0300

perf trace: Move strarrays to beauty.h for further reuse

We'll use it in the upcoming arch_prctl() 'code' arg beautifier.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6e4tj2fjen8qa73gy4u49vav@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 26 ++++++++++----------------
 tools/perf/trace/beauty/beauty.h | 12 ++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6ba8290a0794..9d30e0f3b7ea 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -386,34 +386,28 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 #define SCA_STRARRAY syscall_arg__scnprintf_strarray
 
-struct strarrays {
-	int		nr_entries;
-	struct strarray **entries;
-};
-
-#define DEFINE_STRARRAYS(array) struct strarrays strarrays__##array = { \
-	.nr_entries = ARRAY_SIZE(array), \
-	.entries = array, \
-}
-
-size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
-					struct syscall_arg *arg)
+size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
-	struct strarrays *sas = arg->parm;
 	int i;
 
 	for (i = 0; i < sas->nr_entries; ++i) {
 		struct strarray *sa = sas->entries[i];
-		int idx = arg->val - sa->offset;
+		int idx = val - sa->offset;
 
 		if (idx >= 0 && idx < sa->nr_entries) {
 			if (sa->entries[idx] == NULL)
 				break;
-			return scnprintf(bf, size, "%s%s", arg->show_string_prefix ? sa->prefix : "", sa->entries[idx]);
+			return scnprintf(bf, size, "%s%s", show_prefix ? sa->prefix : "", sa->entries[idx]);
 		}
 	}
 
-	return scnprintf(bf, size, "%d", arg->val);
+	return scnprintf(bf, size, intfmt, val);
+}
+
+size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
+					struct syscall_arg *arg)
+{
+	return strarrays__scnprintf(arg->parm, bf, size, "%d", arg->show_string_prefix, arg->val);
 }
 
 #ifndef AT_FDCWD
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 1a93d9c626ef..58e734b27958 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -32,6 +32,18 @@ size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, boo
 struct trace;
 struct thread;
 
+struct strarrays {
+	int		nr_entries;
+	struct strarray **entries;
+};
+
+#define DEFINE_STRARRAYS(array) struct strarrays strarrays__##array = { \
+	.nr_entries = ARRAY_SIZE(array), \
+	.entries = array, \
+}
+
+size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val);
+
 size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_t size);
 
 extern struct strarray strarray__socket_families;
