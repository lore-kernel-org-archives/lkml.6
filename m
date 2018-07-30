Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34DEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E668208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E668208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbeG3VE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:04:56 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57297 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbeG3VE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:04:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fkDqE-0005fc-6k; Mon, 30 Jul 2018 21:28:26 +0200
Date:   Mon, 30 Jul 2018 21:28:25 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Subject: [PATCH RT] rcu: mark rcu_iw_handler() as IRQ_WORK_HARD_IRQ
Message-ID: <20180730192824.viqzgvdnwz6pfe2m@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU's rcu_iw irq-work (rcu_iw_handler()) acquires the raw spinlock
rnp->lock without disabling interrupts. The lock is held normally with
disabled interrupts for a short time.
Mark irq-work as IRQ_WORK_HARD_IRQ so it is invoked in IRQ context like
on !RT.

Reported-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5a9c5abb17da..4fb983f4b9fd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1294,6 +1294,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		    !rdp->rcu_iw_pending && rdp->rcu_iw_gpnum != rnp->gpnum &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
+			rdp->rcu_iw.flags = IRQ_WORK_HARD_IRQ;
 			rdp->rcu_iw_pending = true;
 			rdp->rcu_iw_gpnum = rnp->gpnum;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
-- 
2.18.0

