Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4814C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AD92085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfAVKOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:14:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfAVKN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:13:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MADmPQ2906531
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:13:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MADmcF2906528;
        Tue, 22 Jan 2019 02:13:48 -0800
Date:   Tue, 22 Jan 2019 02:13:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-3c7b67b23eb317787d113b1e9a6d82250202a1e3@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          jolsa@kernel.org, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, mingo@kernel.org
In-Reply-To: <20190110101301.6196-7-jolsa@kernel.org>
References: <20190110101301.6196-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf session: Add reader__process_events function
Git-Commit-ID: 3c7b67b23eb317787d113b1e9a6d82250202a1e3
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

Commit-ID:  3c7b67b23eb317787d113b1e9a6d82250202a1e3
Gitweb:     https://git.kernel.org/tip/3c7b67b23eb317787d113b1e9a6d82250202a1e3
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 10 Jan 2019 11:13:01 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 15:15:57 -0300

perf session: Add reader__process_events function

The reader object is defined by file's fd, data offset and data size.

Now we can simply define a reader object for an arbitrary file data
portion and pass it to reader__process_events().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 62 +++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 173cf445475c..d6f41611f504 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1826,36 +1826,25 @@ struct reader {
 	u64	data_offset;
 };
 
-static int __perf_session__process_events(struct perf_session *session)
+static int
+reader__process_events(struct reader *rd, struct perf_session *session,
+		       struct ui_progress *prog)
 {
-	struct reader rd = {
-		.fd		= perf_data__fd(session->data),
-		.data_size	= session->header.data_size,
-		.data_offset	= session->header.data_offset,
-	};
-	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
-	u64 data_size = rd.data_size;
+	u64 data_size = rd->data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
-	int err, mmap_prot, mmap_flags, map_idx = 0;
+	int err = 0, mmap_prot, mmap_flags, map_idx = 0;
 	size_t	mmap_size;
 	char *buf, *mmaps[NUM_MMAPS];
 	union perf_event *event;
-	struct ui_progress prog;
 	s64 skip;
 
-	perf_tool__fill_defaults(tool);
-
-	page_offset = page_size * (rd.data_offset / page_size);
+	page_offset = page_size * (rd->data_offset / page_size);
 	file_offset = page_offset;
-	head = rd.data_offset - page_offset;
+	head = rd->data_offset - page_offset;
 
-	if (data_size == 0)
-		goto out;
+	ui_progress__init_size(prog, data_size, "Processing events...");
 
-	ui_progress__init_size(&prog, data_size, "Processing events...");
-
-	data_size += rd.data_offset;
+	data_size += rd->data_offset;
 
 	mmap_size = MMAP_SIZE;
 	if (mmap_size > data_size) {
@@ -1873,12 +1862,12 @@ static int __perf_session__process_events(struct perf_session *session)
 		mmap_flags = MAP_PRIVATE;
 	}
 remap:
-	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd.fd,
+	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd->fd,
 		   file_offset);
 	if (buf == MAP_FAILED) {
 		pr_err("failed to mmap file\n");
 		err = -errno;
-		goto out_err;
+		goto out;
 	}
 	mmaps[map_idx] = buf;
 	map_idx = (map_idx + 1) & (ARRAY_SIZE(mmaps) - 1);
@@ -1910,7 +1899,7 @@ more:
 		       file_offset + head, event->header.size,
 		       event->header.type);
 		err = -EINVAL;
-		goto out_err;
+		goto out;
 	}
 
 	if (skip)
@@ -1919,7 +1908,7 @@ more:
 	head += size;
 	file_pos += size;
 
-	ui_progress__update(&prog, size);
+	ui_progress__update(prog, size);
 
 	if (session_done())
 		goto out;
@@ -1928,6 +1917,31 @@ more:
 		goto more;
 
 out:
+	return err;
+}
+
+static int __perf_session__process_events(struct perf_session *session)
+{
+	struct reader rd = {
+		.fd		= perf_data__fd(session->data),
+		.data_size	= session->header.data_size,
+		.data_offset	= session->header.data_offset,
+	};
+	struct ordered_events *oe = &session->ordered_events;
+	struct perf_tool *tool = session->tool;
+	struct ui_progress prog;
+	int err;
+
+	perf_tool__fill_defaults(tool);
+
+	if (rd.data_size == 0)
+		return -1;
+
+	ui_progress__init_size(&prog, rd.data_size, "Processing events...");
+
+	err = reader__process_events(&rd, session, &prog);
+	if (err)
+		goto out_err;
 	/* do the final flush for ordered samples */
 	err = ordered_events__flush(oe, OE_FLUSH__FINAL);
 	if (err)
