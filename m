Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB20CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990D020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990D020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeLJUmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbeLJUmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:42:35 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC8B2086D;
        Mon, 10 Dec 2018 20:42:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gWSNt-0003k0-R8; Mon, 10 Dec 2018 15:42:33 -0500
Message-Id: <20181210204233.752634083@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Dec 2018 15:41:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 2/2] tracing: Fix memory leak in set_trigger_filter()
References: <20181210204126.603121253@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When create_event_filter() fails in set_trigger_filter(), the filter may
still be allocated and needs to be freed. The caller expects the
data->filter to be updated with the new filter, even if the new filter
failed (we could add an error message by setting set_str parameter of
create_event_filter(), but that's another update).

But because the error would just exit, filter was left hanging and
nothing could free it.

Found by kmemleak detector.

Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: stable@vger.kernel.org
Fixes: bac5fb97a173a ("tracing: Add and use generic set_trigger_filter() implementation")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 2152d1e530cb..cd12ecb66eb9 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -732,8 +732,10 @@ int set_trigger_filter(char *filter_str,
 
 	/* The filter is for the 'trigger' event, not the triggered event */
 	ret = create_event_filter(file->event_call, filter_str, false, &filter);
-	if (ret)
-		goto out;
+	/*
+	 * If create_event_filter() fails, filter still needs to be freed.
+	 * Which the calling code will do with data->filter.
+	 */
  assign:
 	tmp = rcu_access_pointer(data->filter);
 
-- 
2.19.1


