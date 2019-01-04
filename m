Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18A4C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F65E218D3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfADUdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:33:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfADUdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:33:23 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2284FC049598;
        Fri,  4 Jan 2019 20:33:23 +0000 (UTC)
Received: from intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com (intel-purley-fpgabmp-02.ml3.eng.bos.redhat.com [10.19.176.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CC4D19C7C;
        Fri,  4 Jan 2019 20:33:22 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Scott Wood <swood@redhat.com>
Subject: [PATCH RT] rtmutex: Flush block plug on __down_read()
Date:   Fri,  4 Jan 2019 15:33:21 -0500
Message-Id: <1546634001-4450-1-git-send-email-swood@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 04 Jan 2019 20:33:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__down_read() bypasses the rtmutex frontend to call
rt_mutex_slowlock_locked() directly, and thus it needs to call
blk_schedule_flush_flug() itself.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/locking/rwsem-rt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
index 660e22caf709..f73cd4eda5cd 100644
--- a/kernel/locking/rwsem-rt.c
+++ b/kernel/locking/rwsem-rt.c
@@ -1,5 +1,6 @@
 /*
  */
+#include <linux/blkdev.h>
 #include <linux/rwsem.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/signal.h>
@@ -88,6 +89,15 @@ static int __sched __down_read_common(struct rw_semaphore *sem, int state)
 	if (__down_read_trylock(sem))
 		return 0;
 
+	/*
+	 * If sem->rtmutex blocks, the function sched_submit_work will not
+	 * call blk_schedule_flush_plug (because tsk_is_pi_blocked would be
+	 * true).  We must call blk_schedule_flush_plug here; if we don't
+	 * call it, an I/O deadlock may occur.
+	 */
+	if (unlikely(blk_needs_flush_plug(current)))
+		blk_schedule_flush_plug(current);
+
 	might_sleep();
 	raw_spin_lock_irq(&m->wait_lock);
 	/*
-- 
1.8.3.1

