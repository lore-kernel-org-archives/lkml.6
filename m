Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7366EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397CF20871
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVPm9C/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397CF20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbeKLKDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:03:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbeKLIRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:17 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 393BC21508;
        Sun, 11 Nov 2018 22:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975242;
        bh=+VtGXGDZV3xoe/yne6S9XJyv4WoM5IhkwCUQkRCl3iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FVPm9C/dLHu7XjJdQ5DpIT07FxmvsiJrEd+OvPj6WJUA+bp491B4muM31Lqc749zj
         zKpOLdk456IZLjpSUqmD705xux26b+pj6unibXyzN+FufTW+2DmVXxqFXO53zwVd/N
         JerGH1RfRYoVg5pbL3cCvxGR6WYvFlwvRsXbaoGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bruce Allan <bruce.w.allan@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 088/361] ice: fix changing of ring descriptor size (ethtool -G)
Date:   Sun, 11 Nov 2018 14:17:15 -0800
Message-Id: <20181111221632.144443197@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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


