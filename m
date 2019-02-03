Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D7C282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D8C2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfBCOU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:20:28 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55382 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729901AbfBCOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:23 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdC-0006Ij-Ei; Sun, 03 Feb 2019 14:20:22 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9V-0006qf-0I; Sun, 03 Feb 2019 14:49:41 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Clemens Gruber" <clemens.gruber@pqgruber.com>,
        "Chris Healy" <cphealy@gmail.com>,
        "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.750825954@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 044/305] net: phy: Stop with excessive soft reset
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

commit 6e2d85ec05591b739059f65fe8438c9c5999f7d8 upstream.

While consolidating the PHY reset in phy_init_hw() an unconditionaly
BMCR soft-reset I became quite trigger happy with those. This was later
on deactivated for the Generic PHY driver on the premise that a prior
software entity (e.g: bootloader) might have applied workarounds in
commit 0878fff1f42c ("net: phy: Do not perform software reset for
Generic PHY").

Since we have a hook to wire-up a soft_reset callback, just use that and
get rid of the call to genphy_soft_reset() entirely. This speeds up
initialization and link establishment for most PHYs out there that do
not require a reset.

Fixes: 87aa9f9c61ad ("net: phy: consolidate PHY reset in phy_init_hw()")
Tested-by: Wang, Dongsheng <dongsheng.wang@hxt-semitech.com>
Tested-by: Chris Healy <cphealy@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/phy/phy_device.c | 2 --
 1 file changed, 2 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -543,8 +543,6 @@ int phy_init_hw(struct phy_device *phyde
 
 	if (phydev->drv->soft_reset)
 		ret = phydev->drv->soft_reset(phydev);
-	else
-		ret = genphy_soft_reset(phydev);
 
 	if (ret < 0)
 		return ret;

