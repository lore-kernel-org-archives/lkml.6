Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14682C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FFF25942
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4FFF25942
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752757AbeFYMkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:40:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38408 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933402AbeFYMjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:39:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 07C871A00CE;
        Mon, 25 Jun 2018 14:39:39 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BF1DE1A00CA;
        Mon, 25 Jun 2018 14:39:38 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 33F4640A70;
        Mon, 25 Jun 2018 05:39:38 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w5PCd34V025070;
        Mon, 25 Jun 2018 05:39:35 -0700
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v4, 10/10] dpaa_eth: add the get_ts_info interface for ethtool
Date:   Mon, 25 Jun 2018 20:37:16 +0800
Message-Id: <20180625123716.28993-11-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180625123716.28993-1-yangbo.lu@nxp.com>
References: <20180625123716.28993-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the get_ts_info interface for ethtool to check
the timestamping capability.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
Changes for v2:
	- Removed ifdef for hw timestamp.
Changes for v3:
	- None.
Changes for v4:
	- Added ACKs.
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c |   39 ++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 2f933b6..3184c8f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -32,6 +32,9 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/string.h>
+#include <linux/of_platform.h>
+#include <linux/net_tstamp.h>
+#include <linux/fsl/ptp_qoriq.h>
 
 #include "dpaa_eth.h"
 #include "mac.h"
@@ -515,6 +518,41 @@ static int dpaa_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+static int dpaa_get_ts_info(struct net_device *net_dev,
+			    struct ethtool_ts_info *info)
+{
+	struct device *dev = net_dev->dev.parent;
+	struct device_node *mac_node = dev->of_node;
+	struct device_node *fman_node = NULL, *ptp_node = NULL;
+	struct platform_device *ptp_dev = NULL;
+	struct qoriq_ptp *ptp = NULL;
+
+	info->phc_index = -1;
+
+	fman_node = of_get_parent(mac_node);
+	if (fman_node)
+		ptp_node = of_parse_phandle(fman_node, "ptimer-handle", 0);
+
+	if (ptp_node)
+		ptp_dev = of_find_device_by_node(ptp_node);
+
+	if (ptp_dev)
+		ptp = platform_get_drvdata(ptp_dev);
+
+	if (ptp)
+		info->phc_index = ptp->phc_index;
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->tx_types = (1 << HWTSTAMP_TX_OFF) |
+			 (1 << HWTSTAMP_TX_ON);
+	info->rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
+			   (1 << HWTSTAMP_FILTER_ALL);
+
+	return 0;
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_drvinfo = dpaa_get_drvinfo,
 	.get_msglevel = dpaa_get_msglevel,
@@ -530,4 +568,5 @@ static int dpaa_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	.set_link_ksettings = dpaa_set_link_ksettings,
 	.get_rxnfc = dpaa_get_rxnfc,
 	.set_rxnfc = dpaa_set_rxnfc,
+	.get_ts_info = dpaa_get_ts_info,
 };
-- 
1.7.1

