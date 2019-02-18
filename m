Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F299CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFA62081B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500420;
	bh=w7PE5pTB+23ZTx0dFRdbQK+KJ0+18+FL3r/7zqju1w8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DSBPRpV2Ex4eIlH4KHbez1RdT54EZlC4KETeu0h1Xmb8IW51QBzTrYh+bLGtDlF3G
	 YwqqcuiBYaBkZXi7SU/MZTupsUH2igZI0OIRRh3NOanPchw9tXc3abqtLP0B150mbu
	 8j6yRSDhLkcPtAq+vKkf4iXWL0kbeh1VCQ/zytoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbfBRN5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:57:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732840AbfBRN4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC7D2077B;
        Mon, 18 Feb 2019 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498214;
        bh=w7PE5pTB+23ZTx0dFRdbQK+KJ0+18+FL3r/7zqju1w8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BVxzTQkK8O7vw5BlJWBsDFmbKOtpdnLEPvdjCp3ziFDpy+vwt/GPEKdgaeaL2VxBH
         ZYGBr3SEz6whqnL2pqljPWnGpeOQg9fOAqym/z/ATQI2uDLzF3VZTUp69tAYxZgOyb
         ljonkzDx4LfAKpuw+/FF007jNzfTCTD0/+FGqLlU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 60/62] sched, trace: Fix prev_state output in sched_switch tracepoint
Date:   Mon, 18 Feb 2019 14:44:06 +0100
Message-Id: <20190218133510.921592262@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavankumar Kondeti <pkondeti@codeaurora.org>

commit 3054426dc68e5d63aa6a6e9b91ac4ec78e3f3805 upstream.

commit 3f5fe9fef5b2 ("sched/debug: Fix task state recording/printout")
tried to fix the problem introduced by a previous commit efb40f588b43
("sched/tracing: Fix trace_sched_switch task-state printing"). However
the prev_state output in sched_switch is still broken.

task_state_index() uses fls() which considers the LSB as 1. Left
shifting 1 by this value gives an incorrect mapping to the task state.
Fix this by decrementing the value returned by __get_task_state()
before shifting.

Link: http://lkml.kernel.org/r/1540882473-1103-1-git-send-email-pkondeti@codeaurora.org

Cc: stable@vger.kernel.org
Fixes: 3f5fe9fef5b2 ("sched/debug: Fix task state recording/printout")
Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/trace/events/sched.h |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -107,6 +107,8 @@ DEFINE_EVENT(sched_wakeup_template, sche
 #ifdef CREATE_TRACE_POINTS
 static inline long __trace_sched_switch_state(bool preempt, struct task_struct *p)
 {
+	unsigned int state;
+
 #ifdef CONFIG_SCHED_DEBUG
 	BUG_ON(p != current);
 #endif /* CONFIG_SCHED_DEBUG */
@@ -118,7 +120,15 @@ static inline long __trace_sched_switch_
 	if (preempt)
 		return TASK_REPORT_MAX;
 
-	return 1 << __get_task_state(p);
+	/*
+	 * task_state_index() uses fls() and returns a value from 0-8 range.
+	 * Decrement it by 1 (except TASK_RUNNING state i.e 0) before using
+	 * it for left shift operation to get the correct task->state
+	 * mapping.
+	 */
+	state = __get_task_state(p);
+
+	return state ? (1 << (state - 1)) : state;
 }
 #endif /* CREATE_TRACE_POINTS */
 


