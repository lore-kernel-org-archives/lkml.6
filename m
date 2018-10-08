Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24786C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF99621479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tB+O/ifm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF99621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbeJIB4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbeJIB4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:56:50 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 318EB2064A;
        Mon,  8 Oct 2018 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024224;
        bh=OkVQCibIN/0mnf8j7EFGHBPX9fEnXRpms5AplHfW4g0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tB+O/ifmc9qtkhyd2Z+ldemIW3+KTJ6+OdM1hqdkFPhObY63O+ajde2397VPUJg/8
         ZW4UCijrJHDfFpnP8JFI5zWO2RWpczrb8VnvOctNYwGHiniCGmWUwWsC6puRHv799+
         13urs3yf7SNWEc9f3fn5njmXYF56o9/bNtKGEkNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Netanel Belgazal <netanel@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 63/94] net: ena: fix driver when PAGE_SIZE == 64kB
Date:   Mon,  8 Oct 2018 20:31:44 +0200
Message-Id: <20181008175609.427044733@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit ef5b0771d247379c90c8bf1332ff32f7f74bff7f ]

The buffer length field in the ena rx descriptor is 16 bit, and the
current driver passes a full page in each ena rx descriptor.
When PAGE_SIZE equals 64kB or more, the buffer length field becomes
zero.
To solve this issue, limit the ena Rx descriptor to use 16kB even
when allocating 64kB kernel pages. This change would not impact ena
device functionality, as 16kB is still larger than maximum MTU.

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |   10 +++++-----
 drivers/net/ethernet/amazon/ena/ena_netdev.h |   11 +++++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -456,7 +456,7 @@ static inline int ena_alloc_rx_page(stru
 		return -ENOMEM;
 	}
 
-	dma = dma_map_page(rx_ring->dev, page, 0, PAGE_SIZE,
+	dma = dma_map_page(rx_ring->dev, page, 0, ENA_PAGE_SIZE,
 			   DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(rx_ring->dev, dma))) {
 		u64_stats_update_begin(&rx_ring->syncp);
@@ -473,7 +473,7 @@ static inline int ena_alloc_rx_page(stru
 	rx_info->page_offset = 0;
 	ena_buf = &rx_info->ena_buf;
 	ena_buf->paddr = dma;
-	ena_buf->len = PAGE_SIZE;
+	ena_buf->len = ENA_PAGE_SIZE;
 
 	return 0;
 }
@@ -490,7 +490,7 @@ static void ena_free_rx_page(struct ena_
 		return;
 	}
 
-	dma_unmap_page(rx_ring->dev, ena_buf->paddr, PAGE_SIZE,
+	dma_unmap_page(rx_ring->dev, ena_buf->paddr, ENA_PAGE_SIZE,
 		       DMA_FROM_DEVICE);
 
 	__free_page(page);
@@ -910,10 +910,10 @@ static struct sk_buff *ena_rx_skb(struct
 	do {
 		dma_unmap_page(rx_ring->dev,
 			       dma_unmap_addr(&rx_info->ena_buf, paddr),
-			       PAGE_SIZE, DMA_FROM_DEVICE);
+			       ENA_PAGE_SIZE, DMA_FROM_DEVICE);
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_info->page,
-				rx_info->page_offset, len, PAGE_SIZE);
+				rx_info->page_offset, len, ENA_PAGE_SIZE);
 
 		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
 			  "rx skb updated. len %d. data_len %d\n",
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -350,4 +350,15 @@ void ena_dump_stats_to_buf(struct ena_ad
 
 int ena_get_sset_count(struct net_device *netdev, int sset);
 
+/* The ENA buffer length fields is 16 bit long. So when PAGE_SIZE == 64kB the
+ * driver passas 0.
+ * Since the max packet size the ENA handles is ~9kB limit the buffer length to
+ * 16kB.
+ */
+#if PAGE_SIZE > SZ_16K
+#define ENA_PAGE_SIZE SZ_16K
+#else
+#define ENA_PAGE_SIZE PAGE_SIZE
+#endif
+
 #endif /* !(ENA_H) */


