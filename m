Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B63C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C77B20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C77B20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbeKSWoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:44:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729006AbeKSWoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:44:18 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAE0188304;
        Mon, 19 Nov 2018 12:20:50 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C7E45C57B;
        Mon, 19 Nov 2018 12:20:48 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 12/12] perf top: Move perf_top__reset_sample_counters after counts display
Date:   Mon, 19 Nov 2018 13:20:16 +0100
Message-Id: <20181119122016.22423-13-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 19 Nov 2018 12:20:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_top__reset_sample_counters call right after we display
the counters so we can see the updated numbers longer.

Link: http://lkml.kernel.org/n/tip-dqn9jbi0wt939zpk9rydtkc8@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c       | 4 ----
 tools/perf/ui/browsers/hists.c | 3 +++
 tools/perf/util/top.c          | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5d6e30f69d85..af4aaf8edb06 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -273,8 +273,6 @@ static void perf_top__print_sym_table(struct perf_top *top)
 	perf_top__header_snprintf(top, bf, sizeof(bf));
 	printf("%s\n", bf);
 
-	perf_top__reset_sample_counters(top);
-
 	printf("%-*.*s\n", win_width, win_width, graph_dotted_line);
 
 	if (!top->record_opts.overwrite &&
@@ -573,8 +571,6 @@ static void perf_top__sort_new_samples(void *arg)
 
 	if (t->lost || t->drop)
 		ui_helpline__fpush("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
-
-	perf_top__reset_sample_counters(t);
 }
 
 static void stop_top(void)
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 36b262c49f51..ffac1d54a3d4 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2229,8 +2229,11 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 
 		if (top->zero)
 			printed += scnprintf(bf + printed, size - printed, " [z]");
+
+		perf_top__reset_sample_counters(top);
 	}
 
+
 	return printed;
 }
 
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 31a8dee9af69..4c8da8c4435f 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -107,6 +107,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 					top->evlist->cpus->nr > 1 ? "s" : "");
 	}
 
+	perf_top__reset_sample_counters(top);
 	return ret;
 }
 
-- 
2.17.2

