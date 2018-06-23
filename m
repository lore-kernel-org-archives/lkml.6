Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10397C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAD624A76
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAD624A76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934588AbeFWBVK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933841AbeFWBVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:21:06 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 100EC24A6C;
        Sat, 23 Jun 2018 01:21:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fWXEf-0008Q9-33; Fri, 22 Jun 2018 21:21:05 -0400
Message-Id: <20180623012104.986961735@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 22 Jun 2018 21:20:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, air icy <icytxw@gmail.com>
Subject: [PATCH 1/5] tracing: Check for no filter when processing event filters
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0001-tracing-Check-for-no-filter-when-processing-event-fi.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The syzkaller detected a out-of-bounds issue with the events filter code,
specifically here:

	prog[N].pred = NULL;					/* #13 */
	prog[N].target = 1;		/* TRUE */
	prog[N+1].pred = NULL;
	prog[N+1].target = 0;		/* FALSE */
->	prog[N-1].target = N;
	prog[N-1].when_to_branch = false;

As that's the first reference to a "N-1" index, it appears that the code got
here with N = 0, which means the filter parser found no filter to parse
(which shouldn't ever happen, but apparently it did).

Add a new error to the parsing code that will check to make sure that N is
not zero before going into this part of the code. If N = 0, then -EINVAL is
returned, and a error message is added to the filter.

Cc: stable@vger.kernel.org
Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
Reported-by: air icy <icytxw@gmail.com>
bugzilla url: https://bugzilla.kernel.org/show_bug.cgi?id=200019
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index e1c818dbc0d7..0dceb77d1d42 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -78,7 +78,8 @@ static const char * ops[] = { OPS };
 	C(TOO_MANY_PREDS,	"Too many terms in predicate expression"), \
 	C(INVALID_FILTER,	"Meaningless filter expression"),	\
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
-	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"),
+	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
+	C(NO_FILTER,		"No filter found"),
 
 #undef C
 #define C(a, b)		FILT_ERR_##a
@@ -550,6 +551,13 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 		goto out_free;
 	}
 
+	if (!N) {
+		/* No program? */
+		ret = -EINVAL;
+		parse_error(pe, FILT_ERR_NO_FILTER, ptr - str);
+		goto out_free;
+	}
+
 	prog[N].pred = NULL;					/* #13 */
 	prog[N].target = 1;		/* TRUE */
 	prog[N+1].pred = NULL;
-- 
2.17.1


