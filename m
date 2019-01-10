Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B324BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858D0214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547115189;
	bh=tJx16TB75iMzWmpq1Q0XnlEIeyFV+pEgJYBgHVoWO+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EflfkNCEuWIOW8MDAyTC/zhDidM6w8PebdFGsKIaEwFj8TrKgzkVTOrDF0f0VS8hi
	 sz1PHH8nB15EjgHGS8kSzKbaZJawqo/YGwpG59MxgONaMYrI4TqoRbl+Bj5YdvmGRL
	 NFU+FWsfss7FhATaJxekA2DT725dOQYf7OZfkrO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfAJKNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:13:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfAJKNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:13:06 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 789002D7EF;
        Thu, 10 Jan 2019 10:13:05 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEEFD26380;
        Thu, 10 Jan 2019 10:13:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/6] perf session: Rearrange perf_session__process_events function
Date:   Thu, 10 Jan 2019 11:12:56 +0100
Message-Id: <20190110101301.6196-2-jolsa@kernel.org>
In-Reply-To: <20190110101301.6196-1-jolsa@kernel.org>
References: <20190110101301.6196-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 10 Jan 2019 10:13:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reduce function arguments and the code.

Link: http://lkml.kernel.org/n/tip-xuzuxyxqpl2n0otolfnew0o@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

