Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 79F5CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B937208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9ddlhLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B937208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936370AbeFNOxq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936305AbeFNOGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:06:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6612208DD;
        Thu, 14 Jun 2018 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985193;
        bh=ZGFIklxiS1Qf6UFmT16LFDh6VOKKs3pTaaxSqM88wZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9ddlhLiXFAZSjxJ37DTtPJA6Mc6n+geuy4iwMDg+K6maNgu2BFCTPTujr7gjSbyx
         YE/jUHblB4J7YA1MYlETj9Y07CtPM5pVQ+iCF3Lat9q1hoib7PfiXLrWOrfksA4f/1
         i0/CNJsHEUuvoussupyHCt3Eupr9Klr2823tz/Ew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 4.17 32/45] tty: pl011: Avoid spuriously stuck-off interrupts
Date:   Thu, 14 Jun 2018 16:04:23 +0200
Message-Id: <20180614132128.560031566@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Martin <Dave.Martin@arm.com>

commit 4a7e625ce50412a7711efa0f2ef0b96ce3826759 upstream.

Commit 9b96fbacda34 ("serial: PL011: clear pending interrupts")
clears the RX and receive timeout interrupts on pl011 startup, to
avoid a screaming-interrupt scenario that can occur when the
firmware or bootloader leaves these interrupts asserted.

This has been noted as an issue when running Linux on qemu [1].

Unfortunately, the above fix seems to lead to potential
misbehaviour if the RX FIFO interrupt is asserted _non_ spuriously
on driver startup, if the RX FIFO is also already full to the
trigger level.

Clearing the RX FIFO interrupt does not change the FIFO fill level.
In this scenario, because the interrupt is now clear and because
the FIFO is already full to the trigger level, no new assertion of
the RX FIFO interrupt can occur unless the FIFO is drained back
below the trigger level.  This never occurs because the pl011
driver is waiting for an RX FIFO interrupt to tell it that there is
something to read, and does not read the FIFO at all until that
interrupt occurs.

Thus, simply clearing "spurious" interrupts on startup may be
misguided, since there is no way to be sure that the interrupts are
truly spurious, and things can go wrong if they are not.

This patch instead clears the interrupt condition by draining the
RX FIFO during UART startup, after clearing any potentially
spurious interrupt.  This should ensure that an interrupt will
definitely be asserted if the RX FIFO subsequently becomes
sufficiently full.

The drain is done at the point of enabling interrupts only.  This
means that it will occur any time the UART is newly opened through
the tty layer.  It will not apply to polled-mode use of the UART by
kgdboc: since that scenario cannot use interrupts by design, this
should not matter.  kgdboc will interact badly with "normal" use of
the UART in any case: this patch makes no attempt to paper over
such issues.

This patch does not attempt to address the case where the RX FIFO
fills faster than it can be drained: that is a pathological
hardware design problem that is beyond the scope of the driver to
work around.  As a failsafe, the number of poll iterations for
draining the FIFO is limited to twice the FIFO size.  This will
ensure that the kernel at least boots even if it is impossible to
drain the FIFO for some reason.

[1] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
before enabled the interruption
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html

Reported-by: Wei Xu <xuwei5@hisilicon.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 9b96fbacda34 ("serial: PL011: clear pending interrupts")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: stable <stable@vger.kernel.org>
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/amba-pl011.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1727,10 +1727,26 @@ static int pl011_allocate_irq(struct uar
  */
 static void pl011_enable_interrupts(struct uart_amba_port *uap)
 {
+	unsigned int i;
+
 	spin_lock_irq(&uap->port.lock);
 
 	/* Clear out any spuriously appearing RX interrupts */
 	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
+
+	/*
+	 * RXIS is asserted only when the RX FIFO transitions from below
+	 * to above the trigger threshold.  If the RX FIFO is already
+	 * full to the threshold this can't happen and RXIS will now be
+	 * stuck off.  Drain the RX FIFO explicitly to fix this:
+	 */
+	for (i = 0; i < uap->fifosize * 2; ++i) {
+		if (pl011_read(uap, REG_FR) & UART01x_FR_RXFE)
+			break;
+
+		pl011_read(uap, REG_DR);
+	}
+
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;


