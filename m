Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753541AbeEWAR4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 20:17:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38728 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbeEWARy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 20:17:54 -0400
X-Google-Smtp-Source: AB8JxZrt4OVxR05eKikyWfb+0ZKQIvMpzgw6CIDPg7byNqiVRcMC+vWduuFzjqZLKm9QQaoOqIHYjA==
From: Bo Chen <chenbo@pdx.edu>
To: jeffrey.t.kirsher@intel.com
Cc: davem@davemloft.net, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bo Chen <chenbo@pdx.edu>
Subject: [PATCH] e1000: check the return of pci_get_drvdata() in e1000_remove()
Date: Tue, 22 May 2018 17:17:43 -0700
Message-Id: <20180523001743.8492-1-chenbo@pdx.edu>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check on pci_get_drvdata() prevents potential invalid pointer dereferences,
and is a common practice in *_remove() functions from other drivers, such as
'intel/e100.c', 'amd/pcnet32.c', 'realtek/8139too.c', and 'broadcom/tg3.c'.

Signed-off-by: Bo Chen <chenbo@pdx.edu>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 41 ++++++++++---------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d5eb19b86a0a..7f63360dd221 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1283,32 +1283,35 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 static void e1000_remove(struct pci_dev *pdev)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
-	struct e1000_adapter *adapter = netdev_priv(netdev);
-	struct e1000_hw *hw = &adapter->hw;
-	bool disable_dev;
 
-	e1000_down_and_stop(adapter);
-	e1000_release_manageability(adapter);
+	if (netdev) {
+		struct e1000_adapter *adapter = netdev_priv(netdev);
+		struct e1000_hw *hw = &adapter->hw;
+		bool disable_dev;
 
-	unregister_netdev(netdev);
+		e1000_down_and_stop(adapter);
+		e1000_release_manageability(adapter);
 
-	e1000_phy_hw_reset(hw);
+		unregister_netdev(netdev);
 
-	kfree(adapter->tx_ring);
-	kfree(adapter->rx_ring);
+		e1000_phy_hw_reset(hw);
 
-	if (hw->mac_type == e1000_ce4100)
-		iounmap(hw->ce4100_gbe_mdio_base_virt);
-	iounmap(hw->hw_addr);
-	if (hw->flash_address)
-		iounmap(hw->flash_address);
-	pci_release_selected_regions(pdev, adapter->bars);
+		kfree(adapter->tx_ring);
+		kfree(adapter->rx_ring);
 
-	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
-	free_netdev(netdev);
+		if (hw->mac_type == e1000_ce4100)
+			iounmap(hw->ce4100_gbe_mdio_base_virt);
+		iounmap(hw->hw_addr);
+		if (hw->flash_address)
+			iounmap(hw->flash_address);
+		pci_release_selected_regions(pdev, adapter->bars);
 
-	if (disable_dev)
-		pci_disable_device(pdev);
+		disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
+		free_netdev(netdev);
+
+		if (disable_dev)
+			pci_disable_device(pdev);
+	}
 }
 
 /**
-- 
2.17.0
