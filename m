Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbeCOGmy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 02:42:54 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45689 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeCOGmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 02:42:52 -0400
X-Google-Smtp-Source: AG47ELvxfV3VW2Gr0fQT+n/A9FX0uEmYefuhWiDoqRkEgWFqgtj+WgTuSE/eTEfZDRJBea8MWOSqeQ==
From: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>
Cc: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>,
        Schuyler Patton <spatton@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: ti: cpsw: add check for in-band mode setting with RGMII PHY interface
Date: Thu, 15 Mar 2018 14:41:43 +0800
Message-Id: <20180315064145.7022-1-sz.lin@moxa.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to AM335x TRM[1] 14.3.6.2, AM437x TRM[2] 15.3.6.2 and
DRA7 TRM[3] 24.11.4.8.7.3.3, in-band mode in EXT_EN(bit18) register is only
available when PHY is configured in RGMII mode with 10Mbps speed. It will
cause some networking issues without RGMII mode, such as carrier sense
errors and low throughput. TI also mentioned this issue in their forum[4].

This patch adds the check mechanism for PHY interface with RGMII interface
type, the in-band mode can only be set in RGMII mode with 10Mbps speed.

References:
[1]: https://www.ti.com/lit/ug/spruh73p/spruh73p.pdf
[2]: http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf
[3]: http://www.ti.com/lit/ug/spruic2b/spruic2b.pdf
[4]: https://e2e.ti.com/support/arm/sitara_arm/f/791/p/640765/2392155

Suggested-by: Holsety Chen (陳憲輝) <Holsety.Chen@moxa.com>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Schuyler Patton <spatton@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1b1b78fdc138..3bbf22ed59cf 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1014,7 +1014,13 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
 		/* set speed_in input in case RMII mode is used in 100Mbps */
 		if (phy->speed == 100)
 			mac_control |= BIT(15);
-		else if (phy->speed == 10)
+
+		/* in band mode only works in 10Mbps RGMII mode */
+		else if ((phy->speed == 10) &&
+			 ((phy->interface == PHY_INTERFACE_MODE_RGMII) ||
+			 (phy->interface == PHY_INTERFACE_MODE_RGMII_ID) ||
+			 (phy->interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
+			 (phy->interface == PHY_INTERFACE_MODE_RGMII_TXID)))
 			mac_control |= BIT(18); /* In Band mode */
 
 		if (priv->rx_pause)
-- 
2.16.2
