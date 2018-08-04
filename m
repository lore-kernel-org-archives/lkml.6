Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB7C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A3D217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A3D217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeHDPGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 069DB818A6B9;
        Sat,  4 Aug 2018 13:05:36 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 863CC215670D;
        Sat,  4 Aug 2018 13:05:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 07/20] perf annotate: Loop group events directly in annotation__calc_percent
Date:   Sat,  4 Aug 2018 15:05:08 +0200
Message-Id: <20180804130521.11408-8-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:36 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to bring in 'struct hists' object and for that
we need 'struct perf_evsel' object in the scope.

Switching the group data loop with the evsel group loop.
It does the same thing, but it brings evsel object, that
we can use later get the 'struct hists' object.

Link: http://lkml.kernel.org/n/tip-iecglh5ltkg9zgkn8dhfco5z@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.17.1

