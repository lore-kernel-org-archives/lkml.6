Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F34F21A80
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbfBOOVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:21:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfBOOVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:21:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1DA5222A1;
        Fri, 15 Feb 2019 14:21:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gueMc-0006Au-47; Fri, 15 Feb 2019 09:21:14 -0500
Message-Id: <20190215142114.009774813@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 15 Feb 2019 09:20:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, stable@vger.kernel.org,
        Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH 2/2] tracing: Fix number of entries in trace header
References: <20190215142015.860423791@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Perret <quentin.perret@arm.com>

The following commit

  441dae8f2f29 ("tracing: Add support for display of tgid in trace output")

removed the call to print_event_info() from print_func_help_header_irq()
which results in the ftrace header not reporting the number of entries
written in the buffer. As this wasn't the original intent of the patch,
re-introduce the call to print_event_info() to restore the orginal
behaviour.

Link: http://lkml.kernel.org/r/20190214152950.4179-1-quentin.perret@arm.com

Acked-by: Joel Fernandes <joelaf@google.com>
Cc: stable@vger.kernel.org
Fixes: 441dae8f2f29 ("tracing: Add support for display of tgid in trace output")
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c521b7347482..c4238b441624 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3384,6 +3384,8 @@ static void print_func_help_header_irq(struct trace_buffer *buf, struct seq_file
 	const char tgid_space[] = "          ";
 	const char space[] = "  ";
 
+	print_event_info(buf, m);
+
 	seq_printf(m, "#                          %s  _-----=> irqs-off\n",
 		   tgid ? tgid_space : space);
 	seq_printf(m, "#                          %s / _----=> need-resched\n",
-- 
2.20.1


