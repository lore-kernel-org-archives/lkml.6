Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31593C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8E7217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551170962;
	bh=J1u0B5JKC9S8zb47ZMyJJd9N160jdguuqSlS6JAYsPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MfJG1BZISmfnchZ++9Th/LmvZwDRn/i3QJLCWmFW9zr11C4jb5nw6wJvFWRO3n4dr
	 COa+KRj0vL327rmlXP57OdtMPGaxLyJsGlKz1aDpAaKjFCDtu0mQ+9I0S0fAPBpIbi
	 Z2zIN+ZnvhF8QNGAAt/tZrfALf95odUKXFRtBIDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfBZItT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 03:49:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727490AbfBZItT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 03:49:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 947D430B24B8;
        Tue, 26 Feb 2019 08:49:18 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 784721018A04;
        Tue, 26 Feb 2019 08:49:16 +0000 (UTC)
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
Subject: [PATCH 08/11] perf session: Add path to reader object
Date:   Tue, 26 Feb 2019 09:48:52 +0100
Message-Id: <20190226084855.6340-9-jolsa@kernel.org>
In-Reply-To: <20190226084855.6340-1-jolsa@kernel.org>
References: <20190226084855.6340-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 26 Feb 2019 08:49:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding path to reader object, so we can display file
the processing fails for (string in [] brackets).

  $ perf report --stdio
  0x5e0 [perf.data/data.3] [0xa200]: failed to process type: -1577027574

Link: http://lkml.kernel.org/n/tip-4bjnoy4sln7adqtd3505q29q@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1f183bd1a208..c2bc0c58112a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1860,6 +1860,7 @@ struct reader {
 	u64		 data_size;
 	u64		 data_offset;
 	reader_cb_t	 process;
+	char		*path;
 };
 
 static int
@@ -1874,6 +1875,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	union perf_event *event;
 	s64 skip;
 
+	pr_debug("reader processing %s\n", rd->path);
+
 	page_offset = page_size * (rd->data_offset / page_size);
 	file_offset = page_offset;
 	head = rd->data_offset - page_offset;
@@ -1929,8 +1932,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, file_pos)) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
-		       file_offset + head, event->header.size,
+		pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d\n",
+		       file_offset + head, rd->path, event->header.size,
 		       event->header.type);
 		err = -EINVAL;
 		goto out;
@@ -1968,6 +1971,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
 		.process	= process_simple,
+		.path		= session->data->file.path,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
@@ -2042,6 +2046,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
 		.process	= process_simple,
+		.path		= session->data->file.path,
 	};
 	int i, ret = 0;
 	struct ui_progress prog;
@@ -2068,6 +2073,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 			.data_size	= file->size,
 			.data_offset	= 0,
 			.process	= process_index,
+			.path		= file->path,
 		};
 
 		ret = reader__process_events(&rd, session, &prog);
-- 
2.17.2

