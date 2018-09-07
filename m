Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412AFC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5ABF2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5ABF2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbeIHBmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbeIHBmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:42:13 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0E3F2086C;
        Fri,  7 Sep 2018 20:59:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fyNqk-0001kf-OQ; Fri, 07 Sep 2018 16:59:30 -0400
Message-Id: <20180907205930.644573313@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 07 Sep 2018 16:59:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 06/24] PM / s2idle: Make s2idle_wait_head swait based
References: <20180907205857.262840394@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 93f141324d4860a1294e6899923c01ec5411d70b ]

s2idle_wait_head is used during s2idle with interrupts disabled even on
RT. There is no "custom" wake up function so swait could be used instead
which is also lower weight compared to the wait_queue.
Make s2idle_wait_head a swait_queue_head.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/power/suspend.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 999236413460..b89605fe0e88 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -27,6 +27,7 @@
 #include <linux/export.h>
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
+#include <linux/swait.h>
 #include <linux/ftrace.h>
 #include <trace/events/power.h>
 #include <linux/compiler.h>
@@ -57,7 +58,7 @@ EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
 
 static const struct platform_suspend_ops *suspend_ops;
 static const struct platform_s2idle_ops *s2idle_ops;
-static DECLARE_WAIT_QUEUE_HEAD(s2idle_wait_head);
+static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
@@ -91,8 +92,8 @@ static void s2idle_enter(void)
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
 	/* Make the current CPU wait so it can enter the idle loop too. */
-	wait_event(s2idle_wait_head,
-		   s2idle_state == S2IDLE_STATE_WAKE);
+	swait_event(s2idle_wait_head,
+		    s2idle_state == S2IDLE_STATE_WAKE);
 
 	cpuidle_pause();
 	put_online_cpus();
@@ -159,7 +160,7 @@ void s2idle_wake(void)
 	raw_spin_lock_irqsave(&s2idle_lock, flags);
 	if (s2idle_state > S2IDLE_STATE_NONE) {
 		s2idle_state = S2IDLE_STATE_WAKE;
-		wake_up(&s2idle_wait_head);
+		swake_up(&s2idle_wait_head);
 	}
 	raw_spin_unlock_irqrestore(&s2idle_lock, flags);
 }
-- 
2.18.0


