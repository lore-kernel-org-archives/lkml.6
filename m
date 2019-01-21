Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C92C37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A9721736
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115070;
	bh=f/bkya8vCuijkYvokoTEyR4yESIlzdRJpvQOfpmZM+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LcOIHcr9D4VdoSS1Olwqmiq8kPjdwzG9rE3szeqLr76XmpUwSt4y4xSAYpemGi72q
	 9cj5BC1ZwcidmW0SYvG+AW07/NOjoC3UUHbazkk7/PpL6uc2nYHBVJ59KSCuSc85f2
	 B9ad+A52sxEpltfcgUSllyhRZF2RgJ36vdn9xpbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfAUX5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:57:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:58246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfAUX5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:57:48 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9971920870;
        Mon, 21 Jan 2019 23:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115067;
        bh=f/bkya8vCuijkYvokoTEyR4yESIlzdRJpvQOfpmZM+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=by0pcb2fm30W159U5EG1ngzjLHokQR9lp1Mnj6Ha40FvahpxVoB12eC0DL51Embin
         HTFxlZMu94Cuj8cjUahMO7qu0OmFqCz6zxWXhcBui4xPEcwyfL9XCzch0VyC4YrrvL
         bYCKU/F48x7tWq+4+49EcvL93X8DGqWPKmoHEEqY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/24] perf session: Add 'data_size' member to reader object
Date:   Mon, 21 Jan 2019 20:56:47 -0300
Message-Id: <20190121235706.20005-6-acme@kernel.org>
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

Add a  'data_size' member to the reader object. Keep the 'data_size'
variable instead of replacing it with rd.data_size as it will be used in
the following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 06379cc87f59..9f29ed743425 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1822,17 +1822,19 @@ fetch_mmaped_event(struct perf_session *session,
 
 struct reader {
 	int	fd;
+	u64	data_size;
 };
 
 static int __perf_session__process_events(struct perf_session *session)
 {
 	struct reader rd = {
 		.fd		= perf_data__fd(session->data),
+		.data_size	= session->header.data_size,
 	};
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
 	u64 data_offset = session->header.data_offset;
-	u64 data_size = session->header.data_size;
+	u64 data_size = rd.data_size;
 	u64 head, page_offset, file_offset, file_pos, size;
 	int err, mmap_prot, mmap_flags, map_idx = 0;
 	size_t	mmap_size;
-- 
2.20.1

