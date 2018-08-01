Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EE4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20592083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20592083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbeHAUNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:13:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46076 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404313AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D70FE11EF;
        Wed,  1 Aug 2018 17:08:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 247/336] delayacct: Use raw_spinlocks
Date:   Wed,  1 Aug 2018 18:49:42 +0200
Message-Id: <20180801165038.514348943@linuxfoundation.org>
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

[ Upstream commit 02acc80d19edb0d5684c997b2004ad19f9f5236e ]

try_to_wake_up() might invoke delayacct_blkio_end() while holding the
pi_lock (which is a raw_spinlock_t). delayacct_blkio_end() acquires
task_delay_info.lock which is a spinlock_t. This causes a might sleep splat
on -RT where non raw spinlocks are converted to 'sleeping' spinlocks.

task_delay_info.lock is only held for a short amount of time so it's not a
problem latency wise to make convert it to a raw spinlock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Balbir Singh <bsingharora@gmail.com>
Link: https://lkml.kernel.org/r/20180423161024.6710-1-bigeasy@linutronix.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/delayacct.h |    2 +-
 kernel/delayacct.c        |   17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -29,7 +29,7 @@
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 struct task_delay_info {
-	spinlock_t	lock;
+	raw_spinlock_t	lock;
 	unsigned int	flags;	/* Private per-task flags */
 
 	/* For each stat XXX, add following, aligned appropriately
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -44,23 +44,24 @@ void __delayacct_tsk_init(struct task_st
 {
 	tsk->delays = kmem_cache_zalloc(delayacct_cache, GFP_KERNEL);
 	if (tsk->delays)
-		spin_lock_init(&tsk->delays->lock);
+		raw_spin_lock_init(&tsk->delays->lock);
 }
 
 /*
  * Finish delay accounting for a statistic using its timestamps (@start),
  * accumalator (@total) and @count
  */
-static void delayacct_end(spinlock_t *lock, u64 *start, u64 *total, u32 *count)
+static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total,
+			  u32 *count)
 {
 	s64 ns = ktime_get_ns() - *start;
 	unsigned long flags;
 
 	if (ns > 0) {
-		spin_lock_irqsave(lock, flags);
+		raw_spin_lock_irqsave(lock, flags);
 		*total += ns;
 		(*count)++;
-		spin_unlock_irqrestore(lock, flags);
+		raw_spin_unlock_irqrestore(lock, flags);
 	}
 }
 
@@ -127,7 +128,7 @@ int __delayacct_add_tsk(struct taskstats
 
 	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
 
-	spin_lock_irqsave(&tsk->delays->lock, flags);
+	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
 	tmp = d->blkio_delay_total + tsk->delays->blkio_delay;
 	d->blkio_delay_total = (tmp < d->blkio_delay_total) ? 0 : tmp;
 	tmp = d->swapin_delay_total + tsk->delays->swapin_delay;
@@ -137,7 +138,7 @@ int __delayacct_add_tsk(struct taskstats
 	d->blkio_count += tsk->delays->blkio_count;
 	d->swapin_count += tsk->delays->swapin_count;
 	d->freepages_count += tsk->delays->freepages_count;
-	spin_unlock_irqrestore(&tsk->delays->lock, flags);
+	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 
 	return 0;
 }
@@ -147,10 +148,10 @@ __u64 __delayacct_blkio_ticks(struct tas
 	__u64 ret;
 	unsigned long flags;
 
-	spin_lock_irqsave(&tsk->delays->lock, flags);
+	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
 	ret = nsec_to_clock_t(tsk->delays->blkio_delay +
 				tsk->delays->swapin_delay);
-	spin_unlock_irqrestore(&tsk->delays->lock, flags);
+	raw_spin_unlock_irqrestore(&tsk->delays->lock, flags);
 	return ret;
 }
 


