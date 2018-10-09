Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83502ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A66C21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A66C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJJBAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:00:17 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:48518 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJJBAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:00:17 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id lVi91y00Y3XaVaC01Vi9m5; Tue, 09 Oct 2018 19:42:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9w1J-00018c-JE; Tue, 09 Oct 2018 19:42:09 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1g9w1J-0001B0-Gu; Tue, 09 Oct 2018 19:42:09 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Fix receive on SCIFA/SCIFB variants with DMA
Date:   Tue,  9 Oct 2018 19:41:58 +0200
Message-Id: <20181009174158.4476-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SCIFA and SCIFB serial ports with DMA support (i.e. some ports on
R-Car Gen2 and RZ/G1 SoCs), receive DMA operations are submitted before
the DMA channel pointer is initialized.  Hence this fails, and the
driver tries to fall back to PIO.  However, at this early phase in the
initialization sequence, fallback to PIO does not work, leading to a
serial port that cannot receive any data.

Fix this by calling sci_submit_rx() after initialization of the DMA
channel pointer.

Reported-by: Jinzai Solution and RVC Test Teams via Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Fixes: 2c4ee23530ffc022 ("serial: sh-sci: Postpone DMA release when falling back to PIO")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Reported on r8a7790/lager using SCIFA1 on Debug Serial 1.
Tested on r8a7791/koelsch using SCIFA3 on EXIO-B.

This fixes a regression introduced in v4.19-rc1, so please queue for
v4.19.

Thanks!
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index b73b27dc45e60ffb..7e98a4f3ec77abbd 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1614,10 +1614,10 @@ static void sci_request_dma(struct uart_port *port)
 		hrtimer_init(&s->rx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		s->rx_timer.function = rx_timer_fn;
 
+		s->chan_rx_saved = s->chan_rx = chan;
+
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 			sci_submit_rx(s);
-
-		s->chan_rx_saved = s->chan_rx = chan;
 	}
 }
 
-- 
2.17.1

