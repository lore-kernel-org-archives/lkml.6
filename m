Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9DDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648F6222A0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBTSi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbfBTSiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:38:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43B8C222A9;
        Wed, 20 Feb 2019 18:38:10 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92-RC5)
        (envelope-from <rostedt@goodmis.org>)
        id 1gwWkz-0006nx-Dx; Wed, 20 Feb 2019 13:38:09 -0500
Message-Id: <20190220183809.315737571@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 20 Feb 2019 13:38:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 29/29] tracing: Comment why cond_snapshot is checked outside of max_lock
 protection
References: <20190220183737.034634614@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Before setting tr->cond_snapshot, it must be NULL before it can be updated.
It can go to NULL when a trace event hist trigger is created or removed, and
can only be modified under the max_lock spin lock. But because it can only
be set to something other than NULL under both the max_lock spin lock as
well as the trace_types_lock, we can perform the check if it is not NULL
only under the trace_types_lock and fail out without having to grab the
max_lock spin lock.

This is very subtle, and deserves a comment.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0460cc0f28fd..2cf3c747a357 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1116,6 +1116,14 @@ int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data,
 		goto fail_unlock;
 	}
 
+	/*
+	 * The cond_snapshot can only change to NULL without the
+	 * trace_types_lock. We don't care if we race with it going
+	 * to NULL, but we want to make sure that it's not set to
+	 * something other than NULL when we get here, which we can
+	 * do safely with only holding the trace_types_lock and not
+	 * having to take the max_lock.
+	 */
 	if (tr->cond_snapshot) {
 		ret = -EBUSY;
 		goto fail_unlock;
-- 
2.20.1


