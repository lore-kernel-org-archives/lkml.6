Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ejFHOkPnGFsIRwAAmS7hNA
	; Thu, 07 Jun 2018 08:05:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CF2756089E; Thu,  7 Jun 2018 08:05:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3F9DB605A2;
	Thu,  7 Jun 2018 08:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F9DB605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeFGIFU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:05:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55741 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeFGIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:05:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578557r2123907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:05:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w57855Yc2123904;
        Thu, 7 Jun 2018 01:05:05 -0700
Date: Thu, 7 Jun 2018 01:05:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-f5fn7tr1asey6g013wavpn4c@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        wangnan0@huawei.com, acme@redhat.com, jolsa@kernel.org,
        mingo@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        hpa@zytor.com, dsahern@gmail.com
Reply-To: dsahern@gmail.com, hpa@zytor.com, tglx@linutronix.de,
          namhyung@kernel.org, mingo@kernel.org, jolsa@kernel.org,
          acme@redhat.com, wangnan0@huawei.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Introduce
 annotated_source__alloc_histograms
Git-Commit-ID: be3e26d99c3abf4b17728da7bc606dd05419611e
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

Commit-ID:  be3e26d99c3abf4b17728da7bc606dd05419611e
Gitweb:     https://git.kernel.org/tip/be3e26d99c3abf4b17728da7bc606dd05419611e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 May 2018 16:23:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Jun 2018 10:28:51 -0300

perf annotate: Introduce annotated_source__alloc_histograms

So that we can call it independently, in contexts were we know we
already have notes->src allocated.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-f5fn7tr1asey6g013wavpn4c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f6c9bb29ac84..a6fa49bf879b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -697,10 +697,9 @@ static void annotated_source__delete(struct annotated_source *src)
 	free(src);
 }
 
-int symbol__alloc_hist(struct symbol *sym)
+static int annotated_source__alloc_histograms(struct annotated_source *src,
+					      size_t size, int nr_hists)
 {
-	struct annotation *notes = symbol__annotation(sym);
-	size_t size = symbol__size(sym);
 	size_t sizeof_sym_hist;
 
 	/*
@@ -720,20 +719,29 @@ int symbol__alloc_hist(struct symbol *sym)
 	sizeof_sym_hist = (sizeof(struct sym_hist) + size * sizeof(struct sym_hist_entry));
 
 	/* Check for overflow in zalloc argument */
-	if (sizeof_sym_hist > SIZE_MAX / symbol_conf.nr_events)
+	if (sizeof_sym_hist > SIZE_MAX / nr_hists)
 		return -1;
 
+	src->sizeof_sym_hist = sizeof_sym_hist;
+	src->nr_histograms   = nr_hists;
+	src->histograms	     = calloc(nr_hists, sizeof_sym_hist) ;
+	return src->histograms ? 0 : -1;
+}
+
+int symbol__alloc_hist(struct symbol *sym)
+{
+	size_t size = symbol__size(sym);
+	struct annotation *notes = symbol__annotation(sym);
+
 	notes->src = annotated_source__new();
 	if (notes->src == NULL)
 		return -1;
-	notes->src->histograms = calloc(symbol_conf.nr_events, sizeof_sym_hist);
-	if (notes->src->histograms == NULL) {
+
+	if (annotated_source__alloc_histograms(notes->src, size, symbol_conf.nr_events) < 0) {
 		annotated_source__delete(notes->src);
 		notes->src = NULL;
 		return -1;
 	}
-	notes->src->sizeof_sym_hist = sizeof_sym_hist;
-	notes->src->nr_histograms   = symbol_conf.nr_events;
 	return 0;
 }
 
