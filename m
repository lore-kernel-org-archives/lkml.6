Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DDE206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeLNUra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:47:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48981 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730713AbeLNUr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:47:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKlA4T1457511
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:47:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKlARl1457508;
        Fri, 14 Dec 2018 12:47:10 -0800
Date:   Fri, 14 Dec 2018 12:47:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-x4k0iuw7tt6mywsaguq6jfwu@git.kernel.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org,
        peterz@infradead.org, davem@davemloft.net, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: peterz@infradead.org, mingo@kernel.org, namhyung@kernel.org,
          jolsa@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, tglx@linutronix.de,
          davem@davemloft.net
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Move lost events warning to helpline
Git-Commit-ID: f0a93bdc13e413958f7440b69fa4054ccbca5f97
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

Commit-ID:  f0a93bdc13e413958f7440b69fa4054ccbca5f97
Gitweb:     https://git.kernel.org/tip/f0a93bdc13e413958f7440b69fa4054ccbca5f97
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 5 Nov 2018 21:34:47 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:33 -0300

perf top: Move lost events warning to helpline

We can't display the UI box saying that we are slow in the reader
thread.  That will make 'perf top' even slower and the user even more
angry ;-)

Move the UI box message from the reader thread to the UI thread and
change it to a helpline, so there's no need to 'press any key'.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-x4k0iuw7tt6mywsaguq6jfwu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c02ea537d5a7..9fe835ba0697 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -553,8 +553,6 @@ static void perf_top__sort_new_samples(void *arg)
 	struct perf_evsel *evsel = t->sym_evsel;
 	struct hists *hists;
 
-	perf_top__reset_sample_counters(t);
-
 	if (t->evlist->selected != NULL)
 		t->sym_evsel = t->evlist->selected;
 
@@ -571,6 +569,11 @@ static void perf_top__sort_new_samples(void *arg)
 
 	hists__collapse_resort(hists, NULL);
 	perf_evsel__output_resort(evsel, NULL);
+
+	if (t->lost)
+		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
+
+	perf_top__reset_sample_counters(t);
 }
 
 static void *display_thread_tui(void *arg)
@@ -908,10 +911,8 @@ static void perf_top__mmap_read(struct perf_top *top)
 {
 	bool overwrite = top->record_opts.overwrite;
 	struct perf_evlist *evlist = top->evlist;
-	unsigned long long start, end;
 	int i;
 
-	start = rdclock();
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);
 
@@ -922,13 +923,6 @@ static void perf_top__mmap_read(struct perf_top *top)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 	}
-	end = rdclock();
-
-	if ((end - start) > (unsigned long long)top->delay_secs * NSEC_PER_SEC)
-		ui__warning("Too slow to read ring buffer.\n"
-			    "Please try increasing the period (-c) or\n"
-			    "decreasing the freq (-F) or\n"
-			    "limiting the number of CPUs (-C)\n");
 }
 
 /*
