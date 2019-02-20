Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037F6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06F92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBTSu7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:50:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTSu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:50:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB36720859;
        Wed, 20 Feb 2019 18:50:57 +0000 (UTC)
Date:   Wed, 20 Feb 2019 13:50:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Subject: Re: [for-next][PATCH 13/29] tracing: No need to free iter->trace in
 fail path of tracing_open_pipe()
Message-ID: <20190220135056.7dfbb673@gandalf.local.home>
In-Reply-To: <20190220134647.3be6b506@gandalf.local.home>
References: <20190220183737.034634614@goodmis.org>
        <20190220183805.422405135@goodmis.org>
        <20190220134647.3be6b506@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the new patch change log:

From e7f0c424d0806b05d6f47be9f202b037eb701707 Mon Sep 17 00:00:00 2001
From: "zhangyi (F)" <yi.zhang@huawei.com>
Date: Wed, 13 Feb 2019 20:29:06 +0800
Subject: [PATCH] tracing: Do not free iter->trace in fail path of
 tracing_open_pipe()

Commit d716ff71dd12 ("tracing: Remove taking of trace_types_lock in
pipe files") use the current tracer instead of the copy in
tracing_open_pipe(), but it forget to remove the freeing sentence in
the error path.

There's an error path that can call kfree(iter->trace) after the iter->trace
was assigned to tr->current_trace, which would be bad to free.

Link: http://lkml.kernel.org/r/1550060946-45984-1-git-send-email-yi.zhang@huawei.com

Cc: stable@vger.kernel.org
Fixes: d716ff71dd12 ("tracing: Remove taking of trace_types_lock in pipe files")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c521b7347482..b583ff7656bb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5624,7 +5624,6 @@ static int tracing_open_pipe(struct inode *inode, struct file *filp)
 	return ret;
 
 fail:
-	kfree(iter->trace);
 	kfree(iter);
 	__trace_array_put(tr);
 	mutex_unlock(&trace_types_lock);
-- 
2.20.1

