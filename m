Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65966C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D2720989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298453;
	bh=NxL23U+DdkaoDN1JBLjzNV/sG1zL1bVVTTaTrXNXgH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VHF1TjsWvpdO1XC4a40yI5lNOrD/Syp0ZJdFkBvWJZmA1CmsLYv2Y6adBeVOm7z61
	 m3LgZ27YnDlqseQemPRvqNJCxT7b67VnGKjdcYkQZ7ry8+V6bpS13fMNaMdZHiS9Hx
	 ZZWlvFOifectHOSkXNaJaaRaIO7CAyOMSYUftJBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbeLTJeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732753AbeLTJ3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:29:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A0472177E;
        Thu, 20 Dec 2018 09:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298180;
        bh=NxL23U+DdkaoDN1JBLjzNV/sG1zL1bVVTTaTrXNXgH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuIYX0cvFePxJJDatPDTo59WUSZPG4W1IKX6DHqoHf3DdIK2iueg6W2kIAUDpE5Fx
         WXPwQ5tfLhUXZWnstPVtCmdJquq5EuIbAz6tZGcfitK3alBFc7lixPEHDea3EVuWHK
         AID3Ne/eH/xetvNtuqa1u5J9GA7F7nhfoVijEG4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 22/67] net: stmmac: Move debugfs init/exit to ->probe()/->remove()
Date:   Thu, 20 Dec 2018 10:18:34 +0100
Message-Id: <20181220085904.425594564@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5f2b8b62786853341a20d4cd4948f9cbca3db002 ]

Setting up and tearing down debugfs is current unbalanced, as seen by
this error during resume from suspend:

    [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed to create debugfs directory
    [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup: failed debugFS registration

The imbalance happens because the driver creates the debugfs hierarchy
when the device is opened and tears it down when the device is closed.
There's little gain in that, and it could be argued that it is even
surprising because it's not usually done for other devices. Fix the
imbalance by moving the debugfs creation and teardown to the driver's
->probe() and ->remove() implementations instead.

Note that the ring descriptors cannot be read while the interface is
down, so make sure to return an empty file when the descriptors_status
debugfs file is read.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 75896d6ba6e2..99ea5c4ce29c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2547,12 +2547,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool init_ptp)
 			netdev_warn(priv->dev, "PTP init failed\n");
 	}
 
-#ifdef CONFIG_DEBUG_FS
-	ret = stmmac_init_fs(dev);
-	if (ret < 0)
-		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
-			    __func__);
-#endif
 	priv->tx_lpi_timer = STMMAC_DEFAULT_TWT_LS;
 
 	if (priv->use_riwt) {
@@ -2753,10 +2747,6 @@ static int stmmac_release(struct net_device *dev)
 
 	netif_carrier_off(dev);
 
-#ifdef CONFIG_DEBUG_FS
-	stmmac_exit_fs(dev);
-#endif
-
 	stmmac_release_ptp(priv);
 
 	return 0;
@@ -3896,6 +3886,9 @@ static int stmmac_sysfs_ring_read(struct seq_file *seq, void *v)
 	u32 tx_count = priv->plat->tx_queues_to_use;
 	u32 queue;
 
+	if ((dev->flags & IFF_UP) == 0)
+		return 0;
+
 	for (queue = 0; queue < rx_count; queue++) {
 		struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
 
@@ -4394,6 +4387,13 @@ int stmmac_dvr_probe(struct device *device,
 		goto error_netdev_register;
 	}
 
+#ifdef CONFIG_DEBUG_FS
+	ret = stmmac_init_fs(ndev);
+	if (ret < 0)
+		netdev_warn(priv->dev, "%s: failed debugFS registration\n",
+			    __func__);
+#endif
+
 	return ret;
 
 error_netdev_register:
@@ -4429,6 +4429,9 @@ int stmmac_dvr_remove(struct device *dev)
 
 	netdev_info(priv->dev, "%s: removing driver", __func__);
 
+#ifdef CONFIG_DEBUG_FS
+	stmmac_exit_fs(ndev);
+#endif
 	stmmac_stop_all_dma(priv);
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
-- 
2.19.1



