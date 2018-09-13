Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17028C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC60C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC60C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIMMy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:54:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeIMMy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:54:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79EBB309174E;
        Thu, 13 Sep 2018 07:46:09 +0000 (UTC)
Received: from krava (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id C5A43608E7;
        Thu, 13 Sep 2018 07:46:07 +0000 (UTC)
Date:   Thu, 13 Sep 2018 09:46:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] perf: Prevent recursion in ring buffer
Message-ID: <20180913074607.GB15173@krava>
References: <20180912193317.10339-1-jolsa@kernel.org>
 <20180913070740.GT24124@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913070740.GT24124@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 13 Sep 2018 07:46:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 09:07:40AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 12, 2018 at 09:33:17PM +0200, Jiri Olsa wrote:
> > Some of the scheduling tracepoints allow the perf_tp_event
> > code to write to ring buffer under different cpu than the
> > code is running on.
> 
> ARGH.. that is indeed borken.
> 
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 4a9937076331..0c976ac414c5 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -101,6 +101,7 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
> >  
> >  out:
> >  	preempt_enable();
> > +	atomic_set(&rb->recursion, 0);
> >  }
> >  
> >  static __always_inline bool
> > @@ -145,6 +146,12 @@ __perf_output_begin(struct perf_output_handle *handle,
> >  		goto out;
> >  	}
> >  
> > +	if (atomic_cmpxchg(&rb->recursion, 0, 1) != 0) {
> > +		if (rb->nr_pages)
> > +			local_inc(&rb->lost);
> > +		goto out;
> > +	}
> > +
> >  	handle->rb    = rb;
> >  	handle->event = event;
> >  
> > @@ -286,6 +293,7 @@ ring_buffer_init(struct ring_buffer *rb, long watermark, int flags)
> >  		rb->overwrite = 1;
> >  
> >  	atomic_set(&rb->refcount, 1);
> > +	atomic_set(&rb->recursion, 0);
> >  
> >  	INIT_LIST_HEAD(&rb->event_list);
> >  	spin_lock_init(&rb->event_lock);
> 
> That's not a recursion count, that's a test-and-set spinlock, and you
> got the memory ordering wrong for that.
> 
> Also, we tried very hard to avoid atomic ops in the ring-buffer and you
> just wrecked that. Worse, you wrecked previously working interrupt
> nesting output.
> 
> Let me have a look at this.

I was first thinking to just leave it on the current cpu,
but not sure current users would be ok with that ;-)

jirka


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abaed4f8bb7f..9b534a2ecf17 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8308,6 +8308,8 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 				continue;
 			if (event->attr.config != entry->type)
 				continue;
+			if (event->cpu != smp_processor_id())
+				continue;
 			if (perf_tp_event_match(event, &data, regs))
 				perf_swevent_event(event, count, &data, regs);
 		}
