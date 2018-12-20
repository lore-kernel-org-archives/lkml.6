Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB658C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C0F218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbeLTSZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:25:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbeLTSZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:25:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIPU2l3686019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:25:30 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIPTl23686015;
        Thu, 20 Dec 2018 10:25:29 -0800
Date:   Thu, 20 Dec 2018 10:25:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-krxl6klsqc9qyktoaxyih942@git.kernel.org>
Cc:     wangnan0@huawei.com, lclaudio@redhat.com, mingo@kernel.org,
        acme@redhat.com, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com
Reply-To: lclaudio@redhat.com, wangnan0@huawei.com, acme@redhat.com,
          hpa@zytor.com, mingo@kernel.org, namhyung@kernel.org,
          adrian.hunter@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Enclose the errno strings with ()
Git-Commit-ID: 2c83dfae021306d528b21dceb8d128ca16524c5a
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

Commit-ID:  2c83dfae021306d528b21dceb8d128ca16524c5a
Gitweb:     https://git.kernel.org/tip/2c83dfae021306d528b21dceb8d128ca16524c5a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 17 Dec 2018 12:06:34 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:18 -0300

perf trace: Enclose the errno strings with ()

To match strace, now both emit the same line for calls like:

 access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-krxl6klsqc9qyktoaxyih942@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 226e994ac638..35d8fbe47ee4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2024,10 +2024,10 @@ errno_print: {
 		const char *emsg = str_error_r(-ret, bf, sizeof(bf)),
 			   *e = errno_to_name(evsel, -ret);
 
-		fprintf(trace->output, "-1 %s %s", e, emsg);
+		fprintf(trace->output, "-1 %s (%s)", e, emsg);
 	}
 	} else if (ret == 0 && sc->fmt->timeout)
-		fprintf(trace->output, "0 Timeout");
+		fprintf(trace->output, "0 (Timeout)");
 	else if (ttrace->ret_scnprintf) {
 		char bf[1024];
 		struct syscall_arg arg = {
