Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C666C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FEA2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfAVKNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:13:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32847 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAVKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:13:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MABslD2906200
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:11:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MABr2S2906197;
        Tue, 22 Jan 2019 02:11:53 -0800
Date:   Tue, 22 Jan 2019 02:11:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-82715eb184c55b5097c8f1022f54303c2ddbc329@git.kernel.org>
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, namhyung@kernel.org, jolsa@kernel.org,
        hpa@zytor.com, acme@redhat.com
Reply-To: hpa@zytor.com, acme@redhat.com, namhyung@kernel.org,
          jolsa@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, alexander.shishkin@linux.intel.com
In-Reply-To: <20190110101301.6196-4-jolsa@kernel.org>
References: <20190110101301.6196-4-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf session: Add reader object
Git-Commit-ID: 82715eb184c55b5097c8f1022f54303c2ddbc329
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

Commit-ID:  82715eb184c55b5097c8f1022f54303c2ddbc329
Gitweb:     https://git.kernel.org/tip/82715eb184c55b5097c8f1022f54303c2ddbc329
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 10 Jan 2019 11:12:58 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 15:15:57 -0300

perf session: Add reader object

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
