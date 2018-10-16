Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F50C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C097C21480
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qskkIIcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C097C21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeJPMCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbeJPMCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6B8221486;
        Tue, 16 Oct 2018 04:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663227;
        bh=1Wqy80LMEUXChyhtEA7qB2smNSPyw/fOd4od/XbrePA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qskkIIcnP+76rdb69WlhvBi/OF1wVdmHntEvE9OH2l5kMi6wmDs52itvxFMOiwK7C
         VM447CNv3Ng7GTrPwchUdRdpBTCy3rK0N8dq0jS2ZaXztK8eX1whV1s1CcRE9gd9aD
         au8dZb6vJhO7mw+Z3kXPRI56jPh7fP0NCA1B288s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Baruch Siach <baruch@tkos.co.il>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 090/100] net: phy: phylink: fix SFP interface autodetection
Date:   Tue, 16 Oct 2018 00:12:11 -0400
Message-Id: <20181016041221.135528-90-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit 7e4183752735deb7543e179a44f4f4b44917cd6f ]

When connecting SFP PHY to phylink use the detected interface.
Otherwise, the link fails to come up when the configured 'phy-mode'
differs from the SFP detected mode.

Move most of phylink_connect_phy() into __phylink_connect_phy(), and
leave phylink_connect_phy() as a wrapper. phylink_sfp_connect_phy() can
now pass the SFP detected PHY interface to __phylink_connect_phy().

This fixes 1GB SFP module link up on eth3 of the Macchiatobin board that
is configured in the DT to "2500base-x" phy-mode.

Fixes: 9525ae83959b6 ("phylink: add phylink infrastructure")
Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/phylink.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index af4dc4425be2..5827fccd4f29 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -717,6 +717,30 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy)
 	return 0;
 }
 
+static int __phylink_connect_phy(struct phylink *pl, struct phy_device *phy,
+		phy_interface_t interface)
+{
+	int ret;
+
+	if (WARN_ON(pl->link_an_mode == MLO_AN_FIXED ||
+		    (pl->link_an_mode == MLO_AN_INBAND &&
+		     phy_interface_mode_is_8023z(interface))))
+		return -EINVAL;
+
+	if (pl->phydev)
+		return -EBUSY;
+
+	ret = phy_attach_direct(pl->netdev, phy, 0, interface);
+	if (ret)
+		return ret;
+
+	ret = phylink_bringup_phy(pl, phy);
+	if (ret)
+		phy_detach(phy);
+
+	return ret;
+}
+
 /**
  * phylink_connect_phy() - connect a PHY to the phylink instance
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -734,31 +758,13 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy)
  */
 int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)
 {
-	int ret;
-
-	if (WARN_ON(pl->link_an_mode == MLO_AN_FIXED ||
-		    (pl->link_an_mode == MLO_AN_INBAND &&
-		     phy_interface_mode_is_8023z(pl->link_interface))))
-		return -EINVAL;
-
-	if (pl->phydev)
-		return -EBUSY;
-
 	/* Use PHY device/driver interface */
 	if (pl->link_interface == PHY_INTERFACE_MODE_NA) {
 		pl->link_interface = phy->interface;
 		pl->link_config.interface = pl->link_interface;
 	}
 
-	ret = phy_attach_direct(pl->netdev, phy, 0, pl->link_interface);
-	if (ret)
-		return ret;
-
-	ret = phylink_bringup_phy(pl, phy);
-	if (ret)
-		phy_detach(phy);
-
-	return ret;
+	return __phylink_connect_phy(pl, phy, pl->link_interface);
 }
 EXPORT_SYMBOL_GPL(phylink_connect_phy);
 
@@ -1672,7 +1678,9 @@ static void phylink_sfp_link_up(void *upstream)
 
 static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 {
-	return phylink_connect_phy(upstream, phy);
+	struct phylink *pl = upstream;
+
+	return __phylink_connect_phy(upstream, phy, pl->link_config.interface);
 }
 
 static void phylink_sfp_disconnect_phy(void *upstream)
-- 
2.17.1

