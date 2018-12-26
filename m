Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2AEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16AB21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545832304;
	bh=p5JbUQe90++D3cVlLMrBBBXW94CEOnnNDpLZawu9hus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PMbLY6DZBS84/P70EuffxDSsoczBYlCAMKslZS364ec5hx2MtpijCFjrnWgmtsvK9
	 1TrWS78oXKEpX2OfrYg1camLI7EbY7JQ+pQhYT5+js0x8tYm/nEOFNiOPpR7GokDwX
	 MxPSiwfTDZK96aCCK51xgJjrzbDsMc3gfhuOiCyo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeLZNvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 08:51:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbeLZNvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 08:51:41 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75956C049597;
        Wed, 26 Dec 2018 13:51:41 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-92.brq.redhat.com [10.40.204.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77ABC19743;
        Wed, 26 Dec 2018 13:51:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 2/5] perf session: Add reader object
Date:   Wed, 26 Dec 2018 14:51:29 +0100
Message-Id: <20181226135132.29330-3-jolsa@kernel.org>
In-Reply-To: <20181226135132.29330-1-jolsa@kernel.org>
References: <20181226135132.29330-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 26 Dec 2018 13:51:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding session private reader object to encapsulate reading
of the event data block. Starting with fd field inside.

Link: http://lkml.kernel.org/n/tip-glbs0xvtdcstckscvahueigf@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index d6c1d3853f27..f5eecae982ba 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1813,11 +1813,17 @@ fetch_mmaped_event(struct perf_session *session,
 #define NUM_MMAPS 128
 #endif
 
+struct reader {
+	int	fd;
+};
+
 static int __perf_session__process_events(struct perf_session *session)
 {
+	struct reader rd = {
+		.fd		= perf_data__fd(session->data),
+	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
-	int fd = perf_data__fd(session->data);
 	u64 data_offset = session->header.data_offset;
 	u64 data_size = session->header.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
@@ -1857,7 +1863,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		mmap_flags = MAP_PRIVATE;
 	}
 remap:
-	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, fd,
+	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd.fd,
 		   file_offset);
 	if (buf == MAP_FAILED) {
 		pr_err("failed to mmap file\n");
-- 
2.17.2

