Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wgiLDc7yG1uAYAAAmS7hNA
	; Sat, 09 Jun 2018 15:34:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1EE25608C8; Sat,  9 Jun 2018 15:34:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqk9t9wq"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 71D76607DC;
	Sat,  9 Jun 2018 15:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 71D76607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbeFIPeB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932511AbeFIPdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:33:52 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13031204EC;
        Sat,  9 Jun 2018 15:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558431;
        bh=Pz0aN/gp/tICcSX+nrWGs59k4E6c7cQWAaHOdaTOvvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zqk9t9wqTut7pXJcyoUSJQy3mbZYwdCUAo0dZVSyDr6JfkDS5adXGhqNVrVjLAh6i
         K9ILuUelCIe38zE0oZt5bHukTKueHFGsQir/3erQEpZiWm4Pex2dNAZDOpp5YmzgPt
         TWwl0xMI+NNx8odyopNDpxamxMrtBRmkIQ9qLTe4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 38/48] net/mlx4: Fix irq-unsafe spinlock usage
Date: Sat,  9 Jun 2018 17:29:50 +0200
Message-Id: <20180609145950.441065171@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -393,11 +393,11 @@ struct mlx4_qp *mlx4_qp_lookup(struct ml
 	struct mlx4_qp_table *qp_table = &mlx4_priv(dev)->qp_table;
 	struct mlx4_qp *qp;
 
-	spin_lock(&qp_table->lock);
+	spin_lock_irq(&qp_table->lock);
 
 	qp = __mlx4_qp_lookup(dev, qpn);
 
-	spin_unlock(&qp_table->lock);
+	spin_unlock_irq(&qp_table->lock);
 	return qp;
 }
 
