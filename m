Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C1FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38732081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38732081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeKGXYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:24:18 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44424 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbeKGXYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:24:18 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0138A1A0201;
        Wed,  7 Nov 2018 14:53:48 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E9BDE1A01C4;
        Wed,  7 Nov 2018 14:53:47 +0100 (CET)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B280F20137;
        Wed,  7 Nov 2018 14:53:47 +0100 (CET)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH] dpaa_eth: add ethtool coalesce control
Date:   Wed,  7 Nov 2018 15:53:43 +0200
Message-Id: <1541598823-22533-1-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
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
 drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 13d6e2272ece..548a7e8893d8 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -529,6 +529,45 @@ static int dpaa_get_ts_info(struct net_device *net_dev,
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
+	struct qman_portal *portal;
+	u32 period;
+	u8 thresh;
+	int cpu;
+
+	period = c->rx_coalesce_usecs;
+	thresh = c->rx_max_coalesced_frames;
+
+	for_each_cpu(cpu, cpus) {
+		portal = qman_get_affine_portal(cpu);
+		qman_portal_set_iperiod(portal, period);
+		qman_dqrr_set_ithresh(portal, thresh);
+	}
+
+	return 0;
+}
+
 const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_drvinfo = dpaa_get_drvinfo,
 	.get_msglevel = dpaa_get_msglevel,
@@ -545,4 +584,6 @@ const struct ethtool_ops dpaa_ethtool_ops = {
 	.get_rxnfc = dpaa_get_rxnfc,
 	.set_rxnfc = dpaa_set_rxnfc,
 	.get_ts_info = dpaa_get_ts_info,
+	.get_coalesce = dpaa_get_coalesce,
+	.set_coalesce = dpaa_set_coalesce,
 };
-- 
2.1.0

