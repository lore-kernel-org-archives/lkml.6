Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB58C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7D32080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7D32080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731715AbeKLGEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:04:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52884 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbeKLGEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:04:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtB-0000oG-Pv; Sun, 11 Nov 2018 19:59:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001Po-Qn; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Martin" <Dave.Martin@arm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Wei Xu" <xuwei5@hisilicon.com>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Peter Maydell" <peter.maydell@linaro.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.135901520@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 047/366] tty: pl011: Avoid spuriously stuck-off
 interrupts
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

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
Tested-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Open-code pl011_read()
 - s/REG_/UART01x_/
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1531,6 +1531,7 @@ static int pl011_startup(struct uart_por
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int cr, lcr_h, fbrd, ibrd;
 	int retval;
+	unsigned int i;
 
 	retval = pl011_hwinit(port);
 	if (retval)
@@ -1595,6 +1596,20 @@ static int pl011_startup(struct uart_por
 	/* Clear out any spuriously appearing RX interrupts */
 	 writew(UART011_RTIS | UART011_RXIS,
 		uap->port.membase + UART011_ICR);
+
+	/*
+	 * RXIS is asserted only when the RX FIFO transitions from below
+	 * to above the trigger threshold.  If the RX FIFO is already
+	 * full to the threshold this can't happen and RXIS will now be
+	 * stuck off.  Drain the RX FIFO explicitly to fix this:
+	 */
+	for (i = 0; i < uap->fifosize * 2; ++i) {
+		if (readw(uap->port.membase + UART01x_FR) & UART01x_FR_RXFE)
+			break;
+
+		readw(uap->port.membase + UART01x_DR);
+	}
+
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;

