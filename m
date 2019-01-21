Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2619C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EFA21736
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115066;
	bh=S2+YmnxV1HVsxSMkCWS6ek/eotInBhdRANXTU16HwCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uocbqbmt8jnICkO2yLlB+8w4rPvWk2N1BBP46ssxoAGf6JKNGe/A/qsDjVayMWHSP
	 FGq7D+dBasQIkFYXd7Z0DkweG2HaaSwhKvAQua1U7wMkC/ctck+fE/PgclnoL21+Ju
	 jhidQgzEGfGcYAGG1C79sL0k04cwwIAnSHnYVOBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfAUX5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:57:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:58154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfAUX5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:57:42 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1EED217D8;
        Mon, 21 Jan 2019 23:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115061;
        bh=S2+YmnxV1HVsxSMkCWS6ek/eotInBhdRANXTU16HwCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2JBJlFNPfQ/aQZ9iMyr7ASTotIIq5CtXpKZD+tA1yTeMH8YwTxdineTllq+PElebU
         XlDWuev8CI6PHLdZT9wGqc7CWuDR0RcmPU4BsAy5EGeMQyiPjthLryOownU5ikRj5t
         pDZki5ZIgdNbEoVqQRSbv20z1UuSmXZtZOcV3NSM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/24] perf session: Add reader object
Date:   Mon, 21 Jan 2019 20:56:46 -0300
Message-Id: <20190121235706.20005-5-acme@kernel.org>
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

Add a session private reader object to encapsulate the reading of the
event data block. Starting with a 'fd' field.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c8c2069fb01e..06379cc87f59 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1820,11 +1820,17 @@ fetch_mmaped_event(struct perf_session *session,
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
@@ -1864,7 +1870,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		mmap_flags = MAP_PRIVATE;
 	}
 remap:
-	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, fd,
+	buf = mmap(NULL, mmap_size, mmap_prot, mmap_flags, rd.fd,
 		   file_offset);
 	if (buf == MAP_FAILED) {
 		pr_err("failed to mmap file\n");
-- 
2.20.1

