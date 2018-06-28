Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C385C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05C42735E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05C42735E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935323AbeF1M1V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:27:21 -0400
Received: from inva020.nxp.com ([92.121.34.13]:52056 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932640AbeF1M1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:27:19 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 228591A0162;
        Thu, 28 Jun 2018 14:27:18 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 15CE31A0153;
        Thu, 28 Jun 2018 14:27:18 +0200 (CEST)
Received: from fsr-fed2164-101.ea.freescale.net (fsr-fed2164-101.ea.freescale.net [10.171.82.91])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CBE7A2061E;
        Thu, 28 Jun 2018 14:27:12 +0200 (CEST)
From:   Madalin Bucur <madalin.bucur@nxp.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [net 2/2] dpaa_eth: DPAA SGT needs to be 256B
Date:   Thu, 28 Jun 2018 15:26:51 +0300
Message-Id: <1530188811-8918-3-git-send-email-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1530188811-8918-1-git-send-email-madalin.bucur@nxp.com>
References: <1530188811-8918-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DPAA HW requires that at least 256 bytes from the start of the
first scatter-gather table entry are allocated and accessible. The
hardware reads the maximum size the table can have in one access,
thus requiring that the allocation and mapping to be done for the
maximum size of 256B even if there is a smaller number of entries
in the table.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 52f4a6b..65a22cd 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -125,6 +125,9 @@ MODULE_PARM_DESC(tx_timeout, "The Tx timeout in ms");
 /* Default alignment for start of data in an Rx FD */
 #define DPAA_FD_DATA_ALIGNMENT  16
 
+/* The DPAA requires 256 bytes reserved and mapped for the SGT */
+#define DPAA_SGT_SIZE 256
+
 /* Values for the L3R field of the FM Parse Results
  */
 /* L3 Type field: First IP Present IPv4 */
@@ -1631,8 +1634,8 @@ static struct sk_buff *dpaa_cleanup_tx_fd(const struct dpaa_priv *priv,
 
 	if (unlikely(qm_fd_get_format(fd) == qm_fd_sg)) {
 		nr_frags = skb_shinfo(skb)->nr_frags;
-		dma_unmap_single(dev, addr, qm_fd_get_offset(fd) +
-				 sizeof(struct qm_sg_entry) * (1 + nr_frags),
+		dma_unmap_single(dev, addr,
+				 qm_fd_get_offset(fd) + DPAA_SGT_SIZE,
 				 dma_dir);
 
 		/* The sgt buffer has been allocated with netdev_alloc_frag(),
@@ -1917,8 +1920,7 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
 	void *sgt_buf;
 
 	/* get a page frag to store the SGTable */
-	sz = SKB_DATA_ALIGN(priv->tx_headroom +
-		sizeof(struct qm_sg_entry) * (1 + nr_frags));
+	sz = SKB_DATA_ALIGN(priv->tx_headroom + DPAA_SGT_SIZE);
 	sgt_buf = netdev_alloc_frag(sz);
 	if (unlikely(!sgt_buf)) {
 		netdev_err(net_dev, "netdev_alloc_frag() failed for size %d\n",
@@ -1986,9 +1988,8 @@ static int skb_to_sg_fd(struct dpaa_priv *priv,
 	skbh = (struct sk_buff **)buffer_start;
 	*skbh = skb;
 
-	addr = dma_map_single(dev, buffer_start, priv->tx_headroom +
-			      sizeof(struct qm_sg_entry) * (1 + nr_frags),
-			      dma_dir);
+	addr = dma_map_single(dev, buffer_start,
+			      priv->tx_headroom + DPAA_SGT_SIZE, dma_dir);
 	if (unlikely(dma_mapping_error(dev, addr))) {
 		dev_err(dev, "DMA mapping failed");
 		err = -EINVAL;
-- 
2.1.0

