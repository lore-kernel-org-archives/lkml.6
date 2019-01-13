Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DCDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612662086C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 00:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=araneo.si header.i=@araneo.si header.b="aTEaHLeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfAMAct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 19:32:49 -0500
Received: from BSN-77-101-244.static.siol.net ([193.77.101.244]:43480 "EHLO
        araneo.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfAMAct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 19:32:49 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jan 2019 19:32:48 EST
Received: from araneo.si (localhost.lan [127.0.0.1])
        by araneo.si (OpenSMTPD) with ESMTP id b0aeee70;
        Sun, 13 Jan 2019 00:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=araneo.si; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=20180623; bh=WYcNJzRkBf9RHhM51jGxPIUl8eY=; b=aTEaHLeOvRzZa6Ub
        HXoBN6O4i7lDaWY0sSZaH+q9N/sNrKv46ZvtoWqosP0VZRFu0bk2n5dPH3El3EO6
        AWW4Yky1ej87I4hBD7Ht1GkfAfJm3JnYSOEVJti07gxD6DCKW893SJrw7ZK1juz6
        GFV/FVJtDKn3hBLrZ+99OeH7e0hQ1CoPEzhSAwEpYRcVprwjZr4XceAuDAVcEjnP
        hJKyKGTNLY7qWeweRjhIRUzIu6IzXoGtX52gIBRSO1ee/bUYqWxLkHYQgyWRehy0
        DJrmktcY1DJTccKQk772+eHyZqfETF/NwFzenIFwrgvkzsVVNqanrgoJBavZsr/j
        RScdoQ==
Received: by araneo.si (OpenSMTPD) with ESMTPSA id 25b476e9 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sun, 13 Jan 2019 00:26:07 +0000 (UTC)
From:   Timotej Lazar <timotej.lazar@araneo.si>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Timotej Lazar <timotej.lazar@araneo.si>
Subject: [PATCH net] net: phy: meson-gxl: Use the genphy_soft_reset callback
Date:   Sun, 13 Jan 2019 01:22:55 +0100
Message-Id: <20190113002255.15310-1-timotej.lazar@araneo.si>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the referenced commit, Ethernet fails to come up at boot on the
board meson-gxl-s905x-libretech-cc. Fix this by re-enabling the
genphy_soft_reset callback for the Amlogic Meson GXL PHY driver.

Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
Signed-off-by: Timotej Lazar <timotej.lazar@araneo.si>
---
 drivers/net/phy/meson-gxl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index b03bcf2c388a..3ddaf9595697 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -233,6 +233,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.name		= "Meson GXL Internal PHY",
 		.features	= PHY_BASIC_FEATURES,
 		.flags		= PHY_IS_INTERNAL,
+		.soft_reset     = genphy_soft_reset,
 		.config_init	= meson_gxl_config_init,
 		.aneg_done      = genphy_aneg_done,
 		.read_status	= meson_gxl_read_status,
-- 
2.20.1

