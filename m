Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt+MnhHNywh0T5lJDb2P0f6vzotSjqfc4MXWasjCRkWh3ZBRMTyaBxfLhmpV+ktcN74s4FI
ARC-Seal: i=1; a=rsa-sha256; t=1519981233; cv=none;
        d=google.com; s=arc-20160816;
        b=ele3sJRhRyBLxAfTiV1GwFkNZ3rWsPW4OdghzIYO6DVIfLkwPPh9UWiS8L9GWCcAEc
         1ZOJW3Bm3vJeV2+wlybTy51n8i/s3pqd4v0z5iOC2Ao7Ka3fB/y5gMGgYrvCRn+Ca1dv
         vttIbP5rSOOXTmaeMypIOlJ4bQ4/N8G1jhD+Rqj2DBPWPUQIuuvrlWftmTWRL8nlXLFJ
         kP1g+XeO+BWP/GX0sBV3oKM/trH2XVGpu+DqQ/JpvEP8KJwizMloRAqDU+h/GEvfYR12
         MXLxGrypqdC2ZFrBnMGz6aonjYG2TiTRMTzW6mxNtYlo/2igtmK9goIoS70lNumZTUhT
         HgNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qcR94ol8y0iW8ax68o/2pQa278ywTqdGMI0ydaoNNLI=;
        b=Vakpq0Vry3/OTQq6OOOi1K5a6OcVTGuaIleQFHZoUtQELzHw5GeYa8OX1VPKQCU2jR
         TpbWvfUSNDgEOJU+tTxGQGL2Ed+TaLBUSPNfNtuiPkUGqv5CNCmuFGZ7N/9IWz4JLrHn
         Il0T9nxCHW4umHCuxOsSLQ1A1UiSzKdis6caoDPoqeynNmwQopw16axjVsqz9IykYXdO
         0+3X7P2nJnxuMVa7syvZeuo7mqMQj0EiaiT9j7vupBnnc+/lOiMVjKB5EQNvy6jSvt0+
         7WOb+GO8qcagkJpn16bk6/q1BytyUPlsWL8vg+fPyD2gZsuSGQ1rp3YSCKLAH4p2Typk
         73Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexander Kochetkov <al.kochet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 031/115] net: arc_emac: fix arc_emac_rx() error paths
Date: Fri,  2 Mar 2018 09:50:34 +0100
Message-Id: <20180302084505.140477393@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815426038908739?=
X-GMAIL-MSGID: =?utf-8?q?1593815841565707288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Kochetkov <al.kochet@gmail.com>


[ Upstream commit e688822d035b494071ecbadcccbd6f3325fb0f59 ]

arc_emac_rx() has some issues found by code review.

In case netdev_alloc_skb_ip_align() or dma_map_single() failure
rx fifo entry will not be returned to EMAC.

In case dma_map_single() failure previously allocated skb became
lost to driver. At the same time address of newly allocated skb
will not be provided to EMAC.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/arc/emac_main.c |   53 ++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 22 deletions(-)

--- a/drivers/net/ethernet/arc/emac_main.c
+++ b/drivers/net/ethernet/arc/emac_main.c
@@ -210,39 +210,48 @@ static int arc_emac_rx(struct net_device
 			continue;
 		}
 
-		pktlen = info & LEN_MASK;
-		stats->rx_packets++;
-		stats->rx_bytes += pktlen;
-		skb = rx_buff->skb;
-		skb_put(skb, pktlen);
-		skb->dev = ndev;
-		skb->protocol = eth_type_trans(skb, ndev);
-
-		dma_unmap_single(&ndev->dev, dma_unmap_addr(rx_buff, addr),
-				 dma_unmap_len(rx_buff, len), DMA_FROM_DEVICE);
-
-		/* Prepare the BD for next cycle */
-		rx_buff->skb = netdev_alloc_skb_ip_align(ndev,
-							 EMAC_BUFFER_SIZE);
-		if (unlikely(!rx_buff->skb)) {
+		/* Prepare the BD for next cycle. netif_receive_skb()
+		 * only if new skb was allocated and mapped to avoid holes
+		 * in the RX fifo.
+		 */
+		skb = netdev_alloc_skb_ip_align(ndev, EMAC_BUFFER_SIZE);
+		if (unlikely(!skb)) {
+			if (net_ratelimit())
+				netdev_err(ndev, "cannot allocate skb\n");
+			/* Return ownership to EMAC */
+			rxbd->info = cpu_to_le32(FOR_EMAC | EMAC_BUFFER_SIZE);
 			stats->rx_errors++;
-			/* Because receive_skb is below, increment rx_dropped */
 			stats->rx_dropped++;
 			continue;
 		}
 
-		/* receive_skb only if new skb was allocated to avoid holes */
-		netif_receive_skb(skb);
-
-		addr = dma_map_single(&ndev->dev, (void *)rx_buff->skb->data,
+		addr = dma_map_single(&ndev->dev, (void *)skb->data,
 				      EMAC_BUFFER_SIZE, DMA_FROM_DEVICE);
 		if (dma_mapping_error(&ndev->dev, addr)) {
 			if (net_ratelimit())
-				netdev_err(ndev, "cannot dma map\n");
-			dev_kfree_skb(rx_buff->skb);
+				netdev_err(ndev, "cannot map dma buffer\n");
+			dev_kfree_skb(skb);
+			/* Return ownership to EMAC */
+			rxbd->info = cpu_to_le32(FOR_EMAC | EMAC_BUFFER_SIZE);
 			stats->rx_errors++;
+			stats->rx_dropped++;
 			continue;
 		}
+
+		/* unmap previosly mapped skb */
+		dma_unmap_single(&ndev->dev, dma_unmap_addr(rx_buff, addr),
+				 dma_unmap_len(rx_buff, len), DMA_FROM_DEVICE);
+
+		pktlen = info & LEN_MASK;
+		stats->rx_packets++;
+		stats->rx_bytes += pktlen;
+		skb_put(rx_buff->skb, pktlen);
+		rx_buff->skb->dev = ndev;
+		rx_buff->skb->protocol = eth_type_trans(rx_buff->skb, ndev);
+
+		netif_receive_skb(rx_buff->skb);
+
+		rx_buff->skb = skb;
 		dma_unmap_addr_set(rx_buff, addr, addr);
 		dma_unmap_len_set(rx_buff, len, EMAC_BUFFER_SIZE);
 
