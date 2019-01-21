Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ADFC37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E0A217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115075;
	bh=WFLIxS9pJMfSf4Tdw01MOVUsJHkrR82iKQgTK+lZ1x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qmAOU8evyzF0tmHtvmwFutwPTy77nTdf3fzKY46fkrrDCisdUoY9K/CDh1tR+O8x9
	 jSt5wz5x7G3iKan0WSSR+2sJypT5TRC8gTdgVcV4mv8EBi3LyNpd9RuZsFTtPLDr9Q
	 Ctnp5icSUo/63ob5VwXI6Imr4I18wrdjzjN6E3Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfAUX5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:57:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfAUX5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:57:53 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8063A217D6;
        Mon, 21 Jan 2019 23:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115072;
        bh=WFLIxS9pJMfSf4Tdw01MOVUsJHkrR82iKQgTK+lZ1x0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWN/1vBe3RXmm3TJpbc+5PEGgsG80GOdfAJ68T1ACQuOcwAwwtnxXgjNP9RRWwWUb
         YLfYZgLPc3eYEWR+CkYSvXQigqRCBg/PYB6bA84V9+oJDEXM1FJ0L1+v6DdUrEK7en
         UXWEFQIxLHCWQ6KZ9haQ5pJUJ5l2L8j069dVIm9o=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/24] perf session: Add 'data_offset' member to reader object
Date:   Mon, 21 Jan 2019 20:56:48 -0300
Message-Id: <20190121235706.20005-7-acme@kernel.org>
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
-- 
2.20.1

