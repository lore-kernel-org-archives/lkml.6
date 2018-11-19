Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16633C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB29D2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB29D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeKSWoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:44:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeKSWoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:44:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 655C53086272;
        Mon, 19 Nov 2018 12:20:33 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 696745C8A1;
        Mon, 19 Nov 2018 12:20:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 05/12] perf top: Moving lost events warning to helpline
Date:   Mon, 19 Nov 2018 13:20:09 +0100
Message-Id: <20181119122016.22423-6-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 19 Nov 2018 12:20:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can't display the UI box saying that we are slow in reader
thread. That will make perf top even slower and user even more
angry ;-)

Moving the UI box message out of the reader thread into UI thread
and changing it into helpline, so there's no 'press any key'
necessary.

Link: http://lkml.kernel.org/n/tip-0rpmmt3omlait889ewp1cl61@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 047e99de09f3..1d77aa7650da 100644
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
+		ui_helpline__fpush("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
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
-- 
2.17.2

