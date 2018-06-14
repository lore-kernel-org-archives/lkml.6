Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 143AFC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE45B208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko2fc+J/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE45B208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965419AbeFNOnU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965285AbeFNOIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:08:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94BC3208DB;
        Thu, 14 Jun 2018 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985317;
        bh=meyjKcYxcQeDyv5oSaTE+98QpjvI0+M66bRXVcZlMiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ko2fc+J/lFyR6tyKucId0IoYdUkT/Ia3Y63vvwlDnxJrI5TM28q1ffqgvcbRPA4WS
         6HxXupSFOwAeE9qYuwBVvrbc3vf90hzMWW5fTjNwKxx57VEr0WMb6fur2EtZA0EBkA
         pm+0ZyQ81J+9JvsZIRDxsFh21XfSjNChanSdzML0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Matthijs van Duin <matthijsvanduin@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.16 28/43] serial: 8250: omap: Fix idling of clocks for unused uarts
Date:   Thu, 14 Jun 2018 16:04:32 +0200
Message-Id: <20180614132137.215509012@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132135.111973468@linuxfoundation.org>
References: <20180614132135.111973468@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

commit 13dc04d0e5fdc25c8f713ad23fdce51cf2bf96ba upstream.

I noticed that unused UARTs won't necessarily idle properly always
unless at least one byte tx transfer is done first.

After some debugging I narrowed down the problem to the scr register
dma configuration bits that need to be set before softreset for the
clocks to idle. Unless we do this, the module clkctrl idlest bits
may be set to 1 instead of 3 meaning the clock will never idle and
is blocking deeper idle states for the whole domain.

This might be related to the configuration done by the bootloader
or kexec booting where certain configurations cause the 8250 or
the clkctrl clock to jam in a way where setting of the scr bits
and reset is needed to clear it. I've tried diffing the 8250
registers for the various modes, but did not see anything specific.
So far I've only seen this on omap4 but I'm suspecting this might
also happen on the other clkctrl using SoCs considering they
already have a quirk enabled for UART_ERRATA_CLOCK_DISABLE.

Let's fix the issue by configuring scr before reset for basic dma
even if we don't use it. The scr register will be reset when we do
softreset few lines after, and we restore scr on resume. We should
do this for all the SoCs with UART_ERRATA_CLOCK_DISABLE quirk flag
set since the ones with UART_ERRATA_CLOCK_DISABLE are all based
using clkctrl similar to omap4.

Looks like both OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL
bits are needed for the clkctrl to idle after a softreset.

And we need to add omap4 to also use the UART_ERRATA_CLOCK_DISABLE
for the related workaround to be enabled. This same compatible
value will also be used for omap5.

Fixes: cdb929e4452a ("serial: 8250_omap: workaround errata around idling UART after using DMA")
Cc: Keerthy <j-keerthy@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_omap.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1101,13 +1101,14 @@ static int omap8250_no_handle_irq(struct
 	return 0;
 }
 
+static const u8 omap4_habit = UART_ERRATA_CLOCK_DISABLE;
 static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
 static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
 
 static const struct of_device_id omap8250_dt_ids[] = {
 	{ .compatible = "ti,omap2-uart" },
 	{ .compatible = "ti,omap3-uart" },
-	{ .compatible = "ti,omap4-uart" },
+	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
 	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
 	{ .compatible = "ti,am4372-uart", .data = &am3352_habit, },
 	{ .compatible = "ti,dra742-uart", .data = &dra742_habit, },
@@ -1344,6 +1345,19 @@ static int omap8250_soft_reset(struct de
 	int sysc;
 	int syss;
 
+	/*
+	 * At least on omap4, unused uarts may not idle after reset without
+	 * a basic scr dma configuration even with no dma in use. The
+	 * module clkctrl status bits will be 1 instead of 3 blocking idle
+	 * for the whole clockdomain. The softreset below will clear scr,
+	 * and we restore it on resume so this is safe to do on all SoCs
+	 * needing omap8250_soft_reset() quirk. Do it in two writes as
+	 * recommended in the comment for omap8250_update_scr().
+	 */
+	serial_out(up, UART_OMAP_SCR, OMAP_UART_SCR_DMAMODE_1);
+	serial_out(up, UART_OMAP_SCR,
+		   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);
+
 	sysc = serial_in(up, UART_OMAP_SYSC);
 
 	/* softreset the UART */


