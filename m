Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA89C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3398920645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3398920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeJNXLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:11:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35835 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727361AbeJNXLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:11:48 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLb-0004cf-RD; Sun, 14 Oct 2018 16:30:28 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLZ-0000gY-9s; Sun, 14 Oct 2018 16:30:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Alexey Khoroshilov" <khoroshilov@ispras.ru>,
        "Shrikrishna Khare" <skhare@vmware.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.243191634@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 310/366] vmxnet3: fix checks for dma mapping errors
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

commit 5738a09d58d5ad2871f1f9a42bf6a3aa9ece5b3c upstream.

vmxnet3_drv does not check dma_addr with dma_mapping_error()
after mapping dma memory. The patch adds the checks and
tries to handle failures.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Acked-by: Shrikrishna Khare <skhare@vmware.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 71 ++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 11 deletions(-)

--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -587,6 +587,12 @@ vmxnet3_rq_alloc_rx_buf(struct vmxnet3_r
 						&adapter->pdev->dev,
 						rbi->skb->data, rbi->len,
 						PCI_DMA_FROMDEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      rbi->dma_addr)) {
+					dev_kfree_skb_any(rbi->skb);
+					rq->stats.rx_buf_alloc_failure++;
+					break;
+				}
 			} else {
 				/* rx buffer skipped by the device */
 			}
@@ -605,13 +611,18 @@ vmxnet3_rq_alloc_rx_buf(struct vmxnet3_r
 						&adapter->pdev->dev,
 						rbi->page, 0, PAGE_SIZE,
 						PCI_DMA_FROMDEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      rbi->dma_addr)) {
+					put_page(rbi->page);
+					rq->stats.rx_buf_alloc_failure++;
+					break;
+				}
 			} else {
 				/* rx buffers skipped by the device */
 			}
 			val = VMXNET3_RXD_BTYPE_BODY << VMXNET3_RXD_BTYPE_SHIFT;
 		}
 
-		BUG_ON(rbi->dma_addr == 0);
 		gd->rxd.addr = cpu_to_le64(rbi->dma_addr);
 		gd->dword[2] = cpu_to_le32((!ring->gen << VMXNET3_RXD_GEN_SHIFT)
 					   | val | rbi->len);
@@ -655,7 +666,7 @@ vmxnet3_append_frag(struct sk_buff *skb,
 }
 
 
-static void
+static int
 vmxnet3_map_pkt(struct sk_buff *skb, struct vmxnet3_tx_ctx *ctx,
 		struct vmxnet3_tx_queue *tq, struct pci_dev *pdev,
 		struct vmxnet3_adapter *adapter)
@@ -715,6 +726,8 @@ vmxnet3_map_pkt(struct sk_buff *skb, str
 		tbi->dma_addr = dma_map_single(&adapter->pdev->dev,
 				skb->data + buf_offset, buf_size,
 				PCI_DMA_TODEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr))
+			return -EFAULT;
 
 		tbi->len = buf_size;
 
@@ -755,6 +768,8 @@ vmxnet3_map_pkt(struct sk_buff *skb, str
 			tbi->dma_addr = skb_frag_dma_map(&adapter->pdev->dev, frag,
 							 buf_offset, buf_size,
 							 DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev, tbi->dma_addr))
+				return -EFAULT;
 
 			tbi->len = buf_size;
 
@@ -782,6 +797,8 @@ vmxnet3_map_pkt(struct sk_buff *skb, str
 	/* set the last buf_info for the pkt */
 	tbi->skb = skb;
 	tbi->sop_idx = ctx->sop_txd - tq->tx_ring.base;
+
+	return 0;
 }
 
 
@@ -1006,7 +1023,8 @@ vmxnet3_tq_xmit(struct sk_buff *skb, str
 	}
 
 	/* fill tx descs related to addr & len */
-	vmxnet3_map_pkt(skb, &ctx, tq, adapter->pdev, adapter);
+	if (vmxnet3_map_pkt(skb, &ctx, tq, adapter->pdev, adapter))
+		goto unlock_drop_pkt;
 
 	/* setup the EOP desc */
 	ctx.eop_txd->dword[3] = cpu_to_le32(VMXNET3_TXD_CQ | VMXNET3_TXD_EOP);
