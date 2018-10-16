Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F6AC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19152089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2u1mEjIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19152089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeJQBFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727280AbeJQBFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:05:20 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F69421477;
        Tue, 16 Oct 2018 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710037;
        bh=1/Nlq49b31EVc0tWvedHsnUami2pjzeBwcwNeqi9GJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2u1mEjIKfbc906z3C1RNbz3r7H2lfD4B6nZi7azrQ9hmtkqZDxTbbhfbP3d7umB5s
         NxzsT8dhb0w5ov0Ca764dvTlf3B7IO3jJh1io74R0Ed5e+Ep4cA6tfvj3gYpUg7Ix3
         5TnDcmAm5H2yfhAv9TEbWVgoOZ6LMgSRsL9Cviyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 045/135] net: phy: phylink: fix SFP interface autodetection
Date:   Tue, 16 Oct 2018 19:04:35 +0200
Message-Id: <20181016170517.876127514@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/phylink.c |   48 ++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -717,6 +717,30 @@ static int phylink_bringup_phy(struct ph
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
@@ -734,31 +758,13 @@ static int phylink_bringup_phy(struct ph
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
 
@@ -1672,7 +1678,9 @@ static void phylink_sfp_link_up(void *up
 
 static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 {
-	return phylink_connect_phy(upstream, phy);
+	struct phylink *pl = upstream;
+
+	return __phylink_connect_phy(upstream, phy, pl->link_config.interface);
 }
 
 static void phylink_sfp_disconnect_phy(void *upstream)


