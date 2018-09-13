Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35511C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70F820881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70F820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbeIMTAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:00:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33190 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbeIMTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:00:11 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F5DBCFE;
        Thu, 13 Sep 2018 13:50:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 014/197] bnxt_en: Clean up unused functions.
Date:   Thu, 13 Sep 2018 15:29:23 +0200
Message-Id: <20180913131842.136533505@linuxfoundation.org>
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

[ Upstream commit ad95c27bdb930105f3eea02621bda157caf2862d ]

Remove unused bnxt_subtract_ulp_resources().  Change
bnxt_get_max_func_irqs() to static since it is only locally used.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |    2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |    1 -
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |   15 ---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |    1 -
 4 files changed, 1 insertion(+), 18 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5912,7 +5912,7 @@ void bnxt_set_max_func_cp_rings(struct b
 	bp->hw_resc.max_cp_rings = max;
 }
 
-unsigned int bnxt_get_max_func_irqs(struct bnxt *bp)
+static unsigned int bnxt_get_max_func_irqs(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1469,7 +1469,6 @@ unsigned int bnxt_get_max_func_stat_ctxs
 void bnxt_set_max_func_stat_ctxs(struct bnxt *bp, unsigned int max);
 unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp);
 void bnxt_set_max_func_cp_rings(struct bnxt *bp, unsigned int max);
-unsigned int bnxt_get_max_func_irqs(struct bnxt *bp);
 int bnxt_get_avail_msix(struct bnxt *bp, int num);
 int bnxt_reserve_rings(struct bnxt *bp);
 void bnxt_tx_disable(struct bnxt *bp);
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -220,21 +220,6 @@ int bnxt_get_ulp_msix_base(struct bnxt *
 	return 0;
 }
 
-void bnxt_subtract_ulp_resources(struct bnxt *bp, int ulp_id)
-{
-	ASSERT_RTNL();
-	if (bnxt_ulp_registered(bp->edev, ulp_id)) {
-		struct bnxt_en_dev *edev = bp->edev;
-		unsigned int msix_req, max;
-
-		msix_req = edev->ulp_tbl[ulp_id].msix_requested;
-		max = bnxt_get_max_func_cp_rings(bp);
-		bnxt_set_max_func_cp_rings(bp, max - msix_req);
-		max = bnxt_get_max_func_stat_ctxs(bp);
-		bnxt_set_max_func_stat_ctxs(bp, max - 1);
-	}
-}
-
 static int bnxt_send_msg(struct bnxt_en_dev *edev, int ulp_id,
 			 struct bnxt_fw_msg *fw_msg)
 {
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -90,7 +90,6 @@ static inline bool bnxt_ulp_registered(s
 
 int bnxt_get_ulp_msix_num(struct bnxt *bp);
 int bnxt_get_ulp_msix_base(struct bnxt *bp);
-void bnxt_subtract_ulp_resources(struct bnxt *bp, int ulp_id);
 void bnxt_ulp_stop(struct bnxt *bp);
 void bnxt_ulp_start(struct bnxt *bp);
 void bnxt_ulp_sriov_cfg(struct bnxt *bp, int num_vfs);


