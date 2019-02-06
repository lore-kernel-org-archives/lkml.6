Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7A4C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73FE2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9CnzxN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbfBFRqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:46:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43720 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbfBFRqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so3407389plb.10;
        Wed, 06 Feb 2019 09:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jldxP/I4knBZCEs5xEgH6APsGdVBtBxQ/a6oFR4v1rw=;
        b=g9CnzxN1gqVZ2iq7dTwErvMH2Kupr+5RllFJdeGR8N9yx3M/NCIjRQyfA4ECbFh74h
         Kn1x9CMs+JKCCOLADVC2eihWg/sp+2xRLp+jUqqCx1Ogens1eAM20zHkzOUFLaxJdcYG
         41vhGZxXlqyRVXl2qpZ72lACIJeBQ5TDrdaRRQTxgvQyJyvd6ArtIlxI8Y3TpQpEFuX8
         3ArnCytWTORSzkwnMAp5KmvCYkAqsd85o/qbSa4h5d7++x5cD9ZgB3d3qNj0d9HPMcLC
         qApi1+avot9l50+dsdn+jpSkPdrpZmmba3S8pwFU5hdNMWts2d+r3HpVxT90JQt4CzyH
         lKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jldxP/I4knBZCEs5xEgH6APsGdVBtBxQ/a6oFR4v1rw=;
        b=TaoRzP3RWOSdKfVI9rGTk2UJHdfRWxi4kmzoHw/K7lG53onwaCTSIJ1V7kuI+Mh6n1
         SjTJYwD/IV3PsJ3rVnCuzzTZLKvPO7xIrKdJCUOuZb5bd5gYkRMTcgInbPBO1zWbFEOB
         1wQMvu867Qx1myU5Yw2eCqPutqLUhQb+/B2CfkXGZs12maWZuD7QuYkkNWcZ492sSo9z
         WDDaprIK+kvrY1XC4TSjGJAB9E94YL/T3/FfzwcnnpACjgihcD5YYjOIDEP3MahpXaIG
         Vhcz0MLuj7yMf9F5ak19Qn7xLgy3mB76uXHtQSebHDILKykF3nA44YMH8AkPKdZwma+X
         gbOQ==
X-Gm-Message-State: AHQUAubJ2Jvk6CG8s8yS/WSntAholBu086zybp5FO0d080FizvZbyDwx
        lKNkUWhcw5AurPP3AqRapEvOp+ph
X-Google-Smtp-Source: AHgI3IbI+2P1890QxvMefg+o6H/sl6Ba1jlalkUz+oYDxl4b8hv6CWyMQO4JiTqt7egR2uQvv/id7A==
X-Received: by 2002:a17:902:bcc7:: with SMTP id o7mr12061526pls.281.1549475166950;
        Wed, 06 Feb 2019 09:46:06 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:06 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE)
Subject: [PATCH net-next v4 02/12] bnxt: Implement ndo_get_port_parent_id()
Date:   Wed,  6 Feb 2019 09:45:36 -0800
Message-Id: <20190206174546.23597-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BNXT only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
great candidate to be converted to use the ndo_get_port_parent_id() NDO
instead of implementing switchdev_port_attr_get(). The conversion is
straight forward here since the PF and VF code use the same getter.

Since bnxt makes uses of switchdev_port_same_parent_id() convert it to
use netdev_port_same_parent_id().

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 ++++++-------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c | 12 +++-----
 4 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6a512871176b..1c2987c3d708 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9981,8 +9981,11 @@ static int bnxt_get_phys_port_name(struct net_device *dev, char *buf,
 	return 0;
 }
 
-int bnxt_port_attr_get(struct bnxt *bp, struct switchdev_attr *attr)
+int bnxt_get_port_parent_id(struct net_device *dev,
+			    struct netdev_phys_item_id *ppid)
 {
+	struct bnxt *bp = netdev_priv(dev);
+
 	if (bp->eswitch_mode != DEVLINK_ESWITCH_MODE_SWITCHDEV)
 		return -EOPNOTSUPP;
 
@@ -9990,27 +9993,12 @@ int bnxt_port_attr_get(struct bnxt *bp, struct switchdev_attr *attr)
 	if (!BNXT_PF(bp))
 		return -EOPNOTSUPP;
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(bp->switch_id);
-		memcpy(attr->u.ppid.id, bp->switch_id, attr->u.ppid.id_len);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-	return 0;
-}
+	ppid->id_len = sizeof(bp->switch_id);
+	memcpy(ppid->id, bp->switch_id, ppid->id_len);
 
-static int bnxt_swdev_port_attr_get(struct net_device *dev,
-				    struct switchdev_attr *attr)
-{
-	return bnxt_port_attr_get(netdev_priv(dev), attr);
+	return 0;
 }
 
-static const struct switchdev_ops bnxt_switchdev_ops = {
-	.switchdev_port_attr_get	= bnxt_swdev_port_attr_get
-};
-
 static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_open		= bnxt_open,
 	.ndo_start_xmit		= bnxt_start_xmit,
