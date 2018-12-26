Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3C8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8993B21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545832301;
	bh=vT4ncqROY6eOSXH3/4WHjGOxyTHIlmZkRr7caCRvfBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bqOQobV7RTZdlM2Ezchq0JyUHGxFwnf8lB7Y6c6SZS1EynDrFby8nPqz+uhgU3ZKU
	 vLK+F8avo44/gmrF23g9hpjn8/SZTbfwM7IkuCqkMW8Pe6Y/CcEQv0VcFK9kDSJMoF
	 ivgW4Y9Qivm6KtlLC2bQzBTNEe7sPA8dpxBgkDnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbeLZNvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:51:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeLZNvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:51:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2D8AC057F8F;
        Wed, 26 Dec 2018 13:51:38 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA42019743;
        Wed, 26 Dec 2018 13:51:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 1/5] perf session: Get rid of file_size variable
Date:   Wed, 26 Dec 2018 14:51:28 +0100
Message-Id: <20181226135132.29330-2-jolsa@kernel.org>
In-Reply-To: <20181226135132.29330-1-jolsa@kernel.org>
References: <20181226135132.29330-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 26 Dec 2018 13:51:39 +0000 (UTC)
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
index 3972f081a8f4..d6c1d3853f27 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1818,7 +1818,6 @@ static int __perf_session__process_events(struct perf_session *session)
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
 	int fd = perf_data__fd(session->data);
-	u64 file_size = perf_data__size(session->data);
 	u64 data_offset = session->header.data_offset;
 	u64 data_size = session->header.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
@@ -1838,14 +1837,13 @@ static int __perf_session__process_events(struct perf_session *session)
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
 
@@ -1910,7 +1908,7 @@ static int __perf_session__process_events(struct perf_session *session)
 	if (session_done())
 		goto out;
 
-	if (file_pos < file_size)
+	if (file_pos < data_size)
 		goto more;
 
 out:
-- 
2.17.2

