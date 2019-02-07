Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96467C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686D920823
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 09:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBGJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 04:49:59 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:32859 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGJt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 04:49:59 -0500
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 8FBB610000B;
        Thu,  7 Feb 2019 09:49:52 +0000 (UTC)
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
Subject: [PATCH net-next v2 00/10] net: phy: Add support for 2.5GBASET PHYs
Date:   Thu,  7 Feb 2019 10:49:29 +0100
Message-Id: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This is the second iteration of the series introducing support for
2.5GBASET and 5GBASET to the network PHY infrastructure.

These 2 modes are described in the 802.3bz specifications, and allow to
use 2.5G and 5G speeds on cat5e/cat6 cables.

The required infrastructure code is added for 2.5GBASET and 5GBASET, but
only 2.5GBASET support is added to the Marvell10G driver. The reason is
because the 5GBASER interface mode used to communicate with the MAC
isn't implemented yet, and therefore this can't be tested.

This series has seen some rework since last time, see the full details
in the patches changelog. The main highlights are :

 - Patch 1 moves the Pause ans Asym_Pause parameters update after
   calling config_init. This allows us to change the phydev->supported
   modes in config_init, while still forcing some quirks taken from
   phydrv->features, to disable unsupported Pause modes. This was
   proposed by Andrew.

 - Patch 2 generalizes the way we mask-out modes we don't want to use
   when forcing the link speed through DT or ethtool, by walking through
   the PHY settings table, as proposed by Russell.

 - Patch 4 implements automatic setting of TM, FIBRE and Backplane bits
   from the list of supported linkmodes.

 - In Patch 5, we only read abilities from the PMA. Pause parameters
   aren't built from the genphy_c45_pma_read_abilities, as it was done
   in the previous iteration of the patch. We also amke use of
   linkmode_mod_bit to make sure we mask-out unsupported modes.

 - In Patch 8, we manually check for the PMA device id to see if we have
   to use a quirk when reading the 2.5G/5G Extended Abilities

Maxime Chevallier (10):
  net: phy: Update PHY linkmodes after config_init
  net: phy: Mask-out non-compatible modes when setting the max-speed
  net: phy: Move of_set_phy_eee_broken to phy-core.c
  net: phy: Automatically fill the generic TP, FIBRE and Backplane modes
  net: phy: Extract genphy_c45_pma_read_abilities from marvell10g
  net: phy: Add generic support for 2.5GBaseT and 5GBaseT
  net: phy: marvell10g: Add support for 2.5GBASET
  net: phy: marvell10g: Force reading of 2.5/5G
  net: mvpp2: Add 2.5GBaseT support
  net: phy: marvell10g: add support for the 88x2110 PHY

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |   1 +
 drivers/net/phy/marvell10g.c                  | 142 +++++------
 drivers/net/phy/phy-c45.c                     | 111 ++++++++
 drivers/net/phy/phy-core.c                    |  72 ++++++
 drivers/net/phy/phy_device.c                  | 237 +++++++++---------
 include/linux/linkmode.h                      |   6 +
 include/linux/marvell_phy.h                   |   2 +
 include/linux/phy.h                           |   3 +
 include/uapi/linux/mdio.h                     |  16 ++
 9 files changed, 405 insertions(+), 185 deletions(-)

-- 
2.19.2

