Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933973AbeBLLFV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:05:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:36745 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933581AbeBLLFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:05:19 -0500
From: Ingo van Lil <inguin@gmx.de>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Ingo van Lil <inguin@gmx.de>
Subject: [PATCH] net: phy: fix wrong mask to phy_modify()
Date: Mon, 12 Feb 2018 12:02:52 +0100
Message-Id: <20180212110252.27804-1-inguin@gmx.de>
X-Mailer: git-send-email 2.14.3
X-Provags-ID: V03:K0:0xa+Ege4/TFr17fnAo/wt0x4/QNu1dVP49lgan5nlZmIRb3mnt7
 HiwrM6kWrV3v/NGygGsj+st6uAnms4sNwNzO/qZwAcjpF+6Ot2OQf36bHzlvrdYrTfMipPK
 pT6ifQjoO1PS+gA1chTalnDLDiY8Lhp5jPdC+N42NrDagS/fZ34XjoFIrfRdGUh0jHxE8qv
 VZbqqtq6MRwhpLF7shlVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AaASbDlukbc=:iZ+YyVRhcy5fKa7oct9Ufh
 sQTUFXcI7mWmBvcBiALMvqLydHgb51Cmc/2EBaIe/IeofnV5FdQHDaNoSFLZLxXklbROPmgU9
 akzzOC2m/5w/IIlwBPBxPPIPxAGnnkNcv0qvHMwPE8J1ZssSXg6KHMCUzXMVpKwaBVXKOlvAr
 6hUDxJBe4nK1qVIhHC3CnjV39CU1x1PWMTTiNG4nun6aw5lOsWtco2+ATKtoh9rWuYKXMpZqY
 vAQ5rQ55gZeAV3wMkHqVThAR6RyLrw+1sRBp4nR49RQhr47M46W+HDDdBm8eGy5IN0QCjEIlU
 dl5xgq9caCF0dhdPI5T8f77zAoOBtpreZCDLoCRATboGCzId7MNLTbAeCy2yligfySe2YFoco
 JD30E+mzTtCKiVaZHALBU1Ru6wjyHJmLNLzTGlNnuZXHyuWoM2Z0lObXCvv1x2BXv97BFiWHH
 PAaAyRFfyathoe9yJutGL+SU8Bd3tAkmV1JtqVxi9GcCxfrNr5IJ8R761L+MQ8byVQTgupVZ7
 NR3FSuZWFOFHF7+LeGXgu1YDPnNmUJtsl7PvvyhXjnH493r6IQUrdLptIqaW0BXdm8A7hsanF
 sAzre8X2iU8BHW/w2Cj1DptlRWZqIcSCA2YAKZVfgxlWoMh1LpzxmtWsHZGVColXh/2BM+7Fb
 Xvea//69mHZocXCLBhtXS1dV9k/wuLeBWSwBwUsK4dFb1CHsP3dKTKNiJr2k5IeOwtWtWdn38
 xH8us3eWpXQUd7X487R0bSX9+he9YbtocphShFccx4DvencyXKkfLyUiUuhCkwUZ3DGYft7Cr
 HYg2SQ8NMqyWeoUYrU2EobuHnGEVw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When forcing a specific link mode, the PHY driver must clear the
existing speed and duplex bits in BMCR while preserving some other
control bits. This logic was accidentally inverted with the introduction
of phy_modify().

Signed-off-by: Ingo van Lil <inguin@gmx.de>
---
 drivers/net/phy/phy_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b13eed21c87d..d39ae77707ef 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1382,7 +1382,7 @@ int genphy_setup_forced(struct phy_device *phydev)
 		ctl |= BMCR_FULLDPLX;
 
 	return phy_modify(phydev, MII_BMCR,
-			  BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN, ctl);
+			  ~(BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN), ctl);
 }
 EXPORT_SYMBOL(genphy_setup_forced);
 
-- 
2.14.3
