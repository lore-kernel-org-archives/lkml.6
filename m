Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30719C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E131F2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOli48+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfBEXzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:55:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39235 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfBEXzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:55:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so2254390pfc.6;
        Tue, 05 Feb 2019 15:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nGOqzXEDeMpumH0NxEfbE6+o24HDOHXpCnGBcNF7UFE=;
        b=WOli48+ZbANIuPiDuuldixEgD9/b/x40oHX7+8GXrIAe2jk1vcT15dha2MbDpJtBZY
         1JJ4ubldD3M1WVFvtxR66sPn6PwRf7CwCBfmP9FfjQtgB2f/fjqc/s+CT0xwVRNL86nh
         V/yW9VCgrZl01RBZFWK3c4xuEeU7vpGtGafPe+fJULa96dmD+fgSX1bLNjenuNd0n2v4
         MnfKH47CzuiGizO2eZGdUKGEHSVNmOBJiHqxlG+PPfNLeaVCoXaURBSnZJrjhnQl0CIm
         GB+2hyIEvv4QxmCWorv5Q5P7hMcH//25hcTuJp/vdax+vVfg/PSlhVDysCGtosvpcuwZ
         AMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nGOqzXEDeMpumH0NxEfbE6+o24HDOHXpCnGBcNF7UFE=;
        b=q8+UbX7sIqZlHrxK6tGSQP+ySK8XlHSBwb6C2Z159wzGgql8PDDPotvIH+NqGnVwa8
         Y8vX8sW99dDEN4KCAW3OXlIcEd5kpHqS1+UdKCrNb8jMknFYDhNGBcsoWPVZpP/yFfNm
         e4iZzy88VxTKw6jyREHomPFFCjGQG88g65R+rXDN3eomfjLqvyEY2PObHGgcOz9x90u5
         WhqSngm82BH1unzwDeZoBfF0Pq6ErFjZFKEg3RPeji+d8RDd6EzzovqrcxHBW8/CUxLm
         XHEGui7p3Eisb8PsV1OjlSJmfIJL1lqkb5MnSKg5KThqRcDY3qemh/E7gRGOveTLWiAx
         GZQQ==
X-Gm-Message-State: AHQUAuYhCBJ1NiiRD0duDwOJg3GQCw4guSRKAlPxJUQPiEpd+i+/vqvJ
        JbzWrzt/GVw7izLg6yYeeoOfp0cC
X-Google-Smtp-Source: AHgI3IbUINj/13Qrgdxtz+mlsoVMkM62oZrl4OEJjo32Xy9f3SRS/YPGw40DivX/TrmXFoYZmHdsqg==
X-Received: by 2002:a62:9683:: with SMTP id s3mr7626735pfk.60.1549410943602;
        Tue, 05 Feb 2019 15:55:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v184sm6770197pfb.182.2019.02.05.15.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:55:42 -0800 (PST)
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
Subject: [PATCH net-next v3 02/12] bnxt: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 15:53:16 -0800
Message-Id: <20190205235326.14600-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205235326.14600-1-f.fainelli@gmail.com>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
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

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 28 ++++++-------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  4 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_vfr.c | 12 +++-----
 4 files changed, 16 insertions(+), 31 deletions(-)

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
index c683b5e96b1d..170d2fbbb91b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -12,6 +12,7 @@
 #include <linux/if_vlan.h>
 #include <net/flow_dissector.h>
 #include <net/pkt_cls.h>
+#include <net/switchdev.h>
 #include <net/tc_act/tc_gact.h>
 #include <net/tc_act/tc_skbedit.h>
 #include <net/tc_act/tc_mirred.h>
@@ -45,7 +46,7 @@ static u16 bnxt_flow_get_dst_fid(struct bnxt *pf_bp, struct net_device *dev)
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

