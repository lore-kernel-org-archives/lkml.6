Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86AFC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF982146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apRGL30O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfBBH2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:28:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34654 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfBBH2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:28:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so4414733plz.1;
        Fri, 01 Feb 2019 23:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pX1kwP06x3G6yLTSNx68O5rhjBdNo9O9Pwq1+5bwccQ=;
        b=apRGL30OkNKUJgtUeWz5/T5T8kQZo5kfMnjOKUaaKY3XPtBP0RjARZNFGtWAg5KrM7
         U5trfuDWSRQhooMJyvJrZCO20gxS+P+GS1q2bgJxA6ZZ4S/P2KZbLnx3w85V33DnXxq/
         0vyG7iyxPfycsCX2OTb/FDpAapV71Jco0ioAqkJ0zHeB9pc/abVQaGswu3Nf52elA9HI
         fI7p+B9BotxUhg/7ay9qIm4VEpxQmAsNo1d99fBggUd1t1OQdk0VXUk873CFLyYsJvec
         EU2f2IXGDCuyg2+kGVwan10gamA264Uv374UDAi1o1DUh47cF/Jg/TxnKjugDd2G1CRX
         ceBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pX1kwP06x3G6yLTSNx68O5rhjBdNo9O9Pwq1+5bwccQ=;
        b=a9wgPMXkM5Y6akyzo00MIYUldM0zCdamcssaWTRMJRstVxCnO5uHwQF24sJ62jnTij
         h7NqJYnhCPC0RytJ6PdJzFtwswyvZisuNcY9uawlxSAnpNNHs55Sfj67lUjgo6724p5B
         ADnVbZ36QHA4JV93rQsvZkEihs7LBRiCV7td2SitYsUE0ZVb749M8Q/5944XhlH2ngIn
         5YpFRqRNbZm7PZkZ5EnHDR1AhYEkO9LzfD7daJQ6W4/RIxnFuG+Q89dbPjcn1kWVEEAK
         Ua5MH1w8Mj4jEWqC2ZNbcqwej5Xzsr4OI9XK1CyjkqA93SYYPs3slEQuOWiW+7wcE13I
         UWrg==
X-Gm-Message-State: AJcUukccQbzW8qMF42M9XtS3CBC9oo2iEA1oHUz+mq5mM8mam2nHy6cg
        y2pazGaX/XMg/HDpo623FIjoe59m
X-Google-Smtp-Source: ALg8bN5dSw8/1IUPUB+IdP48gx2gfST9g+pIdyDUcaEkswNf/Jj6EogCnDHwjwYbxXgAK/ct6+UZRg==
X-Received: by 2002:a17:902:bb05:: with SMTP id l5mr43690813pls.230.1549092502284;
        Fri, 01 Feb 2019 23:28:22 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id k15sm15973399pfb.147.2019.02.01.23.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 23:28:21 -0800 (PST)
Date:   Fri, 1 Feb 2019 23:28:19 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_uart: Switch pty driver to slave side in
 tty_set_termios()
Message-ID: <20190202072816.GA15630@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tty_set_termios() should be called with slave side of pty driver. So, If
tty driver is pty master, it needs to be switched to ->link.

Reported-by: syzbot+a950165cbb86bdd023a4@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf7b4df23ab..0f6e70ea1dc3 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -299,10 +299,21 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+/* If pty master, return slave side */
+static struct tty_struct *hci_uart_get_real_tty(struct tty_struct *tty)
+{
+	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
+	    tty->driver->subtype == PTY_TYPE_MASTER)
+		tty->link;
+
+	return tty;
+}
+
 /* Flow control or un-flow control the device */
 void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 {
 	struct tty_struct *tty = hu->tty;
+	struct tty_struct *real_tty;
 	struct ktermios ktermios;
 	int status;
 	unsigned int set = 0;
@@ -314,11 +325,14 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		return;
 	}
 
+	/* termios should be set from slave side if tty driver is pty */
+	real_tty = hci_uart_get_real_tty(tty);
+
 	if (enable) {
 		/* Disable hardware flow control */
-		ktermios = tty->termios;
+		ktermios = real_tty->termios;
 		ktermios.c_cflag &= ~CRTSCTS;
-		status = tty_set_termios(tty, &ktermios);
+		status = tty_set_termios(real_tty, &ktermios);
 		BT_DBG("Disabling hardware flow control: %s",
 		       status ? "failed" : "success");
 
@@ -350,9 +364,9 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
 
 		/* Re-enable hardware flow control */
-		ktermios = tty->termios;
+		ktermios = real_tty->termios;
 		ktermios.c_cflag |= CRTSCTS;
-		status = tty_set_termios(tty, &ktermios);
+		status = tty_set_termios(real_tty, &ktermios);
 		BT_DBG("Enabling hardware flow control: %s",
 		       status ? "failed" : "success");
 	}
@@ -367,9 +381,12 @@ void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
-	struct tty_struct *tty = hu->tty;
+	struct tty_struct *tty;
 	struct ktermios ktermios;
 
+	/* termios should be set from slave side if tty driver is pty */
+	tty = hci_uart_get_real_tty(hu->tty);
+
 	ktermios = tty->termios;
 	ktermios.c_cflag &= ~CBAUD;
 	tty_termios_encode_baud_rate(&ktermios, speed, speed);
-- 
2.17.1

