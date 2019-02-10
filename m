Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20918C282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DC3213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfBJU5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:57:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39319 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfBJU5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:57:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1AKv55E3236082
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 10 Feb 2019 12:57:06 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1AKv5Cb3236069;
        Sun, 10 Feb 2019 12:57:05 -0800
Date:   Sun, 10 Feb 2019 12:57:05 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matthias Kaehlcke <tipbot@zytor.com>
Message-ID: <tip-1342d8080f6183b0419a9246c6e6545e21fa1e05@git.kernel.org>
Cc:     hpa@zytor.com, paulmck@linux.vnet.ibm.com, dianders@chromium.org,
        swboyd@chromium.org, bigeasy@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mka@chromium.org, rostedt@goodmis.org
Reply-To: dianders@chromium.org, hpa@zytor.com, paulmck@linux.vnet.ibm.com,
          bigeasy@linutronix.de, mingo@kernel.org, peterz@infradead.org,
          swboyd@chromium.org, tglx@linutronix.de, mka@chromium.org,
          rostedt@goodmis.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190128234625.78241-3-mka@chromium.org>
References: <20190128234625.78241-3-mka@chromium.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq: Don't skip softirq execution when softirq
 thread is parking
Git-Commit-ID: 1342d8080f6183b0419a9246c6e6545e21fa1e05
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

Commit-ID:  1342d8080f6183b0419a9246c6e6545e21fa1e05
Gitweb:     https://git.kernel.org/tip/1342d8080f6183b0419a9246c6e6545e21fa1e05
Author:     Matthias Kaehlcke <mka@chromium.org>
AuthorDate: Mon, 28 Jan 2019 15:46:25 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 10 Feb 2019 21:51:39 +0100

softirq: Don't skip softirq execution when softirq thread is parking

When a CPU is unplugged the kernel threads of this CPU are parked (see
smpboot_park_threads()). kthread_park() is used to mark each thread as
parked and wake it up, so it can complete the process of parking itselfs
(see smpboot_thread_fn()).

If local softirqs are pending on interrupt exit invoke_softirq() is called
to process the softirqs, however it skips processing when the softirq
kernel thread of the local CPU is scheduled to run. The softirq kthread is
one of the threads that is parked when a CPU is unplugged. Parking the
kthread wakes it up, however only to complete the parking process, not to
process the pending softirqs. Hence processing of softirqs at the end of an
interrupt is skipped, but not done elsewhere, which can result in warnings
about pending softirqs when a CPU is unplugged:

/sys/devices/system/cpu # echo 0 > cpu4/online
[ ... ] NOHZ: local_softirq_pending 02
[ ... ] NOHZ: local_softirq_pending 202
[ ... ] CPU4: shutdown
[ ... ] psci: CPU4 killed.

Don't skip processing of softirqs at the end of an interrupt when the
softirq thread of the CPU is parking.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Link: https://lkml.kernel.org/r/20190128234625.78241-3-mka@chromium.org

---
 kernel/softirq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index d28813306b2c..10277429ed84 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -89,7 +89,8 @@ static bool ksoftirqd_running(unsigned long pending)
 
 	if (pending & SOFTIRQ_NOW_MASK)
 		return false;
-	return tsk && (tsk->state == TASK_RUNNING);
+	return tsk && (tsk->state == TASK_RUNNING) &&
+		!__kthread_should_park(tsk);
 }
 
 /*
