Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD63F20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfAVKMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:12:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36123 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfAVKMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:12:42 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MACVlg2906438
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:12:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MACVBr2906435;
        Tue, 22 Jan 2019 02:12:31 -0800
Date:   Tue, 22 Jan 2019 02:12:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-f66f0950527cd070d2949a0133275c30e717ba9b@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        jolsa@kernel.org, acme@redhat.com, mingo@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          jolsa@kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, namhyung@kernel.org, tglx@linutronix.de,
          acme@redhat.com, mingo@kernel.org
In-Reply-To: <20190110101301.6196-5-jolsa@kernel.org>
References: <20190110101301.6196-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf session: Add 'data_size' member to reader
 object
Git-Commit-ID: f66f0950527cd070d2949a0133275c30e717ba9b
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

Commit-ID:  f66f0950527cd070d2949a0133275c30e717ba9b
Gitweb:     https://git.kernel.org/tip/f66f0950527cd070d2949a0133275c30e717ba9b
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 10 Jan 2019 11:12:59 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 15:15:57 -0300

perf session: Add 'data_size' member to reader object

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
