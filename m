Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F46C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438D620871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438D620871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbeKLGYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:24:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49984 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730207AbeKLFsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:13 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0000oG-T6; Sun, 11 Nov 2018 19:58:44 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsY-0001mk-EA; Sun, 11 Nov 2018 19:58:42 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.948961143@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 296/366] tracing: Fix possible double free in
 event_enable_trigger_func()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

commit 15cc78644d0075e76d59476a4467e7143860f660 upstream.

There was a case that triggered a double free in event_trigger_callback()
due to the called reg() function freeing the trigger_data and then it
getting freed again by the error return by the caller. The solution there
was to up the trigger_data ref count.

Code inspection found that event_enable_trigger_func() has the same issue,
but is not as easy to trigger (requires harder to trigger failures). It
needs to be solved slightly different as it needs more to clean up when the
reg() function fails.

Link: http://lkml.kernel.org/r/20180725124008.7008e586@gandalf.local.home

Fixes: 7862ad1846e99 ("tracing: Add 'enable_event' and 'disable_event' event trigger commands")
Reivewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/trace/trace_events_trigger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1231,6 +1231,9 @@ event_enable_trigger_func(struct event_c
 		goto out;
 	}
 
+	/* Up the trigger_data count to make sure nothing frees it on failure */
+	event_trigger_init(trigger_ops, trigger_data);
+
 	if (trigger) {
 		number = strsep(&trigger, ":");
 
@@ -1281,6 +1284,7 @@ event_enable_trigger_func(struct event_c
 		goto out_disable;
 	/* Just return zero, not the number of enabled functions */
 	ret = 0;
+	event_trigger_free(trigger_ops, trigger_data);
  out:
 	return ret;
 
@@ -1291,7 +1295,7 @@ event_enable_trigger_func(struct event_c
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
-	kfree(trigger_data);
+	event_trigger_free(trigger_ops, trigger_data);
 	kfree(enable_data);
 	goto out;
 }

