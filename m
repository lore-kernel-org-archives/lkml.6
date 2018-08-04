Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03133C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDC521838
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDC521838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeHDPGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 49B00818A6B9;
        Sat,  4 Aug 2018 13:05:34 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB966215670D;
        Sat,  4 Aug 2018 13:05:32 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 06/20] perf annotate: Rename hist to sym_hist in annotation__calc_percent
Date:   Sat,  4 Aug 2018 15:05:07 +0200
Message-Id: <20180804130521.11408-7-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:34 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will need to bring in 'struct hists' variable in this scope,
so it's better we do this rename first.

Link: http://lkml.kernel.org/n/tip-33a3t65t9t3h0cdtd39bphta@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/annotate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8bd278a71004..728603636adc 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1753,7 +1753,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	goto out_free_command;
 }
 
-static void calc_percent(struct sym_hist *hist,
+static void calc_percent(struct sym_hist *sym_hist,
 			 struct annotation_data *data,
 			 s64 offset, s64 end)
 {
@@ -1761,15 +1761,15 @@ static void calc_percent(struct sym_hist *hist,
 	u64 period = 0;
 
 	while (offset < end) {
-		hits   += hist->addr[offset].nr_samples;
-		period += hist->addr[offset].period;
+		hits   += sym_hist->addr[offset].nr_samples;
+		period += sym_hist->addr[offset].period;
 		++offset;
 	}
 
-	if (hist->nr_samples) {
+	if (sym_hist->nr_samples) {
 		data->he.period     = period;
 		data->he.nr_samples = hits;
-		data->percent = 100.0 * hits / hist->nr_samples;
+		data->percent = 100.0 * hits / sym_hist->nr_samples;
 	}
 }
 
@@ -1790,12 +1790,12 @@ static void annotation__calc_percent(struct annotation *notes,
 
 		for (i = 0; i < al->data_nr; i++) {
 			struct annotation_data *data;
-			struct sym_hist *hist;
+			struct sym_hist *sym_hist;
 
-			hist = annotation__histogram(notes, evsel->idx + i);
+			sym_hist = annotation__histogram(notes, evsel->idx + i);
 			data = &al->data[i];
 
-			calc_percent(hist, data, al->offset, end);
+			calc_percent(sym_hist, data, al->offset, end);
 		}
 	}
 }
-- 
2.17.1

