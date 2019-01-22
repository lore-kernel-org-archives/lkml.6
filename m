Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B160C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736892085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfAVKOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:14:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAVKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:14:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MADANX2906504
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:13:10 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MADAY42906501;
        Tue, 22 Jan 2019 02:13:10 -0800
Date:   Tue, 22 Jan 2019 02:13:10 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-71002bd214822a15bee0f7bc033a0dbf95cf780b@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        namhyung@kernel.org, acme@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@kernel.org
Reply-To: acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190110101301.6196-6-jolsa@kernel.org>
References: <20190110101301.6196-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf session: Add 'data_offset' member to reader
 object
Git-Commit-ID: 71002bd214822a15bee0f7bc033a0dbf95cf780b
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

Commit-ID:  71002bd214822a15bee0f7bc033a0dbf95cf780b
Gitweb:     https://git.kernel.org/tip/71002bd214822a15bee0f7bc033a0dbf95cf780b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 10 Jan 2019 11:13:00 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 15:15:57 -0300

perf session: Add 'data_offset' member to reader object

Add 'data_offset' member to reader object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 9f29ed743425..173cf445475c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1823,6 +1823,7 @@ fetch_mmaped_event(struct perf_session *session,
 struct reader {
 	int	fd;
 	u64	data_size;
+	u64	data_offset;
 };
 
 static int __perf_session__process_events(struct perf_session *session)
@@ -1830,10 +1831,10 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct reader rd = {
 		.fd		= perf_data__fd(session->data),
 		.data_size	= session->header.data_size,
+		.data_offset	= session->header.data_offset,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
-	u64 data_offset = session->header.data_offset;
 	u64 data_size = rd.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
 	int err, mmap_prot, mmap_flags, map_idx = 0;
@@ -1845,16 +1846,16 @@ static int __perf_session__process_events(struct perf_session *session)
 
 	perf_tool__fill_defaults(tool);
 
-	page_offset = page_size * (data_offset / page_size);
+	page_offset = page_size * (rd.data_offset / page_size);
 	file_offset = page_offset;
-	head = data_offset - page_offset;
+	head = rd.data_offset - page_offset;
 
 	if (data_size == 0)
 		goto out;
 
 	ui_progress__init_size(&prog, data_size, "Processing events...");
 
-	data_size += data_offset;
+	data_size += rd.data_offset;
 
 	mmap_size = MMAP_SIZE;
 	if (mmap_size > data_size) {
