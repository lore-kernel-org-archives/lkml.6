Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08352C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC25620854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC25620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeIMSFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeIMSF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9FDEA3DE;
        Thu, 13 Sep 2018 12:56:08 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5070600CD;
        Thu, 13 Sep 2018 12:56:06 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 33/48] perf tools: Move __perf_session__process_events args into struct
Date:   Thu, 13 Sep 2018 14:54:35 +0200
Message-Id: <20180913125450.21342-34-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Sep 2018 12:56:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will add yet another argument in here, so put all
of them to struct to make it easy to read.

Link: http://lkml.kernel.org/n/tip-lt92qp4bs3igrh6patio0euy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 40 ++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 15314052084d..f21c209aeef1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1796,6 +1796,12 @@ fetch_mmaped_event(struct perf_session *session,
 	return event;
 }
 
+struct process_args {
+	u64	data_offset;
+	u64	data_size;
+	u64	file_size;
+};
+
 /*
  * On 64bit we can mmap the data file in one go. No need for tiny mmap
  * slices. On 32bit we use 32MB.
@@ -1809,13 +1815,13 @@ fetch_mmaped_event(struct perf_session *session,
 #endif
 
 static int __perf_session__process_events(struct perf_session *session,
-					  u64 data_offset, u64 data_size,
-					  u64 file_size)
+					  struct process_args *args)
 {
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
 	int fd = perf_data__fd(session->data);
 	u64 head, page_offset, file_offset, file_pos, size;
+	u64 file_size = args->file_size;
 	int err, mmap_prot, mmap_flags, map_idx = 0;
 	size_t	mmap_size;
 	char *buf, *mmaps[NUM_MMAPS];
@@ -1825,15 +1831,15 @@ static int __perf_session__process_events(struct perf_session *session,
 
 	perf_tool__fill_defaults(tool);
 
-	page_offset = page_size * (data_offset / page_size);
+	page_offset = page_size * (args->data_offset / page_size);
 	file_offset = page_offset;
-	head = data_offset - page_offset;
+	head = args->data_offset - page_offset;
 
-	if (data_size == 0)
+	if (args->data_size == 0)
 		goto out;
 
-	if (data_offset + data_size < file_size)
-		file_size = data_offset + data_size;
+	if (args->data_offset + args->data_size < file_size)
+		file_size = args->data_offset + args->data_size;
 
 	ui_progress__init_size(&prog, file_size, "Processing events...");
 
@@ -1932,6 +1938,7 @@ static int __perf_session__process_events(struct perf_session *session,
 
 static int __perf_session__process_indexed_events(struct perf_session *session)
 {
+	struct process_args args;
 	struct perf_tool *tool = session->tool;
 	int err = 0, i;
 
@@ -1941,9 +1948,11 @@ static int __perf_session__process_indexed_events(struct perf_session *session)
 		if (!idx->size)
 			continue;
 
-		err = __perf_session__process_events(session, idx->offset,
-						     idx->size,
-						     idx->offset + idx->size);
+		args.data_offset = idx->offset;
+		args.data_size   = idx->size;
+		args.file_size   = idx->offset + idx->size;
+
+		err = __perf_session__process_events(session, &args);
 		if (err < 0)
 			break;
 	}
@@ -1956,9 +1965,9 @@ static int __perf_session__process_indexed_events(struct perf_session *session)
 
 int perf_session__process_events(struct perf_session *session)
 {
+	struct process_args args;
 	struct perf_tool *tool = session->tool;
 	struct perf_data *data = session->data;
-	u64 size = perf_data__size(data);
 	int err;
 
 	if (perf_session__register_idle_thread(session) < 0)
@@ -1969,10 +1978,11 @@ int perf_session__process_events(struct perf_session *session)
 	if (perf_has_index)
 		return __perf_session__process_indexed_events(session);
 
-	err = __perf_session__process_events(session,
-					     session->header.data_offset,
-					     session->header.data_size,
-					     size);
+	args.data_offset = session->header.data_offset;
+	args.data_size   = session->header.data_size;
+	args.file_size   = perf_data__size(data);
+
+	err = __perf_session__process_events(session, &args);
 
 	if (!tool->no_warn)
 		perf_session__warn_about_errors(session);
-- 
2.17.1

