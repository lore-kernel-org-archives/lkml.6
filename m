Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971A1C37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B5B21736
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115082;
	bh=3zcnKZoo+UcHJR0dsJ7nwuoQA3aKKKSfVzJqKnSrquM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uWIao1Puc47Og6k7KkJmG2+L02HGPCGDmKYgzrHEjhu8hQk0CK9qBjw7T5Y+V91q4
	 PX930PThbd+pOfFuxatYQ0hu/Q45g92/mlC/MKAyNHEp5A5dG95RkaJfXPkNTjRbT3
	 WHnOM+DyWq2kGx8yrK/MMxCOJIiVXXI1IluMQ5fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfAUX6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:58390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfAUX57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:57:59 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A298621736;
        Mon, 21 Jan 2019 23:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115078;
        bh=3zcnKZoo+UcHJR0dsJ7nwuoQA3aKKKSfVzJqKnSrquM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVRF66vsdqM7Y/eGS6c2AASjtc1PUE7lhB2kKGLnzbnC11J4vlovcPjq61gjNGC/9
         zBFUI89QtO8AdebxR2bc1C5cQuOXeaceKw20fuiikzWSf7dh1Wq39X2eBrN8Thcbzw
         jZZshSFm8IrJfmQQn92yUBsO1VIwVMCRDRbmAy8Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/24] perf session: Add reader__process_events function
Date:   Mon, 21 Jan 2019 20:56:49 -0300
Message-Id: <20190121235706.20005-8-acme@kernel.org>
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
 tools/perf/util/session.c | 62 ++++++++++++++++++++++++---------------
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
@@ -1910,7 +1899,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		       file_offset + head, event->header.size,
 		       event->header.type);
 		err = -EINVAL;
-		goto out_err;
+		goto out;
 	}
 
 	if (skip)
@@ -1919,7 +1908,7 @@ static int __perf_session__process_events(struct perf_session *session)
 	head += size;
 	file_pos += size;
 
-	ui_progress__update(&prog, size);
+	ui_progress__update(prog, size);
 
 	if (session_done())
 		goto out;
@@ -1928,6 +1917,31 @@ static int __perf_session__process_events(struct perf_session *session)
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
2.20.1

