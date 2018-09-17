Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B237EECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705172146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705172146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbeIREg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:36:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49598 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbeIREg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:36:26 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A7350C49;
        Mon, 17 Sep 2018 23:06:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.18 001/158] i2c: xiic: Make the start and the byte count write atomic
Date:   Tue, 18 Sep 2018 00:40:31 +0200
Message-Id: <20180917211710.463810485@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

commit ae7304c3ea28a3ba47a7a8312c76c654ef24967e upstream.

Disable interrupts while configuring the transfer and enable them back.

We have below as the programming sequence
1. start and slave address
2. byte count and stop

In some customer platform there was a lot of interrupts between 1 and 2
and after slave address (around 7 clock cyles) if 2 is not executed
then the transaction is nacked.

To fix this case make the 2 writes atomic.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
[wsa: added a newline for better readability]
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-xiic.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -532,6 +532,7 @@ static void xiic_start_recv(struct xiic_
 {
 	u8 rx_watermark;
 	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
+	unsigned long flags;
 
 	/* Clear and enable Rx full interrupt. */
 	xiic_irq_clr_en(i2c, XIIC_INTR_RX_FULL_MASK | XIIC_INTR_TX_ERROR_MASK);
@@ -547,6 +548,7 @@ static void xiic_start_recv(struct xiic_
 		rx_watermark = IIC_RX_FIFO_DEPTH;
 	xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rx_watermark - 1);
 
+	local_irq_save(flags);
 	if (!(msg->flags & I2C_M_NOSTART))
 		/* write the address */
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
@@ -556,6 +558,8 @@ static void xiic_start_recv(struct xiic_
 
 	xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
 		msg->len | ((i2c->nmsgs == 1) ? XIIC_TX_DYN_STOP_MASK : 0));
+	local_irq_restore(flags);
+
 	if (i2c->nmsgs == 1)
 		/* very last, enable bus not busy as well */
 		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);


