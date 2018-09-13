Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8334C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE7C20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CE7C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeIMSE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727749AbeIMSEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A31830842A8;
        Thu, 13 Sep 2018 12:55:05 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1D78600C8;
        Thu, 13 Sep 2018 12:55:02 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 05/48] perf tools: Use a software dummy event to track task/mmap events
Date:   Thu, 13 Sep 2018 14:54:07 +0200
Message-Id: <20180913125450.21342-6-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 13 Sep 2018 12:55:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

Add APIs for software dummy event to track task/comm/mmap events
separately. The perf record will use them to save such events in
a separate mmap buffer to make it easy to index. This is just a
preparation of multi-thread support which will come later.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Link: http://lkml.kernel.org/n/tip-qo7opc5kb3ueuicyjdyqupkh@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 30 ++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h |  1 +
 tools/perf/util/evsel.h  | 15 +++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index be440df29615..7428d65650c9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -267,6 +267,36 @@ int perf_evlist__add_dummy(struct perf_evlist *evlist)
 	return 0;
 }
 
+int perf_evlist__add_dummy_tracking(struct perf_evlist *evlist)
+{
+	struct perf_event_attr attr = {
+		.type = PERF_TYPE_SOFTWARE,
+		.config = PERF_COUNT_SW_DUMMY,
+		.exclude_kernel = 1,
+	};
+	struct perf_evsel *evsel;
+
+	event_attr_init(&attr);
+
+	evsel = perf_evsel__new(&attr);
+	if (evsel == NULL)
+		goto error;
+
+	/* use strdup() because free(evsel) assumes name is allocated */
+	evsel->name = strdup("dummy");
+	if (!evsel->name)
+		goto error_free;
+
+	perf_evlist__add(evlist, evsel);
+	perf_evlist__set_tracking_event(evlist, evsel);
+
+	return 0;
+error_free:
+	perf_evsel__delete(evsel);
+error:
+	return -ENOMEM;
+}
+
 static int perf_evlist__add_attrs(struct perf_evlist *evlist,
 				  struct perf_event_attr *attrs, size_t nr_attrs)
 {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dc66436add98..c11cb80e7847 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -76,6 +76,7 @@ static inline int perf_evlist__add_default(struct perf_evlist *evlist)
 	return __perf_evlist__add_default(evlist, true);
 }
 
+int perf_evlist__add_dummy_tracking(struct perf_evlist *evlist);
 int __perf_evlist__add_default_attrs(struct perf_evlist *evlist,
 				     struct perf_event_attr *attrs, size_t nr_attrs);
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 4f8430a85531..6e18b9ff997d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -411,6 +411,21 @@ static inline bool perf_evsel__is_clock(struct perf_evsel *evsel)
 	       perf_evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
 }
 
+/**
+ * perf_evsel__is_dummy_tracking - Return whether given evsel is a dummy
+ * event for tracking meta events only
+ *
+ * @evsel - evsel selector to be tested
+ *
+ * Return %true if event is a dummy tracking event
+ */
+static inline bool perf_evsel__is_dummy_tracking(struct perf_evsel *evsel)
+{
+	return evsel->attr.type == PERF_TYPE_SOFTWARE &&
+		evsel->attr.config == PERF_COUNT_SW_DUMMY &&
+		evsel->attr.task == 1 && evsel->attr.mmap == 1;
+}
+
 struct perf_attr_details {
 	bool freq;
 	bool verbose;
-- 
2.17.1

