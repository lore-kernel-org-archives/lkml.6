Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FF6C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA0A2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA0A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeIEOGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:06:16 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60993 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeIEOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:06:14 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fxUEv-0006Jw-Q4; Wed, 05 Sep 2018 11:36:45 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.91)
        (envelope-from <ukl@pengutronix.de>)
        id 1fxUEv-0007JH-Fg; Wed, 05 Sep 2018 11:36:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] sched/debug: use symbolic names for task state constants
Date:   Wed,  5 Sep 2018 11:36:36 +0200
Message-Id: <20180905093636.24068-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/trace/events/sched.h includes <linux/sched.h> (via
<linux/sched/numa_balancing.h>) and so knows about the TASK_* constants
used to interpret .prev_state. So instead of duplicating the magic
numbers make use of the defined macros to ease understanding the
mapping from state bits to letters which isn't completely intuitive for
an outsider.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/trace/events/sched.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 0be866c91f62..f07b270d4fc4 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -159,9 +159,14 @@ TRACE_EVENT(sched_switch,
 
 		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
 		  __print_flags(__entry->prev_state & (TASK_REPORT_MAX - 1), "|",
-				{ 0x01, "S" }, { 0x02, "D" }, { 0x04, "T" },
-				{ 0x08, "t" }, { 0x10, "X" }, { 0x20, "Z" },
-				{ 0x40, "P" }, { 0x80, "I" }) :
+				{ TASK_INTERRUPTIBLE, "S" },
+				{ TASK_UNINTERRUPTIBLE, "D" },
+				{ __TASK_STOPPED, "T" },
+				{ __TASK_TRACED, "t" },
+				{ EXIT_DEAD, "X" },
+				{ EXIT_ZOMBIE, "Z" },
+				{ TASK_PARKED, "P" },
+				{ TASK_DEAD, "I" }) :
 		  "R",
 
 		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
-- 
2.18.0

