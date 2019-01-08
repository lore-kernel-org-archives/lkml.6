Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087D0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC399205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976067;
	bh=GPU3CMkOMXFYnqt0Ial9oQ07/KpqRrs/4nJ02JQcAxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zurp46R4eiNki9Y4rCBkKchczay4oYz/nc3gWamNfbP1QX4YEepHoo6QqulUOFg5L
	 kZg5Wpp2eHxzSZ2nQj2kcPWbKzsVoEicWwrYItfrBpc5DTqd0H+TW1o730tiQD0UrB
	 kww+P/j4Q7hEmEH3E6Bh8tk0thf/zTaELe8bkLmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfAHTe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:43126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731964AbfAHTeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:34:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F04F20827;
        Tue,  8 Jan 2019 19:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976062;
        bh=GPU3CMkOMXFYnqt0Ial9oQ07/KpqRrs/4nJ02JQcAxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+yaLn9fxFcyEa3x7YgFFjeeLzUnB1JyDTR+WlPiGYVaPEVLw776J41rse/MQeD53
         aCQ79cNCI3sOy7cCU7SYmeApjktQFjbZC5hdcbPgHAR/W1KUM7t9RWX5YI242Lskof
         6tb+ncI+IHAt19649/0XkK4evkGhUK206cL7q/0M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Dmitry Safonov <dima@arista.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 23/36] tty/serial: do not free trasnmit buffer page under port lock
Date:   Tue,  8 Jan 2019 14:33:35 -0500
Message-Id: <20190108193348.123880-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193348.123880-1-sashal@kernel.org>
References: <20190108193348.123880-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

[ Upstream commit d72402145ace0697a6a9e8e75a3de5bf3375f78d ]

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
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 53e6db8b0330..bcfdaf6ddbb2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -195,10 +195,15 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
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
@@ -258,6 +263,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	struct uart_port *uport = uart_port_check(state);
 	struct tty_port *port = &state->port;
 	unsigned long flags = 0;
+	char *xmit_buf = NULL;
 
 	/*
 	 * Set the TTY IO error marker
@@ -288,14 +294,18 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
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
2.19.1

