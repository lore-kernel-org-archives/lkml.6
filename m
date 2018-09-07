Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FFBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2A320869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2A320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbeIGPFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:05:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727631AbeIGPFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DD62226A3D;
        Fri,  7 Sep 2018 10:24:58 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-250.brq.redhat.com [10.40.204.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE242166BA3;
        Fri,  7 Sep 2018 10:24:56 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 1/2] perf tools: Add struct ordered_events_buffer layer
Date:   Fri,  7 Sep 2018 12:24:54 +0200
Message-Id: <20180907102455.7030-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 10:24:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 10:24:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ordering events, we use preallocated buffers to store separated
events. Those buffers currently don't have their own struct, but since
they are basically array of 'struct ordered_event' objects, we use the
first event to hold buffers data - list head, that holds all buffers
together:

   struct ordered_events {
     ...
     struct ordered_event *buffer;
     ...
   };

   struct ordered_event {
     u64               timestamp;
     u64               file_offset;
     union perf_event  *event;
     struct list_head  list;
   };

This is quite convoluted and error prone as demonstrated by
free-ing issue discovered and fixed by Stephane in here [1].

This patch adds the 'struct ordered_events_buffer' object,
that holds the buffer data and frees it up properly.

[1] - https://marc.info/?l=linux-kernel&m=153376761329335&w=2

Reported-and-tested-by: Stephane Eranian <eranian@google.com>
Tested-by: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-qrkcqm5m1sugy4q83pfn5a1r@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/ordered-events.c | 83 +++++++++++++++++++++++++++-----
 tools/perf/util/ordered-events.h | 37 ++++++++------
 2 files changed, 91 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index bad9e0296e9a..87171e8fd70d 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -80,14 +80,20 @@ static union perf_event *dup_event(struct ordered_events *oe,
 	return oe->copy_on_queue ? __dup_event(oe, event) : event;
 }
 
-static void free_dup_event(struct ordered_events *oe, union perf_event *event)
+static void __free_dup_event(struct ordered_events *oe, union perf_event *event)
 {
-	if (event && oe->copy_on_queue) {
+	if (event) {
 		oe->cur_alloc_size -= event->header.size;
 		free(event);
 	}
 }
 
+static void free_dup_event(struct ordered_events *oe, union perf_event *event)
+{
+	if (oe->copy_on_queue)
+		__free_dup_event(oe, event);
+}
+
 #define MAX_SAMPLE_BUFFER	(64 * 1024 / sizeof(struct ordered_event))
 static struct ordered_event *alloc_event(struct ordered_events *oe,
 					 union perf_event *event)
@@ -100,15 +106,43 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 	if (!new_event)
 		return NULL;
 
+	/*
+	 * We maintain following scheme of buffers for ordered
+	 * event allocation:
+	 *
+	 *   to_free list -> buffer1 (64K)
+	 *                   buffer2 (64K)
+	 *                   ...
+	 *
+	 * Each buffer keeps an array of ordered events objects:
+	 *    buffer -> event[0]
+	 *              event[1]
+	 *              ...
+	 *
+	 * Each allocated ordered event is linked to one of
+	 * following lists:
+	 *   - time ordered list 'events'
+	 *   - list of currently removed events 'cache'
+	 *
+	 * Allocation of the ordered event uses following order
+	 * to get the memory:
+	 *   - use recently removed object from 'cache' list
+	 *   - use available object in current allocation buffer
+	 *   - allocate new buffer if the current buffer is full
+	 *
+	 * Removal of ordered event object moves it from events to
+	 * the cache list.
+	 */
 	if (!list_empty(cache)) {
 		new = list_entry(cache->next, struct ordered_event, list);
 		list_del(&new->list);
 	} else if (oe->buffer) {
-		new = oe->buffer + oe->buffer_idx;
+		new = &oe->buffer->event[oe->buffer_idx];
 		if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
 			oe->buffer = NULL;
 	} else if (oe->cur_alloc_size < oe->max_alloc_size) {
-		size_t size = MAX_SAMPLE_BUFFER * sizeof(*new);
+		size_t size = sizeof(*oe->buffer) +
+			      MAX_SAMPLE_BUFFER * sizeof(*new);
 
 		oe->buffer = malloc(size);
 		if (!oe->buffer) {
@@ -122,11 +156,11 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 		oe->cur_alloc_size += size;
 		list_add(&oe->buffer->list, &oe->to_free);
 
-		/* First entry is abused to maintain the to_free list. */
-		oe->buffer_idx = 2;
-		new = oe->buffer + 1;
+		oe->buffer_idx = 1;
+		new = &oe->buffer->event[0];
 	} else {
 		pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
+		return NULL;
 	}
 
 	new->event = new_event;
@@ -300,15 +334,38 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
 	oe->deliver	   = deliver;
 }
 
+static void
+ordered_events_buffer__free(struct ordered_events_buffer *buffer,
+			    unsigned int max, struct ordered_events *oe)
+{
+	if (oe->copy_on_queue) {
+		unsigned int i;
+
+		for (i = 0; i < max; i++)
+			__free_dup_event(oe, buffer->event[i].event);
+	}
+
+	free(buffer);
+}
+
 void ordered_events__free(struct ordered_events *oe)
 {
-	while (!list_empty(&oe->to_free)) {
-		struct ordered_event *event;
+	struct ordered_events_buffer *buffer, *tmp;
 
-		event = list_entry(oe->to_free.next, struct ordered_event, list);
-		list_del(&event->list);
-		free_dup_event(oe, event->event);
-		free(event);
+	if (list_empty(&oe->to_free))
+		return;
+
+	/*
+	 * Current buffer might not have all the events allocated
+	 * yet, we need to free only allocated ones ...
+	 */
+	list_del(&oe->buffer->list);
+	ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+
+	/* ... and continue with the rest */
+	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
+		list_del(&buffer->list);
+		ordered_events_buffer__free(buffer, MAX_SAMPLE_BUFFER, oe);
 	}
 }
 
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 8c7a2948593e..1338d5c345dc 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -25,23 +25,28 @@ struct ordered_events;
 typedef int (*ordered_events__deliver_t)(struct ordered_events *oe,
 					 struct ordered_event *event);
 
+struct ordered_events_buffer {
+	struct list_head	list;
+	struct ordered_event	event[0];
+};
+
 struct ordered_events {
-	u64			last_flush;
-	u64			next_flush;
-	u64			max_timestamp;
-	u64			max_alloc_size;
-	u64			cur_alloc_size;
-	struct list_head	events;
-	struct list_head	cache;
-	struct list_head	to_free;
-	struct ordered_event	*buffer;
-	struct ordered_event	*last;
-	ordered_events__deliver_t deliver;
-	int			buffer_idx;
-	unsigned int		nr_events;
-	enum oe_flush		last_flush_type;
-	u32			nr_unordered_events;
-	bool                    copy_on_queue;
+	u64				 last_flush;
+	u64				 next_flush;
+	u64				 max_timestamp;
+	u64				 max_alloc_size;
+	u64				 cur_alloc_size;
+	struct list_head		 events;
+	struct list_head		 cache;
+	struct list_head		 to_free;
+	struct ordered_events_buffer	*buffer;
+	struct ordered_event		*last;
+	ordered_events__deliver_t	 deliver;
+	int				 buffer_idx;
+	unsigned int			 nr_events;
+	enum oe_flush			 last_flush_type;
+	u32				 nr_unordered_events;
+	bool				 copy_on_queue;
 };
 
 int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
-- 
2.17.1

