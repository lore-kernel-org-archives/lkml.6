Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1310DC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B217A2733C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B217A2733C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965544AbeF1Mmx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:42:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46868 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965476AbeF1Mmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:42:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5D11220DCD; Thu, 28 Jun 2018 14:42:48 +0200 (CEST)
Received: from mc-bl-xps13.lan (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 03981206FF;
        Thu, 28 Jun 2018 14:42:37 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net-next 1/4] net: mvpp2: Make TX / RX descriptors little-endian
Date:   Thu, 28 Jun 2018 14:42:04 +0200
Message-Id: <20180628124207.11635-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180628124207.11635-1-maxime.chevallier@bootlin.com>
References: <20180628124207.11635-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PPv2 controller always expect descriptors to be in little endian. We
must therefore force descriptors to use that format, and convert to the
host endianness when necessary.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 56 ++++++++++++-------------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 41 +++++++++---------
 2 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index def00dc3eb4e..fa314b272853 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -831,52 +831,52 @@ struct mvpp2_port {
 
 /* HW TX descriptor for PPv2.1 */
 struct mvpp21_tx_desc {
-	u32 command;		/* Options used by HW for packet transmitting.*/
+	__le32 command;		/* Options used by HW for packet transmitting.*/
 	u8  packet_offset;	/* the offset from the buffer beginning	*/
 	u8  phys_txq;		/* destination queue ID			*/
-	u16 data_size;		/* data size of transmitted packet in bytes */
-	u32 buf_dma_addr;	/* physical addr of transmitted buffer	*/
-	u32 buf_cookie;		/* cookie for access to TX buffer in tx path */
-	u32 reserved1[3];	/* hw_cmd (for future use, BM, PON, PNC) */
-	u32 reserved2;		/* reserved (for future use)		*/
+	__le16 data_size;	/* data size of transmitted packet in bytes */
+	__le32 buf_dma_addr;	/* physical addr of transmitted buffer	*/
+	__le32 buf_cookie;	/* cookie for access to TX buffer in tx path */
+	__le32 reserved1[3];	/* hw_cmd (for future use, BM, PON, PNC) */
+	__le32 reserved2;	/* reserved (for future use)		*/
 };
 
 /* HW RX descriptor for PPv2.1 */
 struct mvpp21_rx_desc {
-	u32 status;		/* info about received packet		*/
-	u16 reserved1;		/* parser_info (for future use, PnC)	*/
-	u16 data_size;		/* size of received packet in bytes	*/
-	u32 buf_dma_addr;	/* physical address of the buffer	*/
-	u32 buf_cookie;		/* cookie for access to RX buffer in rx path */
-	u16 reserved2;		/* gem_port_id (for future use, PON)	*/
-	u16 reserved3;		/* csum_l4 (for future use, PnC)	*/
+	__le32 status;		/* info about received packet		*/
+	__le16 reserved1;	/* parser_info (for future use, PnC)	*/
+	__le16 data_size;	/* size of received packet in bytes	*/
+	__le32 buf_dma_addr;	/* physical address of the buffer	*/
+	__le32 buf_cookie;	/* cookie for access to RX buffer in rx path */
+	__le16 reserved2;	/* gem_port_id (for future use, PON)	*/
+	__le16 reserved3;	/* csum_l4 (for future use, PnC)	*/
 	u8  reserved4;		/* bm_qset (for future use, BM)		*/
 	u8  reserved5;
-	u16 reserved6;		/* classify_info (for future use, PnC)	*/
-	u32 reserved7;		/* flow_id (for future use, PnC) */
-	u32 reserved8;
+	__le16 reserved6;	/* classify_info (for future use, PnC)	*/
+	__le32 reserved7;	/* flow_id (for future use, PnC) */
+	__le32 reserved8;
 };
 
 /* HW TX descriptor for PPv2.2 */
 struct mvpp22_tx_desc {
-	u32 command;
+	__le32 command;
 	u8  packet_offset;
 	u8  phys_txq;
-	u16 data_size;
-	u64 reserved1;
-	u64 buf_dma_addr_ptp;
-	u64 buf_cookie_misc;
+	__le16 data_size;
+	__le64 reserved1;
+	__le64 buf_dma_addr_ptp;
+	__le64 buf_cookie_misc;
 };
 
 /* HW RX descriptor for PPv2.2 */
 struct mvpp22_rx_desc {
-	u32 status;
-	u16 reserved1;
-	u16 data_size;
-	u32 reserved2;
-	u32 reserved3;
-	u64 buf_dma_addr_key_hash;
-	u64 buf_cookie_misc;
+	__le32 status;
+	__le16 reserved1;
+	__le16 data_size;
+	__le32 reserved2;
+	__le32 reserved3;
+	__le64 buf_dma_addr_key_hash;
+	__le64 buf_cookie_misc;
 };
 
 /* Opaque type used by the driver to manipulate the HW TX and RX
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 0319ed9ef8b8..ded187a20b6c 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -151,9 +151,10 @@ static dma_addr_t mvpp2_txdesc_dma_addr_get(struct mvpp2_port *port,
 					    struct mvpp2_tx_desc *tx_desc)
 {
 	if (port->priv->hw_version == MVPP21)
-		return tx_desc->pp21.buf_dma_addr;
+		return le32_to_cpu(tx_desc->pp21.buf_dma_addr);
 	else
-		return tx_desc->pp22.buf_dma_addr_ptp & MVPP2_DESC_DMA_MASK;
+		return le64_to_cpu(tx_desc->pp22.buf_dma_addr_ptp) &
+		       MVPP2_DESC_DMA_MASK;
 }
 
 static void mvpp2_txdesc_dma_addr_set(struct mvpp2_port *port,
@@ -166,12 +167,12 @@ static void mvpp2_txdesc_dma_addr_set(struct mvpp2_port *port,
 	offset = dma_addr & MVPP2_TX_DESC_ALIGN;
 
 	if (port->priv->hw_version == MVPP21) {
-		tx_desc->pp21.buf_dma_addr = addr;
+		tx_desc->pp21.buf_dma_addr = cpu_to_le32(addr);
 		tx_desc->pp21.packet_offset = offset;
 	} else {
-		u64 val = (u64)addr;
+		__le64 val = cpu_to_le64(addr);
 
-		tx_desc->pp22.buf_dma_addr_ptp &= ~MVPP2_DESC_DMA_MASK;
+		tx_desc->pp22.buf_dma_addr_ptp &= ~cpu_to_le64(MVPP2_DESC_DMA_MASK);
 		tx_desc->pp22.buf_dma_addr_ptp |= val;
 		tx_desc->pp22.packet_offset = offset;
 	}
@@ -181,9 +182,9 @@ static size_t mvpp2_txdesc_size_get(struct mvpp2_port *port,
 				    struct mvpp2_tx_desc *tx_desc)
 {
 	if (port->priv->hw_version == MVPP21)
-		return tx_desc->pp21.data_size;
+		return le16_to_cpu(tx_desc->pp21.data_size);
 	else
-		return tx_desc->pp22.data_size;
+		return le16_to_cpu(tx_desc->pp22.data_size);
 }
 
 static void mvpp2_txdesc_size_set(struct mvpp2_port *port,
@@ -191,9 +192,9 @@ static void mvpp2_txdesc_size_set(struct mvpp2_port *port,
 				  size_t size)
 {
 	if (port->priv->hw_version == MVPP21)
-		tx_desc->pp21.data_size = size;
+		tx_desc->pp21.data_size = cpu_to_le16(size);
 	else
-		tx_desc->pp22.data_size = size;
+		tx_desc->pp22.data_size = cpu_to_le16(size);
 }
 
 static void mvpp2_txdesc_txq_set(struct mvpp2_port *port,
@@ -211,9 +212,9 @@ static void mvpp2_txdesc_cmd_set(struct mvpp2_port *port,
 				 unsigned int command)
 {
 	if (port->priv->hw_version == MVPP21)
-		tx_desc->pp21.command = command;
+		tx_desc->pp21.command = cpu_to_le32(command);
 	else
-		tx_desc->pp22.command = command;
+		tx_desc->pp22.command = cpu_to_le32(command);
 }
 
 static unsigned int mvpp2_txdesc_offset_get(struct mvpp2_port *port,
@@ -229,36 +230,38 @@ static dma_addr_t mvpp2_rxdesc_dma_addr_get(struct mvpp2_port *port,
 					    struct mvpp2_rx_desc *rx_desc)
 {
 	if (port->priv->hw_version == MVPP21)
-		return rx_desc->pp21.buf_dma_addr;
+		return le32_to_cpu(rx_desc->pp21.buf_dma_addr);
 	else
-		return rx_desc->pp22.buf_dma_addr_key_hash & MVPP2_DESC_DMA_MASK;
+		return le64_to_cpu(rx_desc->pp22.buf_dma_addr_key_hash) &
+		       MVPP2_DESC_DMA_MASK;
 }
 
 static unsigned long mvpp2_rxdesc_cookie_get(struct mvpp2_port *port,
 					     struct mvpp2_rx_desc *rx_desc)
 {
 	if (port->priv->hw_version == MVPP21)
-		return rx_desc->pp21.buf_cookie;
+		return le32_to_cpu(rx_desc->pp21.buf_cookie);
 	else
-		return rx_desc->pp22.buf_cookie_misc & MVPP2_DESC_DMA_MASK;
+		return le64_to_cpu(rx_desc->pp22.buf_cookie_misc) &
+		       MVPP2_DESC_DMA_MASK;
 }
 
 static size_t mvpp2_rxdesc_size_get(struct mvpp2_port *port,
 				    struct mvpp2_rx_desc *rx_desc)
 {
 	if (port->priv->hw_version == MVPP21)
-		return rx_desc->pp21.data_size;
+		return le16_to_cpu(rx_desc->pp21.data_size);
 	else
-		return rx_desc->pp22.data_size;
+		return le16_to_cpu(rx_desc->pp22.data_size);
 }
 
 static u32 mvpp2_rxdesc_status_get(struct mvpp2_port *port,
 				   struct mvpp2_rx_desc *rx_desc)
 {
 	if (port->priv->hw_version == MVPP21)
-		return rx_desc->pp21.status;
+		return le32_to_cpu(rx_desc->pp21.status);
 	else
-		return rx_desc->pp22.status;
+		return le32_to_cpu(rx_desc->pp22.status);
 }
 
 static void mvpp2_txq_inc_get(struct mvpp2_txq_pcpu *txq_pcpu)
-- 
2.11.0

