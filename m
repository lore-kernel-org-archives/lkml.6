Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs9oMSoA6Y1Cu5jLYxT4pE85EG/E/UUvEkOCqFMlIfDi1z+nkKX0nLIQ7J7Awdt+zdUsmxc
ARC-Seal: i=1; a=rsa-sha256; t=1521483815; cv=none;
        d=google.com; s=arc-20160816;
        b=ORQQIuIsnDMY/+bh1uXhyHeKASs9Aws0JXQFXCtKKPjRyku4uCM5Bn6ocTzr7lVFR3
         5IUp9nEZOdB53Vg1mX0G7fT59zIEFC66yYxWVLP6lbWMUuL3byWAm7D+MRbYQepqK4Tb
         g2p7kj4CowVOzGGA7vGbkXBQU04CzV73shwy8hlk2K0S4QNb5apVkirYPCixT76UZbxN
         cmGkQ0lN37sWlP/85KxCKmvIrOqaeL7319x8zN9HsKH2B8/W3+yoydTv6/HpOELnE2I1
         i4DHQt2vdaFb/B9r0otEj/4/ShsS7hFk2lfWaH3sOKQ4EHie58aNImuobOmcvLPHr0vk
         4GAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mU0gPA9ouPF3HyrcC8f/W8sE2CaNgjeH00POqP6XuFA=;
        b=dqw4zXGJM9AT2Sst5+ZKltaWevQmk+Nd1joQvY/UMTDtPY9vsjlRai3dcK5xawwBSA
         nKkILbakZs+GelzVaB62khy742icsFxBA8lgWJD4AjTTWNeqizLYc3/pq4kXFD3Z7dme
         gk2bYnQIVlsTzPAqpSvS/DjplSHX63Vw2TKSVi/6FCBu5LktK9T9y3WBxr58FL8jnM8F
         y1xOanhpvxOpkROmhf3E02TJtLUCw+8FndHWT02MBRtBOkjPFu4S2V7Gg7o7Pi3YIaj+
         KsOmcMlU7o+6ByvfmeUV0vL4pOxsXQyNxuJRSpH5OD0kJKnw2Y1MFUIOTuem4d+5JUow
         XLpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jayachandran C <jnair@caviumnetworks.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 127/241] tty: amba-pl011: Fix spurious TX interrupts
Date: Mon, 19 Mar 2018 19:06:32 +0100
Message-Id: <20180319180756.456254569@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391413477416074?=
X-GMAIL-MSGID: =?utf-8?q?1595391413477416074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jayachandran C <jnair@caviumnetworks.com>


[ Upstream commit 7d05587c9e0e4611650bb403812e2d492c178a9f ]

On SMP systems, we see a lot of spurious TX interrupts when a
program generates a steady stream of output to the pl011 UART.

The problem can be easily seen when one CPU generates the output
while another CPU handles the pl011 interrupts, and the rate of
output is low enough not to fill the TX FIFO. The problem seems
to be:

    -- CPU a --                        -- CPU b --
   (take port lock)
   pl011_start_tx
      pl011_start_tx_pio
         enable TXIM in REG_IMSC   ->  causes uart tx intr (pl011_int)
         pl011_tx_chars                pl011_int
            ...tx chars, all done...       (wait for port lock)
            pl011_stop_tx                   .
               disable TXIM                 .
    (release port lock)            ->      (take port lock)
                                           check for TXIM, not enabled
                                           (release port lock)
                                           return IRQ_NONE

Enabling the TXIM in pl011_start_tx_pio() causes the interrupt
to be generated and delivered to CPU b, even though pl011_tx_chars()
is able to complete the TX and then disable the tx interrupt.

Fix this by enabling TXIM only after pl011_tx_chars, if it is needed.
pl011_tx_chars will return a boolean indicating whether the TX
interrupts have to be enabled.

Debugged-by: Vijaya Kumar <Vijaya.Kumar@cavium.com>
Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/amba-pl011.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1302,14 +1302,15 @@ static void pl011_stop_tx(struct uart_po
 	pl011_dma_tx_stop(uap);
 }
 
-static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
+static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
 
 /* Start TX with programmed I/O only (no DMA) */
 static void pl011_start_tx_pio(struct uart_amba_port *uap)
 {
-	uap->im |= UART011_TXIM;
-	pl011_write(uap->im, uap, REG_IMSC);
-	pl011_tx_chars(uap, false);
+	if (pl011_tx_chars(uap, false)) {
+		uap->im |= UART011_TXIM;
+		pl011_write(uap->im, uap, REG_IMSC);
+	}
 }
 
 static void pl011_start_tx(struct uart_port *port)
@@ -1389,25 +1390,26 @@ static bool pl011_tx_char(struct uart_am
 	return true;
 }
 
-static void pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
+/* Returns true if tx interrupts have to be (kept) enabled  */
+static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
 {
 	struct circ_buf *xmit = &uap->port.state->xmit;
 	int count = uap->fifosize >> 1;
 
 	if (uap->port.x_char) {
 		if (!pl011_tx_char(uap, uap->port.x_char, from_irq))
-			return;
+			return true;
 		uap->port.x_char = 0;
 		--count;
 	}
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&uap->port)) {
 		pl011_stop_tx(&uap->port);
-		return;
+		return false;
 	}
 
 	/* If we are using DMA mode, try to send some characters. */
 	if (pl011_dma_tx_irq(uap))
-		return;
+		return true;
 
 	do {
 		if (likely(from_irq) && count-- == 0)
@@ -1422,8 +1424,11 @@ static void pl011_tx_chars(struct uart_a
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&uap->port);
 
-	if (uart_circ_empty(xmit))
+	if (uart_circ_empty(xmit)) {
 		pl011_stop_tx(&uap->port);
+		return false;
+	}
+	return true;
 }
 
 static void pl011_modem_status(struct uart_amba_port *uap)
