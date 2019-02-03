Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C643C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03D420823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207876;
	bh=j8wvFTwuEaRS8yzn9VBaGmMVa49ez/I3j7WPRNEtct0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=de59Ub9CUh1dhnkLXUjJnw3lE3Q08H6sgmiHJReKv3h8EMFvOgswN9sMZJOYA651j
	 cm/RxerRWyjVTv6jeu5aV50AKBlb/p8mU/uLFg140P+7v6bk0ULm+2yI4yz1g/dHDP
	 FsFB31S7JGThlhaZY5y/0B8noMzVx0ALT3xukQsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfBCPbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:31:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbfBCPa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:58 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3731D8666C;
        Sun,  3 Feb 2019 15:30:58 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C83E45C238;
        Sun,  3 Feb 2019 15:30:55 +0000 (UTC)
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
Subject: [PATCH 12/14] perf session: Add __perf_session__process_dir_events function
Date:   Sun,  3 Feb 2019 16:30:16 +0100
Message-Id: <20190203153018.9650-13-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 03 Feb 2019 15:30:58 +0000 (UTC)
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
 tools/perf/util/session.c | 86 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b81182b7602a..38d2854cebc1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1864,8 +1864,6 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	file_offset = page_offset;
 	head = rd->data_offset - page_offset;
 
-	ui_progress__init_size(prog, data_size, "Processing events...");
-
 	data_size += rd->data_offset;
 
 	mmap_size = MMAP_SIZE;
@@ -1994,6 +1992,87 @@ static int __perf_session__process_events(struct perf_session *session)
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
+	ret = reader__process_events(&rd, session, &prog);
+	if (ret)
+		goto out_err;
+
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
@@ -2002,6 +2081,9 @@ int perf_session__process_events(struct perf_session *session)
 	if (perf_data__is_pipe(session->data))
 		return __perf_session__process_pipe_events(session);
 
+	if (perf_data__is_dir(session->data))
+		return __perf_session__process_dir_events(session);
+
 	return __perf_session__process_events(session);
 }
 
-- 
2.17.2

