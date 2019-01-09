Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B712C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5487620821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfAIHK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:10:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49151 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbfAIHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:10:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x097A06w3855365
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 23:10:00 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x097A0P33855362;
        Tue, 8 Jan 2019 23:10:00 -0800
Date:   Tue, 8 Jan 2019 23:10:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-oi45i54s59h1w1kmgpzrfuum@git.kernel.org>
Cc:     adrian.hunter@intel.com, lclaudio@redhat.com, namhyung@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        wangnan0@huawei.com, jolsa@kernel.org, acme@redhat.com,
        mingo@kernel.org
Reply-To: adrian.hunter@intel.com, namhyung@kernel.org, hpa@zytor.com,
          lclaudio@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, wangnan0@huawei.com, jolsa@kernel.org,
          acme@redhat.com, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Fix ')' placement in "interrupted"
 syscall lines
Git-Commit-ID: 172bf02d564bdb6df8410f64720fa2c68e755d1a
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

Commit-ID:  172bf02d564bdb6df8410f64720fa2c68e755d1a
Gitweb:     https://git.kernel.org/tip/172bf02d564bdb6df8410f64720fa2c68e755d1a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 7 Jan 2019 16:24:27 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 8 Jan 2019 13:28:12 -0300

perf trace: Fix ')' placement in "interrupted" syscall lines

When we get the sys_enter for a syscall we check if the last one is
still waiting for its matching sys_exit, if so we print this:

   468.753 (         ): firefox/32382 poll(ufds: 0x7f3988d3dd00, nfds: 7, timeout_msecs: 4294967295)     ...
   449.575 ( 0.004 ms): Softwar~cThrea/32434 futex(uaddr: 0x7f39a18a9b70, op: WAKE|PRIVATE_FLAG, val: 1)           = 0

At some point we'll get that poll sys_exit event and will print a "[continued]" line.

While making the sizing of the alignment after the syscall arg list and
its result configurable, so that we can mimic strace, which uses a
smaller alingment by default, a bug was introduced where the closing
parens appeared before the syscall name and its arg list, fix it.

Fixes: 4b8a240ed5e0 ("perf trace: Add alignment spaces after the closing parens")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-oi45i54s59h1w1kmgpzrfuum@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index adbf28183560..b8bf5d025563 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1758,6 +1758,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 {
 	struct thread_trace *ttrace;
 	size_t printed;
+	int len;
 
 	if (trace->failure_only || trace->current == NULL)
 		return 0;
@@ -1768,9 +1769,14 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 		return 0;
 
 	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
-	printed += fprintf(trace->output, ")%-*s ...\n", trace->args_alignment, ttrace->entry_str);
-	ttrace->entry_pending = false;
+	printed += len = fprintf(trace->output, "%s)", ttrace->entry_str);
+
+	if (len < trace->args_alignment - 4)
+		printed += fprintf(trace->output, "%-*s", trace->args_alignment - 4 - len, " ");
 
+	printed += fprintf(trace->output, " ...\n");
+
+	ttrace->entry_pending = false;
 	++trace->nr_events_printed;
 
 	return printed;
