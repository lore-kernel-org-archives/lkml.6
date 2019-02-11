Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856DDC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EC2218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900972;
	bh=qKQsPld7+Gq6rUxJyQb1tECT4aTIdeFg0YFSTf/ufjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GcQe/ucZPsrCSsi+vKaOLmamL003PyEwDunEJpSH8ZW999Nb+jbruN7QcvuI/d+4b
	 WbnboMZkdW8Of6QgpYFHCzW5SOzUjRvTEjDnZAVPxwe0nVa7ASDgMDvi64yHs7WJE9
	 IKgGdVhcESG7X4szLUjl0K4+AcdQfNhRAYzDjevQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfBKQCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730038AbfBKO35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:29:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3370B2082F;
        Mon, 11 Feb 2019 14:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895396;
        bh=qKQsPld7+Gq6rUxJyQb1tECT4aTIdeFg0YFSTf/ufjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sMh4qr0BktRW7zkv4lmbVVFxW9aG2AOCMQRusE6FSgqCGJhkBoI1fv872H3dvp2++
         D4xKXYvzHBHDtNFhIcF2FkL63Isxs54ewXMc+caC9s7nVpajJQ8g4DzMJjATFX2l4o
         KJBZjc8KNFBNEwfWWg1yxVrOOKdKX0HAf4sFrXMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 192/352] bnxt_en: Disable MSIX before re-reserving NQs/CMPL rings.
Date:   Mon, 11 Feb 2019 15:16:59 +0100
Message-Id: <20190211141859.335051590@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 36d65be9a88052cdfc8524eb591baf0e6c878408 ]

When bringing up a device, the code checks to see if the number of
MSIX has changed.  pci_disable_msix() should be called first before
changing the number of reserved NQs/CMPL rings.  This ensures that
the MSIX vectors associated with the NQs/CMPL rings are still
properly mapped when pci_disable_msix() masks the vectors.

This patch will prevent errors when RDMA support is added for the new
57500 chips.  When the RDMA driver shuts down, the number of NQs is
decreased and we must use the new sequence to prevent MSIX errors.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5d21c14853ac..50a4c3ddf977 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7203,23 +7203,26 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
 int bnxt_reserve_rings(struct bnxt *bp)
 {
 	int tcs = netdev_get_num_tc(bp->dev);
+	bool reinit_irq = false;
 	int rc;
 
 	if (!bnxt_need_reserve_rings(bp))
 		return 0;
 
-	rc = __bnxt_reserve_rings(bp);
-	if (rc) {
-		netdev_err(bp->dev, "ring reservation failure rc: %d\n", rc);
-		return rc;
-	}
 	if (BNXT_NEW_RM(bp) && (bnxt_get_num_msix(bp) != bp->total_irqs)) {
 		bnxt_ulp_irq_stop(bp);
 		bnxt_clear_int_mode(bp);
-		rc = bnxt_init_int_mode(bp);
+		reinit_irq = true;
+	}
+	rc = __bnxt_reserve_rings(bp);
+	if (reinit_irq) {
+		if (!rc)
+			rc = bnxt_init_int_mode(bp);
 		bnxt_ulp_irq_restart(bp, rc);
-		if (rc)
-			return rc;
+	}
+	if (rc) {
+		netdev_err(bp->dev, "ring reservation/IRQ init failure rc: %d\n", rc);
+		return rc;
 	}
 	if (tcs && (bp->tx_nr_rings_per_tc * tcs != bp->tx_nr_rings)) {
 		netdev_err(bp->dev, "tx ring reservation failure\n");
-- 
2.19.1



