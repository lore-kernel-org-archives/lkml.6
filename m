Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61585C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2541E223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKL6xF7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2541E223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbeKOI3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbeKOI3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:13 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 328032252A;
        Wed, 14 Nov 2018 22:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234249;
        bh=KcquHZ7K1YB+PSdWcvkktHBoJpVFoYegvtaupJDrfxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKL6xF7IZsKXdMkfBi1jgsvaseaJIMTsxBmQbcCmyDrwdM/y3Z+4K3bfb7QyvUUOl
         Btdpw7IzG8lBdA8OWCjtojTb7Q7FkYOOxproiavQ/Bw/II+8T1LAgOeP0zMXvPhwcc
         aHytzYoMepUc3ShxbWG1z59xl5F6gdazx2+hyoiQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 13/59] net: bcmgenet: protect stop from timeout
Date:   Wed, 14 Nov 2018 17:22:45 -0500
Message-Id: <20181114222335.99339-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 09e805d2570a3a94f13dd9c9ad2bcab23da76e09 ]

A timing hazard exists when the network interface is stopped that
allows a watchdog timeout to be processed by a separate core in
parallel. This creates the potential for the timeout handler to
wake the queues while the driver is shutting down, or access
registers after their clocks have been removed.

The more common case is that the watchdog timeout will produce a
warning message which doesn't lead to a crash. The chances of this
are greatly increased by the fact that bcmgenet_netif_stop stops
the transmit queues which can easily precipitate a watchdog time-
out because of stale trans_start data in the queues.

This commit corrects the behavior by ensuring that the watchdog
timeout is disabled before enterring bcmgenet_netif_stop. There
are currently only two users of the bcmgenet_netif_stop function:
close and suspend.

The close case already handles the issue by exiting the RUNNING
state before invoking the driver close service.

The suspend case now performs the netif_device_detach to exit the
PRESENT state before the call to bcmgenet_netif_stop rather than
after it.

These behaviors prevent any future scheduling of the driver timeout
service during the window. The netif_tx_stop_all_queues function
in bcmgenet_netif_stop is replaced with netif_tx_disable to ensure
synchronization with any transmit or timeout threads that may
already be executing on other cores.

For symmetry, the netif_device_attach call upon resume is moved to
after the call to bcmgenet_netif_start. Since it wakes the transmit
queues it is not necessary to invoke netif_tx_start_all_queues from
bcmgenet_netif_start so it is moved into the driver open service.

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 20c1681bb1af..2d6f090bf644 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2855,7 +2855,6 @@ static void bcmgenet_netif_start(struct net_device *dev)
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
 
-	netif_tx_start_all_queues(dev);
 	bcmgenet_enable_tx_napi(priv);
 
 	/* Monitor link interrupts now */
@@ -2937,6 +2936,8 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_netif_start(dev);
 
+	netif_tx_start_all_queues(dev);
+
 	return 0;
 
 err_irq1:
@@ -2958,7 +2959,7 @@ static void bcmgenet_netif_stop(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	bcmgenet_disable_tx_napi(priv);
-	netif_tx_stop_all_queues(dev);
+	netif_tx_disable(dev);
 
 	/* Disable MAC receive */
 	umac_enable_set(priv, CMD_RX_EN, false);
@@ -3620,13 +3621,13 @@ static int bcmgenet_suspend(struct device *d)
 	if (!netif_running(dev))
 		return 0;
 
+	netif_device_detach(dev);
+
 	bcmgenet_netif_stop(dev);
 
 	if (!device_may_wakeup(d))
 		phy_suspend(dev->phydev);
 
-	netif_device_detach(dev);
-
 	/* Prepare the device for Wake-on-LAN and switch to the slow clock */
 	if (device_may_wakeup(d) && priv->wolopts) {
 		ret = bcmgenet_power_down(priv, GENET_POWER_WOL_MAGIC);
@@ -3700,8 +3701,6 @@ static int bcmgenet_resume(struct device *d)
 	/* Always enable ring 16 - descriptor ring */
 	bcmgenet_enable_dma(priv, dma_ctrl);
 
-	netif_device_attach(dev);
-
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
@@ -3710,6 +3709,8 @@ static int bcmgenet_resume(struct device *d)
 
 	bcmgenet_netif_start(dev);
 
+	netif_device_attach(dev);
+
 	return 0;
 
 out_clk_disable:
-- 
2.17.1

