Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D403C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6CC2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WAHxVwvX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6CC2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbeLCSkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:40:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34631 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeLCSkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:40:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so9961958lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LQhVP2xTDiWvMET8FX8dZ7UeSj+rc4vD4kLYzBGpj+Q=;
        b=WAHxVwvXKFmdWCpyYPcvFNSunMdJ/C2M0OVQ+QS3pwoW2cNSpeHdirsztoll0UBisR
         xQNZPz12+bGdP1TVrbwnktJKZCAer/arLA6OXowvtSgniykZR461ek+4sKCmJIVBwuLG
         r9vfgi0nnPXFwZrPpZcaiHefM73a9rmFFv//0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LQhVP2xTDiWvMET8FX8dZ7UeSj+rc4vD4kLYzBGpj+Q=;
        b=WrdV/mwvvWwY8z3TuRpVNBgnkXR44N6unIJCTeB9LvbtBZx5E+EUrXYSpDQUMPGXRp
         XhrC5AqcZE2IkfOflwWPNTsraDxiuQOwi658UGi4BS0uGXeBtB8eLr6nHkQt+TkXXPLv
         IJhmeB8RiNbAXauRUI16XQUjbsN036gMc2QEFPPrpitEoEcX0ReozYqWUZFr3likxblb
         80aFdhPTQDLJjYHlvZHDscH4LgCVtB2f2SbNmj5a/O/Q/CUZRRjLLwsSs8mIeyTagyvW
         wRjhBhKfym9Xxm2FZpcVE/MCynrUW+iFPs01TA7H54gogjgtcFxNHr+L/WIWkwhcGo5r
         3jNQ==
X-Gm-Message-State: AA+aEWb0XMzTvSqhLSlWM4hosjyC3urec9DctkK7i6wt6K0y1aINQnsC
        1cKZfPm+4LCy2hqvbZOh935Xng==
X-Google-Smtp-Source: AFSGD/UPDpwFWsYoPlLLpddaMc31C4vTNj7cd2E3zUy50EpLl2TFKda1baFDlrI3svZHvSXemk+Cqw==
X-Received: by 2002:a19:9e11:: with SMTP id h17mr10478905lfe.73.1543862434506;
        Mon, 03 Dec 2018 10:40:34 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id d23sm2518513lfc.11.2018.12.03.10.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:40:33 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 5/5] net: ethernet: ti: cpsw: update mc vlan and add uc vlan support based on addr vids
Date:   Mon,  3 Dec 2018 20:40:23 +0200
Message-Id: <20181203184023.3430-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update multicast support for vlans and add uc vlan support using newly
added net/core changes with vid tag.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 86 ++++++++++++++++++++++++++++------
 1 file changed, 71 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index e4aa030f1726..49a223720335 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -796,6 +796,67 @@ static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
 	return 0;
 }
 
+static int cpsw_set_uc(struct net_device *ndev, const u8 *addr,
+		       int vid, int add)
+{
+	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int flags, port, ret;
+
+	if (vid < 0) {
+		if (cpsw->data.dual_emac)
+			vid = cpsw->slaves[priv->emac_port].port_vlan;
+		else
+			vid = 0;
+	}
+
+	port = HOST_PORT_NUM;
+	flags = vid ? ALE_VLAN : 0;
+
+	if (add)
+		ret = cpsw_ale_add_ucast(cpsw->ale, addr, port, flags, vid);
+	else
+		ret = cpsw_ale_del_ucast(cpsw->ale, addr, port, flags, vid);
+
+	return ret;
+}
+
+static int _cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_mc(ndev, addr, vid ? vid : -1, 1);
+	return 0;
+}
+
+static int _cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_mc(ndev, addr, vid ? vid : -1, 0);
+	return 0;
+}
+
+static int _cpsw_add_uc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_uc(ndev, addr, vid ? vid : -1, 1);
+	return 0;
+}
+
+static int _cpsw_del_uc_addr(struct net_device *ndev, const u8 *addr)
+{
+	u16 vid;
+
+	vid = vlan_dev_get_addr_vid(ndev, addr);
+	cpsw_set_uc(ndev, addr, vid ? vid : -1, 0);
+	return 0;
+}
+
 static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -814,8 +875,8 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
 
 	/* add/remove mcast address either for real netdev or for vlan */
-	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
-			       cpsw_del_mc_addr);
+	__dev_mc_sync(ndev, _cpsw_add_mc_addr, _cpsw_del_mc_addr);
+	__dev_uc_sync(ndev, _cpsw_add_uc_addr, _cpsw_del_uc_addr);
 }
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
@@ -2092,7 +2153,8 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
-	__hw_addr_ref_unsync_dev(&ndev->mc, ndev, cpsw_purge_all_mc);
+	__dev_mc_unsync(ndev, _cpsw_del_mc_addr);
+	__dev_uc_unsync(ndev, _cpsw_del_uc_addr);
 	netif_tx_stop_all_queues(priv->ndev);
 	netif_carrier_off(priv->ndev);
 
@@ -2453,21 +2515,11 @@ static inline int cpsw_add_vlan_ale_entry(struct cpsw_priv *priv,
 	if (ret != 0)
 		return ret;
 
-	ret = cpsw_ale_add_ucast(cpsw->ale, priv->mac_addr,
-				 HOST_PORT_NUM, ALE_VLAN, vid);
-	if (ret != 0)
-		goto clean_vid;
-
 	ret = cpsw_ale_add_mcast(cpsw->ale, priv->ndev->broadcast,
 				 mcast_mask, ALE_VLAN, vid, 0);
-	if (ret != 0)
-		goto clean_vlan_ucast;
-	return 0;
+	if (!ret)
+		return 0;
 
-clean_vlan_ucast:
-	cpsw_ale_del_ucast(cpsw->ale, priv->mac_addr,
-			   HOST_PORT_NUM, ALE_VLAN, vid);
-clean_vid:
 	cpsw_ale_del_vlan(cpsw->ale, vid, 0);
 	return ret;
 }
@@ -3418,6 +3470,8 @@ static int cpsw_probe_dual_emac(struct cpsw_priv *priv)
 	priv_sl2->emac_port = 1;
 	cpsw->slaves[1].ndev = ndev;
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->vid_len = NET_802Q_VID_TSIZE;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
@@ -3679,6 +3733,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	}
 
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_CTAG_RX;
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->vid_len = NET_802Q_VID_TSIZE;
 
 	ndev->netdev_ops = &cpsw_netdev_ops;
 	ndev->ethtool_ops = &cpsw_ethtool_ops;
-- 
2.17.1