@@ -10042,6 +10030,7 @@ static const struct net_device_ops bnxt_netdev_ops = {
 	.ndo_bpf		= bnxt_xdp,
 	.ndo_bridge_getlink	= bnxt_bridge_getlink,
 	.ndo_bridge_setlink	= bnxt_bridge_setlink,
+	.ndo_get_port_parent_id	= bnxt_get_port_parent_id,
 	.ndo_get_phys_port_name = bnxt_get_phys_port_name
 };
 
@@ -10400,7 +10389,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->netdev_ops = &bnxt_netdev_ops;
 	dev->watchdog_timeo = BNXT_TX_TIMEOUT;
 	dev->ethtool_ops = &bnxt_ethtool_ops;
-	SWITCHDEV_SET_OPS(dev, &bnxt_switchdev_ops);
 	pci_set_drvdata(pdev, dev);
 
 	rc = bnxt_alloc_hwrm_resources(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 5c886a700bcc..17554d4be651 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -22,7 +22,6 @@
 #include <linux/rhashtable.h>
 #include <net/devlink.h>
 #include <net/dst_metadata.h>
-#include <net/switchdev.h>
 #include <net/xdp.h>
 #include <linux/net_dim.h>
 
@@ -1795,7 +1794,8 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 int bnxt_setup_mq_tc(struct net_device *dev, u8 tc);
 int bnxt_get_max_rings(struct bnxt *, int *, int *, bool);
 int bnxt_restore_pf_fw_resources(struct bnxt *bp);
-int bnxt_port_attr_get(struct bnxt *bp, struct switchdev_attr *attr);
+int bnxt_get_port_parent_id(struct net_device *dev,
+			    struct netdev_phys_item_id *ppid);
 void bnxt_dim_work(struct work_struct *work);
 int bnxt_hwrm_set_ring_coal(struct bnxt *bp, struct bnxt_napi *bnapi);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index c683b5e96b1d..86950f70de1f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -45,7 +45,7 @@ static u16 bnxt_flow_get_dst_fid(struct bnxt *pf_bp, struct net_device *dev)
 	struct bnxt *bp;
 
 	/* check if dev belongs to the same switch */
-	if (!switchdev_port_same_parent_id(pf_bp->dev, dev)) {
+	if (!netdev_port_same_parent_id(pf_bp->dev, dev)) {
 		netdev_info(pf_bp->dev, "dev(ifindex=%d) not on same switch",
 			    dev->ifindex);
 		return BNXT_FID_INVALID;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
index 9a25c05aa571..2bdd2da9aac7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c
@@ -237,21 +237,17 @@ static void bnxt_vf_rep_get_drvinfo(struct net_device *dev,
 	strlcpy(info->version, DRV_MODULE_VERSION, sizeof(info->version));
 }
 
-static int bnxt_vf_rep_port_attr_get(struct net_device *dev,
-				     struct switchdev_attr *attr)
+static int bnxt_vf_rep_get_port_parent_id(struct net_device *dev,
+					  struct netdev_phys_item_id *ppid)
 {
 	struct bnxt_vf_rep *vf_rep = netdev_priv(dev);
 
 	/* as only PORT_PARENT_ID is supported currently use common code
 	 * between PF and VF-rep for now.
 	 */
-	return bnxt_port_attr_get(vf_rep->bp, attr);
+	return bnxt_get_port_parent_id(vf_rep->bp->dev, ppid);
 }
 
-static const struct switchdev_ops bnxt_vf_rep_switchdev_ops = {
-	.switchdev_port_attr_get	= bnxt_vf_rep_port_attr_get
-};
-
 static const struct ethtool_ops bnxt_vf_rep_ethtool_ops = {
 	.get_drvinfo		= bnxt_vf_rep_get_drvinfo
 };
@@ -262,6 +258,7 @@ static const struct net_device_ops bnxt_vf_rep_netdev_ops = {
 	.ndo_start_xmit		= bnxt_vf_rep_xmit,
 	.ndo_get_stats64	= bnxt_vf_rep_get_stats64,
 	.ndo_setup_tc		= bnxt_vf_rep_setup_tc,
+	.ndo_get_port_parent_id	= bnxt_vf_rep_get_port_parent_id,
 	.ndo_get_phys_port_name = bnxt_vf_rep_get_phys_port_name
 };
 
@@ -392,7 +389,6 @@ static void bnxt_vf_rep_netdev_init(struct bnxt *bp, struct bnxt_vf_rep *vf_rep,
 
 	dev->netdev_ops = &bnxt_vf_rep_netdev_ops;
 	dev->ethtool_ops = &bnxt_vf_rep_ethtool_ops;
-	SWITCHDEV_SET_OPS(dev, &bnxt_vf_rep_switchdev_ops);
 	/* Just inherit all the featues of the parent PF as the VF-R
 	 * uses the RX/TX rings of the parent PF
 	 */
-- 
2.17.1

