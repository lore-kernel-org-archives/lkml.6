Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD3BC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA7D204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3XAvWJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA7D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbeKDXIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:08:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730973AbeKDXIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387402085A;
        Sun,  4 Nov 2018 13:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339596;
        bh=676F8azaXKn1LWI8d4rmHSJMwkmr1KsR1W5Jdl6LBdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N3XAvWJifk7ijoN4clvw93CTJES6QTSozbUMOIPLFI26OnXoJpOXnjxZCgM6wJFg2
         fPXaOvif0qyp2icfGMKgu2Ad9BP31wOVNHX/PqLs0Ilcb5NWE8yEeAtDlWBn3b/pkc
         GnjSVziWK1YQaQXfd3ZCj6/FuqAIaA9Xf2TeOz1I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 35/45] sc16is7xx: Fix for multi-channel stall
Date:   Sun,  4 Nov 2018 08:52:30 -0500
Message-Id: <20181104135240.88431-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.org>

[ Upstream commit 8344498721059754e09d30fe255a12dab8fb03ef ]

The SC16IS752 is a dual-channel device. The two channels are largely
independent, but the IRQ signals are wired together as an open-drain,
active low signal which will be driven low while either of the
channels requires attention, which can be for significant periods of
time until operations complete and the interrupt can be acknowledged.
In that respect it is should be treated as a true level-sensitive IRQ.

The kernel, however, needs to be able to exit interrupt context in
order to use I2C or SPI to access the device registers (which may
involve sleeping).  Therefore the interrupt needs to be masked out or
paused in some way.

The usual way to manage sleeping from within an interrupt handler
is to use a threaded interrupt handler - a regular interrupt routine
does the minimum amount of work needed to triage the interrupt before
waking the interrupt service thread. If the threaded IRQ is marked as
IRQF_ONESHOT the kernel will automatically mask out the interrupt
until the thread runs to completion. The sc16is7xx driver used to
use a threaded IRQ, but a patch switched to using a kthread_worker
in order to set realtime priorities on the handler thread and for
other optimisations. The end result is non-threaded IRQ that
schedules some work then returns IRQ_HANDLED, making the kernel
think that all IRQ processing has completed.

The work-around to prevent a constant stream of interrupts is to
mark the interrupt as edge-sensitive rather than level-sensitive,
but interpreting an active-low source as a falling-edge source
requires care to prevent a total cessation of interrupts. Whereas
an edge-triggering source will generate a new edge for every interrupt
condition a level-triggering source will keep the signal at the
interrupting level until it no longer requires attention; in other
words, the host won't see another edge until all interrupt conditions
are cleared. It is therefore vital that the interrupt handler does not
exit with an outstanding interrupt condition, otherwise the kernel
will not receive another interrupt unless some other operation causes
the interrupt state on the device to be cleared.

The existing sc16is7xx driver has a very simple interrupt "thread"
(kthread_work job) that processes interrupts on each channel in turn
until there are no more. If both channels are active and the first
channel starts interrupting while the handler for the second channel
is running then it will not be detected and an IRQ stall ensues. This
could be handled easily if there was a shared IRQ status register, or
a convenient way to determine if the IRQ had been deasserted for any
length of time, but both appear to be lacking.

Avoid this problem (or at least make it much less likely to happen)
by reducing the granularity of per-channel interrupt processing
to one condition per iteration, only exiting the overall loop when
both channels are no longer interrupting.

Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 243c96025053..47b41159a8bc 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -657,7 +657,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		uart_write_wakeup(port);
 }
 
-static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
+static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
 	struct uart_port *port = &s->p[portno].port;
 
@@ -666,7 +666,7 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 
 		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
 		if (iir & SC16IS7XX_IIR_NO_INT_BIT)
-			break;
+			return false;
 
 		iir &= SC16IS7XX_IIR_ID_MASK;
 
@@ -688,16 +688,23 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 					    port->line, iir);
 			break;
 		}
-	} while (1);
+	} while (0);
+	return true;
 }
 
 static void sc16is7xx_ist(struct kthread_work *ws)
 {
 	struct sc16is7xx_port *s = to_sc16is7xx_port(ws, irq_work);
-	int i;
 
-	for (i = 0; i < s->devtype->nr_uart; ++i)
-		sc16is7xx_port_irq(s, i);
+	while (1) {
+		bool keep_polling = false;
+		int i;
+
+		for (i = 0; i < s->devtype->nr_uart; ++i)
+			keep_polling |= sc16is7xx_port_irq(s, i);
+		if (!keep_polling)
+			break;
+	}
 }
 
 static irqreturn_t sc16is7xx_irq(int irq, void *dev_id)
-- 
2.17.1

