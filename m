Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08CEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703DA206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 19:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551035276;
	bh=2g0oZ7327DHbSuOrzv4zyR43BMO6gIcZgj6JYEmn2Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FXrXBk8Cekj+Kdfm0KdaFd+SrGPvmwMlTwMHHhYdRbdX2ZYw1wxb+uk73UojX9GWL
	 VwKRWp3n6Nt+dmr6egQlmtrGqDPXVwcWQGWmsU4q/zlXOEwpaYbD8DYdRlEKeOp3iv
	 LHKzvIkv2H4mQLB1hU5dYnPs7I3irWljYL3LMd1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfBXTHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 14:07:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47416 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbfBXTHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 14:07:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BA206307D931;
        Sun, 24 Feb 2019 19:07:51 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-38.brq.redhat.com [10.40.204.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FC826013A;
        Sun, 24 Feb 2019 19:07:48 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 15/20] perf session: Add process callback to reader object
Date:   Sun, 24 Feb 2019 20:06:51 +0100
Message-Id: <20190224190656.30163-16-jolsa@kernel.org>
In-Reply-To: <20190224190656.30163-1-jolsa@kernel.org>
References: <20190224190656.30163-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 24 Feb 2019 19:07:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding callback function to reader object so
callers can process data in different ways.

Link: http://lkml.kernel.org/n/tip-8g1islzz6xkl36tz0z1nkuff@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9991e9a8bc12..90cec49903b9 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1849,10 +1849,17 @@ fetch_mmaped_event(struct perf_session *session,
 #define NUM_MMAPS 128
 #endif
 
+struct reader;
+
+typedef s64 (*reader_cb_t)(struct perf_session *session,
+			   union perf_event *event,
+			   u64 file_offset);
+
 struct reader {
-	int	fd;
-	u64	data_size;
-	u64	data_offset;
+	int		 fd;
+	u64		 data_size;
+	u64		 data_offset;
+	reader_cb_t	 process;
 };
 
 static int
@@ -1923,7 +1930,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	size = event->header.size;
 
 	if (size < sizeof(struct perf_event_header) ||
-	    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
+	    (skip = rd->process(session, event, file_pos)) < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 		       file_offset + head, event->header.size,
 		       event->header.type);
@@ -1949,12 +1956,20 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	return err;
 }
 
+static s64 process_simple(struct perf_session *session,
+			  union perf_event *event,
+			  u64 file_offset)
+{
+	return perf_session__process_event(session, event, file_offset);
+}
+
 static int __perf_session__process_events(struct perf_session *session)
 {
 	struct reader rd = {
 		.fd		= perf_data__fd(session->data),
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
+		.process	= process_simple,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
-- 
2.17.2

