Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC66C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2890D214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547115209;
	bh=JN25/Y5qTPYnnvtoxG7USoUvOMTYuxegCdv5CMLhggE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i4JWu3z8F81lzXqvIGNI+fZGcNCtBtozGF5RQ7gTqR4C/c2XJOo1MWJFqsUzYK3xm
	 cz5cxXhQitvp7MZjVqNUFGip7EowzxV+5w2Bk56MPZAwTPT2g7s+se4e6jpJKycY7E
	 KN7TBic3Bf/RePH48p/ePnYlFvgPYczzeTbm5ZJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfAJKN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:13:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56920 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfAJKNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:13:12 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B458996E9;
        Thu, 10 Jan 2019 10:13:12 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AEC42654A;
        Thu, 10 Jan 2019 10:13:11 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 5/6] perf session: Add data_offset to reader object
Date:   Thu, 10 Jan 2019 11:13:00 +0100
Message-Id: <20190110101301.6196-6-jolsa@kernel.org>
In-Reply-To: <20190110101301.6196-1-jolsa@kernel.org>
References: <20190110101301.6196-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 10 Jan 2019 10:13:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding data_offset to reader object.

Link: http://lkml.kernel.org/n/tip-k531enq5bmack3mjccjblvi6@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.2

