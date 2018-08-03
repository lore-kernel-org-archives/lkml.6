Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5EAC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6873A21770
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6873A21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbeHCPvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:51:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58293 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbeHCPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:51:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w73Dsquh3909967
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 06:54:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w73DsqNd3909964;
        Fri, 3 Aug 2018 06:54:52 -0700
Date:   Fri, 3 Aug 2018 06:54:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-0a0e0829f990120cef165bbb804237f400953ec2@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, frederic@kernel.org,
        anna-maria@linutronix.de
Reply-To: frederic@kernel.org, anna-maria@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <1533303094-15855-1-git-send-email-frederic@kernel.org>
References: <1533303094-15855-1-git-send-email-frederic@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] nohz: Fix missing tick reprogram when
 interrupting an inline softirq
Git-Commit-ID: 0a0e0829f990120cef165bbb804237f400953ec2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0a0e0829f990120cef165bbb804237f400953ec2
Gitweb:     https://git.kernel.org/tip/0a0e0829f990120cef165bbb804237f400953ec2
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Fri, 3 Aug 2018 15:31:34 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 3 Aug 2018 15:52:10 +0200

nohz: Fix missing tick reprogram when interrupting an inline softirq

The full nohz tick is reprogrammed in irq_exit() only if the exit is not in
a nesting interrupt. This stands as an optimization: whether a hardirq or a
softirq is interrupted, the tick is going to be reprogrammed when necessary
at the end of the inner interrupt, with even potential new updates on the
timer queue.

When soft interrupts are interrupted, it's assumed that they are executing
on the tail of an interrupt return. In that case tick_nohz_irq_exit() is
called after softirq processing to take care of the tick reprogramming.

But the assumption is wrong: softirqs can be processed inline as well, ie:
outside of an interrupt, like in a call to local_bh_enable() or from
ksoftirqd.

Inline softirqs don't reprogram the tick once they are done, as opposed to
interrupt tail softirq processing. So if a tick interrupts an inline
softirq processing, the next timer will neither be reprogrammed from the
interrupting tick's irq_exit() nor after the interrupted softirq
processing. This situation may leave the tick unprogrammed while timers are
armed.

To fix this, simply keep reprogramming the tick even if a softirq has been
interrupted. That can be optimized further, but for now correctness is more
important.

Note that new timers enqueued in nohz_full mode after a softirq gets
interrupted will still be handled just fine through self-IPIs triggered by
the timer code.

Reported-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: stable@vger.kernel.org # 4.14+
Link: https://lkml.kernel.org/r/1533303094-15855-1-git-send-email-frederic@kernel.org

---
 kernel/softirq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 75ffc1d1a2e0..6f584861d329 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -390,7 +390,7 @@ static inline void tick_irq_exit(void)
 
 	/* Make sure that timer wheel updates are propagated */
 	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
-		if (!in_interrupt())
+		if (!in_irq())
 			tick_nohz_irq_exit();
 	}
 #endif
