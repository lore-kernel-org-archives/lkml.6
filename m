Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF230C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982C9205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orczsWKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982C9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeH3FrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:47:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42292 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3FrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:47:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so3107553pff.9;
        Wed, 29 Aug 2018 18:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P/6K4S4/MCf4PvzZUqxPNwP4rElLsJ7tp0RDtzFeYlQ=;
        b=orczsWKVRgZuPvJeEGa/m+ZxOEvcz196T/26JY/4MHs6U+fcmT+xrG777TzOWX7++o
         33xbnEe7/1cTzHn9kKiNDJz9Ay6qKo5JtsRP5cqqfrH9XJ2xIIkwSNBFwvHcDAuXg/A5
         oPmaAx6SnFGYGktVSni3AUm+Lux4LFHMZFAr0fRPaeRYYpRlVmhbLBkYSdpSEdkj+ZL/
         kWqJK9+wKCnrF38cXPwnavwi9SPZtc5PT9BzTQ5eiMbKtpW/2zxYpFX5ugf1ZRjOLaK6
         qEjHpLNAc9D7uBCXUaeAO0kEg4IMYRRMUI4CB+wnefFdRGaNm9GQb8BVy/RNf1EMA7R4
         Aj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P/6K4S4/MCf4PvzZUqxPNwP4rElLsJ7tp0RDtzFeYlQ=;
        b=uGr8JN1tIHVJ9CGAwMwVQBKsGjV8CFCHM//Rq6zIp1rRD33DKY75zs/mF0y8NoUPdS
         +lWB/NUH7uXPoeRqs0CkqUVXNWG5HqcjUSMAceQGeYU+ld8gx8bn7kJvy1tJy88ISKWt
         /tMfRAZ/cM1ioJx+Pne13JcOG9htzDQd6EVMFBisezZ/pUBptqYOjgTxzGXk9dM8UyJ3
         EZMb1lNSPJm6vsIlJRc93Ph/vM/Dgqt4TozUSbv9ZEDZ01cK8vBBvXBkZQfDlaxsXf6O
         IPQEJW8vm+nOeMPJLH2qFRli9YfSM0MT/ueapTUmLNKA1ZUtIVBjUi6XRwEeTAbuOIJQ
         C9ag==
X-Gm-Message-State: APzg51B/PhGsYQKBMkuX/yy73HPmIPZO1jEvwfB6d+C057oNdp60T7zn
        DNzXxDUXkLWrgcWULdUI6R4=
X-Google-Smtp-Source: ANB0VdZZF7ibGIdudvM2cc9I88J2CMbGBgPQ3LH/Np5aAojhEpC9++1Y5sq1VIU8u8VJGl8eBcvEJg==
X-Received: by 2002:a62:435c:: with SMTP id q89-v6mr8383328pfa.135.1535593649045;
        Wed, 29 Aug 2018 18:47:29 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id e14-v6sm5922053pgv.48.2018.08.29.18.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 18:47:28 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        hpeter+linux_kernel@gmail.com
Subject: [PATCH V2 3/4] USB: serial: f81232: implement break control
Date:   Thu, 30 Aug 2018 09:47:13 +0800
Message-Id: <1535593634-22004-5-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement Fintek F81232 break on/off with LCR register.
It's the same with 16550A LCR register layout.

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
v2:
        1: Fix f81232_break_ctl() for mis-operated set_mask_register().
        2: Add set break control bit in f81232_set_termios().

 drivers/usb/serial/f81232.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 56adae8a9ee0..863430d7535f 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -65,6 +65,7 @@ struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
+	bool is_break;
 	speed_t baud_base;
 	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
@@ -377,13 +378,24 @@ static void f81232_process_read_urb(struct urb *urb)
 
 static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 {
-	/* FIXME - Stubbed out for now */
+	struct usb_serial_port *port = tty->driver_data;
+	struct f81232_private *priv = usb_get_serial_port_data(port);
+	int status;
+	u8 tmp = 0;
 
-	/*
-	 * break_state = -1 to turn on break, and 0 to turn off break
-	 * see drivers/char/tty_io.c to see it used.
-	 * last_set_data_urb_value NEVER has the break bit set in it.
-	 */
+	mutex_lock(&priv->lock);
+
+	if (break_state) {
+		priv->is_break = !!break_state;
+		tmp = UART_LCR_SBC;
+	}
+
+	status = f81232_set_mask_register(port, LINE_CONTROL_REGISTER,
+						UART_LCR_SBC, tmp);
+	if (status)
+		dev_err(&port->dev, "set break failed: %d\n", status);
+
+	mutex_unlock(&priv->lock);
 }
 
 static int f81232_find_clk(speed_t baudrate)
@@ -519,6 +531,7 @@ static int f81232_port_disable(struct usb_serial_port *port)
 static void f81232_set_termios(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct f81232_private *priv = usb_get_serial_port_data(port);
 	u8 new_lcr = 0;
 	int status = 0;
 	speed_t baudrate;
@@ -572,11 +585,18 @@ static void f81232_set_termios(struct tty_struct *tty,
 		break;
 	}
 
+	mutex_lock(&priv->lock);
+
+	if (priv->is_break)
+		new_lcr |= UART_LCR_SBC;
+
 	status = f81232_set_register(port, LINE_CONTROL_REGISTER, new_lcr);
 	if (status) {
 		dev_err(&port->dev, "%s failed to set LCR: %d\n",
 			__func__, status);
 	}
+
+	mutex_unlock(&priv->lock);
 }
 
 static int f81232_tiocmget(struct tty_struct *tty)
-- 
2.7.4

