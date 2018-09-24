Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85150ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40FF020877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FF020877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbeIXSKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:10:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbeIXSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:10:12 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDD751081;
        Mon, 24 Sep 2018 12:08:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Yanhui He <yanhuih@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.9 109/111] Revert "e1000e: Separate signaling for link check/link up"
Date:   Mon, 24 Sep 2018 13:53:16 +0200
Message-Id: <20180924113116.076037057@linuxfoundation.org>
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

commit 3016e0a0c91246e55418825ba9aae271be267522 upstream.

This reverts commit 19110cfbb34d4af0cdfe14cd243f3b09dc95b013.
This reverts commit 4110e02eb45ea447ec6f5459c9934de0a273fb91.
This reverts commit d3604515c9eda464a92e8e67aae82dfe07fe3c98.

Commit 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
changed what happens to the link status when there is an error which
happens after "get_link_status = false" in the copper check_for_link
callbacks. Previously, such an error would be ignored and the link
considered up. After that commit, any error implies that the link is down.

Revert commit 19110cfbb34d ("e1000e: Separate signaling for link check/link
up") and its followups. After reverting, the race condition described in
the log of commit 19110cfbb34d is reintroduced. It may still be triggered
by LSC events but this should keep the link down in case the link is
electrically unstable, as discussed. The race may no longer be
triggered by RXO events because commit 4aea7a5c5e94 ("e1000e: Avoid
receiver overrun interrupt bursts") restored reading icr in the Other
handler.

Link: https://lkml.org/lkml/2018/3/1/789
Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Yanhui He <yanhuih@vmware.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |   13 ++++---------
 drivers/net/ethernet/intel/e1000e/mac.c     |   13 ++++---------
 drivers/net/ethernet/intel/e1000e/netdev.c  |    2 +-
 3 files changed, 9 insertions(+), 19 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1364,9 +1364,6 @@ out:
  *  Checks to see of the link status of the hardware has changed.  If a
  *  change in link status has been detected, then we read the PHY registers
  *  to get the current speed/duplex if link exists.
- *
- *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (link
- *  up).
  **/
 static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 {
@@ -1382,7 +1379,7 @@ static s32 e1000_check_for_copper_link_i
 	 * Change or Rx Sequence Error interrupt.
 	 */
 	if (!mac->get_link_status)
-		return 1;
+		return 0;
 
 	/* First we want to see if the MII Status Register reports
 	 * link.  If so, then we want to get the current speed/duplex
@@ -1600,7 +1597,7 @@ static s32 e1000_check_for_copper_link_i
 	 * we have already determined whether we have link or not.
 	 */
 	if (!mac->autoneg)
-		return 1;
+		return -E1000_ERR_CONFIG;
 
 	/* Auto-Neg is enabled.  Auto Speed Detection takes care
 	 * of MAC speed/duplex configuration.  So we only need to
@@ -1614,12 +1611,10 @@ static s32 e1000_check_for_copper_link_i
 	 * different link partner.
 	 */
 	ret_val = e1000e_config_fc_after_link_up(hw);
-	if (ret_val) {
+	if (ret_val)
 		e_dbg("Error configuring flow control\n");
-		return ret_val;
-	}
 
-	return 1;
+	return ret_val;
 }
 
 static s32 e1000_get_variants_ich8lan(struct e1000_adapter *adapter)
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -410,9 +410,6 @@ void e1000e_clear_hw_cntrs_base(struct e
  *  Checks to see of the link status of the hardware has changed.  If a
  *  change in link status has been detected, then we read the PHY registers
  *  to get the current speed/duplex if link exists.
- *
- *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (link
- *  up).
  **/
 s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 {
@@ -426,7 +423,7 @@ s32 e1000e_check_for_copper_link(struct
 	 * Change or Rx Sequence Error interrupt.
 	 */
 	if (!mac->get_link_status)
-		return 1;
+		return 0;
 
 	/* First we want to see if the MII Status Register reports
 	 * link.  If so, then we want to get the current speed/duplex
@@ -450,7 +447,7 @@ s32 e1000e_check_for_copper_link(struct
 	 * we have already determined whether we have link or not.
 	 */
 	if (!mac->autoneg)
-		return 1;
+		return -E1000_ERR_CONFIG;
 
 	/* Auto-Neg is enabled.  Auto Speed Detection takes care
 	 * of MAC speed/duplex configuration.  So we only need to
@@ -464,12 +461,10 @@ s32 e1000e_check_for_copper_link(struct
 	 * different link partner.
 	 */
 	ret_val = e1000e_config_fc_after_link_up(hw);
-	if (ret_val) {
+	if (ret_val)
 		e_dbg("Error configuring flow control\n");
-		return ret_val;
-	}
 
-	return 1;
+	return ret_val;
 }
 
 /**
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -5074,7 +5074,7 @@ static bool e1000e_has_link(struct e1000
 	case e1000_media_type_copper:
 		if (hw->mac.get_link_status) {
 			ret_val = hw->mac.ops.check_for_link(hw);
-			link_active = ret_val > 0;
+			link_active = !hw->mac.get_link_status;
 		} else {
 			link_active = true;
 		}


