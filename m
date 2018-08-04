Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500FBC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F83217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F83217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbeHDPGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 718CA40704AF;
        Sat,  4 Aug 2018 13:05:39 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02C71215670D;
        Sat,  4 Aug 2018 13:05:37 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 09/20] perf annotate: Add PERCENT_HITS_GLOBAL percent value
Date:   Sat,  4 Aug 2018 15:05:10 +0200
Message-Id: <20180804130521.11408-10-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Sat, 04 Aug 2018 13:05:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding and computing global hits percent value for
annotation line. Storing it in struct annotation_data
percent array under new PERCENT_HITS_GLOBAL index.

At the moment it's not displayed, it's coming in
following patches.

Link: http://lkml.kernel.org/n/tip-2w3em3e57zpbn2ukl7qucc3s@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/annotate.c | 8 +++++++-
 tools/perf/util/annotate.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 074adb2a831e..b7485a512da1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1759,6 +1759,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 }
 
 static void calc_percent(struct sym_hist *sym_hist,
+			 struct hists *hists,
 			 struct annotation_data *data,
 			 s64 offset, s64 end)
 {
@@ -1776,6 +1777,10 @@ static void calc_percent(struct sym_hist *sym_hist,
 		data->he.nr_samples = hits;
 		data->percent[PERCENT_HITS_LOCAL] = 100.0 * hits / sym_hist->nr_samples;
 	}
+
+	if (hists->stats.nr_non_filtered_samples)
+		data->percent[PERCENT_HITS_GLOBAL] = 100.0 * hits / hists->stats.nr_non_filtered_samples;
+
 }
 
 static void annotation__calc_percent(struct annotation *notes,
@@ -1795,6 +1800,7 @@ static void annotation__calc_percent(struct annotation *notes,
 		end  = next ? next->offset : len;
 
 		for_each_group_evsel(evsel, leader) {
+			struct hists *hists = evsel__hists(evsel);
 			struct annotation_data *data;
 			struct sym_hist *sym_hist;
 
@@ -1803,7 +1809,7 @@ static void annotation__calc_percent(struct annotation *notes,
 			sym_hist = annotation__histogram(notes, evsel->idx);
 			data = &al->data[i++];
 
-			calc_percent(sym_hist, data, al->offset, end);
+			calc_percent(sym_hist, hists, data, al->offset, end);
 		}
 	}
 }
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0afbf8075fca..3a06cb2b6e28 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -103,6 +103,7 @@ struct sym_hist_entry {
 
 enum {
 	PERCENT_HITS_LOCAL,
+	PERCENT_HITS_GLOBAL,
 	PERCENT_MAX,
 };
 
-- 
2.17.1

