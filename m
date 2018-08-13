Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FBBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A871217BB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A871217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeHMPrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:47:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728370AbeHMPrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:47:01 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C68E4021704;
        Mon, 13 Aug 2018 13:04:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5F96D2026D66;
        Mon, 13 Aug 2018 13:04:47 +0000 (UTC)
Date:   Mon, 13 Aug 2018 15:04:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Subject: [PATCH] perf tools: Add struct ordered_events_buffer layer
Message-ID: <20180813130446.GA8685@krava>
References: <1533767600-7794-1-git-send-email-eranian@google.com>
 <20180809080721.GB19243@krava>
 <CABPqkBQEfoMDEqot1VbgExg1fU3+EEunzZqDFKSGmLKBhxNkwA@mail.gmail.com>
 <20180810115431.GA4162@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810115431.GA4162@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 13:04:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 13 Aug 2018 13:04:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 01:54:31PM +0200, Jiri Olsa wrote:
> On Fri, Aug 10, 2018 at 01:21:18AM -0700, Stephane Eranian wrote:
> > On Thu, Aug 9, 2018 at 1:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Wed, Aug 08, 2018 at 03:33:20PM -0700, Stephane Eranian wrote:
> > > > This patch fixes a bug in ordered_event.c:alloc_event().
> > > > An ordered_event struct was not initialized properly potentially
> > > > causing crashes later on in free_dup_event() depending on the
> > > > content of the memory. If it was NULL, then it would work fine,
> > > > otherwise, it could cause crashes such as:
> > >
> > > I'm now little puzzled what do we use this first event for..
> > > I can't see anything special about it, other than it's added
> > > on the list uninitialized ;-)
> > >
> > > it seems to work properly when we ditch it.. might be some
> > > prehistoric leftover or I'm terribly missing something
> > >
> > You need to keep track of the buffers to free. You do not free the
> > ordered_event structs
> > individually. For each oe->buffer, you need one free(). Each buffer is
> > put in the to_free
> > list. But to link it into the list it needs a list_head. This is what
> > buffer[0] is used for.
> > But the logic is broken in  ordered_events__free(). It does not free individual
> > ordered_event structs, but a buffer with many. Yet, it is missing
> > freeing all of the duped
> > events.
> > 
> >  void ordered_events__free(struct ordered_events *oe)
> > {
> >         while (!list_empty(&oe->to_free)) {
> >                 struct ordered_event *buffer;
> > 
> >                 buffer = list_entry(oe->to_free.next, struct
> > ordered_event, list);
> >                 list_del(&buffer->list);
> > ---->         free_dup_event(oe, event->event);
> >                 free(buffer);
> >         }
> > }
> > This only frees the dup_event of buffer[0] which we know is NULL (well, now).
> > It needs to walk all the entries in buffer[] to free buffer[x].event.
> 
> yes.. if there's copy_on_queue set, we need to do that,
> otherwise we're leaking all the events
> 
> > 
> > I think the goal was likely to avoid adding another list_head field to
> > each ordered_event
> > and instead use one per allocated buffer.
> > This is very convoluted and prone to errors and we are seeing right
> > now. This should
> > be cleaned. So either you add a list_head to ordered_event or you
> > would buffer[x] in
> > ordered_events_free().
> > 
> > At this point, this is my understanding.
> > Do you agree?
> 
> yea, I see it now.. thanks for pointing this out
> 
> how about something like below? haven't tested properly yet

attaching full patch

thanks,
jirka


---
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

Reported-by: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-qrkcqm5m1sugy4q83pfn5a1r@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/ordered-events.c | 44 ++++++++++++++++++++++----------
 tools/perf/util/ordered-events.h | 37 +++++++++++++++------------
 2 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index bad9e0296e9a..038515a52e2c 100644
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
@@ -104,11 +110,12 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
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
@@ -122,9 +129,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
 		oe->cur_alloc_size += size;
 		list_add(&oe->buffer->list, &oe->to_free);
 
-		/* First entry is abused to maintain the to_free list. */
-		oe->buffer_idx = 2;
-		new = oe->buffer + 1;
+		oe->buffer_idx = 1;
+		new = &oe->buffer->event[0];
 	} else {
 		pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
 	}
@@ -300,15 +306,27 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
 	oe->deliver	   = deliver;
 }
 
+static void
+ordered_events_buffer__free(struct ordered_events_buffer *buffer,
+			    struct ordered_events *oe)
+{
+	if (oe->copy_on_queue) {
+		unsigned int i;
+
+		for (i = 0; i < MAX_SAMPLE_BUFFER; i++)
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
+	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
+		list_del(&buffer->list);
+		ordered_events_buffer__free(buffer, oe);
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

