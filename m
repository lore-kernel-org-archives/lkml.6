Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EEFECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8201F21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8201F21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbeIXS1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:27:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57054 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbeIXS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:27:51 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D6C93108B;
        Mon, 24 Sep 2018 12:25:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Poirier <bpoirier@suse.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 4.14 170/173] e1000e: Avoid missed interrupts following ICR read
Date:   Mon, 24 Sep 2018 13:53:24 +0200
Message-Id: <20180924113127.433703288@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
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

From: Benjamin Poirier <bpoirier@suse.com>

commit 116f4a640b3197401bc93b8adc6c35040308ceff upstream.

The 82574 specification update errata 12 states that interrupts may be
missed if ICR is read while INT_ASSERTED is not set. Avoid that problem by
setting all bits related to events that can trigger the Other interrupt in
IMS.

The Other interrupt is raised for such events regardless of whether or not
they are set in IMS. However, only when they are set is the INT_ASSERTED
bit also set in ICR.

By doing this, we ensure that INT_ASSERTED is always set when we read ICR
in e1000_msix_other() and steer clear of the errata. This also ensures that
ICR will automatically be cleared on read, therefore we no longer need to
clear bits explicitly.

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/e1000e/defines.h |   21 ++++++++++++++++++++-
 drivers/net/ethernet/intel/e1000e/netdev.c  |   11 ++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -400,6 +400,10 @@
 #define E1000_ICR_RXDMT0        0x00000010 /* Rx desc min. threshold (0) */
 #define E1000_ICR_RXO           0x00000040 /* Receiver Overrun */
 #define E1000_ICR_RXT0          0x00000080 /* Rx timer intr (ring 0) */
+#define E1000_ICR_MDAC          0x00000200 /* MDIO Access Complete */
+#define E1000_ICR_SRPD          0x00010000 /* Small Receive Packet Detected */
+#define E1000_ICR_ACK           0x00020000 /* Receive ACK Frame Detected */
+#define E1000_ICR_MNG           0x00040000 /* Manageability Event Detected */
 #define E1000_ICR_ECCER         0x00400000 /* Uncorrectable ECC Error */
 /* If this bit asserted, the driver should claim the interrupt */
 #define E1000_ICR_INT_ASSERTED	0x80000000
@@ -407,7 +411,7 @@
 #define E1000_ICR_RXQ1          0x00200000 /* Rx Queue 1 Interrupt */
 #define E1000_ICR_TXQ0          0x00400000 /* Tx Queue 0 Interrupt */
 #define E1000_ICR_TXQ1          0x00800000 /* Tx Queue 1 Interrupt */
-#define E1000_ICR_OTHER         0x01000000 /* Other Interrupts */
+#define E1000_ICR_OTHER         0x01000000 /* Other Interrupt */
 
 /* PBA ECC Register */
 #define E1000_PBA_ECC_COUNTER_MASK  0xFFF00000 /* ECC counter mask */
@@ -431,12 +435,27 @@
 	E1000_IMS_RXSEQ  |    \
 	E1000_IMS_LSC)
 
+/* These are all of the events related to the OTHER interrupt.
+ */
+#define IMS_OTHER_MASK ( \
+	E1000_IMS_LSC  | \
+	E1000_IMS_RXO  | \
+	E1000_IMS_MDAC | \
+	E1000_IMS_SRPD | \
+	E1000_IMS_ACK  | \
+	E1000_IMS_MNG)
+
 /* Interrupt Mask Set */
 #define E1000_IMS_TXDW      E1000_ICR_TXDW      /* Transmit desc written back */
 #define E1000_IMS_LSC       E1000_ICR_LSC       /* Link Status Change */
 #define E1000_IMS_RXSEQ     E1000_ICR_RXSEQ     /* Rx sequence error */
 #define E1000_IMS_RXDMT0    E1000_ICR_RXDMT0    /* Rx desc min. threshold */
+#define E1000_IMS_RXO       E1000_ICR_RXO       /* Receiver Overrun */
 #define E1000_IMS_RXT0      E1000_ICR_RXT0      /* Rx timer intr */
+#define E1000_IMS_MDAC      E1000_ICR_MDAC      /* MDIO Access Complete */
+#define E1000_IMS_SRPD      E1000_ICR_SRPD      /* Small Receive Packet */
+#define E1000_IMS_ACK       E1000_ICR_ACK       /* Receive ACK Frame Detected */
+#define E1000_IMS_MNG       E1000_ICR_MNG       /* Manageability Event */
 #define E1000_IMS_ECCER     E1000_ICR_ECCER     /* Uncorrectable ECC Error */
 #define E1000_IMS_RXQ0      E1000_ICR_RXQ0      /* Rx Queue 0 Interrupt */
 #define E1000_IMS_RXQ1      E1000_ICR_RXQ1      /* Rx Queue 1 Interrupt */
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1910,16 +1910,12 @@ static irqreturn_t e1000_msix_other(int
 	struct net_device *netdev = data;
 	struct e1000_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	u32 icr;
-
-	icr = er32(ICR);
-	ew32(ICR, E1000_ICR_OTHER);
+	u32 icr = er32(ICR);
 
 	if (icr & adapter->eiac_mask)
 		ew32(ICS, (icr & adapter->eiac_mask));
 
 	if (icr & E1000_ICR_LSC) {
-		ew32(ICR, E1000_ICR_LSC);
 		hw->mac.get_link_status = true;
 		/* guard against interrupt when we're going down */
 		if (!test_bit(__E1000_DOWN, &adapter->state))
@@ -1927,7 +1923,7 @@ static irqreturn_t e1000_msix_other(int
 	}
 
 	if (!test_bit(__E1000_DOWN, &adapter->state))
-		ew32(IMS, E1000_IMS_OTHER);
+		ew32(IMS, E1000_IMS_OTHER | IMS_OTHER_MASK);
 
 	return IRQ_HANDLED;
 }
@@ -2254,7 +2250,8 @@ static void e1000_irq_enable(struct e100
 
 	if (adapter->msix_entries) {
 		ew32(EIAC_82574, adapter->eiac_mask & E1000_EIAC_MASK_82574);
-		ew32(IMS, adapter->eiac_mask | E1000_IMS_OTHER | E1000_IMS_LSC);
+		ew32(IMS, adapter->eiac_mask | E1000_IMS_OTHER |
+		     IMS_OTHER_MASK);
 	} else if (hw->mac.type >= e1000_pch_lpt) {
 		ew32(IMS, IMS_ENABLE_MASK | E1000_IMS_ECCER);
 	} else {


