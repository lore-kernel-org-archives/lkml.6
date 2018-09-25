Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6560EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8EE20684
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F8EE20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeIYPhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:37:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48301 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:36:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9TYYK3385786
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:29:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9TYRN3385783;
        Tue, 25 Sep 2018 02:29:34 -0700
Date:   Tue, 25 Sep 2018 02:29:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-53da12e013498c4eca592939bb18a5dbd1d228c9@git.kernel.org>
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        dsahern@gmail.com, eranian@google.com, acme@redhat.com,
        mingo@kernel.org, andi@firstfloor.org, namhyung@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, acme@redhat.com, eranian@google.com,
          dsahern@gmail.com, alexander.shishkin@linux.intel.com,
          andi@firstfloor.org, mingo@kernel.org, hpa@zytor.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, namhyung@kernel.org
In-Reply-To: <20180907102455.7030-2-jolsa@kernel.org>
References: <20180907102455.7030-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ordered_events: Prevent crossing
 max_alloc_size
Git-Commit-ID: 53da12e013498c4eca592939bb18a5dbd1d228c9
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

Commit-ID:  53da12e013498c4eca592939bb18a5dbd1d228c9
Gitweb:     https://git.kernel.org/tip/53da12e013498c4eca592939bb18a5dbd1d228c9
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 7 Sep 2018 12:24:55 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:25:08 -0300

perf ordered_events: Prevent crossing max_alloc_size

Stephane reported a possible issue in the ordered events code, which
could lead to allocating more memory than guarded by max_alloc_size.

He also suggested the fix to properly check that the new size is below
the max_alloc_size limit.

Reported-by: Stephane Eranian <eranian@google.com>
Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180907102455.7030-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 84ce25272c13..1904e7f6ec84 100644
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
