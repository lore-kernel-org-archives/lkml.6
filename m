Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86A1C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E82E21477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E82E21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbeIMHwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:52:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43586 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeIMHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYn-0006P1-Nk; Thu, 13 Sep 2018 02:40:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/50] mos7720: bury dead TIOCM... in ->ioctl()
Date:   Thu, 13 Sep 2018 03:40:03 +0100
Message-Id: <20180913024049.24567-4-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

These ioctls never reach driver's ->ioctl() - tty_ioctl() handles
them on its own.  ->tiocm[gs]et() is what actually gets called,
and mos7720 provides those, with results equivalent to what the
unreachable code would be doing when called.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/usb/serial/mos7720.c | 52 --------------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 27109522fd8b..4c06357b3ef8 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -1786,51 +1786,6 @@ static int mos7720_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static int set_modem_info(struct moschip_port *mos7720_port, unsigned int cmd,
-			  unsigned int __user *value)
-{
-	unsigned int mcr;
-	unsigned int arg;
-
-	struct usb_serial_port *port;
-
-	if (mos7720_port == NULL)
-		return -1;
-
-	port = (struct usb_serial_port *)mos7720_port->port;
-	mcr = mos7720_port->shadowMCR;
-
-	if (copy_from_user(&arg, value, sizeof(int)))
-		return -EFAULT;
-
-	switch (cmd) {
-	case TIOCMBIS:
-		if (arg & TIOCM_RTS)
-			mcr |= UART_MCR_RTS;
-		if (arg & TIOCM_DTR)
-			mcr |= UART_MCR_RTS;
-		if (arg & TIOCM_LOOP)
-			mcr |= UART_MCR_LOOP;
-		break;
-
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS)
-			mcr &= ~UART_MCR_RTS;
-		if (arg & TIOCM_DTR)
-			mcr &= ~UART_MCR_RTS;
-		if (arg & TIOCM_LOOP)
-			mcr &= ~UART_MCR_LOOP;
-		break;
-
-	}
-
-	mos7720_port->shadowMCR = mcr;
-	write_mos_reg(port->serial, port->port_number, MOS7720_MCR,
-		      mos7720_port->shadowMCR);
-
-	return 0;
-}
-
 static int get_serial_info(struct moschip_port *mos7720_port,
 			   struct serial_struct __user *retinfo)
 {
@@ -1868,13 +1823,6 @@ static int mos7720_ioctl(struct tty_struct *tty,
 		return get_lsr_info(tty, mos7720_port,
 					(unsigned int __user *)arg);
 
-	/* FIXME: These should be using the mode methods */
-	case TIOCMBIS:
-	case TIOCMBIC:
-		dev_dbg(&port->dev, "%s TIOCMSET/TIOCMBIC/TIOCMSET\n", __func__);
-		return set_modem_info(mos7720_port, cmd,
-				      (unsigned int __user *)arg);
-
 	case TIOCGSERIAL:
 		dev_dbg(&port->dev, "%s TIOCGSERIAL\n", __func__);
 		return get_serial_info(mos7720_port,
-- 
2.11.0

