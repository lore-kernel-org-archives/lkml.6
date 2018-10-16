Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7372EC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF9E2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF9E2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeJPSxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:53:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbeJPSxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:53:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00E0286668;
        Tue, 16 Oct 2018 11:03:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 49E746248C;
        Tue, 16 Oct 2018 11:03:42 +0000 (UTC)
Date:   Tue, 16 Oct 2018 13:03:41 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [BUG] perf stat: hangs with -p and process completes
Message-ID: <20181016110341.GB18450@krava>
References: <CABPqkBTEOwKrq6ZJo3W-rZQi56OWorWo3VcOTwV17QxZBckS0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTEOwKrq6ZJo3W-rZQi56OWorWo3VcOTwV17QxZBckS0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 16 Oct 2018 11:03:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 02:26:09PM -0700, Stephane Eranian wrote:
> Hi,
> 
> I am running into a perf stat issue with the -p option which allows you
> to attach to a running process. If that process happens to terminate
> while under monitoring
> perf hangs in there and never terminates. The proper behavior would be to stop.
> I can see the issue in that the attached process is not a child, so
> wait() would not work.
> 
> To reproduce:
>   $ sleep 10 &
>   $ perf stat -p $!
> 
> doing the same with perf record works, so there is a solution to this problem.

yea, we don't poll for the event state change in perf stat,
but we do that in perf record.. also because the perf poll
code in kernel is originaly meant for tracking the ring
buffer state

maybe we could return EPOLLIN for alive events without ring
buffer.. like below (totaly untested) and add polling for 
event state into perf stat 

cc-ing perf folks

jirka


---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a97f34bc14c..b9ee7e7803bf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4865,12 +4865,12 @@ static __poll_t perf_poll(struct file *file, poll_table *wait)
 {
 	struct perf_event *event = file->private_data;
 	struct ring_buffer *rb;
-	__poll_t events = EPOLLHUP;
+	__poll_t events = EPOLLIN;
 
 	poll_wait(file, &event->waitq, wait);
 
 	if (is_event_hup(event))
-		return events;
+		return EPOLLHUP;
 
 	/*
 	 * Pin the event->rb by taking event->mmap_mutex; otherwise
