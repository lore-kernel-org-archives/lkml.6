Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6237AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3357A214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547115215;
	bh=4EU9L3Kcy26Pd5+s3nq/xaD1t5li8NxbE+om46GPrKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TP+PId544tgKmz53BOqbwRPUdeeGv78EsDWM5/3YB6XzIjnE2evidBiTBKphlF2M+
	 xKhx0QA/6CKtfkNakbjVV/Ql1bLAtRU2Ivh8RrDko/oCcnMu3VpxFS5SOk8NShOHC7
	 nacaU62WnwRwSoyIbAV+Lx8RzNJSKnMRX60+h3uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfAJKNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:13:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbfAJKNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:13:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4A0B07AEAC;
        Thu, 10 Jan 2019 10:13:07 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C73912654E;
        Thu, 10 Jan 2019 10:13:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/6] perf session: Get rid of file_size variable
Date:   Thu, 10 Jan 2019 11:12:57 +0100
Message-Id: <20190110101301.6196-3-jolsa@kernel.org>
In-Reply-To: <20190110101301.6196-1-jolsa@kernel.org>
References: <20190110101301.6196-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 10 Jan 2019 10:13:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not needed and removing it makes the code little
more simple for upcoming changes.

It's safe to replace file_size with data_size, because
perf_data__size value is never smaller than data_offset
+ data_size.

Link: http://lkml.kernel.org/n/tip-ocz7zwwkkx11v0mkxrtcddih@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index ad14192db811..c8c2069fb01e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1825,7 +1825,6 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
 	int fd = perf_data__fd(session->data);
-	u64 file_size = perf_data__size(session->data);
 	u64 data_offset = session->header.data_offset;
 	u64 data_size = session->header.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
@@ -1845,14 +1844,13 @@ static int __perf_session__process_events(struct perf_session *session)
 	if (data_size == 0)
 		goto out;
 
-	if (data_offset + data_size < file_size)
-		file_size = data_offset + data_size;
+	ui_progress__init_size(&prog, data_size, "Processing events...");
 
-	ui_progress__init_size(&prog, file_size, "Processing events...");
+	data_size += data_offset;
 
 	mmap_size = MMAP_SIZE;
-	if (mmap_size > file_size) {
-		mmap_size = file_size;
+	if (mmap_size > data_size) {
+		mmap_size = data_size;
 		session->one_mmap = true;
 	}
 
@@ -1917,7 +1915,7 @@ static int __perf_session__process_events(struct perf_session *session)
 	if (session_done())
 		goto out;
 
-	if (file_pos < file_size)
+	if (file_pos < data_size)
 		goto more;
 
 out:
-- 
2.17.2

