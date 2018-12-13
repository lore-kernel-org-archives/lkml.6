Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7115C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9345C20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676373;
	bh=3zYfcfXpLX17kKD7rxobdxCmZXEFnUE/PcM43G94814=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RSd2nJgV1w1y55TTzU9xXbNGbrp+AHFWaUPHqLn+zWQXu+fPMXCQrMn9oe6nDG+Uj
	 zCpArqC9CyLzx2czRqovz6uLE1l55DFrHARJ43qKgdD/I0DRxY7E2Zq3H3U8lR0O4n
	 Hc+fqpmqO3c9U8CwM2mJ7tWknCD4WeHWRWbJftMY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9345C20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbeLMEqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbeLMEao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A139D20882;
        Thu, 13 Dec 2018 04:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675443;
        bh=3zYfcfXpLX17kKD7rxobdxCmZXEFnUE/PcM43G94814=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olk/lEi1PMkYY+0RaP/KOuYEO2ODezlpTVv3a7ehWL66WhnY3LMo2otgHkG/kFjGt
         CJ44bviylzdOQf/FGYtDP3WJrQruKFR4ulNWJfJ8Y6eKufxSwjUWYC0odUGtVBnlPf
         4W3BLWye2pitM0McubHkUi3ivqb4xhIEw9KjC68k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>, Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 66/73] i2c: axxia: properly handle master timeout
Date:   Wed, 12 Dec 2018 23:28:31 -0500
Message-Id: <20181213042838.75160-66-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Adamski, Krzysztof (Nokia - PL/Wroclaw)" <krzysztof.adamski@nokia.com>

[ Upstream commit 6c7f25cae54b840302e4f1b371dbf318fbf09ab2 ]

According to Intel (R) Axxia TM Lionfish Communication Processor
Peripheral Subsystem Hardware Reference Manual, the AXXIA I2C module
have a programmable Master Wait Timer, which among others, checks the
time between commands send in manual mode. When a timeout (25ms) passes,
TSS bit is set in Master Interrupt Status register and a Stop command is
issued by the hardware.

The axxia_i2c_xfer(), does not properly handle this situation, however.
For each message a separate axxia_i2c_xfer_msg() is called and this
function incorrectly assumes that any interrupt might happen only when
waiting for completion. This is mostly correct but there is one
exception - a master timeout can trigger if enough time has passed
between individual transfers. It will, by definition, happen between
transfers when the interrupts are disabled by the code. If that happens,
the hardware issues Stop command.

The interrupt indicating timeout will not be triggered as soon as we
enable them since the Master Interrupt Status is cleared when master
mode is entered again (which happens before enabling irqs) meaning this
error is lost and the transfer is continued even though the Stop was
issued on the bus. The subsequent operations completes without error but
a bogus value (0xFF in case of read) is read as the client device is
confused because aborted transfer. No error is returned from
master_xfer() making caller believe that a valid value was read.

To fix the problem, the TSS bit (indicating timeout) in Master Interrupt
Status register is checked before each transfer. If it is set, there was
a timeout before this transfer and (as described above) the hardware
already issued Stop command so the transaction should be aborted thus
-ETIMEOUT is returned from the master_xfer() callback. In order to be
sure no timeout was issued we can't just read the status just before
starting new transaction as there will always be a small window of time
(few CPU cycles at best) where this might still happen. For this reason
we have to temporally disable the timer before checking for TSS bit.
Disabling it will, however, clear the TSS bit so in order to preserve
that information, we have to read it in ISR so we have to ensure that
the TSS interrupt is not masked between transfers of one transaction.
There is no need to call bus recovery or controller reinitialization if
that happens so it's skipped.

Signed-off-by: Krzysztof Adamski <krzysztof.adamski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-axxia.c | 40 ++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 8e60048a33f8..51d34959709b 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -74,8 +74,7 @@
 				 MST_STATUS_ND)
 #define   MST_STATUS_ERR	(MST_STATUS_NAK | \
 				 MST_STATUS_AL  | \
-				 MST_STATUS_IP  | \
-				 MST_STATUS_TSS)
+				 MST_STATUS_IP)
 #define MST_TX_BYTES_XFRD	0x50
 #define MST_RX_BYTES_XFRD	0x54
 #define SCL_HIGH_PERIOD		0x80
