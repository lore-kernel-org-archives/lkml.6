Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21EDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9294920664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB7y1j8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9294920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeKAIIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729851AbeKAIIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB28D20830;
        Wed, 31 Oct 2018 23:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027308;
        bh=xZM3vAlTxqGWiO2nZHvsp2dTWMCK15KsAb2COBsSbL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AB7y1j8GTUCML5omTMC71qJ6+G6XSh1BvwOc4czqdTA+TcG1by7AbUpTrpNsHwAOk
         a0u1JwoFKsKm0HXx6nEa2ppYy8esMlG9if0FXYnQ7YV2RFsts1T4ndpZnCjACx4fiL
         PDx8dx0b+wgtzrAj+DTScWlg3GGqNeMH4T3UNSLE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bruce Allan <bruce.w.allan@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 037/126] ice: fix changing of ring descriptor size (ethtool -G)
Date:   Wed, 31 Oct 2018 19:06:25 -0400
Message-Id: <20181031230754.29029-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruce Allan <bruce.w.allan@intel.com>

[ Upstream commit f934bb9b8b6136edd261b2dc2c9ad4dbc39ffc66 ]

rx_mini_pending was set to an incorrect value. This was causing EINVAL to
always be returned to 'ethtool -G'. The driver does not support mini or
jumbo rings so the respective settings should be zero.

Also, change the valid range of the number of descriptors in the rings to
make the code simpler and easier for users to understand (this removes the
valid settings of 8 and 16). Add a system log message indicating when the
number is rounded-up from what the user specifies with the 'ethtool -G'
command (i.e. when it is not a multiple of 32), and update the log message
when a user-provided value is out of range to also indicate the stride.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice.h         |  4 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 17 ++++++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index ed071ea75f20..ce12824a8325 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -39,9 +39,9 @@
 extern const char ice_drv_ver[];
 #define ICE_BAR0		0
 #define ICE_DFLT_NUM_DESC	128
-#define ICE_MIN_NUM_DESC	8
-#define ICE_MAX_NUM_DESC	8160
 #define ICE_REQ_DESC_MULTIPLE	32
+#define ICE_MIN_NUM_DESC	ICE_REQ_DESC_MULTIPLE
+#define ICE_MAX_NUM_DESC	8160
 #define ICE_DFLT_TRAFFIC_CLASS	BIT(0)
 #define ICE_INT_NAME_STR_LEN	(IFNAMSIZ + 16)
 #define ICE_ETHTOOL_FWVER_LEN	32
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c71a9b528d6d..9d6754f65a1a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -478,9 +478,11 @@ ice_get_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 	ring->tx_max_pending = ICE_MAX_NUM_DESC;
 	ring->rx_pending = vsi->rx_rings[0]->count;
 	ring->tx_pending = vsi->tx_rings[0]->count;
-	ring->rx_mini_pending = ICE_MIN_NUM_DESC;
+
+	/* Rx mini and jumbo rings are not supported */
 	ring->rx_mini_max_pending = 0;
 	ring->rx_jumbo_max_pending = 0;
+	ring->rx_mini_pending = 0;
 	ring->rx_jumbo_pending = 0;
 }
 
@@ -498,14 +500,23 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring)
 	    ring->tx_pending < ICE_MIN_NUM_DESC ||
 	    ring->rx_pending > ICE_MAX_NUM_DESC ||
 	    ring->rx_pending < ICE_MIN_NUM_DESC) {
-		netdev_err(netdev, "Descriptors requested (Tx: %d / Rx: %d) out of range [%d-%d]\n",
+		netdev_err(netdev, "Descriptors requested (Tx: %d / Rx: %d) out of range [%d-%d] (increment %d)\n",
 			   ring->tx_pending, ring->rx_pending,
-			   ICE_MIN_NUM_DESC, ICE_MAX_NUM_DESC);
+			   ICE_MIN_NUM_DESC, ICE_MAX_NUM_DESC,
+			   ICE_REQ_DESC_MULTIPLE);
 		return -EINVAL;
 	}
 
 	new_tx_cnt = ALIGN(ring->tx_pending, ICE_REQ_DESC_MULTIPLE);
+	if (new_tx_cnt != ring->tx_pending)
+		netdev_info(netdev,
+			    "Requested Tx descriptor count rounded up to %d\n",
+			    new_tx_cnt);
 	new_rx_cnt = ALIGN(ring->rx_pending, ICE_REQ_DESC_MULTIPLE);
+	if (new_rx_cnt != ring->rx_pending)
+		netdev_info(netdev,
+			    "Requested Rx descriptor count rounded up to %d\n",
+			    new_rx_cnt);
 
 	/* if nothing to do return success */
 	if (new_tx_cnt == vsi->tx_rings[0]->count &&
-- 
2.17.1

