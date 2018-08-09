Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1F8C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8CC21C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8CC21C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbeHIKbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:31:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727768AbeHIKbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:31:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E72540241DF;
        Thu,  9 Aug 2018 08:07:24 +0000 (UTC)
Received: from krava (unknown [10.40.205.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id D8E872026D68;
        Thu,  9 Aug 2018 08:07:22 +0000 (UTC)
Date:   Thu, 9 Aug 2018 10:07:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com,
        peterz@infradead.org, mingo@elte.hu
Subject: Re: [PATCH v2] perf ordered_events: fix crash in free_dup_event()
Message-ID: <20180809080721.GB19243@krava>
References: <1533767600-7794-1-git-send-email-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533767600-7794-1-git-send-email-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 09 Aug 2018 08:07:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 09 Aug 2018 08:07:24 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 03:33:20PM -0700, Stephane Eranian wrote:
> This patch fixes a bug in ordered_event.c:alloc_event().
> An ordered_event struct was not initialized properly potentially
> causing crashes later on in free_dup_event() depending on the
> content of the memory. If it was NULL, then it would work fine,
> otherwise, it could cause crashes such as:

I'm now little puzzled what do we use this first event for..
I can't see anything special about it, other than it's added
on the list uninitialized ;-)

it seems to work properly when we ditch it.. might be some
prehistoric leftover or I'm terribly missing something

thanks,
jirka


---
diff --cc tools/perf/util/ordered-events.c
index bad9e0296e9a,0e837b0b8582..000000000000
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@@ -119,12 -119,8 +119,9 @@@ static struct ordered_event *alloc_even
  		pr("alloc size %" PRIu64 "B (+%zu), max %" PRIu64 "B\n",
  		   oe->cur_alloc_size, size, oe->max_alloc_size);
  
 +		oe->cur_alloc_size += size;
- 		list_add(&oe->buffer->list, &oe->to_free);
- 
- 		/* First entry is abused to maintain the to_free list. */
- 		oe->buffer_idx = 2;
- 		new = oe->buffer + 1;
+ 		oe->buffer_idx = 1;
+ 		new = oe->buffer;
  	} else {
  		pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
  	}