@@ -241,7 +240,7 @@ static int axxia_i2c_empty_rx_fifo(struct axxia_i2c_dev *idev)
 			 */
 			if (c <= 0 || c > I2C_SMBUS_BLOCK_MAX) {
 				idev->msg_err = -EPROTO;
-				i2c_int_disable(idev, ~0);
+				i2c_int_disable(idev, ~MST_STATUS_TSS);
 				complete(&idev->msg_complete);
 				break;
 			}
@@ -299,14 +298,19 @@ static irqreturn_t axxia_i2c_isr(int irq, void *_dev)
 
 	if (status & MST_STATUS_SCC) {
 		/* Stop completed */
-		i2c_int_disable(idev, ~0);
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
 		complete(&idev->msg_complete);
 	} else if (status & MST_STATUS_SNS) {
 		/* Transfer done */
-		i2c_int_disable(idev, ~0);
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
 		if (i2c_m_rd(idev->msg) && idev->msg_xfrd < idev->msg->len)
 			axxia_i2c_empty_rx_fifo(idev);
 		complete(&idev->msg_complete);
+	} else if (status & MST_STATUS_TSS) {
+		/* Transfer timeout */
+		idev->msg_err = -ETIMEDOUT;
+		i2c_int_disable(idev, ~MST_STATUS_TSS);
+		complete(&idev->msg_complete);
 	} else if (unlikely(status & MST_STATUS_ERR)) {
 		/* Transfer error */
 		i2c_int_disable(idev, ~0);
@@ -339,10 +343,10 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 	u32 rx_xfer, tx_xfer;
 	u32 addr_1, addr_2;
 	unsigned long time_left;
+	unsigned int wt_value;
 
 	idev->msg = msg;
 	idev->msg_xfrd = 0;
-	idev->msg_err = 0;
 	reinit_completion(&idev->msg_complete);
 
 	if (i2c_m_ten(msg)) {
@@ -383,9 +387,18 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 	else if (axxia_i2c_fill_tx_fifo(idev) != 0)
 		int_mask |= MST_STATUS_TFL;
 
+	wt_value = WT_VALUE(readl(idev->base + WAIT_TIMER_CONTROL));
+	/* Disable wait timer temporarly */
+	writel(wt_value, idev->base + WAIT_TIMER_CONTROL);
+	/* Check if timeout error happened */
+	if (idev->msg_err)
+		goto out;
+
 	/* Start manual mode */
 	writel(CMD_MANUAL, idev->base + MST_COMMAND);
 
+	writel(WT_EN | wt_value, idev->base + WAIT_TIMER_CONTROL);
+
 	i2c_int_enable(idev, int_mask);
 
 	time_left = wait_for_completion_timeout(&idev->msg_complete,
@@ -396,13 +409,15 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 	if (readl(idev->base + MST_COMMAND) & CMD_BUSY)
 		dev_warn(idev->dev, "busy after xfer\n");
 
-	if (time_left == 0)
+	if (time_left == 0) {
 		idev->msg_err = -ETIMEDOUT;
-
-	if (idev->msg_err == -ETIMEDOUT)
 		i2c_recover_bus(&idev->adapter);
+		axxia_i2c_init(idev);
+	}
 
-	if (unlikely(idev->msg_err) && idev->msg_err != -ENXIO)
+out:
+	if (unlikely(idev->msg_err) && idev->msg_err != -ENXIO &&
+			idev->msg_err != -ETIMEDOUT)
 		axxia_i2c_init(idev);
 
 	return idev->msg_err;
@@ -410,7 +425,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 
 static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
 {
-	u32 int_mask = MST_STATUS_ERR | MST_STATUS_SCC;
+	u32 int_mask = MST_STATUS_ERR | MST_STATUS_SCC | MST_STATUS_TSS;
 	unsigned long time_left;
 
 	reinit_completion(&idev->msg_complete);
@@ -437,6 +452,9 @@ axxia_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	int i;
 	int ret = 0;
 
+	idev->msg_err = 0;
+	i2c_int_enable(idev, MST_STATUS_TSS);
+
 	for (i = 0; ret == 0 && i < num; ++i)
 		ret = axxia_i2c_xfer_msg(idev, &msgs[i]);
 
-- 
2.19.1

