Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA634C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922732089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866612;
	bh=VuUzpgxjTxKg+nywbtNfOmYFfwP1kVcIq8/Y9bwjhAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qICu+QShl6R0NnPHvuz+CaJCZaBM6daQK9/4SlZo7Pc2HUO6aTXBCVA37ueJIYS0M
	 UhHgGAh7KYKnAarLXhJSJHo3v8xkfiqbLtfu6GjRa5e3vxVXKqiP36+60ucvGcc1J9
	 9+O58vNmH4iNaV0VxNKSt4VfDeOgcZToYGUd3XDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbfAGNKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731572AbfAGNKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:10:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87708217D4;
        Mon,  7 Jan 2019 13:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866606;
        bh=VuUzpgxjTxKg+nywbtNfOmYFfwP1kVcIq8/Y9bwjhAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yIzXdUQ7bTaNZL1U8/OPG5YJVSbFm3GoOp8KgcUSVsnM6YP8yVnf5tCeptEEU6/18
         I0slZsclC5+KtjCG5B7wOnEEUl7ZokGwUDZslj5AYUR7n2TyP91CprSwknLIktNhSz
         GGAgdIkyVVyK/2O6Q1F9atNZA7X1PLFNzMxM9q/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nava kishore Manne <nava.manne@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 4.9 61/71] serial: uartps: Fix interrupt mask issue to handle the RX interrupts properly
Date:   Mon,  7 Jan 2019 13:33:30 +0100
Message-Id: <20190107105336.225934413@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nava kishore Manne <nava.manne@xilinx.com>

commit 260683137ab5276113fc322fdbbc578024185fee upstream.

This patch Correct the RX interrupt mask value to handle the
RX interrupts properly.

Fixes: c8dbdc842d30 ("serial: xuartps: Rewrite the interrupt handling logic")
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/xilinx_uartps.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -128,7 +128,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout
 #define CDNS_UART_IXR_RXTRIG	0x00000001 /* RX FIFO trigger interrupt */
 #define CDNS_UART_IXR_RXFULL	0x00000004 /* RX FIFO full interrupt. */
 #define CDNS_UART_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt. */
-#define CDNS_UART_IXR_MASK	0x00001FFF /* Valid bit mask */
+#define CDNS_UART_IXR_RXMASK	0x000021e7 /* Valid RX bit mask */
 
 	/*
 	 * Do not enable parity error interrupt for the following
@@ -362,7 +362,7 @@ static irqreturn_t cdns_uart_isr(int irq
 		cdns_uart_handle_tx(dev_id);
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
-	if (isrstatus & CDNS_UART_IXR_MASK)
+	if (isrstatus & CDNS_UART_IXR_RXMASK)
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
 	spin_unlock(&port->lock);


