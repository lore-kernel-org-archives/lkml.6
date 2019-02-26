Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2915C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE412147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551170985;
	bh=koVVZABvgHhx+jStCMKzoFoea6H2aIeJ2fuBAMKZ3WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9ZDIe1OPhLqx6oV4tpkvoD3AfmC5JvE5jd5SDB9ndCC4T3KucvVzJOPR2CK5BQkj
	 wsbOOfHHACbgJ1DzBr6JqZb3BYYTNMRJqTP4htS/FJ6EiyxM7PNqdv+bS82zDD4kVo
	 npQhkznNpzQW3al6YoVi8vRjovnVONXpcRYU/6Hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfBZItn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:49:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbfBZItR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:49:17 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E6AD30AA38D;
        Tue, 26 Feb 2019 08:49:16 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ED4F1001E99;
        Tue, 26 Feb 2019 08:49:13 +0000 (UTC)
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
Subject: [PATCH 07/11] perf session: Add __perf_session__process_dir_events function
Date:   Tue, 26 Feb 2019 09:48:51 +0100
Message-Id: <20190226084855.6340-8-jolsa@kernel.org>
In-Reply-To: <20190226084855.6340-1-jolsa@kernel.org>
References: <20190226084855.6340-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 26 Feb 2019 08:49:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding __perf_session__process_dir_events function
to process events over the directory data.

All directory events are pushed into sessions ordered
data and flushed for processing.

Link: http://lkml.kernel.org/n/tip-n3zl0wo3z18tatv5x7epmjrh@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 88 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 90cec49903b9..1f183bd1a208 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1878,8 +1878,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	file_offset = page_offset;
 	head = rd->data_offset - page_offset;
 
-	ui_progress__init_size(prog, data_size, "Processing events...");
-
 	data_size += rd->data_offset;
 
 	mmap_size = MMAP_SIZE;
@@ -2008,6 +2006,89 @@ static int __perf_session__process_events(struct perf_session *session)
 	return err;
 }
 
+static s64 process_index(struct perf_session *session,
+			 union perf_event *event,
+			 u64 file_offset)
+{
+	struct perf_evlist *evlist = session->evlist;
+	u64 timestamp;
+	s64 ret;
+
+	if (session->header.needs_swap)
+		event_swap(event, perf_evlist__sample_id_all(evlist));
+
+	if (event->header.type >= PERF_RECORD_HEADER_MAX)
+		return -EINVAL;
+
+	events_stats__inc(&evlist->stats, event->header.type);
+
+	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
+		return perf_session__process_user_event(session, event, file_offset);
+
+	ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
+	if (ret)
+		return ret;
+
+	return ordered_events__queue(&session->ordered_events, event,
+				     timestamp, file_offset);
+}
+
+static int __perf_session__process_dir_events(struct perf_session *session)
+{
+	struct perf_data *data = session->data;
+	struct perf_tool *tool = session->tool;
+	struct reader rd = {
+		.fd		= perf_data__fd(session->data),
+		.data_size	= session->header.data_size,
+		.data_offset	= session->header.data_offset,
+		.process	= process_simple,
+	};
+	int i, ret = 0;
+	struct ui_progress prog;
+	u64 total_size = perf_data__size(session->data);
+
+	perf_tool__fill_defaults(tool);
+
+	ui_progress__init_size(&prog, total_size, "Processing events...");
+
+	/* Read data from the header file.. */
+	ret = reader__process_events(&rd, session, &prog);
+	if (ret)
+		goto out_err;
+
+	/* ... and continue with data files. */
+	for (i = 0; i < data->dir.nr ; i++) {
+		struct perf_data_file *file = &data->dir.files[i];
+
+		if (file->size == 0)
+			continue;
+
+		rd = (struct reader) {
+			.fd		= file->fd,
+			.data_size	= file->size,
+			.data_offset	= 0,
+			.process	= process_index,
+		};
+
+		ret = reader__process_events(&rd, session, &prog);
+		if (ret)
+			goto out_err;
+	}
+
+	ret = ordered_events__flush(&session->ordered_events, OE_FLUSH__FINAL);
+
+out_err:
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
+
+	/*
+	 * We may switching perf.data output, make ordered_events
+	 * reusable.
+	 */
+	ordered_events__reinit(&session->ordered_events);
+	return ret;
+}
+
 int perf_session__process_events(struct perf_session *session)
 {
 	if (perf_session__register_idle_thread(session) < 0)
@@ -2016,6 +2097,9 @@ int perf_session__process_events(struct perf_session *session)
 	if (perf_data__is_pipe(session->data))
 		return __perf_session__process_pipe_events(session);
 
+	if (perf_data__is_dir(session->data))
+		return __perf_session__process_dir_events(session);
+
 	return __perf_session__process_events(session);
 }
 
-- 
2.17.2

