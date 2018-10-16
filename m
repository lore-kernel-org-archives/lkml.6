Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F24C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9089721471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIaiTraV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9089721471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbeJQCMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:12:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34484 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeJQCM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:12:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id y10-v6so17753310lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jLFuOs1cSVmlpobA1RYDVi6svvbcni9hZ6eXt8GSdXw=;
        b=FIaiTraVPXrqdoxh0HtJYKo8IhE+QVgs/NViyyoegt8hW2EPcAxXZMPTuP2KuIXD88
         NLSCnk4RKWh4pG8tXs4ksgTJrb0A1ldbAv9u6IzOzhhQEg/VgitiZ7OnIS1viy3ODBzh
         wid/HPjpypVB2SjsbdCh0RON1srP7cKDGD9yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jLFuOs1cSVmlpobA1RYDVi6svvbcni9hZ6eXt8GSdXw=;
        b=TQZ5PW25QCoLHbdARVEsPIE585BYnESh3KsNiqFbYndOHIlTvZalpqCKJqt3Hvm16W
         diEfrUk6MUyBeh5K42OFF1CPmMAGaR8QT8R6YIx3pi0CtszlsSSZ7J0cOCFGut7rqY1/
         KkDQgd9KoZuysWBlYKL2+NBo0djbUNapdZjQHoH87w8v7SsTopsau90dZQbXvCStanX1
         OBgTi/1X4oCWL6BNDESJX8xT9gvLfKQn6wCbePkQ6YxvqKkjqHpcM/g3LE/SQgTBhXnM
         K/6sM1krcmpLdNMQYS0+nuGsOK9FgC1sPdlVGWBjCEu22MkI2ZM1CKlpXs/lmKq54gHi
         1l1Q==
X-Gm-Message-State: ABuFfojsJzYAgXd5nxrpdydPcJx8tvdRoZANyYbe4v02hqtM1+oLDMtm
        mim+mcQ8TFMZbVAgNUdk7l9BUQ==
X-Google-Smtp-Source: ACcGV63NzpZi1n2cOSAgCTOqHPxWcPrm75bVEIwRa0h+IPaSALnevFe15RFyQvo4CPlbLkMEe21mxw==
X-Received: by 2002:a19:d713:: with SMTP id o19-v6mr13078188lfg.114.1539714042680;
        Tue, 16 Oct 2018 11:20:42 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id i27-v6sm3207844lfc.22.2018.10.16.11.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 11:20:41 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     grygorii.strashko@ti.com, davem@davemloft.net
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 3/4] net: ethernet: ti: cpsw: fix vlan mcast
Date:   Tue, 16 Oct 2018 21:20:34 +0300
Message-Id: <20181016182035.18234-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this moment, mcast addresses are added only for real device only
(reserved vlans for dual-emac mode), even if a mcast address was added
for some vlan only, thus ALE doesn't have corresponding vlan mcast
entries after vlan socket joined multicast group. So ALE drops vlan
frames with mcast addresses intended for vlans and potentially can
receive mcast frames for base ndev. That's not correct. So, fix it by
creating only vlan/mcast entries as requested. Patch doesn't use any
additional lists and is based on device mc address list and cpsw ALE
table entries.

Also, move device to allmulti state if no space for new mcast entries.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 drivers/net/ethernet/ti/cpsw.c | 172 +++++++++++++++++++++++++++------
 1 file changed, 142 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 226be2a56c1f..5967484619d4 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -570,21 +570,6 @@ static inline int cpsw_get_slave_port(u32 slave_num)
 	return slave_num + 1;
 }
 
-static void cpsw_add_mcast(struct cpsw_priv *priv, const u8 *addr)
-{
-	struct cpsw_common *cpsw = priv->cpsw;
-
-	if (cpsw->data.dual_emac) {
-		struct cpsw_slave *slave = cpsw->slaves + priv->emac_port;
-
-		cpsw_ale_add_mcast(cpsw->ale, addr, ALE_PORT_HOST,
-				   ALE_VLAN, slave->port_vlan, 0);
-		return;
-	}
-
-	cpsw_ale_add_mcast(cpsw->ale, addr, ALE_ALL_PORTS, 0, 0, 0);
-}
-
 static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -660,29 +645,153 @@ static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 	}
 }
 
