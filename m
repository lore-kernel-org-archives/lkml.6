Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DF7C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D216720844
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfAVKL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:11:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48601 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfAVKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:11:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MABFwE2906159
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:11:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MABFwf2906156;
        Tue, 22 Jan 2019 02:11:15 -0800
Date:   Tue, 22 Jan 2019 02:11:15 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4f5a473d79c755d2e325c9a8dab01804d5416923@git.kernel.org>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, namhyung@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, namhyung@kernel.org, acme@redhat.com,
          peterz@infradead.org, jolsa@kernel.org, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <20190110101301.6196-3-jolsa@kernel.org>
References: <20190110101301.6196-3-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf session: Get rid of file_size variable
Git-Commit-ID: 4f5a473d79c755d2e325c9a8dab01804d5416923
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  4f5a473d79c755d2e325c9a8dab01804d5416923
Gitweb:     https://git.kernel.org/tip/4f5a473d79c755d2e325c9a8dab01804d5416923
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 10 Jan 2019 11:12:57 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 15:15:57 -0300

perf session: Get rid of file_size variable

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
 
@@ -1917,7 +1915,7 @@ more:
 	if (session_done())
 		goto out;
 
-	if (file_pos < file_size)
+	if (file_pos < data_size)
 		goto more;
 
 out:
