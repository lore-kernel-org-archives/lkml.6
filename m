Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E230EC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36452075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36452075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeIHB4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:56:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40858 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeIHB4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:56:34 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7A749FAA;
        Fri,  7 Sep 2018 21:13:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kotas <jank@cadence.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.18 008/145] spi: cadence: Change usleep_range() to udelay(), for atomic context
Date:   Fri,  7 Sep 2018 23:07:54 +0200
Message-Id: <20180907210904.340146754@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Janek Kotas <jank@cadence.com>

commit 931c4e9a72ae91d59c5332ffb6812911a749da8e upstream.

The path "spi: cadence: Add usleep_range() for
cdns_spi_fill_tx_fifo()" added a usleep_range() function call,
which cannot be used in atomic context.
However the cdns_spi_fill_tx_fifo() function can be called during
an interrupt which may result in a kernel panic:

BUG: scheduling while atomic: grep/561/0x00010002
Modules linked in:
Preemption disabled at:
[<ffffff800858ea28>] wait_for_common+0x48/0x178
CPU: 0 PID: 561 Comm: grep Not tainted 4.17.0 #1
Hardware name: Cadence CSP (DT)
Call trace:
 dump_backtrace+0x0/0x198
 show_stack+0x14/0x20
 dump_stack+0x8c/0xac
 __schedule_bug+0x6c/0xb8
 __schedule+0x570/0x5d8
 schedule+0x34/0x98
 schedule_hrtimeout_range_clock+0x98/0x110
 schedule_hrtimeout_range+0x10/0x18
 usleep_range+0x64/0x98
 cdns_spi_fill_tx_fifo+0x70/0xb0
 cdns_spi_irq+0xd0/0xe0
 __handle_irq_event_percpu+0x9c/0x128
 handle_irq_event_percpu+0x34/0x88
 handle_irq_event+0x48/0x78
 handle_fasteoi_irq+0xbc/0x1b0
 generic_handle_irq+0x24/0x38
 __handle_domain_irq+0x84/0xf8
 gic_handle_irq+0xc4/0x180

This patch replaces the function call with udelay() which can be
used in an atomic context, like an interrupt.

Signed-off-by: Jan Kotas <jank@cadence.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-cadence.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -319,7 +319,7 @@ static void cdns_spi_fill_tx_fifo(struct
 		 */
 		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
 		    CDNS_SPI_IXR_TXFULL)
-			usleep_range(10, 20);
+			udelay(10);
 
 		if (xspi->txbuf)
 			cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);


