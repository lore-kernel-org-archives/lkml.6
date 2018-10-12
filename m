Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858F0C67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55120868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 15:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mgnt0SvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D55120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeJLXBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:01:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41077 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbeJLXBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:01:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id q39-v6so9602013lfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uL0gQCH5nRToPUTiJMZIUbGu30iF186CtuKZDfZZDX4=;
        b=Mgnt0SvGPqFs/AZ8lavJIGEBb4aSqhnddvXwgozoJoS7jAbUTuWFUD2ObA1nC1Gnp8
         bue0FfkZjVMBiVJqf7G0DCKOeToRqUYbKtOdH60gTdPSpJ+U3XSUGiPq5DBtd7rG15WY
         3hq3pgznBmnbk3manpcFfujZgeMqsvZmJabkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uL0gQCH5nRToPUTiJMZIUbGu30iF186CtuKZDfZZDX4=;
        b=M1P4VqbkhAnb3wkd4CiuxogtoGFLlkV81HtaME0YQI23YX1c2mGugE0iWY5bdJBDUX
         dJDE7UgokfI4DHTT2oeh76O7xdvvQE6wktXgVU864ak02YxNA5BtBcK7xaCJUlfV1XG+
         3kbFulI/nCvALFHej54ASEJH47GmpyIOiE8N2MU1z5CsHP1suioGIgG9irlqSKrKn5C/
         aPpkS9ZN7dCV+PEh+VSKtfoO56ImTe0hjgQq+JnbTDrGyIRfhZKGDXMOeFbJBMQDbIU7
         XY2RoinNIuGwCWsAwetY+t593MEYmNLvk3LLDlO1NgVR+xFnRQ9QAdt3kibmGnSVpErX
         UMMg==
X-Gm-Message-State: ABuFfoh5kZZQV5siL/eDrHPdL6d1OzmTZCKVey7ukaEjgOLaStXAbU9E
        w2/JgtwOr4POH+odDgEnwrVwdA==
X-Google-Smtp-Source: ACcGV63P+q1dkHlYove2K9NfbqmGBoR7yqa7K34iJ4olO9x5+ZFKk1vGxl9KUo5dUlfodY/HgZM6YQ==
X-Received: by 2002:a19:ab1a:: with SMTP id u26-v6mr4360863lfe.103.1539358102146;
        Fri, 12 Oct 2018 08:28:22 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id a63-v6sm325923ljf.54.2018.10.12.08.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 08:28:21 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH 2/2] net: ethernet: ti: cpsw: fix lost of mcast packets while rx_mode update
Date:   Fri, 12 Oct 2018 18:28:15 +0300
Message-Id: <20181012152815.31320-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
References: <20181012152815.31320-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever kernel or user decides to call rx mode update, it clears
every multicast entry from forwarding table and in some time adds
it again. This time can be enough to drop incoming multicast packets.

That's why clear only staled multicast entries and update or add new
one afterwards.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 46 +++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 832bce07c385..b7a6a2a0f71d 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -570,7 +570,7 @@ static inline int cpsw_get_slave_port(u32 slave_num)
 	return slave_num + 1;
 }
 
-static void cpsw_add_mcast(struct cpsw_priv *priv, u8 *addr)
+static void cpsw_add_mcast(struct cpsw_priv *priv, const u8 *addr)
 {
 	struct cpsw_common *cpsw = priv->cpsw;
 
@@ -662,16 +662,35 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 	}
 }
 
-static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+
+	cpsw_add_mcast(priv, addr);
+	return 0;
+}
+
+static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
 	struct cpsw_common *cpsw = priv->cpsw;
-	int vid;
+	int vid, flags;
 
-	if (cpsw->data.dual_emac)
+	if (cpsw->data.dual_emac) {
 		vid = cpsw->slaves[priv->emac_port].port_vlan;
-	else
-		vid = cpsw->data.default_vlan;
+		flags = ALE_VLAN;
+	} else {
+		vid = 0;
+		flags = 0;
+	}
+
+	cpsw_ale_del_mcast(cpsw->ale, addr, 0, flags, vid);
+	return 0;
+}
+
+static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
 
 	if (ndev->flags & IFF_PROMISC) {
 		/* Enable promiscuous mode */
@@ -684,19 +703,9 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	}
 
 	/* Restore allmulti on vlans if necessary */
-	cpsw_ale_set_allmulti(cpsw->ale, priv->ndev->flags & IFF_ALLMULTI);
-
-	/* Clear all mcast from ALE */
-	cpsw_ale_flush_multicast(cpsw->ale, ALE_ALL_PORTS, vid);
+	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
 
-	if (!netdev_mc_empty(ndev)) {
-		struct netdev_hw_addr *ha;
-
-		/* program multicast address list into ALE register */
-		netdev_for_each_mc_addr(ha, ndev) {
-			cpsw_add_mcast(priv, ha->addr);
-		}
-	}
+	__dev_mc_sync(ndev, cpsw_add_mc_addr, cpsw_del_mc_addr);
 }
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
@@ -1956,6 +1965,7 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
+	__dev_mc_unsync(priv->ndev, cpsw_del_mc_addr);
 	netif_tx_stop_all_queues(priv->ndev);
 	netif_carrier_off(priv->ndev);
 
-- 
2.17.1

