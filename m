Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrPTsyQEKJzGTi678FtcA7A05lpTb2Sa2wvZO4oeaL/B24V3g7N+7uOGy1OdVWmYHuhKU/b
ARC-Seal: i=1; a=rsa-sha256; t=1524838198; cv=none;
        d=google.com; s=arc-20160816;
        b=xLC9mS8DOJ+ELAORhw9NQIO2jdIbJPju8mORlIWNZVgT+7XBCVOIN/sqa0qHviSkK0
         eDJOeOgsq7E0i/ntBC8fTaMeMi4Mv34YTa/yV7EDoX2/PW4agju7mwuHdoOzQ0Yigu9L
         PF4V7v/CfhehRC4trUjlC1pQ6qzMmasgOn7ZS6O+gBF0zoxdCYq3ZMIOPh5+CiUxe3x4
         +b4RpKoAwuV8B6ccHfcEAg52oRFQ04xr7JB0ZRf2WwApZwnT8kvEFaADjpJpPZ5Dcsmd
         iio0XLNV4CpcDTmFA9tXyyg/PqdeQxawAGFt1O5ynA8m0617Dm7ABAAtK/Ez7e1ou5+D
         wV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=ZJIjHa946tM+bV78HWgHOvY8t3FqebUSc9/Ecvrjg78=;
        b=PvZeRH9pl7tIjHa5R/8cpjV+1Z309DjHwqkp88GhhSCYBH3g4nFwfzxjrBGIpbXDcE
         ffV07UzI87FpaoX6p6ThrmaRytn+CLZeKK5MHtUWjb4SNTrAxTTEbu/hX82sBykOuEEx
         +psg+9pZ7HncHJn8LCq6+/f03JuixhPyFDrY+aCnGozUvttqsEA2EJEGyDHR8joM99Pa
         0VMlW5IHgzVFjlhu0fXUUgTZAhPkuO+fIYL93wSSNUA3Awdsdbmcc0T1hXQt0i06pcWD
         pe2yX+hVaUMrRPk5BSokv7vTBB0aLTKEjePfT/nqld8s+U5dkV6ZqCLNrRhrrL8HHas/
         n1KQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F2BD21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 17/81] net: mvpp2: Fix DMA address mask size
Date: Fri, 27 Apr 2018 15:58:19 +0200
Message-Id: <20180427135744.287610465@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908738558602138?=
X-GMAIL-MSGID: =?utf-8?q?1598908738558602138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>


[ Upstream commit da42bb271305d68df6cbf99eed90542f1f1ee1c9 ]

PPv2 TX/RX descriptors uses 40bits DMA addresses, but 41 bits masks were
used (GENMASK_ULL(40, 0)).

This commit fixes that by using the correct mask.

Fixes: e7c5359f2eed ("net: mvpp2: introduce PPv2.2 HW descriptors and adapt accessors")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -838,6 +838,8 @@ enum mvpp2_bm_type {
 
 #define MVPP2_MIB_COUNTERS_STATS_DELAY		(1 * HZ)
 
+#define MVPP2_DESC_DMA_MASK	DMA_BIT_MASK(40)
+
 /* Definitions */
 
 /* Shared Packet Processor resources */
@@ -1336,7 +1338,7 @@ static dma_addr_t mvpp2_txdesc_dma_addr_
 	if (port->priv->hw_version == MVPP21)
 		return tx_desc->pp21.buf_dma_addr;
 	else
-		return tx_desc->pp22.buf_dma_addr_ptp & GENMASK_ULL(40, 0);
+		return tx_desc->pp22.buf_dma_addr_ptp & MVPP2_DESC_DMA_MASK;
 }
 
 static void mvpp2_txdesc_dma_addr_set(struct mvpp2_port *port,
@@ -1354,7 +1356,7 @@ static void mvpp2_txdesc_dma_addr_set(st
 	} else {
 		u64 val = (u64)addr;
 
-		tx_desc->pp22.buf_dma_addr_ptp &= ~GENMASK_ULL(40, 0);
+		tx_desc->pp22.buf_dma_addr_ptp &= ~MVPP2_DESC_DMA_MASK;
 		tx_desc->pp22.buf_dma_addr_ptp |= val;
 		tx_desc->pp22.packet_offset = offset;
 	}
@@ -1414,7 +1416,7 @@ static dma_addr_t mvpp2_rxdesc_dma_addr_
 	if (port->priv->hw_version == MVPP21)
 		return rx_desc->pp21.buf_dma_addr;
 	else
-		return rx_desc->pp22.buf_dma_addr_key_hash & GENMASK_ULL(40, 0);
+		return rx_desc->pp22.buf_dma_addr_key_hash & MVPP2_DESC_DMA_MASK;
 }
 
 static unsigned long mvpp2_rxdesc_cookie_get(struct mvpp2_port *port,
@@ -1423,7 +1425,7 @@ static unsigned long mvpp2_rxdesc_cookie
 	if (port->priv->hw_version == MVPP21)
 		return rx_desc->pp21.buf_cookie;
 	else
-		return rx_desc->pp22.buf_cookie_misc & GENMASK_ULL(40, 0);
+		return rx_desc->pp22.buf_cookie_misc & MVPP2_DESC_DMA_MASK;
 }
 
 static size_t mvpp2_rxdesc_size_get(struct mvpp2_port *port,
@@ -8347,7 +8349,7 @@ static int mvpp2_probe(struct platform_d
 	}
 
 	if (priv->hw_version == MVPP22) {
-		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+		err = dma_set_mask(&pdev->dev, MVPP2_DESC_DMA_MASK);
 		if (err)
 			goto err_mg_clk;
 		/* Sadly, the BM pools all share the same register to
