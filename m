Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8240AC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF1D22392
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF1D22392
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeHIXdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727408AbeHIXdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:33:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697E222398;
        Thu,  9 Aug 2018 21:06:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fns91-0001TA-Bv; Thu, 09 Aug 2018 17:06:55 -0400
Message-Id: <20180809210655.269320609@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 09 Aug 2018 17:03:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        joel@joelfernandes.org, stable@vger.kernel.org
Subject: [for-next][PATCH 6/6] uprobes: Use synchronize_rcu() not synchronize_sched()
References: <20180809210333.588854137@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

While debugging another bug, I was looking at all the synchronize*()
functions being used in kernel/trace, and noticed that trace_uprobes was
using synchronize_sched(), with a comment to synchronize with
{u,ret}_probe_trace_func(). When looking at those functions, the data is
protected with "rcu_read_lock()" and not with "rcu_read_lock_sched()". This
is using the wrong synchronize_*() function.

Cc: stable@vger.kernel.org
Fixes: 70ed91c6ec7f8 ("tracing/uprobes: Support ftrace_event_file base multibuffer")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index bf89a51e740d..ac02fafc9f1b 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -952,7 +952,7 @@ probe_event_disable(struct trace_uprobe *tu, struct trace_event_file *file)
 
 		list_del_rcu(&link->list);
 		/* synchronize with u{,ret}probe_trace_func */
-		synchronize_sched();
+		synchronize_rcu();
 		kfree(link);
 
 		if (!list_empty(&tu->tp.files))
-- 
2.18.0


