Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BhfPMqHnGFvwRgAAmS7hNA
	; Thu, 07 Jun 2018 08:06:57 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BB63C6089E; Thu,  7 Jun 2018 08:06:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 34651607E7;
	Thu,  7 Jun 2018 08:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34651607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753427AbeFGIGy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:06:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60899 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753325AbeFGIGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:06:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5786dJP2124191
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:06:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5786dYW2124187;
        Thu, 7 Jun 2018 01:06:39 -0700
Date: Thu, 7 Jun 2018 01:06:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-pqj81aneunhftlntm66tmhz0@git.kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        dsahern@gmail.com, adrian.hunter@intel.com, wangnan0@huawei.com,
        namhyung@kernel.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: wangnan0@huawei.com, namhyung@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          acme@redhat.com, mingo@kernel.org, dsahern@gmail.com,
          adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Introduce symbol__cycle_hists()
Git-Commit-ID: c6b635eece599ae13ffce081bac1fde94912df33
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

Commit-ID:  c6b635eece599ae13ffce081bac1fde94912df33
Gitweb:     https://git.kernel.org/tip/c6b635eece599ae13ffce081bac1fde94912df33
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 17:17:05 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:51 -0300

perf annotate: Introduce symbol__cycle_hists()

In this case we're wanting just notes->src->cycles_hist, allocating it if needed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-pqj81aneunhftlntm66tmhz0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 467bae0279ce..f11199f0be27 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -848,19 +848,23 @@ static int __symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	return 0;
 }
 
-static struct annotation *symbol__get_annotation(struct symbol *sym, bool cycles)
+static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
 	if (notes->src == NULL) {
-		if (symbol__alloc_hist(sym) < 0)
+		notes->src = annotated_source__new();
+		if (notes->src == NULL)
 			return NULL;
+		goto alloc_cycles_hist;
 	}
-	if (!notes->src->cycles_hist && cycles) {
-		if (symbol__alloc_hist_cycles(sym) < 0)
-			return NULL;
+
+	if (!notes->src->cycles_hist) {
+alloc_cycles_hist:
+		symbol__alloc_hist_cycles(sym);
 	}
-	return notes;
+
+	return notes->src->cycles_hist;
 }
 
 static struct annotated_source *symbol__hists(struct symbol *sym)
@@ -900,13 +904,13 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 static int symbol__account_cycles(u64 addr, u64 start,
 				  struct symbol *sym, unsigned cycles)
 {
-	struct annotation *notes;
+	struct cyc_hist *cycles_hist;
 	unsigned offset;
 
 	if (sym == NULL)
 		return 0;
-	notes = symbol__get_annotation(sym, true);
-	if (notes == NULL)
+	cycles_hist = symbol__cycles_hist(sym);
+	if (cycles_hist == NULL)
 		return -ENOMEM;
 	if (addr < sym->start || addr >= sym->end)
 		return -ERANGE;
@@ -918,7 +922,7 @@ static int symbol__account_cycles(u64 addr, u64 start,
 			start = 0;
 	}
 	offset = addr - sym->start;
-	return __symbol__account_cycles(notes->src->cycles_hist,
+	return __symbol__account_cycles(cycles_hist,
 					start ? start - sym->start : 0,
 					offset, cycles,
 					!!start);
