Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76F5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD2B208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD2B208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936343AbeFRJzI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:55:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55088 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964849AbeFRIU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:20:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C8192C87;
        Mon, 18 Jun 2018 08:20:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 116/279] i2c: sprd: Fix the i2c count issue
Date:   Mon, 18 Jun 2018 10:11:41 +0200
Message-Id: <20180618080613.615384453@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Baolin Wang <baolin.wang@linaro.org>

[ Upstream commit 2a010461207cc96bee5ab81748325dec1972976f ]

We found the I2C controller count register is unreliable sometimes,
that will cause I2C to lose data. Thus we can read the data count
from 'i2c_dev->count' instead of the I2C controller count register.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-sprd.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -368,13 +368,12 @@ static irqreturn_t sprd_i2c_isr_thread(i
 	struct sprd_i2c *i2c_dev = dev_id;
 	struct i2c_msg *msg = i2c_dev->msg;
 	bool ack = !(readl(i2c_dev->base + I2C_STATUS) & I2C_RX_ACK);
-	u32 i2c_count = readl(i2c_dev->base + I2C_COUNT);
 	u32 i2c_tran;
 
 	if (msg->flags & I2C_M_RD)
 		i2c_tran = i2c_dev->count >= I2C_FIFO_FULL_THLD;
 	else
-		i2c_tran = i2c_count;
+		i2c_tran = i2c_dev->count;
 
 	/*
 	 * If we got one ACK from slave when writing data, and we did not
@@ -412,14 +411,13 @@ static irqreturn_t sprd_i2c_isr(int irq,
 {
 	struct sprd_i2c *i2c_dev = dev_id;
 	struct i2c_msg *msg = i2c_dev->msg;
-	u32 i2c_count = readl(i2c_dev->base + I2C_COUNT);
 	bool ack = !(readl(i2c_dev->base + I2C_STATUS) & I2C_RX_ACK);
 	u32 i2c_tran;
 
 	if (msg->flags & I2C_M_RD)
 		i2c_tran = i2c_dev->count >= I2C_FIFO_FULL_THLD;
 	else
-		i2c_tran = i2c_count;
+		i2c_tran = i2c_dev->count;
 
 	/*
 	 * If we did not get one ACK from slave when writing data, then we


