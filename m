Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D5BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C1620C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C1620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbeIMSFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeIMSFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:31 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA2BC3082DD0;
        Thu, 13 Sep 2018 12:56:10 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDCE9600C8;
        Thu, 13 Sep 2018 12:56:08 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 34/48] perf ui progress: Fix index progress display
Date:   Thu, 13 Sep 2018 14:54:36 +0200
Message-Id: <20180913125450.21342-35-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 13 Sep 2018 12:56:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display overall index files progress size instead of having
multiple (per index) progress bars.

Link: http://lkml.kernel.org/n/tip-b1alb4i6urd623bcbdqni8xp@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f21c209aeef1..e00a5d7e521e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1797,6 +1797,8 @@ fetch_mmaped_event(struct perf_session *session,
 }
 
 struct process_args {
+	struct ui_progress	prog;
+
 	u64	data_offset;
 	u64	data_size;
 	u64	file_size;
@@ -1826,7 +1828,6 @@ static int __perf_session__process_events(struct perf_session *session,
 	size_t	mmap_size;
 	char *buf, *mmaps[NUM_MMAPS];
 	union perf_event *event;
-	struct ui_progress prog;
 	s64 skip;
 
 	perf_tool__fill_defaults(tool);
@@ -1841,8 +1842,6 @@ static int __perf_session__process_events(struct perf_session *session,
 	if (args->data_offset + args->data_size < file_size)
 		file_size = args->data_offset + args->data_size;
 
-	ui_progress__init_size(&prog, file_size, "Processing events...");
-
 	mmap_size = MMAP_SIZE;
 	if (mmap_size > file_size) {
 		mmap_size = file_size;
@@ -1907,7 +1906,7 @@ static int __perf_session__process_events(struct perf_session *session,
 	head += size;
 	file_pos += size;
 
-	ui_progress__update(&prog, size);
+	ui_progress__update(&args->prog, size);
 
 	if (session_done())
 		goto out;
@@ -1936,12 +1935,29 @@ static int __perf_session__process_events(struct perf_session *session,
 	return err;
 }
 
+static u64 get_index_size(struct perf_session *session)
+{
+	u64 size = 0;
+	int i;
+
+	for (i = 0; i < (int)session->header.nr_index; i++) {
+		struct perf_file_section *idx = &session->header.index[i];
+
+		size += idx->size;
+	}
+
+	return size;
+}
+
 static int __perf_session__process_indexed_events(struct perf_session *session)
 {
 	struct process_args args;
 	struct perf_tool *tool = session->tool;
 	int err = 0, i;
 
+	ui_progress__init_size(&args.prog, get_index_size(session),
+			       "Processing events");
+
 	for (i = 0; i < (int)session->header.nr_index; i++) {
 		struct perf_file_section *idx = &session->header.index[i];
 
@@ -1982,6 +1998,9 @@ int perf_session__process_events(struct perf_session *session)
 	args.data_size   = session->header.data_size;
 	args.file_size   = perf_data__size(data);
 
+	ui_progress__init_size(&args.prog, args.file_size,
+			       "Processing events");
+
 	err = __perf_session__process_events(session, &args);
 
 	if (!tool->no_warn)
-- 
2.17.1

