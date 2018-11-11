Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992C6C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BE3223DD
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTSNZRC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63BE3223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbeKLIT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:19:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388186AbeKLIT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:57 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17545208A3;
        Sun, 11 Nov 2018 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975401;
        bh=eZGuiJO0+7Vx9wVscpkkNhWQvhBi3xkU9qASsRJ93V8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NTSNZRC6G3KeGrB6B8GbsaHLF5uPEBzZyF0XscT3hfkSANkb1Afcelcjp1zJScEHs
         hnHWf8jYLn3uhIWOUXGM4LUqAsjSQr4mhdap2XTubE2FmDn9S+kBtNrHg0y7cyPnJy
         404qKd+++XzWSbR+cyuxOUlSw3jQQcrNABuGlzVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bruce Allan <bruce.w.allan@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 098/350] ice: fix changing of ring descriptor size (ethtool -G)
Date:   Sun, 11 Nov 2018 14:19:22 -0800
Message-Id: <20181111221711.202544543@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice.h         |    4 ++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   17 ++++++++++++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

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
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -478,9 +478,11 @@ ice_get_ringparam(struct net_device *net
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
 
@@ -498,14 +500,23 @@ ice_set_ringparam(struct net_device *net
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


