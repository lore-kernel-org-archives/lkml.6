Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DE8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C21222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991779;
	bh=n0zq6AhuEHRd6RTYQkdUftoPHba5L4i9a2sXw3T0S4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NTXwtCNQOxHRpBmW7NLPLFr1XbIzwUKQBn9fY64zc4P2ZsIAwjpoV/mrFFmgUzQ4O
	 32hapWSuGUOLkTnDE8CZF7HdXK1HFAZP9Xf1rSItdbsPVWb6Jvf9nHRLqx3VzcXeuq
	 SeFAnJ272qGtoRejPkOVT+9r0znON8Ol9E7XAnZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbfBLRQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731712AbfBLRQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:14 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB3B8222BF;
        Tue, 12 Feb 2019 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991773;
        bh=n0zq6AhuEHRd6RTYQkdUftoPHba5L4i9a2sXw3T0S4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPUN+Q1f9epaL9YXQIRxDEKd1UKI3WfEZK43sXfyuYriKrOSS4y11/P6ex0+cjurF
         MiNd3pyxSdh2nAxpB4eVi1vuQzwo44h7uznjbsDjlpjkwjOs8IyOsmDm1+7vqS1Hus
         ouZUgwwJxuTadcfXpUASOaPMhxEske5h9dCSqHQA=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 32/32] net: Make softirq vector masking finegrained on release_sock()
Date:   Tue, 12 Feb 2019 18:14:23 +0100
Message-Id: <20190212171423.8308-33-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a usage example of spin_lock_bh_mask(). NET_RX, TIMER and
TASKLET are the three softirqs that have been reported by lockdep to
be used for this socket lock, at least on my own usecases.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 net/core/sock.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 6aa2e7e0b4fb..24ca1cdacfe3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2795,7 +2795,9 @@ EXPORT_SYMBOL(lock_sock_nested);
 
 void release_sock(struct sock *sk)
 {
-	spin_lock_bh(&sk->sk_lock.slock);
+	unsigned int bh;
+
+	bh = spin_lock_bh_mask(&sk->sk_lock.slock, BIT(NET_RX_SOFTIRQ) | BIT(TIMER_SOFTIRQ) | BIT(TASKLET_SOFTIRQ));
 	if (sk->sk_backlog.tail)
 		__release_sock(sk);
 
@@ -2808,7 +2810,7 @@ void release_sock(struct sock *sk)
 	sock_release_ownership(sk);
 	if (waitqueue_active(&sk->sk_lock.wq))
 		wake_up(&sk->sk_lock.wq);
-	spin_unlock_bh(&sk->sk_lock.slock);
+	spin_unlock_bh_mask(&sk->sk_lock.slock, bh);
 }
 EXPORT_SYMBOL(release_sock);
 
-- 
2.17.1

