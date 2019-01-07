Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0CEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0642173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866184;
	bh=ldRUUl9d/Gf3DHkuSQEmlQIgIqfemy+Glo2o4zzylTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y0eDBnIccx2JW0b9TXtX2r3rjRD7vj/bE83rPyNyMEk6fuDrvb6K9iOE/oQJjCyiB
	 tasiyvkPRTod/4t4hz1yhlPmncITNecxoIne8O+ZeRkm18AJ6+X4+3v3zFBtzfI0W/
	 ZcIG/57KITOn5kLwdzDRWzKo/JZfSgJ2T6Jz/7Pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfAGNDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:03:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730907AbfAGNDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:03:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6EA217D4;
        Mon,  7 Jan 2019 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866180;
        bh=ldRUUl9d/Gf3DHkuSQEmlQIgIqfemy+Glo2o4zzylTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DhF7rpBO75qPYdkAtVreRpF3oRdx12BbyqX9Xe/D3lxVed/h7IbTWc5umHOHGyBDJ
         XlA5GUuPkuePQuAzaqFT8sIEhkMO1sc+9BqjiQFn9SlHmRo0F8sSa5aQf3ZGiDBcBC
         Jv/84bx0TrgqmjacTTum+HUntbCgpD/Wk68Z9rPA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Frank Pavlic <f.pavlic@kunbus.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 071/101] spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode
Date:   Mon,  7 Jan 2019 13:32:59 +0100
Message-Id: <20190107105336.872263253@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 56c1723426d3cfd4723bfbfce531d7b38bae6266 upstream.

The IRQ handler bcm2835_spi_interrupt() first reads as much as possible
from the RX FIFO, then writes as much as possible to the TX FIFO.
Afterwards it decides whether the transfer is finished by checking if
the TX FIFO is empty.

If very few bytes were written to the TX FIFO, they may already have
been transmitted by the time the FIFO's emptiness is checked.  As a
result, the transfer will be declared finished and the chip will be
reset without reading the corresponding received bytes from the RX FIFO.

The odds of this happening increase with a high clock frequency (such
that the TX FIFO drains quickly) and either passing "threadirqs" on the
command line or enabling CONFIG_PREEMPT_RT_BASE (such that the IRQ
handler may be preempted between filling the TX FIFO and checking its
emptiness).

Fix by instead checking whether rx_len has reached zero, which means
that the transfer has been received in full.  This is also more
efficient as it avoids one bus read access per interrupt.  Note that
bcm2835_spi_transfer_one_poll() likewise uses rx_len to determine
whether the transfer has finished.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Fixes: e34ff011c70e ("spi: bcm2835: move to the transfer_one driver model")
Cc: stable@vger.kernel.org # v4.1+
Cc: Mathias Duckeck <m.duckeck@kunbus.de>
Cc: Frank Pavlic <f.pavlic@kunbus.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
Cc: Noralf Trønnes <noralf@tronnes.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm2835.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -155,8 +155,7 @@ static irqreturn_t bcm2835_spi_interrupt
 	/* Write as many bytes as possible to FIFO */
 	bcm2835_wr_fifo(bs);
 
-	/* based on flags decide if we can finish the transfer */
-	if (bcm2835_rd(bs, BCM2835_SPI_CS) & BCM2835_SPI_CS_DONE) {
+	if (!bs->rx_len) {
 		/* Transfer complete - reset SPI HW */
 		bcm2835_spi_reset_hw(master);
 		/* wake up the framework */


