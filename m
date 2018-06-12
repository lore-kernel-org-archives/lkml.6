Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E98E8C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99683208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99683208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933467AbeFLM3B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:29:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59059 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933082AbeFLM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:29:00 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fSiPu-0006Ev-Kz; Tue, 12 Jun 2018 14:28:54 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fSiPr-0005vi-Cn; Tue, 12 Jun 2018 14:28:51 +0200
Date:   Tue, 12 Jun 2018 14:28:51 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>
Cc:     gregkh@linuxfoundation.org, festevam@gmail.com, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serial: imx: fix cached UCR2 read on software reset
Message-ID: <20180612122851.7xjneseskhkvn3ih@pengutronix.de>
References: <20180420124407.12892-1-stefan@agner.ch>
 <20180607075633.y3tm245jv7nkdrqx@pengutronix.de>
 <afda793c86ba7394233e17813589b44c@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afda793c86ba7394233e17813589b44c@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:11:44PM +0200, Stefan Agner wrote:
> On 07.06.2018 09:56, Uwe Kleine-König wrote:
> > On Fri, Apr 20, 2018 at 02:44:07PM +0200, Stefan Agner wrote:
> >> To reset the UART the SRST needs be cleared (low active). According
> >> to the documentation the bit will remain active for 4 module clocks
> >> until it is cleared (set to 1).
> >>
> >> Hence the real register need to be read in case the cached register
> >> indicates that the SRST bit is zero.
> >>
> >> This bug lead to wrong baudrate because the baud rate register got
> >> restored before reset completed in imx_flush_buffer.
> >>
> >> Fixes: 3a0ab62f43de ("serial: imx: implement shadow registers for UCRx and UFCR")
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> >> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > For the record, there is a customer of mine who reports that this commit
> > breaks rs485 communication on i.MX25 because RTS stops to toggle as
> > intended.
> > 
> > (Some details: uart3, fsl,uart-has-rtscts, fsl,dte-mode,
> > linux,rs485-enabled-at-boot-time, native RTS.)
> > 
> > I didn't debug this yet.
> 
> I have seen your patch today "serial: imx: fix comment about UCR2_SRST
> and its handling for shadowing" so I assume you looked into this issue?
> 
> Was it related to that change?

I started looking into this issue, but didn't find the culprit yet.

My work in progress patch looks as follows:

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 758a67f3c8b3..5270173721c6 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1357,6 +1357,12 @@ static int imx_uart_startup(struct uart_port *port)
 	while (!(imx_uart_readl(sport, UCR2) & UCR2_SRST) && (--i > 0))
 		udelay(1);
 
+	if (imx_uart_readl(sport, UCR2) & UCR2_SRST) {
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+		dev_warn(port->dev, "SRST didn't go away\n");
+		return -EIO;
+	}
+
 	/*
 	 * Finally, clear and enable interrupts
 	 */

which seems to trigger on both i.MX25 and i.MX6 at least occasionally.

Maybe 100 us is too short?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
