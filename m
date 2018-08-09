Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A16AC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43F921D62
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROx/+5s5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43F921D62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732907AbeHIRZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:34 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4E121E21;
        Thu,  9 Aug 2018 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826816;
        bh=dgqZZlFlTrtnOrpLDefA1sKsTZkhFAgwstAMCmy7Zsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROx/+5s5ISdq11IAyB+SNLA3pK56bzbjELM8TK6icOjcIBMCXicixOyIMyC25ieil
         XdtWzK7ERaBSFQmpjIAGHV2ZHgDpLf/VgxWdntHi/y9w9POfyjAmOVgjOSh2t+/mKD
         VinUlc6JBgmoZsdi4OPxlwhu08pCYDlM3a4bDNww=
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
Subject: [PATCH 21/44] perf annotate: Add PERCENT_HITS_GLOBAL percent value
Date:   Thu,  9 Aug 2018 11:57:59 -0300
Message-Id: <20180809145822.21391-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding and computing global hits percent value for annotation line.
Storing it in struct annotation_data percent array under new
PERCENT_HITS_GLOBAL index.

At the moment it's not displayed, it's coming in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

