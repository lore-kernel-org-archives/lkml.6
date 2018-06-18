Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A7FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BEB208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BEB208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967132AbeFRIbY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:31:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34050 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966854AbeFRIbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:31:20 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E5DFC75;
        Mon, 18 Jun 2018 08:31:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, sxauwsk <sxauwsk@163.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 027/189] spi: cadence: Add usleep_range() for cdns_spi_fill_tx_fifo()
Date:   Mon, 18 Jun 2018 10:12:03 +0200
Message-Id: <20180618081210.381269818@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
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

From: sxauwsk <sxauwsk@163.com>

[ Upstream commit 49530e6411789c1b9ea3ebc58e520c19d1c3752f ]

In case of xspi work in busy condition, may send bytes failed.
once something wrong, spi controller did't work any more

My test found this situation appear in both of read/write process.
so when TX FIFO is full, add one byte delay before send data;

Signed-off-by: sxauwsk <sxauwsk@163.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-cadence.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -313,6 +313,14 @@ static void cdns_spi_fill_tx_fifo(struct
 
 	while ((trans_cnt < CDNS_SPI_FIFO_DEPTH) &&
 	       (xspi->tx_bytes > 0)) {
+
+		/* When xspi in busy condition, bytes may send failed,
+		 * then spi control did't work thoroughly, add one byte delay
+		 */
+		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
+		    CDNS_SPI_IXR_TXFULL)
+			usleep_range(10, 20);
+
 		if (xspi->txbuf)
 			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
 		else


