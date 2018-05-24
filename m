Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970363AbeEXOJQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:09:16 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44770 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967730AbeEXOJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:09:11 -0400
X-Google-Smtp-Source: AB8JxZptQLr9pTl7r3MS5Cb6/0c0XUesxHLV+ApTSHmsUYTqFMJFIpOM6k/N77/D+WbJN32Wokn/0g==
From: Thierry Reding <thierry.reding@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jon Hunter <jonathanh@nvidia.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: Use mutex instead of spinlock
Date: Thu, 24 May 2018 16:09:07 +0200
Message-Id: <20180524140907.24197-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Some drivers, such as DWC EQOS on Tegra, need to perform operations that
can sleep under this lock (clk_set_rate() in tegra_eqos_fix_speed()) for
proper operation. Since there is no need for this lock to be a spinlock,
convert it to a mutex instead.

Fixes: e6ea2d16fc61 ("net: stmmac: dwc-qos: Add Tegra186 support")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
This applies on top of net-next.

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 12 +++----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 31 +++++++++----------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 42fc76e76bf9..5a2570b8d540 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -121,7 +121,7 @@ struct stmmac_priv {
 	struct net_device *dev;
 	struct device *device;
 	struct mac_device_info *hw;
-	spinlock_t lock;
+	struct mutex lock;
 
 	/* RX Queue */
 	struct stmmac_rx_queue rx_queue[MTL_MAX_RX_QUEUES];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 6d82b3ef5c3b..5710864fa809 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -390,9 +390,9 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
 			ADVERTISED_10baseT_Half |
 			ADVERTISED_10baseT_Full);
 
-		spin_lock(&priv->lock);
+		mutex_lock(&priv->lock);
 		stmmac_pcs_ctrl_ane(priv, priv->ioaddr, 1, priv->hw->ps, 0);
-		spin_unlock(&priv->lock);
+		mutex_unlock(&priv->lock);
 
 		return 0;
 	}
@@ -632,12 +632,12 @@ static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	spin_lock_irq(&priv->lock);
+	mutex_lock(&priv->lock);
 	if (device_can_wakeup(priv->device)) {
 		wol->supported = WAKE_MAGIC | WAKE_UCAST;
 		wol->wolopts = priv->wolopts;
 	}
-	spin_unlock_irq(&priv->lock);
+	mutex_unlock(&priv->lock);
 }
 
 static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
@@ -666,9 +666,9 @@ static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 		disable_irq_wake(priv->wol_irq);
 	}
 
-	spin_lock_irq(&priv->lock);
+	mutex_lock(&priv->lock);
 	priv->wolopts = wol->wolopts;
-	spin_unlock_irq(&priv->lock);
+	mutex_unlock(&priv->lock);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d9dbe1355896..8cc63da79a80 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -381,7 +381,6 @@ bool stmmac_eee_init(struct stmmac_priv *priv)
 {
 	struct net_device *ndev = priv->dev;
 	int interface = priv->plat->interface;
-	unsigned long flags;
 	bool ret = false;
 
 	if ((interface != PHY_INTERFACE_MODE_MII) &&
@@ -408,7 +407,7 @@ bool stmmac_eee_init(struct stmmac_priv *priv)
 			 * changed).
 			 * In that case the driver disable own timers.
 			 */
-			spin_lock_irqsave(&priv->lock, flags);
+			mutex_lock(&priv->lock);
 			if (priv->eee_active) {
 				netdev_dbg(priv->dev, "disable EEE\n");
 				del_timer_sync(&priv->eee_ctrl_timer);
@@ -416,11 +415,11 @@ bool stmmac_eee_init(struct stmmac_priv *priv)
 						tx_lpi_timer);
 			}
 			priv->eee_active = 0;
-			spin_unlock_irqrestore(&priv->lock, flags);
+			mutex_unlock(&priv->lock);
 			goto out;
 		}
 		/* Activate the EEE and start timers */
