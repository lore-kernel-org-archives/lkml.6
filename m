Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA94AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617EE208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617EE208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeH0OyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:54:02 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:55285 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726785AbeH0OyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:54:02 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 27 Aug 2018 20:07:47 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.126 with ESMTP; 27 Aug 2018 20:07:47 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 27 Aug 2018 20:07:47 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        kernel-team@lge.com
Subject: Re: [PATCHv2] perf tools: Add struct ordered_events_buffer layer
Message-ID: <20180827110747.GD8065@sejong>
References: <1533767600-7794-1-git-send-email-eranian@google.com>
 <20180809080721.GB19243@krava>
 <CABPqkBQEfoMDEqot1VbgExg1fU3+EEunzZqDFKSGmLKBhxNkwA@mail.gmail.com>
 <20180810115431.GA4162@krava>
 <20180813130446.GA8685@krava>
 <CABPqkBSgYEFFAkddBqZbYXe9tjUY7RbMBjQsZht8ki1iOR6unw@mail.gmail.com>
 <20180815084825.GD3180@krava>
 <20180827092818.GA3725@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827092818.GA3725@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:28:18AM +0200, Jiri Olsa wrote:

> When ordering events, we use preallocated buffers to store separated
> events. Those buffers currently don't have their own struct, but since
> they are basically array of 'struct ordered_event' objects, we use the
> first event to hold buffers data - list head, that holds all buffers
> together:
> 
>    struct ordered_events {
>      ...
>      struct ordered_event *buffer;
>      ...
>    };
> 
>    struct ordered_event {
>      u64               timestamp;
>      u64               file_offset;
>      union perf_event  *event;
>      struct list_head  list;
>    };
> 
> This is quite convoluted and error prone as demonstrated by
> free-ing issue discovered and fixed by Stephane in here [1].
> 
> This patch adds the 'struct ordered_events_buffer' object,
> that holds the buffer data and frees it up properly.
> 
> [1] - https://marc.info/?l=linux-kernel&m=153376761329335&w=2
> 
> Reported-by: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/n/tip-qrkcqm5m1sugy4q83pfn5a1r@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/ordered-events.c | 82 +++++++++++++++++++++++++++-----
>  tools/perf/util/ordered-events.h | 37 +++++++-------
>  2 files changed, 90 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index bad9e0296e9a..3672060508a7 100644
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@ -80,14 +80,20 @@ static union perf_event *dup_event(struct ordered_events *oe,
>  	return oe->copy_on_queue ? __dup_event(oe, event) : event;
>  }
>  
> -static void free_dup_event(struct ordered_events *oe, union perf_event *event)
> +static void __free_dup_event(struct ordered_events *oe, union perf_event *event)
>  {
> -	if (event && oe->copy_on_queue) {
> +	if (event) {
>  		oe->cur_alloc_size -= event->header.size;
>  		free(event);
>  	}
>  }
>  
> +static void free_dup_event(struct ordered_events *oe, union perf_event *event)
> +{
> +	if (oe->copy_on_queue)
> +		__free_dup_event(oe, event);
> +}
> +
>  #define MAX_SAMPLE_BUFFER	(64 * 1024 / sizeof(struct ordered_event))
>  static struct ordered_event *alloc_event(struct ordered_events *oe,
>  					 union perf_event *event)
> @@ -100,15 +106,43 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
>  	if (!new_event)
>  		return NULL;
>  
> +	/*
> +	 * We maintain following scheme of buffers for ordered
> +	 * event allocation:
> +	 *
> +	 *   to_free list -> buffer1 (64K)
> +	 *                   buffer2 (64K)
> +	 *                   ...
> +	 *
> +	 * Each buffer keeps an array of ordered events objects:
> +	 *    buffer -> event[0]
> +	 *              event[1]
> +	 *              ...
> +	 *
> +	 * Each allocated ordered event is linked to one of
> +	 * following lists:
> +	 *   - time ordered list 'events'
> +	 *   - list of currently removed events 'cache'
> +	 *
> +	 * Allocation of the ordered event uses following order
> +	 * to get the memory:
> +	 *   - use recently removed object from 'cache' list
> +	 *   - use available object in current allocation buffer
> +	 *   - allocate new buffer if the current buffer is full
> +	 *
> +	 * Removal of ordered event object moves it from events to
> +	 * the cache list.
> +	 */
>  	if (!list_empty(cache)) {
>  		new = list_entry(cache->next, struct ordered_event, list);
>  		list_del(&new->list);
>  	} else if (oe->buffer) {
> -		new = oe->buffer + oe->buffer_idx;
> +		new = &oe->buffer->event[oe->buffer_idx];
>  		if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
>  			oe->buffer = NULL;
>  	} else if (oe->cur_alloc_size < oe->max_alloc_size) {
> -		size_t size = MAX_SAMPLE_BUFFER * sizeof(*new);
> +		size_t size = sizeof(*oe->buffer) +
> +			      MAX_SAMPLE_BUFFER * sizeof(*new);
>  
>  		oe->buffer = malloc(size);
>  		if (!oe->buffer) {
> @@ -122,9 +156,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
>  		oe->cur_alloc_size += size;
>  		list_add(&oe->buffer->list, &oe->to_free);
>  
> -		/* First entry is abused to maintain the to_free list. */
> -		oe->buffer_idx = 2;
> -		new = oe->buffer + 1;
> +		oe->buffer_idx = 1;
> +		new = &oe->buffer->event[0];
>  	} else {
>  		pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
>  	}
> @@ -300,15 +333,38 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
>  	oe->deliver	   = deliver;
>  }
>  
> +static void
> +ordered_events_buffer__free(struct ordered_events_buffer *buffer,
> +			    unsigned int max, struct ordered_events *oe)
> +{
> +	if (oe->copy_on_queue) {
> +		unsigned int i;
> +
> +		for (i = 0; i < max; i++)
> +			__free_dup_event(oe, buffer->event[i].event);
> +	}
> +
> +	free(buffer);
> +}
> +
>  void ordered_events__free(struct ordered_events *oe)
>  {
> -	while (!list_empty(&oe->to_free)) {
> -		struct ordered_event *event;
> +	struct ordered_events_buffer *buffer, *tmp;
>  
> -		event = list_entry(oe->to_free.next, struct ordered_event, list);
> -		list_del(&event->list);
> -		free_dup_event(oe, event->event);
> -		free(event);
> +	if (list_empty(&oe->to_free))
> +		return;
> +
> +	/*
> +	 * Current buffer might not have all the events allocated
> +	 * yet, we need to free only allocated ones ...
> +	 */
> +	list_del(&oe->buffer->list);
> +	ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
> +
> +	/* ... and continue with the rest */
> +	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
> +		list_del(&buffer->list);
> +		ordered_events_buffer__free(buffer, MAX_SAMPLE_BUFFER, oe);
>  	}
>  }
>  
> diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
> index 8c7a2948593e..1338d5c345dc 100644
> --- a/tools/perf/util/ordered-events.h
> +++ b/tools/perf/util/ordered-events.h
> @@ -25,23 +25,28 @@ struct ordered_events;
>  typedef int (*ordered_events__deliver_t)(struct ordered_events *oe,
>  					 struct ordered_event *event);
>  
> +struct ordered_events_buffer {
> +	struct list_head	list;
> +	struct ordered_event	event[0];
> +};
> +
>  struct ordered_events {
> -	u64			last_flush;
> -	u64			next_flush;
> -	u64			max_timestamp;
> -	u64			max_alloc_size;
> -	u64			cur_alloc_size;
> -	struct list_head	events;
> -	struct list_head	cache;
> -	struct list_head	to_free;
> -	struct ordered_event	*buffer;
> -	struct ordered_event	*last;
> -	ordered_events__deliver_t deliver;
> -	int			buffer_idx;
> -	unsigned int		nr_events;
> -	enum oe_flush		last_flush_type;
> -	u32			nr_unordered_events;
> -	bool                    copy_on_queue;
> +	u64				 last_flush;
> +	u64				 next_flush;
> +	u64				 max_timestamp;
> +	u64				 max_alloc_size;
> +	u64				 cur_alloc_size;
> +	struct list_head		 events;
> +	struct list_head		 cache;
> +	struct list_head		 to_free;
> +	struct ordered_events_buffer	*buffer;
> +	struct ordered_event		*last;
> +	ordered_events__deliver_t	 deliver;
> +	int				 buffer_idx;
> +	unsigned int			 nr_events;
> +	enum oe_flush			 last_flush_type;
> +	u32				 nr_unordered_events;
> +	bool				 copy_on_queue;
>  };
>  
>  int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
> -- 
> 2.17.1
> 
