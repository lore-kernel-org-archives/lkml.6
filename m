Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D001DC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6AB24004
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6AB24004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753816AbeGEPyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:54:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51002 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753421AbeGEPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:54:40 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fb6aa-0006TL-5E; Thu, 05 Jul 2018 17:54:36 +0200
Date:   Thu, 5 Jul 2018 17:54:36 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        Peter Zilstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RT] Revert "timer: delay waking softirqs from the jiffy tick"
Message-ID: <20180705155435.3zb65vwxgagpza3b@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

This patch was required as long as RT tasks where accounted to CFS
load but this was only a work around. Upstream Commit 17bdcf949d03
("sched: Drop all load weight manipulation for RT tasks") fixed the
accounting of RT tasks into CFS load.

Remove the patch and fix dependencies.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/time/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1666,13 +1666,13 @@ void update_process_times(int user_tick)
 
 	/* Note: this timer irq context must be accounted for as well. */
 	account_process_tick(p, user_tick);
-	scheduler_tick();
 	run_local_timers();
 	rcu_check_callbacks(user_tick);
 #ifdef CONFIG_IRQ_WORK
 	if (in_irq())
 		irq_work_tick();
 #endif
+	scheduler_tick();
 	if (IS_ENABLED(CONFIG_POSIX_TIMERS))
 		run_posix_cpu_timers(p);
 }
