Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165095AbeE1Myo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164039AbeE1KzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <ariel.elior@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 307/496] qede: Fix barrier usage after tx doorbell write.
Date: Mon, 28 May 2018 12:01:32 +0200
Message-Id: <20180528100332.737371332@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manish Chopra <manish.chopra@cavium.com>

[ Upstream commit b9fc828debc8ac2bb21b5819a44d2aea456f1c95 ]

Since commit c5ad119fb6c09b0297446be05bd66602fa564758
("net: sched: pfifo_fast use skb_array") driver is exposed
to an issue where it is hitting NULL skbs while handling TX
completions. Driver uses mmiowb() to flush the writes to the
doorbell bar which is a write-combined bar, however on x86
mmiowb() does not flush the write combined buffer.

This patch fixes this problem by replacing mmiowb() with wmb()
after the write combined doorbell write so that writes are
flushed and synchronized from more than one processor.

V1->V2:
-------
This patch was marked as "superseded" in patchwork.
(Not really sure for what reason).Resending it as v2.

Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: Manish Chopra <manish.chopra@cavium.com>

Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -320,13 +320,11 @@ static inline void qede_update_tx_produc
 	barrier();
 	writel(txq->tx_db.raw, txq->doorbell_addr);
 
-	/* mmiowb is needed to synchronize doorbell writes from more than one
-	 * processor. It guarantees that the write arrives to the device before
-	 * the queue lock is released and another start_xmit is called (possibly
-	 * on another CPU). Without this barrier, the next doorbell can bypass
-	 * this doorbell. This is applicable to IA64/Altix systems.
+	/* Fence required to flush the write combined buffer, since another
+	 * CPU may write to the same doorbell address and data may be lost
+	 * due to relaxed order nature of write combined bar.
 	 */
-	mmiowb();
+	wmb();
 }
 
 static int qede_xdp_xmit(struct qede_dev *edev, struct qede_fastpath *fp,
