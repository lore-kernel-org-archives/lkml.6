Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D9CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A8C2183F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866282;
	bh=/U1qJ53Swlbh6+ONZmtfCfT2lEdzWrtY/sGNbjrPyiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oi/2wGYvJt3r2ReofpwBrsmNqlCeoSc2dlF8BBgnYLhoNAH8Gxs635ODEO/JKzgX6
	 nfaYgKBnPRLy9fvbDOWgEhrn7XBGmVS9jAlhuKdO5n5lmt4Qxl143ucpvtvAAeXHTU
	 o3mC3asbdd3+FmIIjQvsfBIhygaZ8kOB7hRwBStU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbfAGNEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:04:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730812AbfAGNEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:04:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6247221736;
        Mon,  7 Jan 2019 13:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866276;
        bh=/U1qJ53Swlbh6+ONZmtfCfT2lEdzWrtY/sGNbjrPyiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxc0+BkGMRhyjlf10qk9jb/HO/oVNUXifUm4C8mewWCw/sJMt8ZtpGfFzMS4GU5F0
         ouCXrbOSyqFO6n6NqOIWfbS7im+8dDWxERhf3Rs/ZGbyMZ/0zXaXaVt+gQgyer6A0R
         4xWi/V3+C3UrTD9Xl0rz+gW7sNxGWAElwDrz0MyM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nava kishore Manne <nava.manne@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 4.14 086/101] serial: uartps: Fix interrupt mask issue to handle the RX interrupts properly
Date:   Mon,  7 Jan 2019 13:33:14 +0100
Message-Id: <20190107105337.618407713@linuxfoundation.org>
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
@@ -130,7 +130,7 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout
 #define CDNS_UART_IXR_RXTRIG	0x00000001 /* RX FIFO trigger interrupt */
 #define CDNS_UART_IXR_RXFULL	0x00000004 /* RX FIFO full interrupt. */
 #define CDNS_UART_IXR_RXEMPTY	0x00000002 /* RX FIFO empty interrupt. */
-#define CDNS_UART_IXR_MASK	0x00001FFF /* Valid bit mask */
+#define CDNS_UART_IXR_RXMASK	0x000021e7 /* Valid RX bit mask */
 
 	/*
 	 * Do not enable parity error interrupt for the following
@@ -366,7 +366,7 @@ static irqreturn_t cdns_uart_isr(int irq
 		cdns_uart_handle_tx(dev_id);
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
-	if (isrstatus & CDNS_UART_IXR_MASK)
+	if (isrstatus & CDNS_UART_IXR_RXMASK)
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
 	spin_unlock(&port->lock);


