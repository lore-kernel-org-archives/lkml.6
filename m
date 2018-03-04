Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeCDSZG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 13:25:06 -0500
Received: from bran.ispras.ru ([83.149.199.196]:12824 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751611AbeCDSZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 13:25:03 -0500
From: Alexander Monakov <amonakov@ispras.ru>
To: linux-kernel@vger.kernel.org
Cc: Alexander Monakov <amonakov@ispras.ru>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: [PATCH] phy: berlin-usb: adjust USB_PHY_RX_CTRL init flags
Date: Sun,  4 Mar 2018 21:18:07 +0300
Message-Id: <20180304181807.20825-1-amonakov@ispras.ru>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the value written into the USB_PHY_RX_CTRL configuration register
match 0xAA79 value written by manufacturer-supplied kernels for Sony
NSZ-GS7 (Berlin2 SoC), Google Chromecast and Valve Steam Link (BG2CD).

This fixes timeouts communicating to the internal hub on Steam Link.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com> 
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
Hello,

I'm trying to run mainline kernel on "Steam Link" device built around
Marvell BG2CD SoC, and in doing so I've found that USB almost always
fails to initialize with timeout errors when connecting to the hub:

[    0.223563] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    0.223580] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.223596] usb usb1: Product: EHCI Host Controller
[    0.223608] usb usb1: Manufacturer: Linux 4.15.0-00014-gc6f881cd62dc-dirty ehci_hcd
[    0.223624] usb usb1: SerialNumber: ci_hdrc.0
[    0.223985] hub 1-0:1.0: USB hub found
[    0.224022] hub 1-0:1.0: 1 port detected
[    0.524726] ci_hdrc ci_hdrc.0: port 1 reset error -110
[    1.044673] ci_hdrc ci_hdrc.0: port 1 reset error -110
[    1.399721] mwifiex_sdio mmc0:0001:1: info: FW download over, size 814048 bytes
[    1.484666] ci_hdrc ci_hdrc.0: port 1 reset error -110
[    2.113451] mwifiex_sdio mmc0:0001:1: WLAN FW is active
[    2.113725] sdio platform data not available
[    2.192570] mwifiex_sdio mmc0:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (15.68.7.p112) 
[    2.192599] mwifiex_sdio mmc0:0001:1: driver_version = mwifiex 1.0 (15.68.7.p112) 
[    2.213433] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    2.294676] ci_hdrc ci_hdrc.0: port 1 reset error -110

and so on until...

[   19.254658] ci_hdrc ci_hdrc.0: port 1 reset error -110
[   19.913433] usb usb1-port1: Cannot enable. Maybe the USB cable is bad?
[   19.913472] usb usb1-port1: unable to enumerate USB device

I've inspected how the original kernel performs phy initialization, and
found that the value written into the USB_PHY_RX_CTRL register differs
in one field. Correcting the field is enough to stabilize it in my case.

I don't know where the _260 choice in mainline source comes from. I've
checked three publicly available kernels for devices with this phy, and
they all write the same value, 0xAA79.

FWIW, this is not the only difference I've found. Other kernels also:
- do not touch TX config registers;
- drive a particular GPIO low before and high after configuring the phy.

I am unsure if anything needs to or can be done about those differences.

Thanks.
Alexander

 drivers/phy/marvell/phy-berlin-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-berlin-usb.c b/drivers/phy/marvell/phy-berlin-usb.c
index 2017751ede26..8f2b5cae360f 100644
--- a/drivers/phy/marvell/phy-berlin-usb.c
+++ b/drivers/phy/marvell/phy-berlin-usb.c
@@ -127,7 +127,7 @@ static int phy_berlin_usb_power_on(struct phy *phy)
 	writel(V2I_VCO_RATIO(0x5) | R_ROTATE_0 | ANA_TEST_DC_CTRL(0x5),
 	       priv->base + USB_PHY_ANALOG);
 	writel(PHASE_FREEZE_DLY_4_CL | ACK_LENGTH_16_CL | SQ_LENGTH_12 |
-	       DISCON_THRESHOLD_260 | SQ_THRESHOLD(0xa) | LPF_COEF(0x2) |
+	       DISCON_THRESHOLD_270 | SQ_THRESHOLD(0xa) | LPF_COEF(0x2) |
 	       INTPL_CUR_30, priv->base + USB_PHY_RX_CTRL);
 
 	writel(TX_VDD12_13 | TX_OUT_AMP(0x3), priv->base + USB_PHY_TX_CTRL1);
-- 
2.11.0
