Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0121C37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30D920870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115054;
	bh=IZPzVY7+Qin5MUdQgyPC1iWYB5R2HdmssooYil9El+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AxkG3+t9lWeRfEGYxD8LjIRc3NWNqvLwyQePrDeUZz3mayEul4QxJPGYQ/6Q6kQcH
	 h9+QFWKCuObr1cvl9NIIwaVuY1VpL3eepm87vBaf4H7bVver3/+XA9odpzCW8HN2pu
	 pBXaLL56ojPbA6RDUsz/3stlxV6/9FFgzJGGLKGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfAUX5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfAUX5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:57:30 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A843217F4;
        Mon, 21 Jan 2019 23:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115050;
        bh=IZPzVY7+Qin5MUdQgyPC1iWYB5R2HdmssooYil9El+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xB6vrk3XhuC36TsenadeNh6MKePaysr+r66o/05RrjHVebp7/uLQ4A/pRbG/rt8dk
         hPgTwislpehEJptLnyoYBZv7g0Fnx8NCGi5j4+Y/6YoMzijqpRKbLrozkzLxBsllbw
         0LVL88pmeTTCdLprgzZddf7Fk9H+6iHt62Wz8Q5U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/24] perf session: Rearrange perf_session__process_events function
Date:   Mon, 21 Jan 2019 20:56:44 -0300
Message-Id: <20190121235706.20005-3-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To reduce function arguments and the code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5456c84c7dd1..ad14192db811 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1820,13 +1820,14 @@ fetch_mmaped_event(struct perf_session *session,
 #define NUM_MMAPS 128
 #endif
 
-static int __perf_session__process_events(struct perf_session *session,
-					  u64 data_offset, u64 data_size,
-					  u64 file_size)
+static int __perf_session__process_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
 	int fd = perf_data__fd(session->data);
+	u64 file_size = perf_data__size(session->data);
+	u64 data_offset = session->header.data_offset;
+	u64 data_size = session->header.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
 	int err, mmap_prot, mmap_flags, map_idx = 0;
 	size_t	mmap_size;
@@ -1944,20 +1945,13 @@ static int __perf_session__process_events(struct perf_session *session,
 
 int perf_session__process_events(struct perf_session *session)
 {
-	u64 size = perf_data__size(session->data);
-	int err;
-
 	if (perf_session__register_idle_thread(session) < 0)
 		return -ENOMEM;
 
-	if (!perf_data__is_pipe(session->data))
-		err = __perf_session__process_events(session,
-						     session->header.data_offset,
-						     session->header.data_size, size);
-	else
-		err = __perf_session__process_pipe_events(session);
+	if (perf_data__is_pipe(session->data))
+		return __perf_session__process_pipe_events(session);
 
-	return err;
+	return __perf_session__process_events(session);
 }
 
 bool perf_session__has_traces(struct perf_session *session, const char *msg)
-- 
2.20.1

