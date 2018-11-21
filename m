Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71720C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C8520C01
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 11:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C8520C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbeKUWP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 17:15:28 -0500
Received: from inva021.nxp.com ([92.121.34.21]:46562 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbeKUWP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 17:15:26 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DB8E62002A1;
        Wed, 21 Nov 2018 12:41:20 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CF5C42000C5;
        Wed, 21 Nov 2018 12:41:20 +0100 (CET)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1FB00205F3;
        Wed, 21 Nov 2018 12:41:20 +0100 (CET)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     leoyang.li@nxp.com, roy.pledge@nxp.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH v3 3/3] dpaa_eth: add ethtool coalesce control
Date:   Wed, 21 Nov 2018 13:41:09 +0200
Message-Id: <1542800469-6802-4-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1542800469-6802-1-git-send-email-madalin.bucur@nxp.com>
References: <1542800469-6802-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow ethtool control of the DPAA QMan portal interrupt coalescing
settings.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 13d6e2272ece..62497119c85f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -529,6 +529,75 @@ static int dpaa_get_ts_info(struct net_device *net_dev,
 	return 0;
 }
 
+static int dpaa_get_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *c)
+{
+	struct qman_portal *portal;
+	u32 period;
+	u8 thresh;
+
+	portal = qman_get_affine_portal(smp_processor_id());
+	qman_portal_get_iperiod(portal, &period);
+	qman_dqrr_get_ithresh(portal, &thresh);
+
+	c->rx_coalesce_usecs = period;
+	c->rx_max_coalesced_frames = thresh;
+	c->use_adaptive_rx_coalesce = false;
+
+	return 0;
+}
+
+static int dpaa_set_coalesce(struct net_device *dev,
+			     struct ethtool_coalesce *c)
+{
+	const cpumask_t *cpus = qman_affine_cpus();
+	bool needs_revert[NR_CPUS] = {false};
+	struct qman_portal *portal;
+	u32 period, prev_period;
+	u8 thresh, prev_thresh;
+	int cpu, res;
+
+	if (c->use_adaptive_rx_coalesce)
+		return -EINVAL;
+
+	period = c->rx_coalesce_usecs;
+	thresh = c->rx_max_coalesced_frames;
+
+	/* save previous values */
+	portal = qman_get_affine_portal(smp_processor_id());
+	qman_portal_get_iperiod(portal, &prev_period);
+	qman_dqrr_get_ithresh(portal, &prev_thresh);
+
+	/* set new values */
+	for_each_cpu(cpu, cpus) {
+		portal = qman_get_affine_portal(cpu);
+		res = qman_portal_set_iperiod(portal, period);
+		if (res)
+			goto revert_values;
+		res = qman_dqrr_set_ithresh(portal, thresh);
+		if (res) {
+			qman_portal_set_iperiod(portal, prev_period);
+			goto revert_values;
+		}
+		needs_revert[cpu] = true;
+	}
+
+	return 0;
+
+revert_values:
+	/* restore previous values */
+	for_each_cpu(cpu, cpus) {
+		if (!needs_revert[cpu])
+			continue;
+		portal = qman_get_affine_portal(cpu);
+		/* previous values will not fail, ignore return value */
+		qman_portal_set_iperiod(portal, prev_period);
+		qman_dqrr_set_ithresh(portal, prev_thresh);
+	}
+
+	return res;
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_drvinfo = dpaa_get_drvinfo,
 	.get_msglevel = dpaa_get_msglevel,
@@ -545,4 +614,6 @@ const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_rxnfc = dpaa_get_rxnfc,
 	.set_rxnfc = dpaa_set_rxnfc,
 	.get_ts_info = dpaa_get_ts_info,
+	.get_coalesce = dpaa_get_coalesce,
+	.set_coalesce = dpaa_set_coalesce,
 };
-- 
2.1.0

