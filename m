Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CE4tGebmGFsQRwAAmS7hNA
	; Thu, 07 Jun 2018 08:04:31 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 739F6607F7; Thu,  7 Jun 2018 08:04:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D3486607DC;
	Thu,  7 Jun 2018 08:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3486607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753369AbeFGIE1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:04:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48563 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeFGIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:04:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w57846HN2123832
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:04:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w57845Sb2123829;
        Thu, 7 Jun 2018 01:04:05 -0700
Date: Thu, 7 Jun 2018 01:04:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tsx7dhxzpi0criyx0sio3pz3@git.kernel.org>
Cc: dsahern@gmail.com, acme@redhat.com, adrian.hunter@intel.com,
        wangnan0@huawei.com, namhyung@kernel.org, hpa@zytor.com,
        mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
          dsahern@gmail.com, namhyung@kernel.org, adrian.hunter@intel.com,
          wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Split allocation of
 annotated_source struct
Git-Commit-ID: 116c626b9aca10ee7619b06185c22a5b2da19e30
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

Commit-ID:  116c626b9aca10ee7619b06185c22a5b2da19e30
Gitweb:     https://git.kernel.org/tip/116c626b9aca10ee7619b06185c22a5b2da19e30
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 15:31:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:51 -0300

perf annotate: Split allocation of annotated_source struct

So that we can allocate just the notes->src->cyc_hist, that, unlike
notes->src->histograms, is not per event, and in paths where we
need to lazily allocate notes->src->cyc_hist we don't have the
number of events handy to also allocate ->histograms.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-tsx7dhxzpi0criyx0sio3pz3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 10 +++++++---
 tools/perf/util/annotate.h |  6 +++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a7221f9fa504..f0c6941bca6c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -701,13 +701,17 @@ int symbol__alloc_hist(struct symbol *sym)
 	sizeof_sym_hist = (sizeof(struct sym_hist) + size * sizeof(struct sym_hist_entry));
 
 	/* Check for overflow in zalloc argument */
-	if (sizeof_sym_hist > (SIZE_MAX - sizeof(*notes->src))
-				/ symbol_conf.nr_events)
+	if (sizeof_sym_hist > SIZE_MAX / symbol_conf.nr_events)
 		return -1;
 
-	notes->src = zalloc(sizeof(*notes->src) + symbol_conf.nr_events * sizeof_sym_hist);
+	notes->src = zalloc(sizeof(*notes->src));
 	if (notes->src == NULL)
 		return -1;
+	notes->src->histograms = calloc(symbol_conf.nr_events, sizeof_sym_hist);
+	if (notes->src->histograms == NULL) {
+		zfree(&notes->src);
+		return -1;
+	}
 	notes->src->sizeof_sym_hist = sizeof_sym_hist;
 	notes->src->nr_histograms   = symbol_conf.nr_events;
 	INIT_LIST_HEAD(&notes->src->source);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index aef9eae4f125..94b60e34c3a7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -201,7 +201,7 @@ struct cyc_hist {
 
 /** struct annotated_source - symbols with hits have this attached as in sannotation
  *
- * @histogram: Array of addr hit histograms per event being monitored
+ * @histograms: Array of addr hit histograms per event being monitored
  * @lines: If 'print_lines' is specified, per source code line percentages
  * @source: source parsed from a disassembler like objdump -dS
  * @cyc_hist: Average cycles per basic block
@@ -217,7 +217,7 @@ struct annotated_source {
 	int    		   nr_histograms;
 	size_t		   sizeof_sym_hist;
 	struct cyc_hist	   *cycles_hist;
-	struct sym_hist	   histograms[0];
+	struct sym_hist	   *histograms;
 };
 
 struct annotation {
@@ -269,7 +269,7 @@ void annotation__init_column_widths(struct annotation *notes, struct symbol *sym
 
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
-	return (((void *)&notes->src->histograms) +
+	return (((void *)notes->src->histograms) +
 	 	(notes->src->sizeof_sym_hist * idx));
 }
 