@@ -1170,6 +1188,7 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx
 		struct vmxnet3_rx_buf_info *rbi;
 		struct sk_buff *skb, *new_skb = NULL;
 		struct page *new_page = NULL;
+		dma_addr_t new_dma_addr;
 		int num_to_alloc;
 		struct Vmxnet3_RxDesc *rxd;
 		u32 idx, ring_idx;
@@ -1227,6 +1246,21 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx
 				skip_page_frags = true;
 				goto rcd_done;
 			}
+			new_dma_addr = dma_map_single(&adapter->pdev->dev,
+						      new_skb->data, rbi->len,
+						      PCI_DMA_FROMDEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev,
+					      new_dma_addr)) {
+				dev_kfree_skb(new_skb);
+				/* Skb allocation failed, do not handover this
+				 * skb to stack. Reuse it. Drop the existing pkt
+				 */
+				rq->stats.rx_buf_alloc_failure++;
+				ctx->skb = NULL;
+				rq->stats.drop_total++;
+				skip_page_frags = true;
+				goto rcd_done;
+			}
 
 			dma_unmap_single(&adapter->pdev->dev, rbi->dma_addr,
 					 rbi->len,
@@ -1243,9 +1277,7 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx
 
 			/* Immediate refill */
 			rbi->skb = new_skb;
-			rbi->dma_addr = dma_map_single(&adapter->pdev->dev,
-						       rbi->skb->data, rbi->len,
-						       PCI_DMA_FROMDEVICE);
+			rbi->dma_addr = new_dma_addr;
 			rxd->addr = cpu_to_le64(rbi->dma_addr);
 			rxd->len = rbi->len;
 
@@ -1275,6 +1307,19 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx
 				skip_page_frags = true;
 				goto rcd_done;
 			}
+			new_dma_addr = dma_map_page(&adapter->pdev->dev,
+						rbi->page,
+						0, PAGE_SIZE,
+						PCI_DMA_FROMDEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev,
+					      new_dma_addr)) {
+				put_page(new_page);
+				rq->stats.rx_buf_alloc_failure++;
+				dev_kfree_skb(ctx->skb);
+				ctx->skb = NULL;
+				skip_page_frags = true;
+				goto rcd_done;
+			}
 
 			if (rcd->len) {
 				dma_unmap_page(&adapter->pdev->dev,
@@ -1286,10 +1331,7 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx
 
 			/* Immediate refill */
 			rbi->page = new_page;
-			rbi->dma_addr = dma_map_page(&adapter->pdev->dev,
-						     rbi->page,
-						     0, PAGE_SIZE,
-						     PCI_DMA_FROMDEVICE);
+			rbi->dma_addr = new_dma_addr;
 			rxd->addr = cpu_to_le64(rbi->dma_addr);
 			rxd->len = rbi->len;
 		}
@@ -2065,7 +2107,8 @@ vmxnet3_set_mc(struct net_device *netdev
 							PCI_DMA_TODEVICE);
 			}
 
-			if (new_table_pa) {
+			if (!dma_mapping_error(&adapter->pdev->dev,
+					       new_table_pa)) {
 				new_mode |= VMXNET3_RXM_MCAST;
 				rxConf->mfTablePA = cpu_to_le64(new_table_pa);
 			} else {
@@ -2976,6 +3019,11 @@ vmxnet3_probe_device(struct pci_dev *pde
 	adapter->adapter_pa = dma_map_single(&adapter->pdev->dev, adapter,
 					     sizeof(struct vmxnet3_adapter),
 					     PCI_DMA_TODEVICE);
+	if (dma_mapping_error(&adapter->pdev->dev, adapter->adapter_pa)) {
+		dev_err(&pdev->dev, "Failed to map dma\n");
+		err = -EFAULT;
+		goto err_dma_map;
+	}
 	adapter->shared = dma_alloc_coherent(
 				&adapter->pdev->dev,
 				sizeof(struct Vmxnet3_DriverShared),
@@ -3129,6 +3177,7 @@ err_alloc_queue_desc:
 err_alloc_shared:
 	dma_unmap_single(&adapter->pdev->dev, adapter->adapter_pa,
 			 sizeof(struct vmxnet3_adapter), PCI_DMA_TODEVICE);
+err_dma_map:
 	free_netdev(netdev);
 	return err;
 }

