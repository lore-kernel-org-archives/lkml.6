Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60283C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA9220869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA9220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbeIGPFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:05:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727631AbeIGPFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:05:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0ED526A81;
        Fri,  7 Sep 2018 10:25:00 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-250.brq.redhat.com [10.40.204.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C5672166BA3;
        Fri,  7 Sep 2018 10:24:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 2/2] perf tools: Prevent crossing ordered events max_alloc_size
Date:   Fri,  7 Sep 2018 12:24:55 +0200
Message-Id: <20180907102455.7030-2-jolsa@kernel.org>
In-Reply-To: <20180907102455.7030-1-jolsa@kernel.org>
References: <20180907102455.7030-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 10:25:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 10:25:00 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane reported possible issue in the ordered
events code, which could lead to allocating more
memory than guarded by max_alloc_size.

He also suggested the fix to properly check that
the new size is below the max_alloc_size limit.

Reported-and-suggested-by: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-ji6otoar06ze4ka0shnp4djd@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/ordered-events.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 87171e8fd70d..2d1d0f3c8f77 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -101,6 +101,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 	struct list_head *cache = &oe->cache;
 	struct ordered_event *new = NULL;
 	union perf_event *new_event;
+	size_t size;
 
 	new_event = dup_event(oe, event);
 	if (!new_event)
@@ -133,6 +134,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 	 * Removal of ordered event object moves it from events to
 	 * the cache list.
 	 */
+	size = sizeof(*oe->buffer) + MAX_SAMPLE_BUFFER * sizeof(*new);
+
 	if (!list_empty(cache)) {
 		new = list_entry(cache->next, struct ordered_event, list);
 		list_del(&new->list);
@@ -140,10 +143,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 		new = &oe->buffer->event[oe->buffer_idx];
 		if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
 			oe->buffer = NULL;
-	} else if (oe->cur_alloc_size < oe->max_alloc_size) {
-		size_t size = sizeof(*oe->buffer) +
-			      MAX_SAMPLE_BUFFER * sizeof(*new);
-
+	} else if ((oe->cur_alloc_size + size) < oe->max_alloc_size) {
 		oe->buffer = malloc(size);
 		if (!oe->buffer) {
 			free_dup_event(oe, new_event);
-- 
2.17.1

