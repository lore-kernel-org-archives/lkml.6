Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7491ECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3B3214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:24:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3B3214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbeIZThl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:37:41 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59546 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbeIZTfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:35:55 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D66EC1A025C;
        Wed, 26 Sep 2018 15:22:57 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C81BA1A004C;
        Wed, 26 Sep 2018 15:22:57 +0200 (CEST)
Received: from fsr-ub1864-101.ea.freescale.net (fsr-ub1864-101.ea.freescale.net [10.171.82.97])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BD67203C2;
        Wed, 26 Sep 2018 15:22:57 +0200 (CEST)
From:   laurentiu.tudor@nxp.com
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     roy.pledge@nxp.com, madalin.bucur@nxp.com, davem@davemloft.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, robin.murphy@arm.com,
        bharat.bhushan@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 12/22] dpaa_eth: base dma mappings on the fman rx port
Date:   Wed, 26 Sep 2018 16:22:37 +0300
Message-Id: <20180926132247.10971-13-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
References: <20180926132247.10971-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The dma transactions initiator is the rx fman port so that's the device
that the dma mappings should be done. Previously the mappings were done
through the MAC device which makes no sense because it's neither dma-able
nor connected in any way to smmu.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 6ca3fdbef580..ac9e50c8a556 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2796,8 +2796,15 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	mac_dev = dpaa_mac_dev_get(pdev);
+	if (IS_ERR(mac_dev)) {
+		dev_err(&pdev->dev, "dpaa_mac_dev_get() failed\n");
+		err = PTR_ERR(mac_dev);
+		goto probe_err;
+	}
+
 	/* device used for DMA mapping */
-	dev = pdev->dev.parent;
+	dev = fman_port_get_device(mac_dev->port[RX]);
 	err = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(40));
 	if (err) {
 		dev_err(dev, "dma_coerce_mask_and_coherent() failed\n");
@@ -2822,13 +2829,6 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 
 	priv->msg_enable = netif_msg_init(debug, DPAA_MSG_DEFAULT);
 
-	mac_dev = dpaa_mac_dev_get(pdev);
-	if (IS_ERR(mac_dev)) {
-		dev_err(dev, "dpaa_mac_dev_get() failed\n");
-		err = PTR_ERR(mac_dev);
-		goto free_netdev;
-	}
-
 	/* If fsl_fm_max_frm is set to a higher value than the all-common 1500,
 	 * we choose conservatively and let the user explicitly set a higher
 	 * MTU via ifconfig. Otherwise, the user may end up with different MTUs
@@ -2964,9 +2964,9 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	qman_release_cgrid(priv->cgr_data.cgr.cgrid);
 free_dpaa_bps:
 	dpaa_bps_free(priv);
-free_netdev:
 	dev_set_drvdata(dev, NULL);
 	free_netdev(net_dev);
+probe_err:
 
 	return err;
 }
-- 
2.17.1

