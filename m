Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A24C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A580F20895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A580F20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389222AbeG0LXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:23:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34412 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbeG0LXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:23:48 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6EF7BCB1;
        Fri, 27 Jul 2018 10:02:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stephane Grosjean <s.grosjean@peak-system.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.14 46/48] can: peak_canfd: fix firmware < v3.3.0: limit allocation to 32-bit DMA addr only
Date:   Fri, 27 Jul 2018 12:00:31 +0200
Message-Id: <20180727095923.253794276@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727095918.503549522@linuxfoundation.org>
References: <20180727095918.503549522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephane Grosjean <s.grosjean@peak-system.com>

commit 5d4c94ed9f564224d7b37dbee13f7c5d4a8a01ac upstream.

The DMA logic in firmwares < v3.3.0 embedded in the PCAN-PCIe FD cards
family is not capable of handling a mix of 32-bit and 64-bit logical
addresses. If the board is equipped with 2 or 4 CAN ports, then such a
situation might lead to a PCIe Bus Error "Malformed TLP" packet
as well as "irq xx: nobody cared" issue.

This patch adds a workaround that requests only 32-bit DMA addresses
when these might be allocated outside of the 4 GB area.

This issue has been fixed in firmware v3.3.0 and next.

Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-stable <stable@vger.kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/can/peak_canfd/peak_pciefd_main.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/drivers/net/can/peak_canfd/peak_pciefd_main.c
+++ b/drivers/net/can/peak_canfd/peak_pciefd_main.c
@@ -58,6 +58,10 @@ MODULE_LICENSE("GPL v2");
 #define PCIEFD_REG_SYS_VER1		0x0040	/* version reg #1 */
 #define PCIEFD_REG_SYS_VER2		0x0044	/* version reg #2 */
 
+#define PCIEFD_FW_VERSION(x, y, z)	(((u32)(x) << 24) | \
+					 ((u32)(y) << 16) | \
+					 ((u32)(z) << 8))
+
 /* System Control Registers Bits */
 #define PCIEFD_SYS_CTL_TS_RST		0x00000001	/* timestamp clock */
 #define PCIEFD_SYS_CTL_CLK_EN		0x00000002	/* system clock */
@@ -783,6 +787,21 @@ static int peak_pciefd_probe(struct pci_
 		 "%ux CAN-FD PCAN-PCIe FPGA v%u.%u.%u:\n", can_count,
 		 hw_ver_major, hw_ver_minor, hw_ver_sub);
 
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+	/* FW < v3.3.0 DMA logic doesn't handle correctly the mix of 32-bit and
+	 * 64-bit logical addresses: this workaround forces usage of 32-bit
+	 * DMA addresses only when such a fw is detected.
+	 */
+	if (PCIEFD_FW_VERSION(hw_ver_major, hw_ver_minor, hw_ver_sub) <
+	    PCIEFD_FW_VERSION(3, 3, 0)) {
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (err)
+			dev_warn(&pdev->dev,
+				 "warning: can't set DMA mask %llxh (err %d)\n",
+				 DMA_BIT_MASK(32), err);
+	}
+#endif
+
 	/* stop system clock */
 	pciefd_sys_writereg(pciefd, PCIEFD_SYS_CTL_CLK_EN,
 			    PCIEFD_REG_SYS_CTL_CLR);


