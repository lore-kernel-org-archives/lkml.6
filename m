Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A383C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B9E20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfBKOZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:25:53 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:34449 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbfBKOZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:43 -0500
X-Originating-IP: 90.88.22.177
Received: from mc-bl-xps13.lan (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr [90.88.22.177])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 6B4EC240010;
        Mon, 11 Feb 2019 14:25:38 +0000 (UTC)
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
Subject: [PATCH net-next 0/4] net: phy: Add 2.5G/5GBASET PHYs support
Date:   Mon, 11 Feb 2019 15:25:25 +0100
Message-Id: <20190211142529.22885-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 802.3bz standard defines 2 modes based on the NBASET alliance work
that allow to use 2.5Gbps and 5Gbps speeds on Cat 5e, 6 and 7 cables.

This series adds the necessary infrastructure to handle these modes with
C45 PHYs. This series was originally part of a bigger one, that has
seen 2 iterations [1] [2] that added support for these modes on Marvell
Alaska PHYs.

Following some discussions with Heiner and Andrew [3], we decided to
split-out the generic parts so that we can work together on the
following steps to get these mode fully working with Aquantia and
Marvell PHYS.

The first 3 patches are reworking some of the internal network phy
infrastructure to handle the new modes in a more generic way.

The 4th patch adds all the C45 register definition and accesses that
follows the 802.3bz standard to support 2.5GBASET and 5GBASET.

[1] : https://lore.kernel.org/netdev/20190118152352.26417-1-maxime.chevallier@bootlin.com/
[2] : https://lore.kernel.org/netdev/20190207094939.27369-1-maxime.chevallier@bootlin.com/
[3] : https://lore.kernel.org/netdev/81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com/

Maxime Chevallier (4):
  net: phy: Mask-out non-compatible modes when setting the max-speed
  net: phy: Move of_set_phy_eee_broken to phy-core.c
  net: phy: Extract genphy_c45_pma_read_abilities from marvell10g
  net: phy: Add generic support for 2.5GBaseT and 5GBaseT

 drivers/net/phy/marvell10g.c |  78 +++---------------------
 drivers/net/phy/phy-c45.c    | 111 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy-core.c   |  72 +++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  81 -------------------------
 include/linux/phy.h          |   3 +
 include/uapi/linux/mdio.h    |  16 +++++
 6 files changed, 210 insertions(+), 151 deletions(-)

-- 
2.19.2

