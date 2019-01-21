Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE44C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D75D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115059;
	bh=zaHz+IQxBrrO/EQ5yjnaQ7+gwAPGFUR7Z+TN/WbNmsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GSa30HQCP2FFaOArCWfom3TYsrwKUI06P5pi3IWcAfLW1nh2c0QSdmAbz9Cepa+9+
	 VXnNiRZbT5547nB2ZWl+Jed7LuXoOFYElm44Ym0od6zJC5D0q135yh5Jy1fUfe54bc
	 wwb/TYX/WTFbKIw3a3+kxG1vuhwWtUAXBTTX2bu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfAUX5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfAUX5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:57:37 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1297C21736;
        Mon, 21 Jan 2019 23:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115056;
        bh=zaHz+IQxBrrO/EQ5yjnaQ7+gwAPGFUR7Z+TN/WbNmsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fn2nSGnCb7umHrpHH7dshaeJGVxq8AspqxVvCl9LD/cNtIbV9SAgbi/v2rEwZ4QiO
         vCwIODjRBpvbvd1FQicrCd/6WqEwtmykMvqygLW2JuqvYkvC87I+RzIYE2pmv7yaEu
         0AnWNZgUK/YEws50LyVPmYZc0C97yQwafEPOL91Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/24] perf session: Get rid of file_size variable
Date:   Mon, 21 Jan 2019 20:56:45 -0300
Message-Id: <20190121235706.20005-4-acme@kernel.org>
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

It's not needed and removing it makes the code a little simpler for the
upcoming changes.

It's safe to replace file_size with data_size, because the
perf_data__size() value is never smaller than data_offset + data_size.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190110101301.6196-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

