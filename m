Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C496C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582DF20844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfAVKKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:10:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAVKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:10:47 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAAap72906105
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:10:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAAaUM2906102;
        Tue, 22 Jan 2019 02:10:36 -0800
Date:   Tue, 22 Jan 2019 02:10:36 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-7ba4da100261482afcb693a1b39e483c9c03aba2@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        jolsa@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, mingo@kernel.org,
          hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
          namhyung@kernel.org
In-Reply-To: <20190110101301.6196-2-jolsa@kernel.org>
References: <20190110101301.6196-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf session: Rearrange
 perf_session__process_events function
Git-Commit-ID: 7ba4da100261482afcb693a1b39e483c9c03aba2
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

Commit-ID:  7ba4da100261482afcb693a1b39e483c9c03aba2
Gitweb:     https://git.kernel.org/tip/7ba4da100261482afcb693a1b39e483c9c03aba2
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 10 Jan 2019 11:12:56 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 15:15:57 -0300

perf session: Rearrange perf_session__process_events function

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
@@ -1944,20 +1945,13 @@ out_err:
 
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
