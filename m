Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6922C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EB6219DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EB6219DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388850AbeHGJdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:33:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727360AbeHGJdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:33:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 827377C6CA;
        Tue,  7 Aug 2018 07:20:31 +0000 (UTC)
Received: from krava (unknown [10.43.17.214])
        by smtp.corp.redhat.com (Postfix) with SMTP id 47CD1112D19D;
        Tue,  7 Aug 2018 07:20:30 +0000 (UTC)
Date:   Tue, 7 Aug 2018 09:20:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com,
        peterz@infradead.org, mingo@elte.hu
Subject: Re: [PATCH] perf ordered_events: fix crash in free_dup_event()
Message-ID: <20180807072029.GA7716@krava>
References: <1533605015-19514-1-git-send-email-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533605015-19514-1-git-send-email-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 07 Aug 2018 07:20:31 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 07 Aug 2018 07:20:31 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 06:23:35PM -0700, Stephane Eranian wrote:
> Depending on memory allocations, it was possible to get a SEGFAULT in
> free_dup_event() because the event pointer was bogus:
> 
> perf[1354]: segfault at ffffffff00000006 ip 00000000004b7fc7

is there any reproducer?

> 
> Initially, I thought it was some double free. But it turns out
> it looked more like a buffer overrun. Adding padding before
> the union perf_event field in struct ordered_event avoided the
> problem. But it was not obvious where this could be coming from
> given the accesses to the struct, i.e.,  no internal array.
> 
> Then, it struck me that the following was bogus in __dup_event():
> 
>  __dup_event(struct ordered_events *oe, union perf_event *event)
> {
>    ...
>    union perf_event *new_event;
>    new_event = memdup(event, event->header.size);
>    ...
> }
> 
> The problem here is that header.size <= sizeof(*new_event). The code
> was trying to copy only what was necessary, but then, the allocation

hum, and I think we should continue to do so.. we can't allocate ~4000
bytes space for 30 bytes sample

> was also only partial. In other words if the event was not the largest
> possible for the union, it would not be fully backed by memory, likely
> causing troubles.

how? using that event allocated space for another type of event?

> 
> This patch fixes the problem by passing the size of the union and not
> that of the actual event.

I think that's just bypassing the real issue, please share more details
on how to reproduce this

thanks,
jirka

> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> 
> ---
>  tools/perf/util/ordered-events.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index bad9e0296e9a..a90dbe5df019 100644
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@ -66,9 +66,9 @@ static union perf_event *__dup_event(struct ordered_events *oe,
>  	union perf_event *new_event = NULL;
>  
>  	if (oe->cur_alloc_size < oe->max_alloc_size) {
> -		new_event = memdup(event, event->header.size);
> +		new_event = memdup(event, sizeof(*event));
>  		if (new_event)
> -			oe->cur_alloc_size += event->header.size;
> +			oe->cur_alloc_size += sizeof(*event);
>  	}
>  
>  	return new_event;
> -- 
> 2.18.0.597.ga71716f1ad-goog
> 
