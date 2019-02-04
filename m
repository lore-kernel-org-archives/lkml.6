Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBF1C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88ED217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277508;
	bh=HsHNp14502tTPkKrkxxZVCswIaf/9v/jkzPF4ASLymY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XwHl0p9X4vScwx+tsoN0CtJCe3Fz68Os+k40KrOdmPAeF0hxu9RCn/+KftsPKwayO
	 vEIAVfbJvwOFHBorJSZeDXV9gjKD634W6plOv4TN90FfP8vDNmQhX3qns6nvHGjZk5
	 NX8q3eYA1NPCVxpFB6M/VEbS8W56xBm7LjSNA5rQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfBDKvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:51:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732417AbfBDKvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6242070C;
        Mon,  4 Feb 2019 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277501;
        bh=HsHNp14502tTPkKrkxxZVCswIaf/9v/jkzPF4ASLymY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0pid5Rj6zna2A9TSIHXOufUbOFTbZesgFE5O+LEYg9+LTgPfxx2NeF6mCOmAGI3P
         gzxFi4raygXmxuW4P+7fn+HQ6cr4Iwox7oFyf5DFlT6nXOyM7cSu/Gj6r9Cq+wH/Rj
         HPcpSfRcRT5ySQn6ADmeSxbwKod0mFknRvwTBMqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 13/80] ravb: expand rx descriptor data to accommodate hw checksum
Date:   Mon,  4 Feb 2019 11:36:33 +0100
Message-Id: <20190204103622.206658376@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Horman <horms+renesas@verge.net.au>

[ Upstream commit 12da64300fbc76b875900445f4146c3dc617d43e ]

EtherAVB may provide a checksum of packet data appended to packet data. In
order to allow this checksum to be received by the host descriptor data
needs to be enlarged by 2 bytes to accommodate the checksum.

In the case of MTU-sized packets without a VLAN tag the
checksum were already accommodated by virtue of the space reserved for the
VLAN tag. However, a packet of MTU-size with a  VLAN tag consumed all
packet data space provided by a descriptor leaving no space for the
trailing checksum.

This was not detected by the driver which incorrectly used the last two
bytes of packet data as the checksum and truncate the packet by two bytes.
This resulted all such packets being dropped.

A work around is to disable RX checksum offload
 # ethtool -K eth0 rx off

This patch resolves this problem by increasing the size available for
packet data in RX descriptors by two bytes.

Tested on R-Car E3 (r8a77990) ES1.0 based Ebisu-4D board

v2
* Use sizeof(__sum16) directly rather than adding a driver-local
  #define for the size of the checksum provided by the hw (2 bytes).

Fixes: 4d86d3818627 ("ravb: RX checksum offload")
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/ravb_main.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -350,7 +350,7 @@ static int ravb_ring_init(struct net_dev
 	int i;
 
 	priv->rx_buf_sz = (ndev->mtu <= 1492 ? PKT_BUF_SZ : ndev->mtu) +
-		ETH_HLEN + VLAN_HLEN;
+		ETH_HLEN + VLAN_HLEN + sizeof(__sum16);
 
 	/* Allocate RX and TX skb rings */
 	priv->rx_skb[q] = kcalloc(priv->num_rx_ring[q],
@@ -533,13 +533,15 @@ static void ravb_rx_csum(struct sk_buff
 {
 	u8 *hw_csum;
 
-	/* The hardware checksum is 2 bytes appended to packet data */
-	if (unlikely(skb->len < 2))
+	/* The hardware checksum is contained in sizeof(__sum16) (2) bytes
+	 * appended to packet data
+	 */
+	if (unlikely(skb->len < sizeof(__sum16)))
 		return;
-	hw_csum = skb_tail_pointer(skb) - 2;
+	hw_csum = skb_tail_pointer(skb) - sizeof(__sum16);
 	skb->csum = csum_unfold((__force __sum16)get_unaligned_le16(hw_csum));
 	skb->ip_summed = CHECKSUM_COMPLETE;
-	skb_trim(skb, skb->len - 2);
+	skb_trim(skb, skb->len - sizeof(__sum16));
 }
 
 /* Packet receive function for Ethernet AVB */


