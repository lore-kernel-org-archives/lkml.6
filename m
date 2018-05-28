Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033251AbeE1KU4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033218AbeE1KUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:20:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 117/268] gianfar: Fix Rx byte accounting for ndev stats
Date: Mon, 28 May 2018 12:01:31 +0200
Message-Id: <20180528100215.377943044@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudiu Manoil <claudiu.manoil@nxp.com>

[ Upstream commit 590399ddf9561f2ed0839311c8ae1be21597ba68 ]

Don't include in the Rx bytecount of the packet sent up the stack:
the FCB (frame control block), and the padding bytes inserted by
the controller into the frame payload, nor the FCS. All these are
being pulled out of the skb by gfar_process_frame().
This issue is old, likely from the driver's beginnings, however
it was amplified by recent:
commit d903ec77118c ("gianfar: simplify FCS handling and fix memory leak")
which basically added the FCS to the Rx bytecount, and so brought
this to my attention.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/gianfar.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -3053,9 +3053,6 @@ static void gfar_process_frame(struct ne
 	if (ndev->features & NETIF_F_RXCSUM)
 		gfar_rx_checksum(skb, fcb);
 
-	/* Tell the skb what kind of packet this is */
-	skb->protocol = eth_type_trans(skb, ndev);
-
 	/* There's need to check for NETIF_F_HW_VLAN_CTAG_RX here.
 	 * Even if vlan rx accel is disabled, on some chips
 	 * RXFCB_VLN is pseudo randomly set.
@@ -3126,13 +3123,15 @@ int gfar_clean_rx_ring(struct gfar_priv_
 			continue;
 		}
 
+		gfar_process_frame(ndev, skb);
+
 		/* Increment the number of packets */
 		total_pkts++;
 		total_bytes += skb->len;
 
 		skb_record_rx_queue(skb, rx_queue->qindex);
 
-		gfar_process_frame(ndev, skb);
+		skb->protocol = eth_type_trans(skb, ndev);
 
 		/* Send the packet up the stack */
 		napi_gro_receive(&rx_queue->grp->napi_rx, skb);
