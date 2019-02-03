Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D588BC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A624721901
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207894;
	bh=MLWrDCtbQ3f9HQ+s7P6f5hB/JUztltSUYb0QM1jmkps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ryldyDCAPxnI3G35PVljfpzH0XX05EpA/6bIMBUQkbzg1kw2OsmUOAj0BkRMqOYPD
	 QGJwzB/8lVdTJokxGEZEAwA0FXr+wpI38AA30BaYtI6btn35SDDxQfJxIv8MOjL8sv
	 nauBj2p5qR9VO4KRmr2OR1Tht1XBCiLhXN4z0AYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfBCPac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:30:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfBCPa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:29 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66A2FE77DB;
        Sun,  3 Feb 2019 15:30:28 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08F145C238;
        Sun,  3 Feb 2019 15:30:25 +0000 (UTC)
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
Subject: [PATCH 02/14] perf session: Add process callback to reader object
Date:   Sun,  3 Feb 2019 16:30:06 +0100
Message-Id: <20190203153018.9650-3-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 03 Feb 2019 15:30:28 +0000 (UTC)
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
index 2012396abb7c..b81182b7602a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1835,10 +1835,17 @@ fetch_mmaped_event(struct perf_session *session,
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
@@ -1909,7 +1916,7 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	size = event->header.size;
 
 	if (size < sizeof(struct perf_event_header) ||
-	    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
+	    (skip = rd->process(session, event, file_pos)) < 0) {
 		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
 		       file_offset + head, event->header.size,
 		       event->header.type);
@@ -1935,12 +1942,20 @@ reader__process_events(struct reader *rd, struct perf_session *session,
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

