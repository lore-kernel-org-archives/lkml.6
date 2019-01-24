Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDFDC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769A5218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548359053;
	bh=tzSxricLIu1w/cd4mlrkb+yFGj6B+Zeo7fuR7WEfjAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LF4/CxbB36jzJPQGW7ny/DEXG6q/w336PA7+kaCoHn44XymCI21goxbXJinMYmNOb
	 Zpd+FjfrO1fII9pmi1LNdAP2SlcOQ5ujHNMOOFyoIPmNzgOcBllJ6TIC95PQric3Xp
	 0qp6vWKZ3NV+Ur15zV/vmzBt4y6d/R/dyxZBRg6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbfAXToL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733294AbfAXToI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:44:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA612218D9;
        Thu, 24 Jan 2019 19:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548359047;
        bh=tzSxricLIu1w/cd4mlrkb+yFGj6B+Zeo7fuR7WEfjAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yBYihuOCLp/4gymk0AuwWpQDoJ7cmKmTb0jPYAdtnhcss7CgZQD7eUVA+nt/YEL/Y
         Xp6V1DsEKmFFKPM63vw0Wx+uUOBkaevLRUrGIWuQm2M9SU4Ty7GiQxgXvPB6B3ySqP
         UFTedNvuQY6dCrQxlxVggxpvrWORHltuQDzi88+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Dmitry Safonov <dima@arista.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 081/127] tty/serial: do not free trasnmit buffer page under port lock
Date:   Thu, 24 Jan 2019 20:20:27 +0100
Message-Id: <20190124190215.561583313@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190211.984305387@linuxfoundation.org>
References: <20190124190211.984305387@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



