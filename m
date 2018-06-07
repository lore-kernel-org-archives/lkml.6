Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id T6a2L4WlGFtRawAAmS7hNA
	; Thu, 07 Jun 2018 03:25:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2ACF26089E; Thu,  7 Jun 2018 03:25:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 994AA60452;
	Thu,  7 Jun 2018 03:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 994AA60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933697AbeFGDZJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 23:25:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:34137 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932746AbeFGDZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 23:25:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E49C32001F9;
        Thu,  7 Jun 2018 05:25:02 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B0B98200206;
        Thu,  7 Jun 2018 05:25:02 +0200 (CEST)
Received: from az84smr01.freescale.net (az84smr01.freescale.net [10.64.34.197])
        by inv1260.na-rdc02.nxp.com (Postfix) with ESMTP id 2679640A70;
        Wed,  6 Jun 2018 20:25:02 -0700 (MST)
Received: from titan.ap.freescale.net ([10.192.208.233])
        by az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id w573OSwX023286;
        Wed, 6 Jun 2018 20:24:59 -0700
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 10/10] dpaa_eth: add the get_ts_info interface for ethtool
Date: Thu,  7 Jun 2018 11:22:56 +0800
Message-Id: <20180607032256.39802-11-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180607032256.39802-1-yangbo.lu@nxp.com>
References: <20180607032256.39802-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the get_ts_info interface for ethtool to check
the timestamping capability.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Removed ifdef for hw timestamp.
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
