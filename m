Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A087C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E857A21727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E857A21727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389564AbeHNUSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:18:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53214 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387619AbeHNUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:18:55 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 62C3DD67;
        Tue, 14 Aug 2018 17:30:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 03/97] Mark HI and TASKLET softirq synchronous
Date:   Tue, 14 Aug 2018 19:16:15 +0200
Message-Id: <20180814171433.300425851@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 3c53776e29f81719efcf8f7a6e30cdf753bee94d upstream.

Way back in 4.9, we committed 4cd13c21b207 ("softirq: Let ksoftirqd do
its job"), and ever since we've had small nagging issues with it.  For
example, we've had:

  1ff688209e2e ("watchdog: core: make sure the watchdog_worker is not deferred")
  8d5755b3f77b ("watchdog: softdog: fire watchdog even if softirqs do not get to run")
  217f69743681 ("net: busy-poll: allow preemption in sk_busy_loop()")

all of which worked around some of the effects of that commit.

The DVB people have also complained that the commit causes excessive USB
URB latencies, which seems to be due to the USB code using tasklets to
schedule USB traffic.  This seems to be an issue mainly when already
living on the edge, but waiting for ksoftirqd to handle it really does
seem to cause excessive latencies.

Now Hanna Hawa reports that this issue isn't just limited to USB URB and
DVB, but also causes timeout problems for the Marvell SoC team:

 "I'm facing kernel panic issue while running raid 5 on sata disks
  connected to Macchiatobin (Marvell community board with Armada-8040
  SoC with 4 ARMv8 cores of CA72) Raid 5 built with Marvell DMA engine
  and async_tx mechanism (ASYNC_TX_DMA [=y]); the DMA driver (mv_xor_v2)
  uses a tasklet to clean the done descriptors from the queue"

The latency problem causes a panic:

  mv_xor_v2 f0400000.xor: dma_sync_wait: timeout!
  Kernel panic - not syncing: async_tx_quiesce: DMA error waiting for transaction

We've discussed simply just reverting the original commit entirely, and
also much more involved solutions (with per-softirq threads etc).  This
patch is intentionally stupid and fairly limited, because the issue
still remains, and the other solutions either got sidetracked or had
other issues.

We should probably also consider the timer softirqs to be synchronous
and not be delayed to ksoftirqd (since they were the issue with the
earlier watchdog problems), but that should be done as a separate patch.
This does only the tasklet cases.

Reported-and-tested-by: Hanna Hawa <hannah@marvell.com>
Reported-and-tested-by: Josef Griebichler <griebichler.josef@gmx.at>
Reported-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/softirq.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -79,12 +79,16 @@ static void wakeup_softirqd(void)
 
 /*
  * If ksoftirqd is scheduled, we do not want to process pending softirqs
- * right now. Let ksoftirqd handle this at its own rate, to get fairness.
+ * right now. Let ksoftirqd handle this at its own rate, to get fairness,
+ * unless we're doing some of the synchronous softirqs.
  */
-static bool ksoftirqd_running(void)
+#define SOFTIRQ_NOW_MASK ((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ))
+static bool ksoftirqd_running(unsigned long pending)
 {
 	struct task_struct *tsk = __this_cpu_read(ksoftirqd);
 
+	if (pending & SOFTIRQ_NOW_MASK)
+		return false;
 	return tsk && (tsk->state == TASK_RUNNING);
 }
 
@@ -329,7 +333,7 @@ asmlinkage __visible void do_softirq(voi
 
 	pending = local_softirq_pending();
 
-	if (pending && !ksoftirqd_running())
+	if (pending && !ksoftirqd_running(pending))
 		do_softirq_own_stack();
 
 	local_irq_restore(flags);
@@ -356,7 +360,7 @@ void irq_enter(void)
 
 static inline void invoke_softirq(void)
 {
-	if (ksoftirqd_running())
+	if (ksoftirqd_running(local_softirq_pending()))
 		return;
 
 	if (!force_irqthreads) {


