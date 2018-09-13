Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E236EC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9494F20C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9494F20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeIMSvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:51:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60124 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbeIMSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:51:42 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B71D7D19;
        Thu, 13 Sep 2018 13:42:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish <manish.chopra@cavium.com>,
        Benjamin Poirier <bpoirier@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 006/115] qlge: Fix netdev features configuration.
Date:   Thu, 13 Sep 2018 15:30:26 +0200
Message-Id: <20180913131823.835822382@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manish Chopra <manish.chopra@cavium.com>

[ Upstream commit 6750c87074c5b534d82fdaabb1deb45b8f1f57de ]

qlge_fix_features() is not supposed to modify hardware or
driver state, rather it is supposed to only fix requested
fetures bits. Currently qlge_fix_features() also goes for
interface down and up unnecessarily if there is not even
any change in features set.

This patch changes/fixes following -

1) Move reload of interface or device re-config from
   qlge_fix_features() to qlge_set_features().
2) Reload of interface in qlge_set_features() only if
   relevant feature bit (NETIF_F_HW_VLAN_CTAG_RX) is changed.
3) Get rid of qlge_fix_features() since driver is not really
   required to fix any features bit.

Signed-off-by: Manish <manish.chopra@cavium.com>
Reviewed-by: Benjamin Poirier <bpoirier@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qlge/qlge_main.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

--- a/drivers/net/ethernet/qlogic/qlge/qlge_main.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_main.c
@@ -2386,26 +2386,20 @@ static int qlge_update_hw_vlan_features(
 	return status;
 }
 
-static netdev_features_t qlge_fix_features(struct net_device *ndev,
-	netdev_features_t features)
-{
-	int err;
-
-	/* Update the behavior of vlan accel in the adapter */
-	err = qlge_update_hw_vlan_features(ndev, features);
-	if (err)
-		return err;
-
-	return features;
-}
-
 static int qlge_set_features(struct net_device *ndev,
 	netdev_features_t features)
 {
 	netdev_features_t changed = ndev->features ^ features;
+	int err;
+
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
+		/* Update the behavior of vlan accel in the adapter */
+		err = qlge_update_hw_vlan_features(ndev, features);
+		if (err)
+			return err;
 
-	if (changed & NETIF_F_HW_VLAN_CTAG_RX)
 		qlge_vlan_mode(ndev, features);
+	}
 
 	return 0;
 }
@@ -4719,7 +4713,6 @@ static const struct net_device_ops qlge_
 	.ndo_set_mac_address	= qlge_set_mac_address,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_tx_timeout		= qlge_tx_timeout,
-	.ndo_fix_features	= qlge_fix_features,
 	.ndo_set_features	= qlge_set_features,
 	.ndo_vlan_rx_add_vid	= qlge_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= qlge_vlan_rx_kill_vid,


