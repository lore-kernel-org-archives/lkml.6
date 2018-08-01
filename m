Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B35C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940D2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6940D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbeHAUPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:15:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404252AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F271BFC4;
        Wed,  1 Aug 2018 16:58:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 110/336] PM / wakeup: Make s2idle_lock a RAW_SPINLOCK
Date:   Wed,  1 Aug 2018 18:47:25 +0200
Message-Id: <20180801165033.366893454@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 62fc00a6611a0014c85763f9def1fc07c15d1302 ]

The `s2idle_lock' is acquired during suspend while interrupts are
disabled even on RT. The lock is acquired for short sections only.
Make it a RAW lock which avoids "sleeping while atomic" warnings on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/power/suspend.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -60,7 +60,7 @@ static const struct platform_s2idle_ops
 static DECLARE_WAIT_QUEUE_HEAD(s2idle_wait_head);
 
 enum s2idle_states __read_mostly s2idle_state;
-static DEFINE_SPINLOCK(s2idle_lock);
+static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
@@ -78,12 +78,12 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
-	spin_lock_irq(&s2idle_lock);
+	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
 
 	s2idle_state = S2IDLE_STATE_ENTER;
-	spin_unlock_irq(&s2idle_lock);
+	raw_spin_unlock_irq(&s2idle_lock);
 
 	get_online_cpus();
 	cpuidle_resume();
@@ -97,11 +97,11 @@ static void s2idle_enter(void)
 	cpuidle_pause();
 	put_online_cpus();
 
-	spin_lock_irq(&s2idle_lock);
+	raw_spin_lock_irq(&s2idle_lock);
 
  out:
 	s2idle_state = S2IDLE_STATE_NONE;
-	spin_unlock_irq(&s2idle_lock);
+	raw_spin_unlock_irq(&s2idle_lock);
 
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
 }
@@ -156,12 +156,12 @@ void s2idle_wake(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&s2idle_lock, flags);
+	raw_spin_lock_irqsave(&s2idle_lock, flags);
 	if (s2idle_state > S2IDLE_STATE_NONE) {
 		s2idle_state = S2IDLE_STATE_WAKE;
 		wake_up(&s2idle_wait_head);
 	}
-	spin_unlock_irqrestore(&s2idle_lock, flags);
+	raw_spin_unlock_irqrestore(&s2idle_lock, flags);
 }
 EXPORT_SYMBOL_GPL(s2idle_wake);
 


