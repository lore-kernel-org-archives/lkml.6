Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADD8218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbeLTSX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:23:56 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60555 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbeLTSXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:23:55 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKINk0C3684110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:23:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKINkwH3684107;
        Thu, 20 Dec 2018 10:23:46 -0800
Date:   Thu, 20 Dec 2018 10:23:46 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ofovpmvdli3bwch30936xn7t@git.kernel.org>
Cc:     tglx@linutronix.de, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        acme@redhat.com, lclaudio@redhat.com, mingo@kernel.org
Reply-To: jolsa@kernel.org, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com, tglx@linutronix.de, adrian.hunter@intel.com,
          lclaudio@redhat.com, acme@redhat.com, mingo@kernel.org,
          hpa@zytor.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Print O_RDONLY when (flags &
 O_ACCMODE) == 0
Git-Commit-ID: 601d66d43309534eb7a268bdc42c205521014645
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

Commit-ID:  601d66d43309534eb7a268bdc42c205521014645
Gitweb:     https://git.kernel.org/tip/601d66d43309534eb7a268bdc42c205521014645
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 17 Dec 2018 11:55:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:07:42 -0300

perf trace beauty: Print O_RDONLY when (flags & O_ACCMODE) == 0

And there are more flags, to match strace's output.

 openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3

Also to help with regression tests.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ofovpmvdli3bwch30936xn7t@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/open_flags.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/open_flags.c b/tools/perf/trace/beauty/open_flags.c
index 6da48893a1bb..78f6566ef110 100644
--- a/tools/perf/trace/beauty/open_flags.c
+++ b/tools/perf/trace/beauty/open_flags.c
@@ -27,8 +27,10 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool sh
 	const char *prefix = "O_";
 	int printed = 0;
 
+	if ((flags & O_ACCMODE) == O_RDONLY)
+		printed = scnprintf(bf, size, "%s%s", show_prefix ? prefix : "", "RDONLY");
 	if (flags == 0)
-		return scnprintf(bf, size, "%s%s", show_prefix ? prefix : "", "RDONLY");
+		return printed;
 #define	P_FLAG(n) \
 	if (flags & O_##n) { \
 		printed += scnprintf(bf + printed, size - printed, "%s%s%s", printed ? "|" : "", show_prefix ? prefix : "", #n); \
