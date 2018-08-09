Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED433C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70CB21E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vzST+YRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70CB21E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732876AbeHIRZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:24 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 742FB21DEC;
        Thu,  9 Aug 2018 15:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826807;
        bh=HoKsNIT8dXHPOvvFOpMtklrPwdis8I92D4hCip70KIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzST+YRUz62ckBdVN0VRsrLwFCi+22t19EcR5t5v0P+uFGJMeuQB+e1sBvgw5FATu
         EoHJWDyfXk/gikWTgCyNYoMkm2cCREwhIqD8L5CJ89GQ27v4w02efJm+yj32dgyrWs
         z3UPSw1f5wShoHCUnb6OZk65RQgRkbLQghEkINm4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/44] perf annotate: Loop group events directly in annotation__calc_percent()
Date:   Thu,  9 Aug 2018 11:57:57 -0300
Message-Id: <20180809145822.21391-20-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

