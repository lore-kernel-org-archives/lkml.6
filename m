Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CEFC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19382208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19382208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeHUJpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:45:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbeHUJpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:45:05 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 596F5ACC;
        Tue, 21 Aug 2018 06:26:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 4.17 31/42] serial: 8250_exar: Read INT0 from slave device, too
Date:   Tue, 21 Aug 2018 08:21:03 +0200
Message-Id: <20180821055019.155538759@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
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

From: Aaron Sierra <asierra@xes-inc.com>

commit 60ab0fafc4b652fcaf7cbc3bb8555a0cf1149c28 upstream.

The sleep wake-up refactoring that I introduced in

  commit c7e1b4059075 ("tty: serial: exar: Relocate sleep wake-up handling")

did not account for devices with a slave device on the expansion port.
This patch pokes the INT0 register in the slave device, if present, in
order to ensure that MSI interrupts don't get permanently "stuck"
because of a sleep wake-up interrupt as described here:

  commit 2c0ac5b48a35 ("serial: exar: Fix stuck MSIs")

This also converts an ioread8() to readb() in order to provide visual
consistency with the MMIO-only accessors used elsewhere in the driver.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
Fixes: c7e1b4059075 ("tty: serial: exar: Relocate sleep wake-up handling")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_exar.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -433,7 +433,11 @@ static irqreturn_t exar_misc_handler(int
 	struct exar8250 *priv = data;
 
 	/* Clear all PCI interrupts by reading INT0. No effect on IIR */
-	ioread8(priv->virt + UART_EXAR_INT0);
+	readb(priv->virt + UART_EXAR_INT0);
+
+	/* Clear INT0 for Expansion Interface slave ports, too */
+	if (priv->board->num_ports > 8)
+		readb(priv->virt + 0x2000 + UART_EXAR_INT0);
 
 	return IRQ_HANDLED;
 }


