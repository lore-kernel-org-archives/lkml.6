Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782BBC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB8A2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB8A2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbeIXSqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:46:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59680 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389239AbeIXSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:46:52 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C81B11099;
        Mon, 24 Sep 2018 12:44:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 224/235] staging: fsl-dpaa2/eth: Fix DMA mapping direction
Date:   Mon, 24 Sep 2018 13:53:30 +0200
Message-Id: <20180924113125.577011821@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>

[ Upstream commit 466bcdc1fa303be175c45d054bb00effc575033a ]

We are using DMA_FROM_DEVICE when mapping RX frame buffers,
but DMA_BIDIRECTIONAL for unmap. Fix the direction for DMA
unmapping operation.

Fixes: 87eb55e418b7 ("staging: fsl-dpaa2/eth: Fix potential endless loop")

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -767,7 +767,7 @@ static void free_bufs(struct dpaa2_eth_p
 	for (i = 0; i < count; i++) {
 		vaddr = dpaa2_iova_to_virt(priv->iommu_domain, buf_array[i]);
 		dma_unmap_single(dev, buf_array[i], DPAA2_ETH_RX_BUF_SIZE,
-				 DMA_BIDIRECTIONAL);
+				 DMA_FROM_DEVICE);
 		skb_free_frag(vaddr);
 	}
 }


