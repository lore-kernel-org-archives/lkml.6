Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE09C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5C82080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD5C82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeKAG7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:59:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbeKAG7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:59:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VLxheu2558034
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 14:59:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VLxgBB2558030;
        Wed, 31 Oct 2018 14:59:42 -0700
Date:   Wed, 31 Oct 2018 14:59:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-o3ymi3104m8moaz9865g09w9@git.kernel.org>
Cc:     benjamin@python.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, dsahern@gmail.com, mingo@kernel.org,
        wangnan0@huawei.com, tglx@linutronix.de, acme@redhat.com,
        adrian.hunter@intel.com, namhyung@kernel.org
Reply-To: acme@redhat.com, tglx@linutronix.de, adrian.hunter@intel.com,
          namhyung@kernel.org, wangnan0@huawei.com, dsahern@gmail.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
          benjamin@python.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty: Introduce
 strarray__scnprintf_flags()
Git-Commit-ID: 579e5ff629b17744f62473f314768de8b6f1e66c
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

Commit-ID:  579e5ff629b17744f62473f314768de8b6f1e66c
Gitweb:     https://git.kernel.org/tip/579e5ff629b17744f62473f314768de8b6f1e66c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 25 Oct 2018 14:21:31 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 30 Oct 2018 11:46:23 -0300

perf beauty: Introduce strarray__scnprintf_flags()

Generalizing pkey_alloc__scnprintf_access_rights(), so that we can use
it with other flags-like arguments, such as mount's mountflags argument.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-o3ymi3104m8moaz9865g09w9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/beauty.h     |  1 +
 tools/perf/trace/beauty/pkey_alloc.c | 27 ++++++++++++++++-----------
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 2570152d3909..a1806c4f3ccd 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -24,6 +24,7 @@ struct strarray {
 }
 
 size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, int val);
+size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, unsigned long flags);
 
 struct trace;
 struct thread;
diff --git a/tools/perf/trace/beauty/pkey_alloc.c b/tools/perf/trace/beauty/pkey_alloc.c
index d3e5188a9bef..1b8ed4cac815 100644
--- a/tools/perf/trace/beauty/pkey_alloc.c
+++ b/tools/perf/trace/beauty/pkey_alloc.c
@@ -9,31 +9,28 @@
 #include <linux/kernel.h>
 #include <linux/log2.h>
 
-static size_t pkey_alloc__scnprintf_access_rights(int access_rights, char *bf, size_t size)
+size_t strarray__scnprintf_flags(struct strarray *sa, char *bf, size_t size, unsigned long flags)
 {
 	int i, printed = 0;
 
-#include "trace/beauty/generated/pkey_alloc_access_rights_array.c"
-	static DEFINE_STRARRAY(pkey_alloc_access_rights);
-
-	if (access_rights == 0) {
-		const char *s = strarray__pkey_alloc_access_rights.entries[0];
+	if (flags == 0) {
+		const char *s = sa->entries[0];
 		if (s)
 			return scnprintf(bf, size, "%s", s);
 		return scnprintf(bf, size, "%d", 0);
 	}
 
-	for (i = 1; i < strarray__pkey_alloc_access_rights.nr_entries; ++i) {
-		int bit = 1 << (i - 1);
+	for (i = 1; i < sa->nr_entries; ++i) {
+		unsigned long bit = 1UL << (i - 1);
 
-		if (!(access_rights & bit))
+		if (!(flags & bit))
 			continue;
 
 		if (printed != 0)
 			printed += scnprintf(bf + printed, size - printed, "|");
 
-		if (strarray__pkey_alloc_access_rights.entries[i] != NULL)
-			printed += scnprintf(bf + printed, size - printed, "%s", strarray__pkey_alloc_access_rights.entries[i]);
+		if (sa->entries[i] != NULL)
+			printed += scnprintf(bf + printed, size - printed, "%s", sa->entries[i]);
 		else
 			printed += scnprintf(bf + printed, size - printed, "0x%#", bit);
 	}
@@ -41,6 +38,14 @@ static size_t pkey_alloc__scnprintf_access_rights(int access_rights, char *bf, s
 	return printed;
 }
 
+static size_t pkey_alloc__scnprintf_access_rights(int access_rights, char *bf, size_t size)
+{
+#include "trace/beauty/generated/pkey_alloc_access_rights_array.c"
+	static DEFINE_STRARRAY(pkey_alloc_access_rights);
+
+	return strarray__scnprintf_flags(&strarray__pkey_alloc_access_rights, bf, size, access_rights);
+}
+
 size_t syscall_arg__scnprintf_pkey_alloc_access_rights(char *bf, size_t size, struct syscall_arg *arg)
 {
 	unsigned long cmd = arg->val;
