Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258ABECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D057120854
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D057120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbeGTNQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:16:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36508 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbeGTNQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:16:26 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 38560BBF;
        Fri, 20 Jul 2018 12:28:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 11/66] spi/bcm63xx: make spi subsystem aware of message size limits
Date:   Fri, 20 Jul 2018 14:13:28 +0200
Message-Id: <20180720121407.910738439@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121407.228772286@linuxfoundation.org>
References: <20180720121407.228772286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

commit 0135c03df914f0481c61f097c78d37cece84f330 upstream.

The bcm63xx SPI controller does not allow manual control of the CS
lines and will toggle it automatically before and after sending data,
so we are limited to messages that fit in the FIFO buffer. Since the CS
lines aren't available as GPIOs either, we will need to make slave
drivers aware of this limitation so they can handle them accordingly.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm63xx.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -428,6 +428,13 @@ static irqreturn_t bcm63xx_spi_interrupt
 	return IRQ_HANDLED;
 }
 
+static size_t bcm63xx_spi_max_length(struct spi_device *dev)
+{
+	struct bcm63xx_spi *bs = spi_master_get_devdata(spi->master);
+
+	return bs->fifo_size;
+}
+
 static const unsigned long bcm6348_spi_reg_offsets[] = {
 	[SPI_CMD]		= SPI_6348_CMD,
 	[SPI_INT_STATUS]	= SPI_6348_INT_STATUS,
@@ -541,6 +548,8 @@ static int bcm63xx_spi_probe(struct plat
 	master->transfer_one_message = bcm63xx_spi_transfer_one;
 	master->mode_bits = MODEBITS;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->max_transfer_size = bcm63xx_spi_max_length;
+	master->max_message_size = bcm63xx_spi_max_length;
 	master->auto_runtime_pm = true;
 	bs->msg_type_shift = bs->reg_offsets[SPI_MSG_TYPE_SHIFT];
 	bs->msg_ctl_width = bs->reg_offsets[SPI_MSG_CTL_WIDTH];


