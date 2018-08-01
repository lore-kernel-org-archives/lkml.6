Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3469C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB460208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB460208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732754AbeHAT7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:59:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389715AbeHATIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B171B1330;
        Wed,  1 Aug 2018 17:12:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.14 014/246] tracing: Fix possible double free in event_enable_trigger_func()
Date:   Wed,  1 Aug 2018 18:48:44 +0200
Message-Id: <20180801165012.385193023@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

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

Cc: stable@vger.kernel.org
Fixes: 7862ad1846e99 ("tracing: Add 'enable_event' and 'disable_event' event trigger commands")
Reivewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_trigger.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1396,6 +1396,9 @@ int event_enable_trigger_func(struct eve
 		goto out;
 	}
 
+	/* Up the trigger_data count to make sure nothing frees it on failure */
+	event_trigger_init(trigger_ops, trigger_data);
+
 	if (trigger) {
 		number = strsep(&trigger, ":");
 
@@ -1446,6 +1449,7 @@ int event_enable_trigger_func(struct eve
 		goto out_disable;
 	/* Just return zero, not the number of enabled functions */
 	ret = 0;
+	event_trigger_free(trigger_ops, trigger_data);
  out:
 	return ret;
 
@@ -1456,7 +1460,7 @@ int event_enable_trigger_func(struct eve
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
-	kfree(trigger_data);
+	event_trigger_free(trigger_ops, trigger_data);
 	kfree(enable_data);
 	goto out;
 }


