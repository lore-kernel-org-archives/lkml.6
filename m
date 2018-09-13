Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0ADC070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E00B2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E00B2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeIMHtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:49:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43778 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeIMHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYs-0006T2-Kj; Thu, 13 Sep 2018 02:40:54 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 39/50] dgnc: TIOCM... won't reach ->ioctl()
Date:   Thu, 13 Sep 2018 03:40:38 +0100
Message-Id: <20180913024049.24567-39-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

bury the dead code (and ->tiocmget()/->tiocmset() are there, so I really
wonder why have they kept the stuff that became unreachable with the
introduction of those...)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/dgnc/dgnc_tty.c | 114 ----------------------------------------
 1 file changed, 114 deletions(-)

diff --git a/drivers/staging/dgnc/dgnc_tty.c b/drivers/staging/dgnc/dgnc_tty.c
index f91eaa1c3b67..9accaa705820 100644
--- a/drivers/staging/dgnc/dgnc_tty.c
+++ b/drivers/staging/dgnc/dgnc_tty.c
@@ -60,10 +60,6 @@ static void dgnc_tty_unthrottle(struct tty_struct *tty);
 static void dgnc_tty_flush_chars(struct tty_struct *tty);
 static void dgnc_tty_flush_buffer(struct tty_struct *tty);
 static void dgnc_tty_hangup(struct tty_struct *tty);
-static int dgnc_set_modem_info(struct channel_t *ch, unsigned int command,
-			       unsigned int __user *value);
-static int dgnc_get_modem_info(struct channel_t *ch,
-			       unsigned int __user *value);
 static int dgnc_tty_tiocmget(struct tty_struct *tty);
 static int dgnc_tty_tiocmset(struct tty_struct *tty, unsigned int set,
 			     unsigned int clear);
@@ -1701,106 +1697,6 @@ static void dgnc_tty_send_xchar(struct tty_struct *tty, char c)
 	spin_unlock_irqrestore(&ch->ch_lock, flags);
 }
 
-/* Return modem signals to ld. */
-static inline int dgnc_get_mstat(struct channel_t *ch)
-{
-	unsigned char mstat;
-	unsigned long flags;
-	int rc;
-
-	if (!ch)
-		return -ENXIO;
-
-	spin_lock_irqsave(&ch->ch_lock, flags);
-
-	mstat = ch->ch_mostat | ch->ch_mistat;
-
-	spin_unlock_irqrestore(&ch->ch_lock, flags);
-
-	rc = 0;
-
-	if (mstat & UART_MCR_DTR)
-		rc |= TIOCM_DTR;
-	if (mstat & UART_MCR_RTS)
-		rc |= TIOCM_RTS;
-	if (mstat & UART_MSR_CTS)
-		rc |= TIOCM_CTS;
-	if (mstat & UART_MSR_DSR)
-		rc |= TIOCM_DSR;
-	if (mstat & UART_MSR_RI)
-		rc |= TIOCM_RI;
-	if (mstat & UART_MSR_DCD)
-		rc |= TIOCM_CD;
-
-	return rc;
-}
-
-/* Return modem signals to ld. */
-static int dgnc_get_modem_info(struct channel_t *ch,
-			       unsigned int  __user *value)
-{
-	return put_user(dgnc_get_mstat(ch), value);
-}
-
-/* Set modem signals, called by ld. */
-static int dgnc_set_modem_info(struct channel_t *ch,
-			       unsigned int command,
-			       unsigned int __user *value)
-{
-	int rc;
-	unsigned int arg = 0;
-	unsigned long flags;
-
-	rc = get_user(arg, value);
-	if (rc)
-		return rc;
-
-	switch (command) {
-	case TIOCMBIS:
-		if (arg & TIOCM_RTS)
-			ch->ch_mostat |= UART_MCR_RTS;
-
-		if (arg & TIOCM_DTR)
-			ch->ch_mostat |= UART_MCR_DTR;
-
-		break;
-
-	case TIOCMBIC:
-		if (arg & TIOCM_RTS)
-			ch->ch_mostat &= ~(UART_MCR_RTS);
-
-		if (arg & TIOCM_DTR)
-			ch->ch_mostat &= ~(UART_MCR_DTR);
-
-		break;
-
-	case TIOCMSET:
-
-		if (arg & TIOCM_RTS)
-			ch->ch_mostat |= UART_MCR_RTS;
-		else
-			ch->ch_mostat &= ~(UART_MCR_RTS);
-
-		if (arg & TIOCM_DTR)
-			ch->ch_mostat |= UART_MCR_DTR;
-		else
-			ch->ch_mostat &= ~(UART_MCR_DTR);
-
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	spin_lock_irqsave(&ch->ch_lock, flags);
-
-	ch->ch_bd->bd_ops->assert_modem_signals(ch);
-
-	spin_unlock_irqrestore(&ch->ch_lock, flags);
-
-	return 0;
-}
-
 /* Ioctl to get the information for ditty. */
 static int dgnc_tty_digigeta(struct tty_struct *tty,
 			     struct digi_t __user *retinfo)
@@ -2282,16 +2178,6 @@ static int dgnc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 
 		return 0;
 
-	case TIOCMGET:
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-		return dgnc_get_modem_info(ch, uarg);
-
-	case TIOCMBIS:
-	case TIOCMBIC:
-	case TIOCMSET:
-		spin_unlock_irqrestore(&ch->ch_lock, flags);
-		return dgnc_set_modem_info(ch, cmd, uarg);
-
 		/* Here are any additional ioctl's that we want to implement */
 
 	case TCFLSH:
-- 
2.11.0

