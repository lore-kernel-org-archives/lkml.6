Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1DBC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632FB2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632FB2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbeIFSEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:04:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45514 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728699AbeIFSEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:04:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA96F5A745;
        Thu,  6 Sep 2018 13:29:04 +0000 (UTC)
Received: from krava (unknown [10.43.17.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5F65A2027EA0;
        Thu,  6 Sep 2018 13:29:03 +0000 (UTC)
Date:   Thu, 6 Sep 2018 15:28:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCHv3] perf tools: Add struct ordered_events_buffer layer
Message-ID: <20180906132859.GA9577@krava>
References: <CABPqkBQEfoMDEqot1VbgExg1fU3+EEunzZqDFKSGmLKBhxNkwA@mail.gmail.com>
 <20180810115431.GA4162@krava>
 <20180813130446.GA8685@krava>
 <CABPqkBSgYEFFAkddBqZbYXe9tjUY7RbMBjQsZht8ki1iOR6unw@mail.gmail.com>
 <20180815084825.GD3180@krava>
 <20180827092818.GA3725@krava>
 <CABPqkBQS+QG1jjzMU=wpuOJXD5A8iiPj3fNZoHSsPep7rfEQow@mail.gmail.com>
 <20180827170543.GA31347@krava>
 <20180902144738.GA28012@krava>
 <CABPqkBTiDYm_pbFdbQCiNTpECVpWyOb16vBFC7AZ=vzqcR=2ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTiDYm_pbFdbQCiNTpECVpWyOb16vBFC7AZ=vzqcR=2ig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 06 Sep 2018 13:29:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 06 Sep 2018 13:29:04 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 07:37:56PM -0700, Stephane Eranian wrote:

SNIP

> 
> I think the code is correct now for the issue related to uninitialized pointer.
> But there is still one problem I found stressing the code with max_alloc_size.
> The way the following is written:
> 
>        if (!list_empty(cache)) {
>                 new = list_entry(cache->next, struct ordered_event, list);
>                 list_del(&new->list);
>         } else if (oe->buffer) {
>                 new = oe->buffer + oe->buffer_idx;
>                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
>                         oe->buffer = NULL;
>         } else if (oe->cur_alloc_size < oe->max_alloc_size) {
>                 size_t size = sizeof(*oe->buffer) MAX_SAMPLE_BUFFER *
> sizeof(*new);
> 
>                 oe->buffer = malloc(size);
>                 if (!oe->buffer) {
>                         free_dup_event(oe, new_event);
>                         return NULL;
>                 }
> 
>                 pr("alloc size %" PRIu64 "B (+%zu), max %" PRIu64 "B\n",
>                    oe->cur_alloc_size, size, oe->max_alloc_size);
> 
>                 oe->cur_alloc_size += size;
> 
> You can end up with oe->cur_alloc_size > oe->max_alloc_size in case
> the max limit is
> really low (< size_t size = sizeof (*oe->buffer) + MAX_SAMPLE_BUFFER *
> sizeof(*new);
> So I think to make sure you can never allocate more than the max, you
> have to do:
> 
>       size_t size = sizeof(*oe->buffer) MAX_SAMPLE_BUFFER * sizeof(*new);
>        if (!list_empty(cache)) {
>                 new = list_entry(cache->next, struct ordered_event, list);
>                 list_del(&new->list);
>         } else if (oe->buffer) {
>                 new = oe->buffer + oe->buffer_idx;
>                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
>                         oe->buffer = NULL;
>         } else if ((oe->cur_alloc_size + size) < oe->max_alloc_size) {
> 
> Then you will never allocate more than the max.
> I think with this change, we are okay.
> Tested-by: Stephane Eranian <eranian@google.com>

yep, makes sense.. something like below then
I'll post it on top of the previous patch

thanks,
jirka


---
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
