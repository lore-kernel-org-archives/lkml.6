Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A1BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E149C2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131792;
	bh=OvzNvNwxN3hwWQ1ytyYbHUJKgz0iDWBvkqMOwL7fqek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=deFuFA12mclrCRHkAGrKqsLzqzaA2B1czKIsbegG9yrVvqwZqQv/q4qIe5Ea8R0Dj
	 zao9qClj7sJlQOW10M9OyRKHpGVzDm2dbKWAbQzHHmeHg9ALg1dzyBLdzQq5m/PRFE
	 68pGaim9NWXFoIR1frY8BI/JVUVPtp8cGzaBrC4g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E149C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbeLFV3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:29:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbeLFV3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:45 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CDB320989;
        Thu,  6 Dec 2018 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131785;
        bh=OvzNvNwxN3hwWQ1ytyYbHUJKgz0iDWBvkqMOwL7fqek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e32PP//k92+GjfPYmgd9lYeLvCGQCf4NFbi4vlRmhfWpXXAysmWs/mQczh7MLqcTo
         tPkN7foU5yASYeDYyVWiqx45WSi5Sk+cndp3PhD/PwowEbfuUM/sTXi0k5j2q+uoSE
         nXuSoZ6rJNkGuiHci0M9nJbgLnVIq9O+oSRjbQqc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 49/75] perf top: Move lost events warning to helpline
Date:   Thu,  6 Dec 2018 18:25:36 -0300
Message-Id: <20181206212602.20474-50-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
-- 
2.19.2