-static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr)
+struct addr_sync_ctx {
+	struct net_device *ndev;
+	const u8 *addr;		/* address to be sync or unsync */
+	int keep_num;		/* number of address instances to be kept */
+	int flush;		/* flush flag */
+};
+
+/**
+ * cpsw_set_mc - adds multicast entry to the table if it's not added or deletes
+ * if it's not deleted
+ * @ndev: device to sync
+ * @addr: address to be added or deleted
+ * @vid: vlan id, if vid < 0 set/unset address for real device
+ * @add: add address if the flag is set or remove otherwise
+ */
+static int cpsw_set_mc(struct net_device *ndev, const u8 *addr,
+		       int vid, int add)
 {
 	struct cpsw_priv *priv = netdev_priv(ndev);
+	struct cpsw_common *cpsw = priv->cpsw;
+	int mask, flags, ret;
+
+	if (vid < 0) {
+		if (cpsw->data.dual_emac)
+			vid = cpsw->slaves[priv->emac_port].port_vlan;
+		else
+			vid = 0;
+	}
+
+	mask = cpsw->data.dual_emac ? ALE_PORT_HOST : ALE_ALL_PORTS;
+	flags = vid ? ALE_VLAN : 0;
+
+	if (add)
+		ret = cpsw_ale_add_mcast(cpsw->ale, addr, mask, flags, vid, 0);
+	else
+		ret = cpsw_ale_del_mcast(cpsw->ale, addr, 0, flags, vid);
+
+	return ret;
+}
+
+static int cpsw_update_vlan_mc(struct net_device *vdev, int vid, void *ctx)
+{
+	struct addr_sync_ctx *sync_ctx = ctx;
+	struct netdev_hw_addr *ha;
+	int found = 0, ret = 0;
+
+	if (!vdev || !(vdev->flags & IFF_UP))
+		return ret;
+
+	/* vlan address is relevant if it's sync_cnt != 0 */
+	netdev_for_each_mc_addr(ha, vdev) {
+		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
+			found = ha->sync_cnt;
+			break;
+		}
+	}
+
+	if (found)
+		sync_ctx->keep_num--;
+
+	if (sync_ctx->flush) {
+		if (!found)
+			cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
+		return ret;
+	}
+
+	if (found)
+		ret = cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 1);
+
+	return ret;
+}
+
+static int cpsw_add_mc_addr(struct net_device *ndev, const u8 *addr, int num)
+{
+	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
+	struct addr_sync_ctx sync_ctx;
+	int ret;
+
+	sync_ctx.keep_num = num;
+	sync_ctx.addr = addr;
+	sync_ctx.ndev = ndev;
+	sync_ctx.flush = 0;
+
+	ret = vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
+	if (sync_ctx.keep_num && !ret)
+		ret = cpsw_set_mc(ndev, addr, -1, 1);
+
+	/* table is overflowed, set ALLMULTI */
+	if (ret == -ENOMEM)
+		cpsw_ale_set_allmulti(cpsw->ale, IFF_ALLMULTI);
+
+	return ret;
+}
+
+static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr, int num)
+{
+	struct addr_sync_ctx sync_ctx;
+
+	sync_ctx.keep_num = num;
+	sync_ctx.addr = addr;
+	sync_ctx.ndev = ndev;
+	sync_ctx.flush = 1;
+
+	vlan_for_each(ndev, cpsw_update_vlan_mc, &sync_ctx);
+	if (!sync_ctx.keep_num)
+		cpsw_set_mc(ndev, addr, -1, 0);
 
-	cpsw_add_mcast(priv, addr);
 	return 0;
 }
 
-static int cpsw_del_mc_addr(struct net_device *ndev, const u8 *addr)
+static int cpsw_purge_vlan_mc(struct net_device *vdev, int vid, void *ctx)
 {
-	struct cpsw_priv *priv = netdev_priv(ndev);
-	struct cpsw_common *cpsw = priv->cpsw;
-	int vid, flags;
+	struct addr_sync_ctx *sync_ctx = ctx;
+	struct netdev_hw_addr *ha;
+	int found = 0;
 
-	if (cpsw->data.dual_emac) {
-		vid = cpsw->slaves[priv->emac_port].port_vlan;
-		flags = ALE_VLAN;
-	} else {
-		vid = 0;
-		flags = 0;
+	if (!vdev || !(vdev->flags & IFF_UP))
+		return 0;
+
+	/* vlan address is relevant if it's sync_cnt != 0 */
+	netdev_for_each_mc_addr(ha, vdev) {
+		if (ether_addr_equal(ha->addr, sync_ctx->addr)) {
+			found = ha->sync_cnt;
+			break;
+		}
 	}
 
-	cpsw_ale_del_mcast(cpsw->ale, addr, 0, flags, vid);
+	if (!found)
+		return 0;
+
+	sync_ctx->keep_num--;
+	cpsw_set_mc(sync_ctx->ndev, sync_ctx->addr, vid, 0);
+	return 0;
+}
+
+static int cpsw_purge_all_mc(struct net_device *ndev, const u8 *addr, int num)
+{
+	struct addr_sync_ctx sync_ctx;
+
+	sync_ctx.addr = addr;
+	sync_ctx.ndev = ndev;
+	sync_ctx.keep_num = num;
+
+	vlan_for_each(ndev, cpsw_purge_vlan_mc, &sync_ctx);
+	if (sync_ctx.keep_num)
+		cpsw_set_mc(ndev, addr, -1, 0);
+
 	return 0;
 }
 
@@ -703,7 +812,9 @@ static void cpsw_ndo_set_rx_mode(struct net_device *ndev)
 	/* Restore allmulti on vlans if necessary */
 	cpsw_ale_set_allmulti(cpsw->ale, ndev->flags & IFF_ALLMULTI);
 
-	__dev_mc_sync(ndev, cpsw_add_mc_addr, cpsw_del_mc_addr);
+	/* add/remove mcast address either for real netdev or for vlan */
+	__hw_addr_ref_sync_dev(&ndev->mc, ndev, cpsw_add_mc_addr,
+			       cpsw_del_mc_addr);
 }
 
 static void cpsw_intr_enable(struct cpsw_common *cpsw)
@@ -1963,7 +2074,7 @@ static int cpsw_ndo_stop(struct net_device *ndev)
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	cpsw_info(priv, ifdown, "shutting down cpsw device\n");
-	__dev_mc_unsync(priv->ndev, cpsw_del_mc_addr);
+	__hw_addr_ref_unsync_dev(&ndev->mc, ndev, cpsw_purge_all_mc);
 	netif_tx_stop_all_queues(priv->ndev);
 	netif_carrier_off(priv->ndev);
 
@@ -2414,6 +2525,7 @@ static int cpsw_ndo_vlan_rx_kill_vid(struct net_device *ndev,
 				  HOST_PORT_NUM, ALE_VLAN, vid);
 	ret |= cpsw_ale_del_mcast(cpsw->ale, priv->ndev->broadcast,
 				  0, ALE_VLAN, vid);
+	ret |= cpsw_ale_flush_multicast(cpsw->ale, 0, vid);
 err:
 	pm_runtime_put(cpsw->dev);
 	return ret;
-- 
2.17.1

