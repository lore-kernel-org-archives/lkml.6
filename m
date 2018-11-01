Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226BCC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72C420820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkeedtJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D72C420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeKBIBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:01:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42127 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBIBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:01:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id t6-v6so45079plo.9;
        Thu, 01 Nov 2018 15:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wGelYywzF5fSfuCLfYancfxYe7GditSfWIRM2C+KKvE=;
        b=hkeedtJ45GcpqXHPb59q1a0zuYBNWeamXY9wOF4S3cEjDLvHnHScI/iIpC+BGUiusP
         PxZ8vgJmlVAl70Z89sZInAqWMuY2yksvj3sKpuQUwuly/oXjH2eSvTXjuXMh/W1HSqP3
         Pef7uKhoiKiULakob1ge3hiBYzds5Rhvgpikcoj8YlW0ypZ0X7Bs8iZ9F+r57S3MSfvQ
         +4qd+xlMihzH+uAaaVT6gA5Z0Z3ccQKir707YhFzAovbJn8jKClJR+KtVuSH1juL0ind
         uCK8S9a/gYHrsIIp9l1LLxTKlYejQKkvVgtPMfV1oEOuEFOhxDNZRaRxsH737DgHju8m
         ydNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wGelYywzF5fSfuCLfYancfxYe7GditSfWIRM2C+KKvE=;
        b=bKX6II0LMq6xK2d5pIpQxMUpgoSnoMqGaThgVXaBEkPU0FgC/uEaVEwtmNK9iHbvke
         OGqNJ6u2WklU4FRgOK6lt/R0Tmf5aqaqgsQGfAmO36YB4NhhdRWniN44KeIgYqmzL+DW
         boLlb0felJNniGknlGHVCObafdxp+aeJnweL9XI2CLkW8J2zSD/PArF7rnjjwBB7ck42
         HKS7htOmRddJaLYqXAoxuOBzkBXO/lNtDXLBMS4H48EMsJ72+M4WXG7vyH/TgWLkairV
         dx1fiyP8dZjaIdLyQuzZ7A/WYSnqBd2Hhb00BNatzCcAsO1VCeZh04mlN4jFTKuTXJJN
         Vt6A==
X-Gm-Message-State: AGRZ1gKrr0kVn8d2eRmOMEwdfvqmmFzA5flhBcV8vdN2cKnSK22RDznz
        HnEn6rhcFnfG5hYsqPmtQ0QEu9HV
X-Google-Smtp-Source: AJdET5eLdB98gA5oVeDXw735E53yknmIkdb+s54kGap3LrH5Qm0bY5GGgaAHZdQApzs+CKgCbbXuWg==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11-v6mr9585166plb.101.1541113000626;
        Thu, 01 Nov 2018 15:56:40 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v189-v6sm40929635pfb.54.2018.11.01.15.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 15:56:39 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     jaedon.shin@gmail.com, opendmb@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 1/2] net: bcmgenet: protect stop from timeout
Date:   Thu,  1 Nov 2018 15:55:37 -0700
Message-Id: <20181101225538.18632-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101225538.18632-1-f.fainelli@gmail.com>
References: <20181101225538.18632-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 1c1008c793fa ("net: bcmgenet: add main driver file")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
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

