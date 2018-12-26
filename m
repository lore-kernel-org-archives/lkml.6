Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FC2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E6821720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545832314;
	bh=s8mCX0ERyFXAEWP35xc/fHlxJiGL8cKmUJIWgssFGDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nenjuhPm3csVk0FNfdiHEbcBceoH5J2EIPjlbcv7BfdwwYS8+8cl3mkVZz4/DWpPu
	 CB/PrgnFhRwH0Gg+LEO/AM3u0GxStY1Y1zsHsGxc+RIm3TXN3J7eMH3W1HXeeVmiL6
	 GgrWW43v4iL9F93xih65eMNJ+Di/nViM9faruKEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbeLZNvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:51:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeLZNvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:51:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD26981F0D;
        Wed, 26 Dec 2018 13:51:50 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9476419743;
        Wed, 26 Dec 2018 13:51:48 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 5/5] perf session: Add reader__process_events function
Date:   Wed, 26 Dec 2018 14:51:32 +0100
Message-Id: <20181226135132.29330-6-jolsa@kernel.org>
In-Reply-To: <20181226135132.29330-1-jolsa@kernel.org>
References: <20181226135132.29330-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 26 Dec 2018 13:51:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding reader__process_events function to readers data.

The reader object is defined by file's fd, data offset
and data size.

Now we can simply define reader object for arbitrary file
data portion and pass it to reader__process_events function
to process its data.

Link: http://lkml.kernel.org/n/tip-sh3yfoavlzr2f45rf8g6145j@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 62 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index bc2a4f80535c..6a9dc5f0675c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1819,36 +1819,25 @@ struct reader {
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
@@ -1866,12 +1855,12 @@ static int __perf_session__process_events(struct perf_session *session)
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
@@ -1903,7 +1892,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		       file_offset + head, event->header.size,
 		       event->header.type);
 		err = -EINVAL;
-		goto out_err;
+		goto out;
 	}
 
 	if (skip)
@@ -1912,7 +1901,7 @@ static int __perf_session__process_events(struct perf_session *session)
 	head += size;
 	file_pos += size;
 
-	ui_progress__update(&prog, size);
+	ui_progress__update(prog, size);
 
 	if (session_done())
 		goto out;
@@ -1921,6 +1910,31 @@ static int __perf_session__process_events(struct perf_session *session)
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
-- 
2.17.2

