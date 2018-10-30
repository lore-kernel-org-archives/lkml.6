Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5750BC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1188F20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E4Q5iJhp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gE4zVjgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1188F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJ3PrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:47:00 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59998 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeJ3PrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:47:00 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0BF386086A; Tue, 30 Oct 2018 06:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540882485;
        bh=zvSWgS0dBh4BEPcq1diroF+MPUT3lq1ibtWYOIEED8U=;
        h=From:To:Cc:Subject:Date:From;
        b=E4Q5iJhp+B7ur2JiNPwOW1ILES8A5zIAUlPij3Dqi9W3NCXCL/+hi17X8iD0YwuKO
         fwofmWL2yYDrCbv5lIgU916sWV3D6U7Mptd99BNU3oKIRBSOwvdA6pl3tv/ty1hFJk
         dZcgG0nOO+9irYw6JSlOO6FsYfmpiAYsgF/H73Z0=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 782016074F;
        Tue, 30 Oct 2018 06:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540882484;
        bh=zvSWgS0dBh4BEPcq1diroF+MPUT3lq1ibtWYOIEED8U=;
        h=From:To:Cc:Subject:Date:From;
        b=gE4zVjgLsHacagoCDGIFzOeeWelOz2KhDrZOOfMoPxwNAHDKNPrhBdXMoQWn1wYKH
         HtWWIxe1saWU2nxBEKeSPmdxpjqIlplnO+KDAVNOLzAO7khmHiKrIMO9pOzCmmSke5
         Yghn0aUnzfu4gWW5ms6DndGYQgzrO5W9zZfHLtfw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 782016074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
From:   Pavankumar Kondeti <pkondeti@codeaurora.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Pavankumar Kondeti <pkondeti@codeaurora.org>
Subject: [PATCH] sched, trace: Fix prev_state output in sched_switch tracepoint
Date:   Tue, 30 Oct 2018 12:24:33 +0530
Message-Id: <1540882473-1103-1-git-send-email-pkondeti@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3f5fe9fef5b2 ("sched/debug: Fix task state recording/printout")
tried to fix the problem introduced by a previous commit efb40f588b43
("sched/tracing: Fix trace_sched_switch task-state printing"). However
the prev_state output in sched_switch is still broken.

task_state_index() uses fls() which considers the LSB as 1. Left
shifting 1 by this value gives an incorrect mapping to the task state.
Fix this by decrementing the value returned by __get_task_state()
before shifting.

Fixes: 3f5fe9fef5b2 ("sched/debug: Fix task state recording/printout")
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
---
 include/trace/events/sched.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index f07b270..9a4bdfa 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -107,6 +107,8 @@
 #ifdef CREATE_TRACE_POINTS
 static inline long __trace_sched_switch_state(bool preempt, struct task_struct *p)
 {
+	unsigned int state;
+
 #ifdef CONFIG_SCHED_DEBUG
 	BUG_ON(p != current);
 #endif /* CONFIG_SCHED_DEBUG */
@@ -118,7 +120,15 @@ static inline long __trace_sched_switch_state(bool preempt, struct task_struct *
 	if (preempt)
 		return TASK_REPORT_MAX;
 
-	return 1 << task_state_index(p);
+	/*
+	 * task_state_index() uses fls() and returns a value from 0-8 range.
+	 * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
+	 * it for left shift operation to get the correct task->state
+	 * mapping.
+	 */
+	state = task_state_index(p);
+
+	return state ? (1 << (state - 1)) : state;
 }
 #endif /* CREATE_TRACE_POINTS */
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

