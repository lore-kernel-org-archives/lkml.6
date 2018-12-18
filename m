Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E82EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46733217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeLROMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:12:41 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44423 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeLROMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:12:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIECJbT2854410
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:12:19 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIECJsh2854407;
        Tue, 18 Dec 2018 06:12:19 -0800
Date:   Tue, 18 Dec 2018 06:12:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-ocjdukp2a8ujikkmafd0j5zv@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, davem@davemloft.net,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: peterz@infradead.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
          acme@redhat.com, davem@davemloft.net,
          alexander.shishkin@linux.intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ordered_events: Rework show_progress for
 __ordered_events__flush
Git-Commit-ID: b8494f1df875abba925374cf31bd96a464a7e5d1
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
Message-ID: <20181218141219.UTRSkBgPMdjDyBtrjDa4mWH-BKkPlWd5VV0sai1SwYw@z>

Commit-ID:  b8494f1df875abba925374cf31bd96a464a7e5d1
Gitweb:     https://git.kernel.org/tip/b8494f1df875abba925374cf31bd96a464a7e5d1
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 7 Nov 2018 16:46:47 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:57:12 -0300

perf ordered_events: Rework show_progress for __ordered_events__flush

Decide to use the progress bar one level higher, we will need this in
following patch.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-ocjdukp2a8ujikkmafd0j5zv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 1904e7f6ec84..28f0f5c95024 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -219,13 +219,13 @@ int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 	return 0;
 }
 
-static int __ordered_events__flush(struct ordered_events *oe)
+static int __ordered_events__flush(struct ordered_events *oe,
+				   bool show_progress)
 {
 	struct list_head *head = &oe->events;
 	struct ordered_event *tmp, *iter;
 	u64 limit = oe->next_flush;
 	u64 last_ts = oe->last ? oe->last->timestamp : 0ULL;
-	bool show_progress = limit == ULLONG_MAX;
 	struct ui_progress prog;
 	int ret;
 
@@ -272,6 +272,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		"HALF ",
 	};
 	int err;
+	bool show_progress = false;
 
 	if (oe->nr_events == 0)
 		return 0;
@@ -279,6 +280,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 	switch (how) {
 	case OE_FLUSH__FINAL:
 		oe->next_flush = ULLONG_MAX;
+		show_progress = true;
 		break;
 
 	case OE_FLUSH__HALF:
@@ -308,7 +310,7 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 		   str[how], oe->nr_events);
 	pr_oe_time(oe->max_timestamp, "max_timestamp\n");
 
-	err = __ordered_events__flush(oe);
+	err = __ordered_events__flush(oe, show_progress);
 
 	if (!err) {
 		if (how == OE_FLUSH__ROUND)
