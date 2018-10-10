Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACFEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324C92098A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzQ4yEob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324C92098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeJKGi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJKGi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:26 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4D512087A;
        Wed, 10 Oct 2018 23:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213244;
        bh=fGt5FUWysEUqGMoZVChWVVopR2CrsR/JYmgoOU7AkSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OzQ4yEobeSfOqggMVvaNAzRxXoU7C7ReqlUQlpQ+QuFnBbcaicV573juvInYz4f70
         kfQ/9uDPwgbian62DQ8/rCMKekAR2EsZ2rIFeDj2WinKcyMIKkSbYqQzhw4nNaE/ff
         dpFkKse2lRoKnkv1ntg1jjAoEN7vaYr0hIPjgnFU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 30/30] softirq: Tasklet/net-rx fixup
Date:   Thu, 11 Oct 2018 01:12:17 +0200
Message-Id: <1539213137-13953-31-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

Tasklets and net-rx vectors don't quite get along. If one is interrupted
by another, we may run into a nasty spin_lock recursion:

	[  135.427198] Call Trace:
	[  135.429650]  <IRQ>
	[  135.431690]  dump_stack+0x67/0x95
	[  135.435024]  spin_bug+0x95/0xf0
	[  135.438187]  do_raw_spin_lock+0x77/0xa0
	[  135.442079]  _raw_spin_lock_nested+0x40/0x50
	[  135.446439]  ? tcp_v4_rcv+0x9da/0xb10
	[  135.450131]  tcp_v4_rcv+0x9da/0xb10
	[  135.453650]  ? ip_local_deliver+0x78/0x260
	[  135.457758]  ip_local_deliver+0xdf/0x260
	[  135.461728]  ip_rcv+0x4e/0x80
	[  135.464716]  __netif_receive_skb_one_core+0x55/0x80
	[  135.469623]  __netif_receive_skb+0x1b/0x70
	[  135.473757]  netif_receive_skb_internal+0x92/0x390
	[  135.478574]  napi_gro_receive+0xdf/0x1a0
	[  135.482545]  rtl8169_poll+0x2b8/0x670
	[  135.486211]  net_rx_action+0x1f8/0x3e0
	[  135.489989]  __do_softirq+0x1a0/0x63c
	[  135.493691]  irq_exit+0x10f/0x120
	[  135.497033]  do_IRQ+0x71/0x130
	[  135.500137]  common_interrupt+0xf/0xf
	[  135.503839] RIP: 0010:_raw_spin_unlock_irqrestore+0x59/0x70
	[  135.509471] Code: 75 21 53 9d e8 e8 1d a5 ff bf 01 00 00 00 e8 8e f6 97 ff 65 8b 05 ef 06 8d 7e 85 c0 74 0e 5b 41 5c 5d c3 e8 c9 20 a5 ff 53 9d <eb> dd e8 90 d4 8b ff 5b 41 5c 5d c3 66 66 2e 0f 1f 84 00 00 00 00
	[  135.528347] RSP: 0018:ffff88021fb03d28 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffde
	[  135.535989] RAX: ffff880217762480 RBX: 0000000000000246 RCX: 0000000000000002
	[  135.543201] RDX: 0000000000000000 RSI: ffff880217762c70 RDI: ffff880217762480
	[  135.550332] RBP: ffff88021fb03d38 R08: 0000000000000001 R09: 0000000000000000
	[  135.557519] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88021fa59b40
	[  135.564719] R13: ffff88021fa59b40 R14: 00000000fffd78b5 R15: 000000000e000001
	[  135.571905]  ? common_interrupt+0xa/0xf
	[  135.575783]  mod_timer+0x196/0x440
	[  135.579221]  sk_reset_timer+0x18/0x30
	[  135.582940]  tcp_schedule_loss_probe+0xe9/0x120
	[  135.587515]  tcp_write_xmit+0x2c4/0x1240
	[  135.591468]  tcp_tsq_write.part.46+0x5e/0xb0
	[  135.595756]  tcp_tsq_handler+0xa3/0xb0
	[  135.599534]  tcp_tasklet_func+0xdc/0x120
	[  135.603488]  tasklet_action_common.isra.17+0xa3/0xb0
	[  135.608471]  tasklet_action+0x2d/0x30
	[  135.612161]  __do_softirq+0x1a0/0x63c
	[  135.615847]  irq_exit+0x10f/0x120
	[  135.619173]  do_IRQ+0x71/0x130
	[  135.622251]  common_interrupt+0xf/0xf
	[  135.625949]  </IRQ>

This is an ugly workaround until we find a proper solution.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/softirq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index f4cb1ea..d95295f 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -320,6 +320,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
+	bool tasklet_enabled = false, net_rx_enabled = false;
 	bool in_hardirq;
 	__u32 pending;
 	int softirq_bit;
@@ -338,6 +339,10 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	in_hardirq = lockdep_softirq_start();
 
 restart:
+	if (local_softirq_enabled() & TASKLET_SOFTIRQ)
+		tasklet_enabled = true;
+	if (local_softirq_enabled() & NET_RX_SOFTIRQ)
+		net_rx_enabled = true;
 	/* Reset the pending bitmask before enabling irqs */
 	softirq_pending_nand(pending);
 
@@ -358,8 +363,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 		trace_softirq_entry(vec_nr);
 		softirq_enabled_nand(BIT(vec_nr));
+		if (vec_nr == NET_RX_SOFTIRQ && tasklet_enabled)
+			softirq_enabled_nand(BIT(TASKLET_SOFTIRQ));
+		if (vec_nr == TASKLET_SOFTIRQ && net_rx_enabled)
+			softirq_enabled_nand(BIT(NET_RX_SOFTIRQ));
 		barrier();
 		h->action(h);
+		if (vec_nr == TASKLET_SOFTIRQ && net_rx_enabled)
+			softirq_enabled_or(BIT(NET_RX_SOFTIRQ));
+		if (vec_nr == NET_RX_SOFTIRQ && tasklet_enabled)
+			softirq_enabled_or(BIT(TASKLET_SOFTIRQ));
 		softirq_enabled_or(BIT(vec_nr));
 		trace_softirq_exit(vec_nr);
 		if (unlikely(prev_count != preempt_count())) {
-- 
2.7.4

