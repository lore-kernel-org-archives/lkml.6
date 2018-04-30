Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeD3KEp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:04:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeD3KEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:04:44 -0400
Message-Id: <20180430100344.472662715@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 12:00:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH v2 3/7] clocksource: Initialize cs->wd_list
References: <20180430100008.503783478@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-3.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of places relies on list_empty(&cs->wd_list), however the
list_head does not get initialized. Do so upon registration, such that
thereafter it is possible to rely on list_empty() correctly reflecting
the list membership status.

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
