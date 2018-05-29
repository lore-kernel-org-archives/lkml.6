Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934890AbeE2OSP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:18:15 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:61563 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934158AbeE2OSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:18:12 -0400
From: Faiz Abbas <faiz_abbas@ti.com>
To: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC: <mkl@pengutronix.de>, <wg@grandegger.com>, <faiz_abbas@ti.com>
Subject: [PATCH] can: m_can: Move acessing of message ram to after clocks are enabled
Date: Tue, 29 May 2018 19:49:40 +0530
Message-ID: <20180529141940.1682-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCAN message ram should only be accessed once clocks are enabled.
Therefore, move the call to parse/init the message ram to after
clocks are enabled.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b397a33f3d32..a9fbf81ac3d4 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1642,8 +1642,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	priv->can.clock.freq = clk_get_rate(cclk);
 	priv->mram_base = mram_addr;
 
-	m_can_of_parse_mram(priv, mram_config_vals);
-
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
@@ -1666,6 +1664,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	m_can_of_parse_mram(priv, mram_config_vals);
+
 	devm_can_led_init(dev);
 
 	of_can_transceiver(dev);
@@ -1715,8 +1715,6 @@ static __maybe_unused int m_can_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	m_can_init_ram(priv);
-
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	if (netif_running(ndev)) {
@@ -1726,6 +1724,7 @@ static __maybe_unused int m_can_resume(struct device *dev)
 		if (ret)
 			return ret;
 
+		m_can_init_ram(priv);
 		m_can_start(ndev);
 		netif_device_attach(ndev);
 		netif_start_queue(ndev);
-- 
2.17.0
