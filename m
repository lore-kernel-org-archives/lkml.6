Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBZCbt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:31:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751931AbeBZCbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:31:44 -0500
From: Benjamin Poirier <bpoirier@suse.com>
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] e1000e: Fix link check race condition.
Date: Mon, 26 Feb 2018 11:31:18 +0900
Message-Id: <20180226023118.17439-1-bpoirier@suse.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <CAKgT0UffXiggXxC5x1vrtbnKPHzcy8+VTRvBGBH-7tCYmUi6LQ@mail.gmail.com>
References: <CAKgT0UffXiggXxC5x1vrtbnKPHzcy8+VTRvBGBH-7tCYmUi6LQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 41 ++++++++++++++++-------------
 drivers/net/ethernet/intel/e1000e/mac.c     | 14 +++++++---
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index ff308b05d68c..3c2c4f87e075 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1386,6 +1386,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	 */
 	if (!mac->get_link_status)
 		return 1;
+	mac->get_link_status = false;
 
 	/* First we want to see if the MII Status Register reports
 	 * link.  If so, then we want to get the current speed/duplex
@@ -1393,12 +1394,12 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
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
@@ -1431,7 +1432,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 
 		ret_val = hw->phy.ops.acquire(hw);
 		if (ret_val)
-			return ret_val;
+			goto out;
 
 		if (hw->mac.type == e1000_pch2lan)
 			emi_addr = I82579_RX_CONFIG;
@@ -1453,7 +1454,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 		hw->phy.ops.release(hw);
 
 		if (ret_val)
-			return ret_val;
+			goto out;
 
 		if (hw->mac.type >= e1000_pch_spt) {
 			u16 data;
@@ -1462,14 +1463,14 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
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
@@ -1483,18 +1484,18 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
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
@@ -1521,7 +1522,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	    (hw->adapter->pdev->device == E1000_DEV_ID_PCH_I218_V3)) {
 		ret_val = e1000_k1_workaround_lpt_lp(hw, link);
 		if (ret_val)
-			return ret_val;
+			goto out;
 	}
 	if (hw->mac.type >= e1000_pch_lpt) {
 		/* Set platform power management values for
@@ -1529,7 +1530,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 		 */
 		ret_val = e1000_platform_pm_pch_lpt(hw, link);
 		if (ret_val)
-			return ret_val;
+			goto out;
 	}
 
 	/* Clear link partner's EEE ability */
@@ -1551,22 +1552,22 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 		ew32(FEXTNVM6, fextnvm6);
 	}
 
-	if (!link)
+	if (!link) {
+		mac->get_link_status = true;
 		return 0;	/* No link detected */
-
-	mac->get_link_status = false;
+	}
 
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
 		ret_val = e1000_k1_workaround_lv(hw);
 		if (ret_val)
-			return ret_val;
+			goto out;
 		/* fall-thru */
 	case e1000_pchlan:
 		if (hw->phy.type == e1000_phy_82578) {
 			ret_val = e1000_link_stall_workaround_hv(hw);
 			if (ret_val)
-				return ret_val;
+				goto out;
 		}
 
 		/* Workaround for PCHx parts in half-duplex:
@@ -1595,7 +1596,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	if (hw->phy.type > e1000_phy_82579) {
 		ret_val = e1000_set_eee_pchlan(hw);
 		if (ret_val)
-			return ret_val;
+			goto out;
 	}
 
 	/* If we are forcing speed/duplex, then we simply return since
@@ -1618,10 +1619,14 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 	ret_val = e1000e_config_fc_after_link_up(hw);
 	if (ret_val) {
 		e_dbg("Error configuring flow control\n");
-		return ret_val;
+		goto out;
 	}
 
 	return 1;
+
+out:
+	mac->get_link_status = true;
+	return ret_val;
 }
 
 static s32 e1000_get_variants_ich8lan(struct e1000_adapter *adapter)
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index db735644b312..60c8beaf5cb3 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -427,6 +427,7 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 	 */
 	if (!mac->get_link_status)
 		return 1;
+	mac->get_link_status = false;
 
 	/* First we want to see if the MII Status Register reports
 	 * link.  If so, then we want to get the current speed/duplex
@@ -434,12 +435,13 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 	 */
 	ret_val = e1000e_phy_has_link_generic(hw, 1, 0, &link);
 	if (ret_val)
-		return ret_val;
+		goto out;
 
-	if (!link)
+	if (!link) {
+		mac->get_link_status = true;
 		return 0;	/* No link detected */
+	}
 
-	mac->get_link_status = false;
 
 	/* Check if there was DownShift, must be checked
 	 * immediately after link-up
@@ -466,10 +468,14 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 	ret_val = e1000e_config_fc_after_link_up(hw);
 	if (ret_val) {
 		e_dbg("Error configuring flow control\n");
-		return ret_val;
+		goto out;
 	}
 
 	return 1;
+
+out:
+	mac->get_link_status = true;
+	return ret_val;
 }
 
 /**
-- 
2.16.1
