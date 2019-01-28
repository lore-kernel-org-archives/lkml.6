Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20113C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28652082E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695696;
	bh=uHnkHQQsOVEeoAnRkGNL9lBBtPsK+Co/sNtCztttgWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pAVkSKbngPhXqiFaNmoFnzFueK3orPq0b6FiW+XWVClbIULSGhAm41rYPdIFrpClJ
	 z57RQgAKlqhKMo3sEXz2wq2S9/dYalGC13ary2nAC1zS2p2Fbmo2G040501etczCgt
	 HwnCLjXVbNejC132MgdYPaJCnVb/mdXvTqrfUC8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbfA1ROy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:14:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbfA1QHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:07:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8062147A;
        Mon, 28 Jan 2019 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691645;
        bh=uHnkHQQsOVEeoAnRkGNL9lBBtPsK+Co/sNtCztttgWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n030O25dj8PlOr46ECGSTZ3sq5YnxaifAhWGd4z9JyYV161/zoTuVEZkOzKylSXA4
         q5xqgOndpEB4CyY8qfWENK+mUBsBlioMod4sUspB8YOceY3E950R60Q/8XxHKbYPVC
         d5P3S+I2pYdDgNExHCQwMHPrlTx9BRBn76l8bVi4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 171/258] bnxt_en: Disable MSIX before re-reserving NQs/CMPL rings.
Date:   Mon, 28 Jan 2019 10:57:57 -0500
Message-Id: <20190128155924.51521-171-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

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
index e2d92548226a..034f57500f00 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6073,23 +6073,26 @@ static void bnxt_clear_int_mode(struct bnxt *bp)
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

