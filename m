Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652CCC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A2020645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A2020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeJNXlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:41:21 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35871 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727384AbeJNXLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLd-0004cC-6H; Sun, 14 Oct 2018 16:30:29 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLa-0000kA-QA; Sun, 14 Oct 2018 16:30:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Tariq Toukan" <tariqt@mellanox.com>,
        "Jack Morgenstein" <jackm@dev.mellanox.co.il>,
        "David S. Miller" <davem@davemloft.net>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.679954207@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 344/366] net/mlx4: Fix irq-unsafe spinlock usage
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

commit d546b67cda015fb92bfee93d5dc0ceadb91deaee upstream.

spin_lock/unlock was used instead of spin_un/lock_irq
in a procedure used in process space, on a spinlock
which can be grabbed in an interrupt.

This caused the stack trace below to be displayed (on kernel
4.17.0-rc1 compiled with Lock Debugging enabled):

[  154.661474] WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
[  154.668909] 4.17.0-rc1-rdma_rc_mlx+ #3 Tainted: G          I
[  154.675856] -----------------------------------------------------
[  154.682706] modprobe/10159 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[  154.690254] 00000000f3b0e495 (&(&qp_table->lock)->rlock){+.+.}, at: mlx4_qp_remove+0x20/0x50 [mlx4_core]
[  154.700927]
and this task is already holding:
[  154.707461] 0000000094373b5d (&(&cq->lock)->rlock/1){....}, at: destroy_qp_common+0x111/0x560 [mlx4_ib]
[  154.718028] which would create a new lock dependency:
[  154.723705]  (&(&cq->lock)->rlock/1){....} -> (&(&qp_table->lock)->rlock){+.+.}
[  154.731922]
but this new dependency connects a SOFTIRQ-irq-safe lock:
[  154.740798]  (&(&cq->lock)->rlock){..-.}
[  154.740800]
... which became SOFTIRQ-irq-safe at:
[  154.752163]   _raw_spin_lock_irqsave+0x3e/0x50
[  154.757163]   mlx4_ib_poll_cq+0x36/0x900 [mlx4_ib]
[  154.762554]   ipoib_tx_poll+0x4a/0xf0 [ib_ipoib]
...
to a SOFTIRQ-irq-unsafe lock:
[  154.815603]  (&(&qp_table->lock)->rlock){+.+.}
[  154.815604]
... which became SOFTIRQ-irq-unsafe at:
[  154.827718] ...
[  154.827720]   _raw_spin_lock+0x35/0x50
[  154.833912]   mlx4_qp_lookup+0x1e/0x50 [mlx4_core]
[  154.839302]   mlx4_flow_attach+0x3f/0x3d0 [mlx4_core]

Since mlx4_qp_lookup() is called only in process space, we can
simply replace the spin_un/lock calls with spin_un/lock_irq calls.

Fixes: 6dc06c08bef1 ("net/mlx4: Fix the check in attaching steering rules")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/mellanox/mlx4/qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -363,11 +363,11 @@ struct mlx4_qp *mlx4_qp_lookup(struct ml
 	struct mlx4_qp_table *qp_table = &mlx4_priv(dev)->qp_table;
 	struct mlx4_qp *qp;
 
-	spin_lock(&qp_table->lock);
+	spin_lock_irq(&qp_table->lock);
 
 	qp = __mlx4_qp_lookup(dev, qpn);
 
-	spin_unlock(&qp_table->lock);
+	spin_unlock_irq(&qp_table->lock);
 	return qp;
 }
 

