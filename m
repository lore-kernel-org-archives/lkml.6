Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ADDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53319206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbeLNUtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:49:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeLNUtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:49:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKmtRF1457909
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:48:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKmt501457906;
        Fri, 14 Dec 2018 12:48:55 -0800
Date:   Fri, 14 Dec 2018 12:48:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-r8aufbgbixr2f85s3wcoaw9v@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, davem@davemloft.net,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, hpa@zytor.com
Reply-To: davem@davemloft.net, mingo@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          jolsa@kernel.org, hpa@zytor.com, peterz@infradead.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Set the 'session_done' volatile variable
 when exiting
Git-Commit-ID: 2e86f646dd68cfdb412efd1262ff75e25fbbe050
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

Commit-ID:  2e86f646dd68cfdb412efd1262ff75e25fbbe050
Gitweb:     https://git.kernel.org/tip/2e86f646dd68cfdb412efd1262ff75e25fbbe050
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Nov 2018 20:11:19 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:33 -0300

perf top: Set the 'session_done' volatile variable when exiting

So we can get out of hist processing ASAP on user request.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-r8aufbgbixr2f85s3wcoaw9v@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index aad58643102e..50ec01eb7f57 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -577,6 +577,12 @@ static void perf_top__sort_new_samples(void *arg)
 	perf_top__reset_sample_counters(t);
 }
 
+static void stop_top(void)
+{
+	session_done = 1;
+	done = 1;
+}
+
 static void *display_thread_tui(void *arg)
 {
 	struct perf_evsel *pos;
@@ -613,13 +619,13 @@ static void *display_thread_tui(void *arg)
 				      !top->record_opts.overwrite,
 				      &top->annotation_opts);
 
-	done = 1;
+	stop_top();
 	return NULL;
 }
 
 static void display_sig(int sig __maybe_unused)
 {
-	done = 1;
+	stop_top();
 }
 
 static void display_setup_sig(void)
@@ -672,7 +678,7 @@ repeat:
 
 			if (perf_top__handle_keypress(top, c))
 				goto repeat;
-			done = 1;
+			stop_top();
 		}
 	}
 
