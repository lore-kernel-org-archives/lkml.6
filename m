Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B779C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA23520867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA23520867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeIYPg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:36:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49667 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:36:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9T3Zc3385758
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:29:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9T3vV3385755;
        Tue, 25 Sep 2018 02:29:03 -0700
Date:   Tue, 25 Sep 2018 02:29:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-d5ceb62b36545b597e89adb5eb778c3e15431c10@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, andi@firstfloor.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        eranian@google.com, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: tglx@linutronix.de, jolsa@kernel.org, andi@firstfloor.org,
          hpa@zytor.com, alexander.shishkin@linux.intel.com,
          acme@redhat.com, peterz@infradead.org, mingo@kernel.org,
          namhyung@kernel.org, eranian@google.com, dsahern@gmail.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180907102455.7030-1-jolsa@kernel.org>
References: <20180907102455.7030-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ordered_events: Add 'struct
 ordered_events_buffer' layer
Git-Commit-ID: d5ceb62b36545b597e89adb5eb778c3e15431c10
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

Commit-ID:  d5ceb62b36545b597e89adb5eb778c3e15431c10
Gitweb:     https://git.kernel.org/tip/d5ceb62b36545b597e89adb5eb778c3e15431c10
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 7 Sep 2018 12:24:54 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:24:57 -0300

perf ordered_events: Add 'struct ordered_events_buffer' layer

When ordering events, we use preallocated buffers to store separate
events.  Those buffers currently don't have their own struct, but since
they are basically an array of 'struct ordered_event' objects, we use
the first event to hold buffers data - list head, that holds all buffers
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

This is quite convoluted and error prone as demonstrated by free-ing
issue discovered and fixed by Stephane in here [1].

This patch adds the 'struct ordered_events_buffer' object, that holds
the buffer data and frees it up properly.

[1] - https://marc.info/?l=linux-kernel&m=153376761329335&w=2

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Stephane Eranian <eranian@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180907102455.7030-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 83 +++++++++++++++++++++++++++++++++-------
 tools/perf/util/ordered-events.h | 37 ++++++++++--------
 2 files changed, 91 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index bad9e0296e9a..84ce25272c13 100644
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
+	 * We maintain the following scheme of buffers for ordered
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
+	 * Allocation of the ordered event uses the following order
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
