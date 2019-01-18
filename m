Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13663C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E241020657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfARPYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:24:16 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51288 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727481AbfARPYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:24:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0FB2420A7D; Fri, 18 Jan 2019 16:24:13 +0100 (CET)
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id A768420797;
        Fri, 18 Jan 2019 16:24:02 +0100 (CET)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: [PATCH net-next 0/7] net: phy: Add support for 2.5GBASET PHYs
Date:   Fri, 18 Jan 2019 16:23:45 +0100
Message-Id: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This series introduces support for 2.5GBASET mode in Network PHYs, and
implements that support in some PHYs in the Marvell Alaska product
range, the PPv2 driver, and a new PHY from the Alaska family.

2.5GBASET and 5GBASET were originally defined by the NBASET alliance,
and are now being specified as an IEEE standard, under the 802.3bz
specification.

The first patch in the series generalizes the way we build the list of
supported modes in C45 PHYs, relying on the various modes exposed in the
PMA registers. It extracts the logic from the marvell10g driver.

The second patch adds the new register definitions from the 802.3bz
specifications, and adds the generic code to handle both 2.5GBASET and
5GBASET.

The third patch allows to automatically detect whether or not a PHY
supports 2.5GBASET and 5GBASET, by reading the PMA abilities.

Patches 4 and 5 add support for 2.5GBASET into the marvell10g driver,
with a workaround for incorrect abilities being reported by the 88X3310
and the 88E2010 PHYs. (see patch 5).

Patch 6 adds support for 2.5GBASET in the PPv2 ethernet driver, thus
enabling support for that mode on the MacchiatoBin.

Finally, patch 7 introduces support for the 88x2110 PHY, which is very
similar to the 88x3310, the only difference being the lack of Fiber
support. The 88x2110 already reports the correct abilities from it's
PMA, and thus doesn't require the workaround implemented in patch 5 for
2.5GBASET to work. This is based on work originally done by Antoine Tenart.

This patch series was tested on the MacchiatoBin, a custom board using a
88e2010, and another using a 88x2110.

The 88x2110 support is enclosed in the series to better show the need
for the workaround in the 88x3310, feel free to tell me if we should
handle such hardware issues in another way, or if support for that PHY
should be submitted separately.

At this point, future development adding 5GBASET to Marvell PHYs should be
straightforward, but this isn't included in the series since I lack any
hardware to test the 5GBASE-R mode that the PHY uses to connect to the
MAC in that case.

Thanks to Andrew for doing the rework of the link_mode representation
this series depends on.

Maxime Chevallier (7):
  net: phy: Extract genphy_c45_read_abilities from marvell10g
  net: phy: Add generic support for 2.5GBaseT and 5GBaseT
  net: phy: Read 2.5G and 5G extended abilities
  net: phy: marvell10g: Add support for 2.5GBASET and 5GBASET
  net: phy: marvell10g: Force reading of 2.5/5G PMA extended abilities
  net: mvpp2: Add 2.5GBaseT support
  net: phy: marvell10g: add support for the 88x2110 PHY

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   1 +
 drivers/net/phy/marvell10g.c                  | 155 +++++++++---------
 drivers/net/phy/phy-c45.c                     | 132 +++++++++++++++
 include/linux/phy.h                           |   1 +
 include/uapi/linux/mdio.h                     |  16 ++
 5 files changed, 226 insertions(+), 79 deletions(-)

-- 
2.19.2

