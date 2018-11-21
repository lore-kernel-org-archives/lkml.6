Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73015C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A13A214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeCpPlQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A13A214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbeKVFny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388124AbeKVFnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DC9C214D9;
        Wed, 21 Nov 2018 19:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827300;
        bh=JUyhDgnWNRD9CcDBttIBQ7je20zz6A27h/O82UTRUx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeCpPlQY/Glg4DW4hSYZhIUyspVtPbiEACvUS0Wp5CnnS38NdIcJXe2GoFKn7Weh5
         J6OnvGbZdQ1YF3wQIMN3zFkfUPvhZ4qJG8FzE44LBpJipDTic2G6JIQl6b8ppE5RQj
         GbFIO67FLoWds2X/aUv0lZ0OdLXQANkGx+PHGBIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 06/42] net: bcmgenet: protect stop from timeout
Date:   Wed, 21 Nov 2018 20:05:42 +0100
Message-Id: <20181121183148.245710803@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doug Berger <opendmb@gmail.com>

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

[ Upstream commit 09e805d2570a3a94f13dd9c9ad2bcab23da76e09 ]

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2855,7 +2855,6 @@ static void bcmgenet_netif_start(struct
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
 
-	netif_tx_start_all_queues(dev);
 	bcmgenet_enable_tx_napi(priv);
 
 	/* Monitor link interrupts now */
@@ -2937,6 +2936,8 @@ static int bcmgenet_open(struct net_devi
 
 	bcmgenet_netif_start(dev);
 
+	netif_tx_start_all_queues(dev);
+
 	return 0;
 
 err_irq1:
@@ -2958,7 +2959,7 @@ static void bcmgenet_netif_stop(struct n
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	bcmgenet_disable_tx_napi(priv);
-	netif_tx_stop_all_queues(dev);
+	netif_tx_disable(dev);
 
 	/* Disable MAC receive */
 	umac_enable_set(priv, CMD_RX_EN, false);
@@ -3620,13 +3621,13 @@ static int bcmgenet_suspend(struct devic
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
@@ -3700,8 +3701,6 @@ static int bcmgenet_resume(struct device
 	/* Always enable ring 16 - descriptor ring */
 	bcmgenet_enable_dma(priv, dma_ctrl);
 
-	netif_device_attach(dev);
-
 	if (!device_may_wakeup(d))
 		phy_resume(dev->phydev);
 
@@ -3710,6 +3709,8 @@ static int bcmgenet_resume(struct device
 
 	bcmgenet_netif_start(dev);
 
+	netif_device_attach(dev);
+
 	return 0;
 
 out_clk_disable:


