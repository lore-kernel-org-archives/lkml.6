Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3510C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71882215FB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 08:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71882215FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbeHOLjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 07:39:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726155AbeHOLjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 07:39:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82EC58197001;
        Wed, 15 Aug 2018 08:48:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5416E111AF04;
        Wed, 15 Aug 2018 08:48:26 +0000 (UTC)
Date:   Wed, 15 Aug 2018 10:48:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Subject: Re: [PATCH] perf tools: Add struct ordered_events_buffer layer
Message-ID: <20180815084825.GD3180@krava>
References: <1533767600-7794-1-git-send-email-eranian@google.com>
 <20180809080721.GB19243@krava>
 <CABPqkBQEfoMDEqot1VbgExg1fU3+EEunzZqDFKSGmLKBhxNkwA@mail.gmail.com>
 <20180810115431.GA4162@krava>
 <20180813130446.GA8685@krava>
 <CABPqkBSgYEFFAkddBqZbYXe9tjUY7RbMBjQsZht8ki1iOR6unw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBSgYEFFAkddBqZbYXe9tjUY7RbMBjQsZht8ki1iOR6unw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 15 Aug 2018 08:48:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 15 Aug 2018 08:48:27 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 12:14:19AM -0700, Stephane Eranian wrote:

SNIP

> > @@ -104,11 +110,12 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
> >                 new = list_entry(cache->next, struct ordered_event, list);
> >                 list_del(&new->list);
> >         } else if (oe->buffer) {
> > -               new = oe->buffer + oe->buffer_idx;
> > +               new = &oe->buffer->event[oe->buffer_idx];
> >                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
> >                         oe->buffer = NULL;
> >         } else if (oe->cur_alloc_size < oe->max_alloc_size) {
> > -               size_t size = MAX_SAMPLE_BUFFER * sizeof(*new);
> > +               size_t size = sizeof(*oe->buffer) +
> > +                             MAX_SAMPLE_BUFFER * sizeof(*new);
> >
> >                 oe->buffer = malloc(size);
> >                 if (!oe->buffer) {
> > @@ -122,9 +129,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
> >                 oe->cur_alloc_size += size;
> >                 list_add(&oe->buffer->list, &oe->to_free);
> >
> > -               /* First entry is abused to maintain the to_free list. */
> > -               oe->buffer_idx = 2;
> > -               new = oe->buffer + 1;
> > +               oe->buffer_idx = 1;
> > +               new = &oe->buffer->event[0];
> 
> Ok, but I think this section between the malloc() and the line above
> needs some comments to clarify what is going on.
> It is still hard to read.

ok, I put some bigger comment at the top, but I'm not too happy
feel free to suggest different one ;-)

> 
> >         } else {
> >                 pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
> >         }
> > @@ -300,15 +306,27 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
> >         oe->deliver        = deliver;
> >  }
> >
> > +static void
> > +ordered_events_buffer__free(struct ordered_events_buffer *buffer,
> > +                           struct ordered_events *oe)
> > +{
> > +       if (oe->copy_on_queue) {
> > +               unsigned int i;
> > +
> > +               for (i = 0; i < MAX_SAMPLE_BUFFER; i++)
> > +                       __free_dup_event(oe, buffer->event[i].event);
> > +       }
> > +
> I have a problem with this one, given that the buffer->event[] is
> never actually zeroed.
> So what happens if you do not use all the entries by the time you have to free?
> I think one way to avoid this is by iterating only all the way to
> oe->buffer_idx.

right, please check attached patch

thanks,
jirka


---
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index bad9e0296e9a..7a9707301f17 100644
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
+         * We maintain following scheme of buffers for ordered
+         * event allocation:
+         *
+         *   to_free list -> buffer1 (64K)
+         *                   buffer2 (64K)
+         *                   ...
+         *
+         * Each buffer keeps an array of ordered events objects:
+         *    buffer -> event[0]
+         *              event[1]
+         *              ...
+         *
+         * Each allocated ordered event is linked to one of
+         * following lists:
+         *   - time ordered list 'events'
+         *   - list of currently removed events 'cache'
+         *
+         * Allocation of the ordered event uses following order
+         * to get the memory:
+         *   - use recently removed object from 'cache' list
+         *   - use available object in current allocation buffer
+         *   - allocate new buffer if the current buffer is full
+         *
+         * Removal of ordered event object moves it from events to
+         * the cache list.
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
@@ -122,9 +156,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
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
@@ -300,15 +333,35 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
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
