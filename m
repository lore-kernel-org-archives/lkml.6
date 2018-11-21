Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD08CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C8E21582
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL3LZWSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C8E21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388167AbeKVFnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388124AbeKVFnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6911214DB;
        Wed, 21 Nov 2018 19:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827296;
        bh=ob8ALZgLIzj6p+RI5857wiIgtMqfE0TPOfEKA+muz6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DL3LZWSRdk4N19uw5w6XF7XW7JndYIj+55z2BZL7zsRu278wlCkUCp2lMjWD12GAb
         1+GAR2rZhwk7MBWD5hVmxBcmFYpdFQsPHGwRpocBnLIEMEosZfPXIED7Tt2TVoxr6T
         5WPk4WTYdK8rIC/+6my7I8YM5OYwGiJuKk5lcHVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 14/42] net: systemport: Protect stop from timeout
Date:   Wed, 21 Nov 2018 20:05:50 +0100
Message-Id: <20181121183148.586577516@linuxfoundation.org>
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

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 7cb6a2a2c72c1ed8f42fb01f1a661281b568dead ]

A timing hazard exists when the network interface is stopped that
allows a watchdog timeout to be processed by a separate core in
parallel. This creates the potential for the timeout handler to
wake the queues while the driver is shutting down, or access
registers after their clocks have been removed.

The more common case is that the watchdog timeout will produce a
warning message which doesn't lead to a crash. The chances of this
are greatly increased by the fact that bcm_sysport_netif_stop stops
the transmit queues which can easily precipitate a watchdog time-
out because of stale trans_start data in the queues.

This commit corrects the behavior by ensuring that the watchdog
timeout is disabled before enterring bcm_sysport_netif_stop. There
are currently only two users of the bcm_sysport_netif_stop function:
close and suspend.

The close case already handles the issue by exiting the RUNNING
state before invoking the driver close service.

The suspend case now performs the netif_device_detach to exit the
PRESENT state before the call to bcm_sysport_netif_stop rather than
after it.

These behaviors prevent any future scheduling of the driver timeout
service during the window. The netif_tx_stop_all_queues function
in bcm_sysport_netif_stop is replaced with netif_tx_disable to ensure
synchronization with any transmit or timeout threads that may
already be executing on other cores.

For symmetry, the netif_device_attach call upon resume is moved to
after the call to bcm_sysport_netif_start. Since it wakes the transmit
queues it is not necessary to invoke netif_tx_start_all_queues from
bcm_sysport_netif_start so it is moved into the driver open service.

Fixes: 40755a0fce17 ("net: systemport: add suspend and resume support")
Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1897,9 +1897,6 @@ static void bcm_sysport_netif_start(stru
 		intrl2_1_mask_clear(priv, 0xffffffff);
 	else
 		intrl2_0_mask_clear(priv, INTRL2_0_TDMA_MBDONE_MASK);
-
-	/* Last call before we start the real business */
-	netif_tx_start_all_queues(dev);
 }
 
 static void rbuf_init(struct bcm_sysport_priv *priv)
@@ -2045,6 +2042,8 @@ static int bcm_sysport_open(struct net_d
 
 	bcm_sysport_netif_start(dev);
 
+	netif_tx_start_all_queues(dev);
+
 	return 0;
 
 out_clear_rx_int:
@@ -2068,7 +2067,7 @@ static void bcm_sysport_netif_stop(struc
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 
 	/* stop all software from updating hardware */
-	netif_tx_stop_all_queues(dev);
+	netif_tx_disable(dev);
 	napi_disable(&priv->napi);
 	cancel_work_sync(&priv->dim.dim.work);
 	phy_stop(dev->phydev);
@@ -2654,12 +2653,12 @@ static int __maybe_unused bcm_sysport_su
 	if (!netif_running(dev))
 		return 0;
 
+	netif_device_detach(dev);
+
 	bcm_sysport_netif_stop(dev);
 
 	phy_suspend(dev->phydev);
 
-	netif_device_detach(dev);
-
 	/* Disable UniMAC RX */
 	umac_enable_set(priv, CMD_RX_EN, 0);
 
@@ -2743,8 +2742,6 @@ static int __maybe_unused bcm_sysport_re
 		goto out_free_rx_ring;
 	}
 
-	netif_device_attach(dev);
-
 	/* RX pipe enable */
 	topctrl_writel(priv, 0, RX_FLUSH_CNTL);
 
@@ -2789,6 +2786,8 @@ static int __maybe_unused bcm_sysport_re
 
 	bcm_sysport_netif_start(dev);
 
+	netif_device_attach(dev);
+
 	return 0;
 
 out_free_rx_ring:


