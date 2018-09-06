Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C1BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A320520844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A320520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbeIFRo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:44:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56989 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbeIFRo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:44:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D9IGK303971
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:09:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D9Iwg303968;
        Thu, 6 Sep 2018 06:09:18 -0700
Date:   Thu, 6 Sep 2018 06:09:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-canomaoiybkswwnhj69u9ae4@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, namhyung@kernel.org,
        jolsa@kernel.org, acme@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dsahern@gmail.com,
        wangnan0@huawei.com
Reply-To: acme@redhat.com, wangnan0@huawei.com, hpa@zytor.com,
          dsahern@gmail.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com, jolsa@kernel.org, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Extract the comm/tid printing for
 syscall enter
Git-Commit-ID: 6dcbd212ff4988d8e6caa0b6700bd1c1d317dc02
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

Commit-ID:  6dcbd212ff4988d8e6caa0b6700bd1c1d317dc02
Gitweb:     https://git.kernel.org/tip/6dcbd212ff4988d8e6caa0b6700bd1c1d317dc02
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 Aug 2018 11:40:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:19 -0300

perf trace: Extract the comm/tid printing for syscall enter

Will be used with augmented syscalls, where we haven't transitioned
completely to combining sys_enter_FOO with sys_exit_FOO, so we'll go
as far as having it similar to the end result, strace like, as possible.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-canomaoiybkswwnhj69u9ae4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bcf882afd6d0..92488edd00eb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1144,11 +1144,9 @@ static void sig_handler(int sig)
 	interrupted = sig == SIGINT;
 }
 
-static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
-					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
+static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread, FILE *fp)
 {
-	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
-	printed += fprintf_duration(duration, duration_calculated, fp);
+	size_t printed = 0;
 
 	if (trace->multiple_threads) {
 		if (trace->show_comm)
@@ -1159,6 +1157,14 @@ static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thre
 	return printed;
 }
 
+static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
+					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
+{
+	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
+	printed += fprintf_duration(duration, duration_calculated, fp);
+	return printed + trace__fprintf_comm_tid(trace, thread, fp);
+}
+
 static int trace__process_event(struct trace *trace, struct machine *machine,
 				union perf_event *event, struct perf_sample *sample)
 {
