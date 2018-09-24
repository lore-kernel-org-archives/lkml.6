Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6408C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716F6208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716F6208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeIXSNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:13:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54838 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbeIXSNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:13:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4DD891082;
        Mon, 24 Sep 2018 12:11:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Yanhui He <yanhuih@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 110/111] e1000e: Fix link check race condition
Date:   Mon, 24 Sep 2018 13:53:17 +0200
Message-Id: <20180924113116.226495480@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.337261320@linuxfoundation.org>
References: <20180924113103.337261320@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Poirier <bpoirier@suse.com>

commit e2710dbf0dc1e37d85368e2404049dadda848d5a upstream.

Alex reported the following race condition:

/* link goes up... interrupt... schedule watchdog */
\ e1000_watchdog_task
	\ e1000e_has_link
		\ hw->mac.ops.check_for_link() === e1000e_check_for_copper_link
			\ e1000e_phy_has_link_generic(..., &link)
				link = true

					 /* link goes down... interrupt */
					 \ e1000_msix_other
						 hw->mac.get_link_status = true

			/* link is up */
			mac->get_link_status = false

		link_active = true
		/* link_active is true, wrongly, and stays so because
		 * get_link_status is false */

Avoid this problem by making sure that we don't set get_link_status = false
after having checked the link.

It seems this problem has been present since the introduction of e1000e.

Link: https://lkml.org/lkml/2018/1/29/338
Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Yanhui He <yanhuih@vmware.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |   31 +++++++++++++++-------------
 drivers/net/ethernet/intel/e1000e/mac.c     |   14 ++++++------
 2 files changed, 24 insertions(+), 21 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1380,6 +1380,7 @@ static s32 e1000_check_for_copper_link_i
 	 */
 	if (!mac->get_link_status)
 		return 0;
+	mac->get_link_status = false;
 
 	/* First we want to see if the MII Status Register reports
 	 * link.  If so, then we want to get the current speed/duplex
@@ -1387,12 +1388,12 @@ static s32 e1000_check_for_copper_link_i
 	 */
 	ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
 	if (ret_val)
-		return ret_val;
+		goto out;
 
 	if (hw->mac.type == e1000_pchlan) {
 		ret_val = e1000_k1_gig_workaround_hv(hw, link);
 		if (ret_val)
-			return ret_val;
+			goto out;
 	}
 
 	/* When connected at 10Mbps half-duplex, some parts are excessively
@@ -1427,7 +1428,7 @@ static s32 e1000_check_for_copper_link_i
 
 		ret_val = hw->phy.ops.acquire(hw);
 		if (ret_val)
-			return ret_val;
+			goto out;
 
 		if (hw->mac.type == e1000_pch2lan)
 			emi_addr = I82579_RX_CONFIG;
@@ -1450,7 +1451,7 @@ static s32 e1000_check_for_copper_link_i
 		hw->phy.ops.release(hw);
 
 		if (ret_val)
-			return ret_val;
+			goto out;
 
 		if (hw->mac.type == e1000_pch_spt) {
 			u16 data;
@@ -1459,14 +1460,14 @@ static s32 e1000_check_for_copper_link_i
 			if (speed == SPEED_1000) {
 				ret_val = hw->phy.ops.acquire(hw);
 				if (ret_val)
-					return ret_val;
+					goto out;
 
 				ret_val = e1e_rphy_locked(hw,
 							  PHY_REG(776, 20),
 							  &data);
 				if (ret_val) {
 					hw->phy.ops.release(hw);
-					return ret_val;
+					goto out;
 				}
 
 				ptr_gap = (data & (0x3FF << 2)) >> 2;
@@ -1480,18 +1481,18 @@ static s32 e1000_check_for_copper_link_i
 				}
 				hw->phy.ops.release(hw);
 				if (ret_val)
-					return ret_val;
+					goto out;
 			} else {
 				ret_val = hw->phy.ops.acquire(hw);
 				if (ret_val)
-					return ret_val;
+					goto out;
 
 				ret_val = e1e_wphy_locked(hw,
 							  PHY_REG(776, 20),
 							  0xC023);
 				hw->phy.ops.release(hw);
 				if (ret_val)
-					return ret_val;
+					goto out;
 
 			}
 		}
@@ -1518,7 +1519,7 @@ static s32 e1000_check_for_copper_link_i
 	    (hw->adapter->pdev->device == E1000_DEV_ID_PCH_I218_V3)) {
 		ret_val = e1000_k1_workaround_lpt_lp(hw, link);
 		if (ret_val)
-			return ret_val;
+			goto out;
 	}
 	if ((hw->mac.type == e1000_pch_lpt) ||
 	    (hw->mac.type == e1000_pch_spt)) {
@@ -1527,7 +1528,7 @@ static s32 e1000_check_for_copper_link_i
 		 */
 		ret_val = e1000_platform_pm_pch_lpt(hw, link);
 		if (ret_val)
-			return ret_val;
+			goto out;
 	}
 
 	/* Clear link partner's EEE ability */
@@ -1547,9 +1548,7 @@ static s32 e1000_check_for_copper_link_i
 	}
 
 	if (!link)
-		return 0;	/* No link detected */
-
-	mac->get_link_status = false;
+		goto out;
 
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
@@ -1615,6 +1614,10 @@ static s32 e1000_check_for_copper_link_i
 		e_dbg("Error configuring flow control\n");
 
 	return ret_val;
+
+out:
+	mac->get_link_status = true;
+	return ret_val;
 }
 
 static s32 e1000_get_variants_ich8lan(struct e1000_adapter *adapter)
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -424,19 +424,15 @@ s32 e1000e_check_for_copper_link(struct
 	 */
 	if (!mac->get_link_status)
 		return 0;
+	mac->get_link_status = false;
 
 	/* First we want to see if the MII Status Register reports
 	 * link.  If so, then we want to get the current speed/duplex
 	 * of the PHY.
 	 */
 	ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
-	if (ret_val)
-		return ret_val;
-
-	if (!link)
-		return 0;	/* No link detected */
-
-	mac->get_link_status = false;
+	if (ret_val || !link)
+		goto out;
 
 	/* Check if there was DownShift, must be checked
 	 * immediately after link-up
@@ -465,6 +461,10 @@ s32 e1000e_check_for_copper_link(struct
 		e_dbg("Error configuring flow control\n");
 
 	return ret_val;
+
+out:
+	mac->get_link_status = true;
+	return ret_val;
 }
 
 /**


