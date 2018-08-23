Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA238C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776FA208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776FA208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbeHWL50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:57:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbeHWL5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:57:25 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0BADE8B1;
        Thu, 23 Aug 2018 08:28:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 122/217] dpaa_eth: DPAA SGT needs to be 256B
Date:   Thu, 23 Aug 2018 09:53:55 +0200
Message-Id: <20180823075511.017648333@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit 595e802e53f24642a145cf7f3e4ac9afab4c21ec ]

The DPAA HW requires that at least 256 bytes from the start of the
first scatter-gather table entry are allocated and accessible. The
hardware reads the maximum size the table can have in one access,
thus requiring that the allocation and mapping to be done for the
maximum size of 256B even if there is a smaller number of entries
in the table.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -125,6 +125,9 @@ MODULE_PARM_DESC(tx_timeout, "The Tx tim
 /* Default alignment for start of data in an Rx FD */
 #define DPAA_FD_DATA_ALIGNMENT  16
 
+/* The DPAA requires 256 bytes reserved and mapped for the SGT */
+#define DPAA_SGT_SIZE 256
+
 /* Values for the L3R field of the FM Parse Results
  */
 /* L3 Type field: First IP Present IPv4 */
@@ -1622,8 +1625,8 @@ static struct sk_buff *dpaa_cleanup_tx_f
 
 	if (unlikely(qm_fd_get_format(fd) == qm_fd_sg)) {
 		nr_frags = skb_shinfo(skb)->nr_frags;
-		dma_unmap_single(dev, addr, qm_fd_get_offset(fd) +
-				 sizeof(struct qm_sg_entry) * (1 + nr_frags),
+		dma_unmap_single(dev, addr,
+				 qm_fd_get_offset(fd) + DPAA_SGT_SIZE,
 				 dma_dir);
 
 		/* The sgt buffer has been allocated with netdev_alloc_frag(),
@@ -1907,8 +1910,7 @@ static int skb_to_sg_fd(struct dpaa_priv
 	void *sgt_buf;
 
 	/* get a page frag to store the SGTable */
-	sz = SKB_DATA_ALIGN(priv->tx_headroom +
-		sizeof(struct qm_sg_entry) * (1 + nr_frags));
+	sz = SKB_DATA_ALIGN(priv->tx_headroom + DPAA_SGT_SIZE);
 	sgt_buf = netdev_alloc_frag(sz);
 	if (unlikely(!sgt_buf)) {
 		netdev_err(net_dev, "netdev_alloc_frag() failed for size %d\n",
@@ -1976,9 +1978,8 @@ static int skb_to_sg_fd(struct dpaa_priv
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


