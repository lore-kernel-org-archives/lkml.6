Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB53C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA0320832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA0320832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeK2G6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:58:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbeK2G6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:58:41 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E7720864;
        Wed, 28 Nov 2018 19:55:53 +0000 (UTC)
Date:   Wed, 28 Nov 2018 14:55:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Slavomir Kaslev <kaslevs@vmware.com>
Subject: [PATCH] tools/lib/traceevent: Add sanity check to
 is_timestamp_in_us()
Message-ID: <20181128145552.68c4f87b@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch adds a sanity check to is_timestamp_in_us() input
parameter trace_clock. It avoids a potential segfault in this
function for the case trace_clock is NULL.

Reported-by: Slavomir Kaslev <kaslevs@vmware.com>
Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 3692f29fee46..c383305510b4 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5409,7 +5409,7 @@ void tep_event_info(struct trace_seq *s, struct tep_event_format *event,
 
 static bool is_timestamp_in_us(char *trace_clock, bool use_trace_clock)
 {
-	if (!use_trace_clock)
+	if (!trace_clock || !use_trace_clock)
 		return true;
 
 	if (!strcmp(trace_clock, "local") || !strcmp(trace_clock, "global")
-- 
2.19.1

