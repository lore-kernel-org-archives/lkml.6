Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0C6C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DFC24011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14DFC24011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932455AbeGFBGo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932362AbeGFBGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:06:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46791240C0;
        Fri,  6 Jul 2018 01:06:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fbFCo-0007IG-BW; Thu, 05 Jul 2018 21:06:38 -0400
Message-Id: <20180706010638.254195015@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Jul 2018 21:06:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/6] tracing: Make create_filter() code match the comments
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The comment in create_filter() states that the passed in filter pointer
(filterp) will either be NULL or contain an error message stating why the
filter failed. But it also expects the filter pointer to point to NULL when
passed in. If it is not, the function create_filter_start() will warn and
return an error message without updating the filter pointer. This is not
what the comment states.

As we always expect the pointer to point to NULL, if it is not, trigger a
WARN_ON(), set it to NULL, and then continue the path as the rest will work
as the comment states. Also update the comment to state it must point to
NULL.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 0dceb77d1d42..893a206bcba4 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1701,6 +1701,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
  * @filter_str: filter string
  * @set_str: remember @filter_str and enable detailed error in filter
  * @filterp: out param for created filter (always updated on return)
+ *           Must be a pointer that references a NULL pointer.
  *
  * Creates a filter for @call with @filter_str.  If @set_str is %true,
  * @filter_str is copied and recorded in the new filter.
@@ -1718,6 +1719,10 @@ static int create_filter(struct trace_event_call *call,
 	struct filter_parse_error *pe = NULL;
 	int err;
 
+	/* filterp must point to NULL */
+	if (WARN_ON(*filterp))
+		*filterp = NULL;
+
 	err = create_filter_start(filter_string, set_str, &pe, filterp);
 	if (err)
 		return err;
-- 
2.17.1


