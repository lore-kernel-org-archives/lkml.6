Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2561C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DCE20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DCE20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbeIMTAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:00:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbeIMTAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:00:22 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 199EACFE;
        Thu, 13 Sep 2018 13:50:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 015/197] bnxt_en: Do not adjust max_cp_rings by the ones used by RDMA.
Date:   Thu, 13 Sep 2018 15:29:24 +0200
Message-Id: <20180913131842.180746718@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 00fe9c326d2027f2437dea38ef0e82f9d02d94c0 ]

Currently, the driver adjusts the bp->hw_resc.max_cp_rings by the number
of MSIX vectors used by RDMA.  There is one code path in open that needs
to check the true max_cp_rings including any used by RDMA.  This code
is now checking for the reduced max_cp_rings which will fail when the
number of cp rings is very small.

To fix this in a clean way, we don't adjust max_cp_rings anymore.
Instead, we add a helper bnxt_get_max_func_cp_rings_for_en() to get the
reduced max_cp_rings when appropriate.

Fixes: ec86f14ea506 ("bnxt_en: Add ULP calls to stop and restart IRQs.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |    7 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h       |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c |    7 ++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c   |    5 -----
 4 files changed, 9 insertions(+), 12 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5907,9 +5907,9 @@ unsigned int bnxt_get_max_func_cp_rings(
 	return bp->hw_resc.max_cp_rings;
 }
 
-void bnxt_set_max_func_cp_rings(struct bnxt *bp, unsigned int max)
+unsigned int bnxt_get_max_func_cp_rings_for_en(struct bnxt *bp)
 {
-	bp->hw_resc.max_cp_rings = max;
+	return bp->hw_resc.max_cp_rings - bnxt_get_ulp_msix_num(bp);
 }
 
 static unsigned int bnxt_get_max_func_irqs(struct bnxt *bp)
@@ -8492,7 +8492,8 @@ static void _bnxt_get_max_rings(struct b
 
 	*max_tx = hw_resc->max_tx_rings;
 	*max_rx = hw_resc->max_rx_rings;
-	*max_cp = min_t(int, hw_resc->max_irqs, hw_resc->max_cp_rings);
+	*max_cp = min_t(int, bnxt_get_max_func_cp_rings_for_en(bp),
+			hw_resc->max_irqs);
 	*max_cp = min_t(int, *max_cp, hw_resc->max_stat_ctxs);
 	max_ring_grps = hw_resc->max_hw_ring_grps;
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp) && BNXT_PF(bp)) {
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1468,7 +1468,7 @@ int bnxt_hwrm_set_coal(struct bnxt *);
 unsigned int bnxt_get_max_func_stat_ctxs(struct bnxt *bp);
 void bnxt_set_max_func_stat_ctxs(struct bnxt *bp, unsigned int max);
 unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp);
-void bnxt_set_max_func_cp_rings(struct bnxt *bp, unsigned int max);
+unsigned int bnxt_get_max_func_cp_rings_for_en(struct bnxt *bp);
 int bnxt_get_avail_msix(struct bnxt *bp, int num);
 int bnxt_reserve_rings(struct bnxt *bp);
 void bnxt_tx_disable(struct bnxt *bp);
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -451,7 +451,7 @@ static int bnxt_hwrm_func_vf_resc_cfg(st
 
 	bnxt_hwrm_cmd_hdr_init(bp, &req, HWRM_FUNC_VF_RESOURCE_CFG, -1, -1);
 
-	vf_cp_rings = hw_resc->max_cp_rings - bp->cp_nr_rings;
+	vf_cp_rings = bnxt_get_max_func_cp_rings_for_en(bp) - bp->cp_nr_rings;
 	vf_stat_ctx = hw_resc->max_stat_ctxs - bp->num_stat_ctxs;
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		vf_rx_rings = hw_resc->max_rx_rings - bp->rx_nr_rings * 2;
@@ -544,7 +544,8 @@ static int bnxt_hwrm_func_cfg(struct bnx
 	max_stat_ctxs = hw_resc->max_stat_ctxs;
 
 	/* Remaining rings are distributed equally amongs VF's for now */
-	vf_cp_rings = (hw_resc->max_cp_rings - bp->cp_nr_rings) / num_vfs;
+	vf_cp_rings = (bnxt_get_max_func_cp_rings_for_en(bp) -
+		       bp->cp_nr_rings) / num_vfs;
 	vf_stat_ctx = (max_stat_ctxs - bp->num_stat_ctxs) / num_vfs;
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		vf_rx_rings = (hw_resc->max_rx_rings - bp->rx_nr_rings * 2) /
@@ -638,7 +639,7 @@ static int bnxt_sriov_enable(struct bnxt
 	 */
 	vfs_supported = *num_vfs;
 
-	avail_cp = hw_resc->max_cp_rings - bp->cp_nr_rings;
+	avail_cp = bnxt_get_max_func_cp_rings_for_en(bp) - bp->cp_nr_rings;
 	avail_stat = hw_resc->max_stat_ctxs - bp->num_stat_ctxs;
 	avail_cp = min_t(int, avail_cp, avail_stat);
 
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -169,7 +169,6 @@ static int bnxt_req_msix_vecs(struct bnx
 		edev->ulp_tbl[ulp_id].msix_requested = avail_msix;
 	}
 	bnxt_fill_msix_vecs(bp, ent);
-	bnxt_set_max_func_cp_rings(bp, max_cp_rings - avail_msix);
 	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
 	return avail_msix;
 }
@@ -178,7 +177,6 @@ static int bnxt_free_msix_vecs(struct bn
 {
 	struct net_device *dev = edev->net;
 	struct bnxt *bp = netdev_priv(dev);
-	int max_cp_rings, msix_requested;
 
 	ASSERT_RTNL();
 	if (ulp_id != BNXT_ROCE_ULP)
@@ -187,9 +185,6 @@ static int bnxt_free_msix_vecs(struct bn
 	if (!(edev->flags & BNXT_EN_FLAG_MSIX_REQUESTED))
 		return 0;
 
-	max_cp_rings = bnxt_get_max_func_cp_rings(bp);
-	msix_requested = edev->ulp_tbl[ulp_id].msix_requested;
-	bnxt_set_max_func_cp_rings(bp, max_cp_rings + msix_requested);
 	edev->ulp_tbl[ulp_id].msix_requested = 0;
 	edev->flags &= ~BNXT_EN_FLAG_MSIX_REQUESTED;
 	if (netif_running(dev)) {