-		spin_lock_irqsave(&priv->lock, flags);
+		mutex_lock(&priv->lock);
 		if (!priv->eee_active) {
 			priv->eee_active = 1;
 			timer_setup(&priv->eee_ctrl_timer,
@@ -435,7 +434,7 @@ bool stmmac_eee_init(struct stmmac_priv *priv)
 		stmmac_set_eee_pls(priv, priv->hw, ndev->phydev->link);
 
 		ret = true;
-		spin_unlock_irqrestore(&priv->lock, flags);
+		mutex_unlock(&priv->lock);
 
 		netdev_dbg(priv->dev, "Energy-Efficient Ethernet initialized\n");
 	}
@@ -811,13 +810,12 @@ static void stmmac_adjust_link(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev = dev->phydev;
-	unsigned long flags;
 	bool new_state = false;
 
 	if (!phydev)
 		return;
 
-	spin_lock_irqsave(&priv->lock, flags);
+	mutex_lock(&priv->lock);
 
 	if (phydev->link) {
 		u32 ctrl = readl(priv->ioaddr + MAC_CTRL_REG);
@@ -876,7 +874,7 @@ static void stmmac_adjust_link(struct net_device *dev)
 	if (new_state && netif_msg_link(priv))
 		phy_print_status(phydev);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	mutex_unlock(&priv->lock);
 
 	if (phydev->is_pseudo_fixed_link)
 		/* Stop PHY layer to call the hook to adjust the link in case
@@ -4337,7 +4335,7 @@ int stmmac_dvr_probe(struct device *device,
 			       (8 * priv->plat->rx_queues_to_use));
 	}
 
-	spin_lock_init(&priv->lock);
+	mutex_init(&priv->lock);
 
 	/* If a specific clk_csr value is passed from the platform
 	 * this means that the CSR Clock Range selection cannot be
@@ -4421,6 +4419,7 @@ int stmmac_dvr_remove(struct device *dev)
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
 	destroy_workqueue(priv->wq);
+	mutex_destroy(&priv->lock);
 	free_netdev(ndev);
 
 	return 0;
@@ -4438,7 +4437,6 @@ int stmmac_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned long flags;
 
 	if (!ndev || !netif_running(ndev))
 		return 0;
@@ -4446,7 +4444,7 @@ int stmmac_suspend(struct device *dev)
 	if (ndev->phydev)
 		phy_stop(ndev->phydev);
 
-	spin_lock_irqsave(&priv->lock, flags);
+	mutex_lock(&priv->lock);
 
 	netif_device_detach(ndev);
 	stmmac_stop_all_queues(priv);
@@ -4467,7 +4465,7 @@ int stmmac_suspend(struct device *dev)
 		clk_disable(priv->plat->pclk);
 		clk_disable(priv->plat->stmmac_clk);
 	}
-	spin_unlock_irqrestore(&priv->lock, flags);
+	mutex_unlock(&priv->lock);
 
 	priv->oldlink = false;
 	priv->speed = SPEED_UNKNOWN;
@@ -4512,7 +4510,6 @@ int stmmac_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	unsigned long flags;
 
 	if (!netif_running(ndev))
 		return 0;
@@ -4524,9 +4521,9 @@ int stmmac_resume(struct device *dev)
 	 * from another devices (e.g. serial console).
 	 */
 	if (device_may_wakeup(priv->device)) {
-		spin_lock_irqsave(&priv->lock, flags);
+		mutex_lock(&priv->lock);
 		stmmac_pmt(priv, priv->hw, 0);
-		spin_unlock_irqrestore(&priv->lock, flags);
+		mutex_unlock(&priv->lock);
 		priv->irq_wake = 0;
 	} else {
 		pinctrl_pm_select_default_state(priv->device);
@@ -4540,7 +4537,7 @@ int stmmac_resume(struct device *dev)
 
 	netif_device_attach(ndev);
 
-	spin_lock_irqsave(&priv->lock, flags);
+	mutex_lock(&priv->lock);
 
 	stmmac_reset_queues_param(priv);
 
@@ -4554,7 +4551,7 @@ int stmmac_resume(struct device *dev)
 
 	stmmac_start_all_queues(priv);
 
-	spin_unlock_irqrestore(&priv->lock, flags);
+	mutex_unlock(&priv->lock);
 
 	if (ndev->phydev)
 		phy_start(ndev->phydev);
-- 
2.17.0
