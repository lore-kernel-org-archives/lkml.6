Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC24DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8F020821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8F020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeLJTdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbeLJTdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:33:36 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1DB2084C;
        Mon, 10 Dec 2018 19:33:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gWRJ8-0002qF-Q3; Mon, 10 Dec 2018 14:33:34 -0500
Message-Id: <20181210193334.710041488@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 10 Dec 2018 14:30:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/6] fgraph: Add comment to describe ftrace_graph_get_ret_stack
References: <20181210193007.655970639@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ret_stack should not be accessed directly via the curr_ret_stack
variable on the task_struct. This is because the ret_stack is going to be
converted into a series of longs and not an array of ret_stack structures.
The way that a ret_stack should be retrieved is via the
ftrace_graph_get_ret_stack structure, but it needs to be documented on how
to use it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index a3704ec8b599..d4f04f0ca646 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -232,6 +232,17 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	return ret;
 }
 
+/**
+ * ftrace_graph_get_ret_stack - return the entry of the shadow stack
+ * @task: The task to read the shadow stack from
+ * @idx: Index down the shadow stack
+ *
+ * Return the ret_struct on the shadow stack of the @task at the
+ * call graph at @idx starting with zero. If @idx is zero, it
+ * will return the last saved ret_stack entry. If it is greater than
+ * zero, it will return the corresponding ret_stack for the depth
+ * of saved return addresses.
+ */
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-- 
2.19.1


