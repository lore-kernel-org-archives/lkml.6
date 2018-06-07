Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id F1yaNb7nGFuBSwAAmS7hNA
	; Thu, 07 Jun 2018 08:07:26 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C5EA46089E; Thu,  7 Jun 2018 08:07:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 344A0607E7;
	Thu,  7 Jun 2018 08:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 344A0607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753507AbeFGIHY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:07:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60489 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeFGIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:07:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5787Cjh2124241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:07:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5787Cvu2124238;
        Thu, 7 Jun 2018 01:07:12 -0700
Date: Thu, 7 Jun 2018 01:07:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9mgosbqa977h39j4i9ys8t75@git.kernel.org>
Cc: jolsa@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, namhyung@kernel.org, dsahern@gmail.com,
        tglx@linutronix.de, adrian.hunter@intel.com, wangnan0@huawei.com,
        mingo@kernel.org
Reply-To: jolsa@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, adrian.hunter@intel.com, wangnan0@huawei.com,
          mingo@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
          dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Stop using symbol_conf.nr_events
 global in symbol__hists()
Git-Commit-ID: 0693f7588a2f2e016e0774102c52ab2494938348
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

Commit-ID:  0693f7588a2f2e016e0774102c52ab2494938348
Gitweb:     https://git.kernel.org/tip/0693f7588a2f2e016e0774102c52ab2494938348
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 17:20:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:52 -0300

perf annotate: Stop using symbol_conf.nr_events global in symbol__hists()

Since now we have evsel->evlist->nr_entries in the single place calling
this function, use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9mgosbqa977h39j4i9ys8t75@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f11199f0be27..7c194b04a2da 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -21,6 +21,7 @@
 #include "debug.h"
 #include "annotate.h"
 #include "evsel.h"
+#include "evlist.h"
 #include "block-range.h"
 #include "string2.h"
 #include "arch/common.h"
@@ -867,7 +868,7 @@ alloc_cycles_hist:
 	return notes->src->cycles_hist;
 }
 
-static struct annotated_source *symbol__hists(struct symbol *sym)
+static struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
@@ -881,7 +882,7 @@ static struct annotated_source *symbol__hists(struct symbol *sym)
 	if (notes->src->histograms == NULL) {
 alloc_histograms:
 		annotated_source__alloc_histograms(notes->src, symbol__size(sym),
-						   symbol_conf.nr_events);
+						   nr_hists);
 	}
 
 	return notes->src;
@@ -895,7 +896,7 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 
 	if (sym == NULL)
 		return 0;
-	src = symbol__hists(sym);
+	src = symbol__hists(sym, evsel->evlist->nr_entries);
 	if (src == NULL)
 		return -ENOMEM;
 	return __symbol__inc_addr_samples(sym, map, src, evsel->idx, addr, sample);
