Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs2FX5YlW8ndAvAbNG4QqgBRk+nsgYxoQrxu667yyX+OLne2jLvRPmaD9Y/gb5ooJK/vJ/W
ARC-Seal: i=1; a=rsa-sha256; t=1521483650; cv=none;
        d=google.com; s=arc-20160816;
        b=aJrM2j/i5rYRTm34MDeJZBGyohvucKJbmjiMEoursCym3BXJuS5xnWpIBLQlz1DXcz
         W/tyqzVyoGLGrbNq8qMcUIjCIuyKV/cEK/8VAvcUH3qwqLJxEMGrsGwyR76RNnzOwvvr
         qjpBJxPVHmMjRZ/OrV7Fi/mDSB7Z/EK194H6aDbthywnmBcxdiAlwNRkatCicxcYpoD6
         ueMzxYuN56OqA3ywAi4yN2xZ7BgXWGIDTv2wl2nhczaQQVi4ii/dciYEM0I5lk00hsUp
         tIUzIYVgq19RujVqdafQ9fI9kwsRtAv3q9j9toMQ8AiWzXr2B9lJe72b5UV3U8BL7sLh
         N9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lOPZdfGUW0GadWgOFHk+PmqF2hKdr0WFfWkHAKY6lFk=;
        b=V2qzW2J6iDapVlVdrVucSrylsNw9ymVbqQpeSNjTb2xZGmaKwguExTCnnSbFX31vQp
         27ihRuPLPIlIbJT/UpxSVCsTjconWkuFy+OMTvG/TGBjsdxDFrSnN9BnkwArk2PWzhcG
         6i65nmE+DsTQQbfZFzZzEhY6fJ2LxPzDINCpLmdYiWdhgdKd1T/DPjnRBrWDgD+IUxU+
         IRSdy6S2c+bFPmEoY98EKrYURmX8lO5Hfy/EIDjdCa2zFVIatTzUyJpF0mJC9Nwy9PB8
         UBJ8pdAwm3db/8b9LiyW7Ia+ZYyKJ9oL+h1MthM4nCdRQ0UeV08skh66Vbqj7TRwgSad
         Slow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Iyappan Subramanian <isubramanian@apm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 031/241] drivers: net: xgene: Fix Rx checksum validation logic
Date: Mon, 19 Mar 2018 19:04:56 +0100
Message-Id: <20180319180752.460359004@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391240841331983?=
X-GMAIL-MSGID: =?utf-8?q?1595391240841331983?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Iyappan Subramanian <isubramanian@apm.com>


[ Upstream commit 0a0400c3094b5d5cedd479ddbf1329de74c09c4b ]

This patch fixes Rx checksum validation logic and
adds NETIF_F_RXCSUM flag.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c |   27 ++++++++++++++---------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -505,14 +505,24 @@ static netdev_tx_t xgene_enet_start_xmit
 	return NETDEV_TX_OK;
 }
 
-static void xgene_enet_skip_csum(struct sk_buff *skb)
+static void xgene_enet_rx_csum(struct sk_buff *skb)
 {
+	struct net_device *ndev = skb->dev;
 	struct iphdr *iph = ip_hdr(skb);
 
-	if (!ip_is_fragment(iph) ||
-	    (iph->protocol != IPPROTO_TCP && iph->protocol != IPPROTO_UDP)) {
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-	}
+	if (!(ndev->features & NETIF_F_RXCSUM))
+		return;
+
+	if (skb->protocol != htons(ETH_P_IP))
+		return;
+
+	if (ip_is_fragment(iph))
+		return;
+
+	if (iph->protocol != IPPROTO_TCP && iph->protocol != IPPROTO_UDP)
+		return;
+
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
 static int xgene_enet_rx_frame(struct xgene_enet_desc_ring *rx_ring,
@@ -555,10 +565,7 @@ static int xgene_enet_rx_frame(struct xg
 
 	skb_checksum_none_assert(skb);
 	skb->protocol = eth_type_trans(skb, ndev);
-	if (likely((ndev->features & NETIF_F_IP_CSUM) &&
-		   skb->protocol == htons(ETH_P_IP))) {
-		xgene_enet_skip_csum(skb);
-	}
+	xgene_enet_rx_csum(skb);
 
 	rx_ring->rx_packets++;
 	rx_ring->rx_bytes += datalen;
@@ -1725,7 +1732,7 @@ static int xgene_enet_probe(struct platf
 	xgene_enet_setup_ops(pdata);
 
 	if (pdata->phy_mode == PHY_INTERFACE_MODE_XGMII) {
-		ndev->features |= NETIF_F_TSO;
+		ndev->features |= NETIF_F_TSO | NETIF_F_RXCSUM;
 		spin_lock_init(&pdata->mss_lock);
 	}
 	ndev->hw_features = ndev->features;
