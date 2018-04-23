Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932124AbeDWQ3i (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:29:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755237AbeDWQ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:29:35 -0400
Message-Id: <20180423162642.113827596@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 18:16:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH 3/5] clocksource: Initialize cs->wd_list
References: <20180423161648.622657048@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-3.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a number of places we rely on list_empty(&cs->wd_list), however we
do not initialize this list_head. Do so upon registration, such that
thereafter we can rely on list_empty() correctly reflecting the list
membership status.

Tested-by: Diego Viola <diego.viola@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/clocksource.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -332,6 +332,8 @@ static void clocksource_resume_watchdog(
 
 static void clocksource_enqueue_watchdog(struct clocksource *cs)
 {
+	INIT_LIST_HEAD(&cs->wd_list);
+
 	if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 		/* cs is a clocksource to be watched. */
 		list_add(&cs->wd_list, &watchdog_list);
