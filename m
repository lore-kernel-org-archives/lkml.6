Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458F3C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76E621A1C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76E621A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeHKQ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbeHKQYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D186921A74;
        Sat, 11 Aug 2018 13:50:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHW-0006B0-Sj; Sat, 11 Aug 2018 09:50:14 -0400
Message-Id: <20180811135014.791024195@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:49:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 21/34] tracing: Make tracer_tracing_is_on() return bool
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

There's code that expects tracer_tracing_is_on() to be either true or false,
not some random number. Currently, it should only return one or zero, but
just in case, change its return value to bool, to enforce it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2378bb4f1442..2dad27809794 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1087,7 +1087,7 @@ void disable_trace_on_warning(void)
  *
  * Shows real state of the ring buffer if it is enabled or not.
  */
-int tracer_tracing_is_on(struct trace_array *tr)
+bool tracer_tracing_is_on(struct trace_array *tr)
 {
 	if (tr->trace_buffer.buffer)
 		return ring_buffer_record_is_on(tr->trace_buffer.buffer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e1c8a1d6f240..d88cd9bb72f4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -594,7 +594,7 @@ void tracing_reset_current(int cpu);
 void tracing_reset_all_online_cpus(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
-int tracer_tracing_is_on(struct trace_array *tr);
+bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
 void tracer_tracing_off(struct trace_array *tr);
 struct dentry *trace_create_file(const char *name,
-- 
2.18.0


