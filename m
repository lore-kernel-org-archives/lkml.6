Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A39DC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464D3217AE
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 13:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464D3217AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeHKQYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 12:24:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbeHKQYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 12:24:34 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B0921A28;
        Sat, 11 Aug 2018 13:50:18 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1foUHZ-0006ID-OC; Sat, 11 Aug 2018 09:50:17 -0400
Message-Id: <20180811135017.655911310@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 11 Aug 2018 09:50:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [for-next][PATCH 34/34] tracepoints: Free early tracepoints after RCU is initialized
References: <20180811134928.034373761@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When enabling trace events via the kernel command line, I hit this warning:

WARNING: CPU: 0 PID: 13 at kernel/rcu/srcutree.c:236 check_init_srcu_struct+0xe/0x61
Modules linked in:
CPU: 0 PID: 13 Comm: watchdog/0 Not tainted 4.18.0-rc6-test+ #6
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
RIP: 0010:check_init_srcu_struct+0xe/0x61
Code: 48 c7 c6 ec 8a 65 b4 e8 ff 79 fe ff 48 89 df 31 f6 e8 f2 fa ff ff 5a
5b 41 5c 5d c3 0f 1f 44 00 00 83 3d 68 94 b8 01 01 75 02 <0f> 0b 48 8b 87 f0
0a 00 00 a8 03 74 45 55 48 89 e5 41 55 41 54 4c
RSP: 0000:ffff96eb9ea03e68 EFLAGS: 00010246
RAX: ffff96eb962b5b01 RBX: ffffffffb4a87420 RCX: 0000000000000001
RDX: ffffffffb3107969 RSI: ffff96eb962b5b40 RDI: ffffffffb4a87420
RBP: ffff96eb9ea03eb0 R08: ffffabbd00cd7f48 R09: 0000000000000000
R10: ffff96eb9ea03e68 R11: ffffffffb4a6eec0 R12: ffff96eb962b5b40
R13: ffff96eb9ea03ef8 R14: ffffffffb3107969 R15: ffffffffb3107948
FS:  0000000000000000(0000) GS:ffff96eb9ea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff96eb13ab2000 CR3: 0000000192a1e001 CR4: 00000000001606f0
Call Trace:
 <IRQ>
 ? __call_srcu+0x2d/0x290
 ? rcu_process_callbacks+0x26e/0x448
 ? allocate_probes+0x2b/0x2b
 call_srcu+0x13/0x15
 rcu_free_old_probes+0x1f/0x21
 rcu_process_callbacks+0x2ed/0x448
 __do_softirq+0x172/0x336
 irq_exit+0x62/0xb2
 smp_apic_timer_interrupt+0x161/0x19e
 apic_timer_interrupt+0xf/0x20
 </IRQ>

The problem is that the enabling of trace events before RCU is set up will
cause SRCU to give this warning. To avoid this, add a list to store probes
that need to be freed till after RCU is initialized, and then free them
then.

Link: http://lkml.kernel.org/r/20180810113554.1df28050@gandalf.local.home
Link: http://lkml.kernel.org/r/20180810123517.5e9714ad@gandalf.local.home

Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Fixes: e6753f23d961d ("tracepoint: Make rcuidle tracepoint callers use SRCU")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/tracepoint.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 955148d91b74..96db841bf0fc 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -53,6 +53,9 @@ static LIST_HEAD(tracepoint_module_list);
  */
 static DEFINE_MUTEX(tracepoints_mutex);
 
+static struct rcu_head *early_probes;
+static bool ok_to_free_tracepoints;
+
 /*
  * Note about RCU :
  * It is used to delay the free of multiple probes array until a quiescent
@@ -80,11 +83,40 @@ static void rcu_free_old_probes(struct rcu_head *head)
 	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
 }
 
+static __init int release_early_probes(void)
+{
+	struct rcu_head *tmp;
+
+	ok_to_free_tracepoints = true;
+
+	while (early_probes) {
+		tmp = early_probes;
+		early_probes = tmp->next;
+		call_rcu_sched(tmp, rcu_free_old_probes);
+	}
+
+	return 0;
+}
+
+/* SRCU is initialized at core_initcall */
+postcore_initcall(release_early_probes);
+
 static inline void release_probes(struct tracepoint_func *old)
 {
 	if (old) {
 		struct tp_probes *tp_probes = container_of(old,
 			struct tp_probes, probes[0]);
+
+		/*
+		 * We can't free probes if SRCU is not initialized yet.
+		 * Postpone the freeing till after SRCU is initialized.
+		 */
+		if (unlikely(!ok_to_free_tracepoints)) {
+			tp_probes->rcu.next = early_probes;
+			early_probes = &tp_probes->rcu;
+			return;
+		}
+
 		/*
 		 * Tracepoint probes are protected by both sched RCU and SRCU,
 		 * by calling the SRCU callback in the sched RCU callback we
-- 
2.18.0


