Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFE2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5338220675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfAPVe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:34:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbfAPVe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:34:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93EDA369C9;
        Wed, 16 Jan 2019 21:34:27 +0000 (UTC)
Received: from krava (ovpn-204-68.brq.redhat.com [10.40.204.68])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5198B5D9CA;
        Wed, 16 Jan 2019 21:34:26 +0000 (UTC)
Date:   Wed, 16 Jan 2019 22:34:25 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, acme@kernel.org
Subject: Re: perf segfault in in ordered_events__free()
Message-ID: <20190116213425.GA16366@krava>
References: <CAPhsuW4EiGUo=p=KYsu+kGWVFRoxEjF3Bq_32QvakQjCsAAjFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4EiGUo=p=KYsu+kGWVFRoxEjF3Bq_32QvakQjCsAAjFQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 16 Jan 2019 21:34:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:57:49AM -0800, Song Liu wrote:
> Hi,
> 
> We are debugging a segfault of perf in ordered_events__free().

hi,
any backtrace or info on how to reproduce it?

> Disassemble shows the segfault was caused by oe->buff == NULL
> in the following line:
> 
>         /*
>          * Current buffer might not have all the events allocated
>          * yet, we need to free only allocated ones ...
>          */
>         list_del(&oe->buffer->list);
> 
> After poking around the code, I suspect it is caused by the following
> condition in alloc_event():
> 
>         } else if (oe->buffer) {
>                 new = &oe->buffer->event[oe->buffer_idx];
>                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
>                         oe->buffer = NULL;


argh.. yea, we need to check oe->buffer in ordered_events__free

would attached change fix it for you?

thanks,
jirka


---
diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 897589507d97..ea523d3b248f 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -391,8 +391,10 @@ void ordered_events__free(struct ordered_events *oe)
 	 * Current buffer might not have all the events allocated
 	 * yet, we need to free only allocated ones ...
 	 */
-	list_del(&oe->buffer->list);
-	ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	if (oe->buffer) {
+		list_del(&oe->buffer->list);
+		ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	}
 
 	/* ... and continue with the rest */
 	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
