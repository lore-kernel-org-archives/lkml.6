Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710E8C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0242064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0242064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbeJBUnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:43:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbeJBUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:12 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ABB6EC2B;
        Tue,  2 Oct 2018 13:30:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Tony Brelinski <tonyx.brelinski@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 202/228] ice: Fix a few null pointer dereference issues
Date:   Tue,  2 Oct 2018 06:24:59 -0700
Message-Id: <20181002132511.505556266@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>

[ Upstream commit c7f2c42b80ed6009f44e355aefc1e40db9485a9d ]

1) When ice_ena_msix_range() fails to reserve vectors, a devm_kfree()
   warning was seen in the error flow path. So check pf->irq_tracker
   before use in ice_clear_interrupt_scheme().

2) In ice_vsi_cfg(), check vsi->netdev before use.

3) In ice_get_link_status, check link_up before use.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c |    2 +-
 drivers/net/ethernet/intel/ice/ice_main.c   |   17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1483,7 +1483,7 @@ enum ice_status ice_get_link_status(stru
 	struct ice_phy_info *phy_info;
 	enum ice_status status = 0;
 
-	if (!pi)
+	if (!pi || !link_up)
 		return ICE_ERR_PARAM;
 
 	phy_info = &pi->phy;
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3260,8 +3260,10 @@ static void ice_clear_interrupt_scheme(s
 	if (test_bit(ICE_FLAG_MSIX_ENA, pf->flags))
 		ice_dis_msix(pf);
 
-	devm_kfree(&pf->pdev->dev, pf->irq_tracker);
-	pf->irq_tracker = NULL;
+	if (pf->irq_tracker) {
+		devm_kfree(&pf->pdev->dev, pf->irq_tracker);
+		pf->irq_tracker = NULL;
+	}
 }
 
 /**
@@ -4115,11 +4117,12 @@ static int ice_vsi_cfg(struct ice_vsi *v
 {
 	int err;
 
-	ice_set_rx_mode(vsi->netdev);
-
-	err = ice_restore_vlan(vsi);
-	if (err)
-		return err;
+	if (vsi->netdev) {
+		ice_set_rx_mode(vsi->netdev);
+		err = ice_restore_vlan(vsi);
+		if (err)
+			return err;
+	}
 
 	err = ice_vsi_cfg_txqs(vsi);
 	if (!err)


