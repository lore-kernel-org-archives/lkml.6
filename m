Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C38FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FB5218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389224AbeLTSak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:30:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46501 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389002AbeLTS3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:29:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKISv443686550
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:28:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKISv2b3686544;
        Thu, 20 Dec 2018 10:28:57 -0800
Date:   Thu, 20 Dec 2018 10:28:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-kx59j2dk5l1x04ou57mt99ck@git.kernel.org>
Cc:     tglx@linutronix.de, wangnan0@huawei.com, mingo@kernel.org,
        acme@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, lclaudio@redhat.com, namhyung@kernel.org,
        adrian.hunter@intel.com
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, namhyung@kernel.org,
          jolsa@kernel.org, lclaudio@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, wangnan0@huawei.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: When showing string prefixes show
 prefix + ??? for unknown entries
Git-Commit-ID: 9614b8d697350d529743702f095b3db3f6d5a889
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

Commit-ID:  9614b8d697350d529743702f095b3db3f6d5a889
Gitweb:     https://git.kernel.org/tip/9614b8d697350d529743702f095b3db3f6d5a889
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Dec 2018 10:54:19 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:19 -0300

perf trace: When showing string prefixes show prefix + ??? for unknown entries

To match 'strace' output, like in:

  arch_prctl(0x3001 /* ARCH_??? */, 0x7ffc8a92dc80) = -1 EINVAL (Invalid argument)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kx59j2dk5l1x04ou57mt99ck@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9d30e0f3b7ea..6d9be952e3a7 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -365,8 +365,12 @@ size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const cha
 {
 	int idx = val - sa->offset;
 
-	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL)
-		return scnprintf(bf, size, intfmt, val);
+	if (idx < 0 || idx >= sa->nr_entries || sa->entries[idx] == NULL) {
+		size_t printed = scnprintf(bf, size, intfmt, val);
+		if (show_prefix)
+			printed += scnprintf(bf + printed, size - printed, " /* %s??? */", sa->prefix);
+		return printed;
+	}
 
 	return scnprintf(bf, size, "%s%s", show_prefix ? sa->prefix : "", sa->entries[idx]);
 }
@@ -388,6 +392,7 @@ static size_t syscall_arg__scnprintf_strarray(char *bf, size_t size,
 
 size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
 {
+	size_t printed;
 	int i;
 
 	for (i = 0; i < sas->nr_entries; ++i) {
@@ -401,7 +406,10 @@ size_t strarrays__scnprintf(struct strarrays *sas, char *bf, size_t size, const
 		}
 	}
 
-	return scnprintf(bf, size, intfmt, val);
+	printed = scnprintf(bf, size, intfmt, val);
+	if (show_prefix)
+		printed += scnprintf(bf + printed, size - printed, " /* %s??? */", sas->entries[0]->prefix);
+	return printed;
 }
 
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size,
