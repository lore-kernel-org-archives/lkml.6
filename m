Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2DAC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14CB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896381;
	bh=T5wUs41lArKKshnbE/bJQazh0s7EyBLKdjoluqRFj+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NjqsP0q6VqFZepB/uTXOVl49z+jaU39SNORPNeVK1Qa4UnUXe9Nyl9GW4XQwySj21
	 Rjhw2Yxm8DCOXxSjJjb+cladHge8mrz1tjKOsEoFggKivChvftOfs3P1XCt9G6WaK4
	 8ubXLClXF5KpZeCUwGeB5x28qyddBM8pvA+Wfq5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbfBKOqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733183AbfBKOqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E016206BA;
        Mon, 11 Feb 2019 14:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896372;
        bh=T5wUs41lArKKshnbE/bJQazh0s7EyBLKdjoluqRFj+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEXdbW3oRmJaYG1JDYOA3woIFoskb4Rx9sljSRIk1mzwRTSYeAM7CPgWL3fquHq2o
         3E/GxcWzzYDsS2oyJTNZSgTJ7jQuodEhUaOjD7ly5cshWXkFhhm9GN+Kt89d22d48y
         UGhDpxGkan+zVnMiTh2XlHQcBbkYvFuOTvDmDOX8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 163/313] bnxt_en: Disable MSIX before re-reserving NQs/CMPL rings.
Date:   Mon, 11 Feb 2019 15:17:23 +0100
Message-Id: <20190211141904.368663103@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



