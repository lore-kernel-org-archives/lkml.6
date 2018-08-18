Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64806C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241F22146E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241F22146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbeHROgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:36:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38241 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:36:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBSrbs1286016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:28:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBSrDB1286013;
        Sat, 18 Aug 2018 04:28:53 -0700
Date:   Sat, 18 Aug 2018 04:28:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-2bcf73069b0722c92a84c0fd57df542890a74904@git.kernel.org>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, jolsa@kernel.org
Reply-To: dsahern@gmail.com, alexander.shishkin@linux.intel.com,
          acme@redhat.com, tglx@linutronix.de, peterz@infradead.org,
          eranian@google.com, jolsa@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org
In-Reply-To: <20180804130521.11408-8-jolsa@kernel.org>
References: <20180804130521.11408-8-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Loop group events directly in
 annotation__calc_percent()
Git-Commit-ID: 2bcf73069b0722c92a84c0fd57df542890a74904
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

Commit-ID:  2bcf73069b0722c92a84c0fd57df542890a74904
Gitweb:     https://git.kernel.org/tip/2bcf73069b0722c92a84c0fd57df542890a74904
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:08 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:47 -0300

perf annotate: Loop group events directly in annotation__calc_percent()

We need to bring in 'struct hists' object and for that we need 'struct
perf_evsel' object in the scope.

Switching the group data loop with the evsel group loop.  It does the
same thing, but it brings evsel object, that we can use later get the
'struct hists' object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 13 ++++++++-----
 tools/perf/util/evsel.h    |  7 +++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 728603636adc..34d4bb73aa84 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1774,13 +1774,14 @@ static void calc_percent(struct sym_hist *sym_hist,
 }
 
 static void annotation__calc_percent(struct annotation *notes,
-				     struct perf_evsel *evsel, s64 len)
+				     struct perf_evsel *leader, s64 len)
 {
 	struct annotation_line *al, *next;
+	struct perf_evsel *evsel;
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		s64 end;
-		int i;
+		int i = 0;
 
 		if (al->offset == -1)
 			continue;
@@ -1788,12 +1789,14 @@ static void annotation__calc_percent(struct annotation *notes,
 		next = annotation_line__next(al, &notes->src->source);
 		end  = next ? next->offset : len;
 
-		for (i = 0; i < al->data_nr; i++) {
+		for_each_group_evsel(evsel, leader) {
 			struct annotation_data *data;
 			struct sym_hist *sym_hist;
 
-			sym_hist = annotation__histogram(notes, evsel->idx + i);
-			data = &al->data[i];
+			BUG_ON(i >= al->data_nr);
+
+			sym_hist = annotation__histogram(notes, evsel->idx);
+			data = &al->data[i++];
 
 			calc_percent(sym_hist, data, al->offset, end);
 		}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 973c03167947..163c960614d3 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -452,11 +452,18 @@ static inline int perf_evsel__group_idx(struct perf_evsel *evsel)
 	return evsel->idx - evsel->leader->idx;
 }
 
+/* Iterates group WITHOUT the leader. */
 #define for_each_group_member(_evsel, _leader) 					\
 for ((_evsel) = list_entry((_leader)->node.next, struct perf_evsel, node); 	\
      (_evsel) && (_evsel)->leader == (_leader);					\
      (_evsel) = list_entry((_evsel)->node.next, struct perf_evsel, node))
 
+/* Iterates group WITH the leader. */
+#define for_each_group_evsel(_evsel, _leader) 					\
+for ((_evsel) = _leader; 							\
+     (_evsel) && (_evsel)->leader == (_leader);					\
+     (_evsel) = list_entry((_evsel)->node.next, struct perf_evsel, node))
+
 static inline bool perf_evsel__has_branch_callstack(const struct perf_evsel *evsel)
 {
 	return evsel->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
