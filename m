Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF58C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2FB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2FB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeKSWnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:43:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728785AbeKSWnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:43:53 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F44F3082E43;
        Mon, 19 Nov 2018 12:20:26 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 89F8C45F35;
        Mon, 19 Nov 2018 12:20:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 02/12] perf tools: Rework show_progress for __ordered_events__flush
Date:   Mon, 19 Nov 2018 13:20:06 +0100
Message-Id: <20181119122016.22423-3-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 19 Nov 2018 12:20:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decide to use the progress bar one level higher,
we will need this in following patch.

Link: http://lkml.kernel.org/n/tip-ocjdukp2a8ujikkmafd0j5zv@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.17.2

