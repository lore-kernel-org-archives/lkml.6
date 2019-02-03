Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0E1C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE3420823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207866;
	bh=xO9G0Otbnf10qdlhKLxfbQmm0TO0dj9IMnL+L0p7o5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XUqxGnFhi36dW4OOC9cWsB4qhpt71vNkwr1NUeMGS5Vh01iyxbtkoteukMLvIcZPT
	 u//oBcNX5QEk54GJ49ZPgzknQ07NOae3EH/Rk+i9c5N8m13TQutTa5NuDc4Dp9ej0b
	 bgCFfqCStwWrZRs1IFOe87MnjwtBFwmBdUyihqJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfBCPbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:31:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbfBCPbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:31:01 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B8DE12F91E;
        Sun,  3 Feb 2019 15:31:01 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90EF45C238;
        Sun,  3 Feb 2019 15:30:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 13/14] perf session: Add path to reader object
Date:   Sun,  3 Feb 2019 16:30:17 +0100
Message-Id: <20190203153018.9650-14-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 03 Feb 2019 15:31:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding path to reader object, so we can display file
the processing fails for (string in [] brackets).

  $ perf report --stdio
  0x5e0 [perf.data/data.3] [0xa200]: failed to process type: -1577027574

Link: http://lkml.kernel.org/n/tip-4bjnoy4sln7adqtd3505q29q@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/session.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 38d2854cebc1..aa7c4fd1cd2f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1846,6 +1846,7 @@ struct reader {
 	u64		 data_size;
 	u64		 data_offset;
 	reader_cb_t	 process;
+	char		*path;
 };
 
 static int
@@ -1915,8 +1916,8 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, file_pos)) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
-		       file_offset + head, event->header.size,
+		pr_err("%#" PRIx64 " [%s] [%#x]: failed to process type: %d\n",
+		       file_offset + head, rd->path, event->header.size,
 		       event->header.type);
 		err = -EINVAL;
 		goto out;
@@ -1954,6 +1955,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
 		.process	= process_simple,
+		.path		= session->data->file.path,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
@@ -2028,6 +2030,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 		.data_size	= session->header.data_size,
 		.data_offset	= session->header.data_offset,
 		.process	= process_simple,
+		.path		= session->data->file.path,
 	};
 	int i, ret = 0;
 	struct ui_progress prog;
@@ -2052,6 +2055,7 @@ static int __perf_session__process_dir_events(struct perf_session *session)
 			.data_size	= file->size,
 			.data_offset	= 0,
 			.process	= process_index,
+			.path		= file->path,
 		};
 
 		ret = reader__process_events(&rd, session, &prog);
-- 
2.17.2

