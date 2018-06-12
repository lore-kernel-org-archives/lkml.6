Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ECE21C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23DF208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv48kKr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23DF208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934887AbeFLQry (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:47:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:32910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934744AbeFLQrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:47:51 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74412208B7;
        Tue, 12 Jun 2018 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822071;
        bh=Lhsik9VY3/qtRndCmZMCs85od6fhZ7ZeI/ow8uDNJ+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hv48kKr5wz1OT9FVCvtZ5XN8d62YqLS6BVAOKCoTq9FrENuJ4OGYO2c943kgaM9/s
         UJ/x5TbNxNvi047mmgu5tu105ZTCWmfzjtkuum1x+H3Em9cxJL8tTNsuJw4HlnblCL
         /C3rM0UjAo3wZxgFG9P3+zZRC1XgUFPFg9wBQ6Z8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 24/31] net/mlx4: Fix irq-unsafe spinlock usage
Date:   Tue, 12 Jun 2018 18:46:27 +0200
Message-Id: <20180612164621.741710164@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164620.797338191@linuxfoundation.org>
References: <20180612164620.797338191@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit d546b67cda015fb92bfee93d5dc0ceadb91deaee ]

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/qp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/qp.c
+++ b/drivers/net/ethernet/mellanox/mlx4/qp.c
@@ -392,11 +392,11 @@ struct mlx4_qp *mlx4_qp_lookup(struct ml
 	struct mlx4_qp_table *qp_table = &mlx4_priv(dev)->qp_table;
 	struct mlx4_qp *qp;
 
-	spin_lock(&qp_table->lock);
+	spin_lock_irq(&qp_table->lock);
 
 	qp = __mlx4_qp_lookup(dev, qpn);
 
-	spin_unlock(&qp_table->lock);
+	spin_unlock_irq(&qp_table->lock);
 	return qp;
 }
 


