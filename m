Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2770C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCDC2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nM86aQ0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCDC2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLME7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:59:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42731 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLME7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:59:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so441274plp.9;
        Wed, 12 Dec 2018 20:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ijx3QTZ5ohdseoyBoZ9iVr+EAYZ1FODMqiDCfnQWwwo=;
        b=nM86aQ0awybgoOc50n/YECeZq7M7hImQQhxpBkhN1MW+R0siMoLsDwBsWAojM+G/qN
         I+7f2C1svAwlNXCxLKmTl8A+vJos7y/Uny5cZ//WKVijXSUOmSfeyGUo3UtIBY4nkFD4
         NwvKweY3lNQB1UYPIJMJ3JGU0MlpQjofbiG/3b1R3WIAfeRR/WEXTGo67aRs+praR2k6
         A41fipBQBRxjnjPxph8jJf36fVGtFpkoKXuQ036Gi/VTzjVUxdt3c0cYeNwyj2y495D6
         3/IlhuJfQXvB6nNdpRMRoTV2xkBLsb1bEHl6R5eYnxsgz4raHTpxYPMIYBNur/5I6OxV
         aZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ijx3QTZ5ohdseoyBoZ9iVr+EAYZ1FODMqiDCfnQWwwo=;
        b=aA6yE/oJU73z8/3U4Zq8BHHSxT4ckOVu1u2wC7QTMmU6HtCU+sewLq3IYXSH7e3Tyb
         On1vtQ0q47P7WrBYV1+R4C1/FcesvjTzzc09PhzqJoaIaFqDIscVE5kVISsAcJQHIVR3
         zIGfiSSa0zmikYPVHbkCEC11MBXdKXBWlrDFFQHboKHRH0IgKhTS7eS0ubRWIgFq6wy9
         oEaEaQt4MImjg3B1keuV7x6SuG0Rk0G1TYhSMDgaTYAu7MsO9GGfIgFYBbIVqjqD3Hwg
         GoofU09Cg7u5YdmZiyBOBa8oq4+oBHg/DUGp59gXrxE99oQhGMzNmHqpPPQQtN5UR54A
         uT1A==
X-Gm-Message-State: AA+aEWb4co/ZJPnu6ZZT03DofP5b6ecrPff3aeb+8q3+7/ga10ZplGpC
        2ccjQ1En0Fthn30k9PFpyOKgNn6a
X-Google-Smtp-Source: AFSGD/VmAjJZPzC52Izxm9VMLmzjVPxaPECI58nfbDp6XJZNdGIiZF0b+Jp/wkLMHtqYyiTyLZYDaQ==
X-Received: by 2002:a17:902:b093:: with SMTP id p19mr22265729plr.135.1544677176242;
        Wed, 12 Dec 2018 20:59:36 -0800 (PST)
Received: from localhost.localdomain ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id e188sm754251pfg.130.2018.12.12.20.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 20:59:35 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Dmitry Safonov <dima@arista.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] tty/serial: do not free trasnmit buffer page under port lock
Date:   Thu, 13 Dec 2018 13:58:39 +0900
Message-Id: <20181213045839.9692-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKP has hit yet another circular locking dependency between uart
console drivers and debugobjects [1]:

     CPU0                                    CPU1

                                            rhltable_init()
                                             __init_work()
                                              debug_object_init
     uart_shutdown()                          /* db->lock */
      /* uart_port->lock */                    debug_print_object()
       free_page()                              printk()
                                                 call_console_drivers()
        debug_check_no_obj_freed()                /* uart_port->lock */
         /* db->lock */
          debug_print_object()

So there are two dependency chains:
	uart_port->lock -> db->lock
And
	db->lock -> uart_port->lock

This particular circular locking dependency can be addressed in several
ways:

a) One way would be to move debug_print_object() out of db->lock scope
   and, thus, break the db->lock -> uart_port->lock chain.
b) Another one would be to free() transmit buffer page out of db->lock
   in UART code; which is what this patch does.

It makes sense to apply a) and b) independently: there are too many things
going on behind free(), none of which depend on uart_port->lock.

The patch fixes transmit buffer page free() in uart_shutdown() and,
additionally, in uart_port_startup() (as was suggested by Dmitry Safonov).

[1] https://lore.kernel.org/lkml/20181211091154.GL23332@shao2-debian/T/#u
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/serial_core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c439a5a1e6c0..d4cca5bdaf1c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -205,10 +205,15 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	if (!state->xmit.buf) {
 		state->xmit.buf = (unsigned char *) page;
 		uart_circ_clear(&state->xmit);
+		uart_port_unlock(uport, flags);
 	} else {
+		uart_port_unlock(uport, flags);
+		/*
+		 * Do not free() the page under the port lock, see
+		 * uart_shutdown().
+		 */
 		free_page(page);
 	}
-	uart_port_unlock(uport, flags);
 
 	retval = uport->ops->startup(uport);
 	if (retval == 0) {
@@ -268,6 +273,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	struct uart_port *uport = uart_port_check(state);
 	struct tty_port *port = &state->port;
 	unsigned long flags = 0;
+	char *xmit_buf = NULL;
 
 	/*
 	 * Set the TTY IO error marker
@@ -298,14 +304,18 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	tty_port_set_suspended(port, 0);
 
 	/*
-	 * Free the transmit buffer page.
+	 * Do not free() the transmit buffer page under the port lock since
+	 * this can create various circular locking scenarios. For instance,
+	 * console driver may need to allocate/free a debug object, which
+	 * can endup in printk() recursion.
 	 */
 	uart_port_lock(state, flags);
-	if (state->xmit.buf) {
-		free_page((unsigned long)state->xmit.buf);
-		state->xmit.buf = NULL;
-	}
+	xmit_buf = state->xmit.buf;
+	state->xmit.buf = NULL;
 	uart_port_unlock(uport, flags);
+
+	if (xmit_buf)
+		free_page((unsigned long)xmit_buf);
 }
 
 /**
-- 
2.20.0

