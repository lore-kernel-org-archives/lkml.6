Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164003AbeE1Kyv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163955AbeE1Kyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:54:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Raghuram Chary J <raghuramchary.jallipalli@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 298/496] lan78xx: Set ASD in MAC_CR when EEE is enabled.
Date: Mon, 28 May 2018 12:01:23 +0200
Message-Id: <20180528100332.381146713@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>

[ Upstream commit e69647a19c870c2f919e4d5023af8a515e8ef25f ]

Description:
EEE does not work with lan7800 when AutoSpeed is not set.
(This can happen when EEPROM is not populated or configured incorrectly)

Root-Cause:
When EEE is enabled, the mac config register ASD is not set
i.e. in default state, causing EEE fail.

Fix:
Set the register when eeprom is not present.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2352,6 +2352,7 @@ static int lan78xx_reset(struct lan78xx_
 	u32 buf;
 	int ret = 0;
 	unsigned long timeout;
+	u8 sig;
 
 	ret = lan78xx_read_reg(dev, HW_CFG, &buf);
 	buf |= HW_CFG_LRST_;
@@ -2451,6 +2452,15 @@ static int lan78xx_reset(struct lan78xx_
 	/* LAN7801 only has RGMII mode */
 	if (dev->chipid == ID_REV_CHIP_ID_7801_)
 		buf &= ~MAC_CR_GMII_EN_;
+
+	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
+		ret = lan78xx_read_raw_eeprom(dev, 0, 1, &sig);
+		if (!ret && sig != EEPROM_INDICATOR) {
+			/* Implies there is no external eeprom. Set mac speed */
+			netdev_info(dev->net, "No External EEPROM. Setting MAC Speed\n");
+			buf |= MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_;
+		}
+	}
 	ret = lan78xx_write_reg(dev, MAC_CR, buf);
 
 	ret = lan78xx_read_reg(dev, MAC_TX, &buf);
