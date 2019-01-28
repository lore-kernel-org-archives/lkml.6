Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C132C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E074920881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696380;
	bh=PC+aLUhFG8iRPV/zT7tw3bmhnn4oRIpFtBcQBmpT26E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=egzCTlIjaqWthPB6Wuz+qv6VOhby0XpVlqTsQFFD0tQ/lcvSJNrjWZC5OOHFOO0aZ
	 GFi7BYmNcLg0oUs6PK2gEBrhj4J275wgAM/Qe8h1FwDWY6Za3iybL93hBX0qb7EZGa
	 yNSo5MJGn2PxUTaFveea0S1kpvcJ9/Zt9gG6d70A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfA1QAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:00:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730475AbfA1QAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:00:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EB472175B;
        Mon, 28 Jan 2019 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691241;
        bh=PC+aLUhFG8iRPV/zT7tw3bmhnn4oRIpFtBcQBmpT26E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkOJuAbHwWa1r0EdjrNVInN4aXYPNoVlRm1oFlGNJw2OvtAHr8A18QSOxjMv4yMqo
         hmDK6FKYrW116iK/iP5B5E5PABhqrQWj8HzsPy/lXT/gFp5na8xoE4m8/n9Hbvthy4
         nazySYFDv25Alg/fdE1zKEsoHd0NnQMm3x+1K0wI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 029/258] serial: core: Allow processing sysrq at port unlock time
Date:   Mon, 28 Jan 2019 10:55:35 -0500
Message-Id: <20190128155924.51521-29-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit d6e1935819db0c91ce4a5af82466f3ab50d17346 ]

Right now serial drivers process sysrq keys deep in their character
receiving code.  This means that they've already grabbed their
port->lock spinlock.  This can end up getting in the way if we've go
to do serial stuff (especially kgdb) in response to the sysrq.

Serial drivers have various hacks in them to handle this.  Looking at
'8250_port.c' you can see that the console_write() skips locking if
we're in the sysrq handler.  Looking at 'msm_serial.c' you can see
that the port lock is dropped around uart_handle_sysrq_char().

It turns out that these hacks aren't exactly perfect.  If you have
lockdep turned on and use something like the 8250_port hack you'll get
a splat that looks like:

  WARNING: possible circular locking dependency detected
  [...] is trying to acquire lock:
  ... (console_owner){-.-.}, at: console_unlock+0x2e0/0x5e4

  but task is already holding lock:
  ... (&port_lock_key){-.-.}, at: serial8250_handle_irq+0x30/0xe4

  which lock already depends on the new lock.

  the existing dependency chain (in reverse order) is:

  -> #1 (&port_lock_key){-.-.}:
         _raw_spin_lock_irqsave+0x58/0x70
         serial8250_console_write+0xa8/0x250
         univ8250_console_write+0x40/0x4c
         console_unlock+0x528/0x5e4
         register_console+0x2c4/0x3b0
         uart_add_one_port+0x350/0x478
         serial8250_register_8250_port+0x350/0x3a8
         dw8250_probe+0x67c/0x754
         platform_drv_probe+0x58/0xa4
         really_probe+0x150/0x294
         driver_probe_device+0xac/0xe8
         __driver_attach+0x98/0xd0
         bus_for_each_dev+0x84/0xc8
         driver_attach+0x2c/0x34
         bus_add_driver+0xf0/0x1ec
         driver_register+0xb4/0x100
         __platform_driver_register+0x60/0x6c
         dw8250_platform_driver_init+0x20/0x28
	 ...

  -> #0 (console_owner){-.-.}:
         lock_acquire+0x1e8/0x214
         console_unlock+0x35c/0x5e4
         vprintk_emit+0x230/0x274
         vprintk_default+0x7c/0x84
         vprintk_func+0x190/0x1bc
         printk+0x80/0xa0
         __handle_sysrq+0x104/0x21c
         handle_sysrq+0x30/0x3c
         serial8250_read_char+0x15c/0x18c
         serial8250_rx_chars+0x34/0x74
         serial8250_handle_irq+0x9c/0xe4
         dw8250_handle_irq+0x98/0xcc
         serial8250_interrupt+0x50/0xe8
         ...

  other info that might help us debug this:

   Possible unsafe locking scenario:

         CPU0                    CPU1
         ----                    ----
    lock(&port_lock_key);
                                 lock(console_owner);
                                 lock(&port_lock_key);
    lock(console_owner);

   *** DEADLOCK ***

The hack used in 'msm_serial.c' doesn't cause the above splats but it
seems a bit ugly to unlock / lock our spinlock deep in our irq
handler.

It seems like we could defer processing the sysrq until the end of the
interrupt handler right after we've unlocked the port.  With this
scheme if a whole batch of sysrq characters comes in one irq then we
won't handle them all, but that seems like it should be a fine
compromise.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/serial_core.h | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 406edae44ca3..3460b15a2607 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -173,6 +173,7 @@ struct uart_port {
 	struct console		*cons;			/* struct console, if any */
 #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
 	unsigned long		sysrq;			/* sysrq timeout */
+	unsigned int		sysrq_ch;		/* char for sysrq */
 #endif
 
 	/* flags must be updated while holding port mutex */
@@ -482,8 +483,42 @@ uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 	}
 	return 0;
 }
+static inline int
+uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
+{
+	if (port->sysrq) {
+		if (ch && time_before(jiffies, port->sysrq)) {
+			port->sysrq_ch = ch;
+			port->sysrq = 0;
+			return 1;
+		}
+		port->sysrq = 0;
+	}
+	return 0;
+}
+static inline void
+uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+{
+	int sysrq_ch;
+
+	sysrq_ch = port->sysrq_ch;
+	port->sysrq_ch = 0;
+
+	spin_unlock_irqrestore(&port->lock, irqflags);
+
+	if (sysrq_ch)
+		handle_sysrq(sysrq_ch);
+}
 #else
-#define uart_handle_sysrq_char(port,ch) ({ (void)port; 0; })
+static inline int
+uart_handle_sysrq_char(struct uart_port *port, unsigned int ch) { return 0; }
+static inline int
+uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch) { return 0; }
+static inline void
+uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
+{
+	spin_unlock_irqrestore(&port->lock, irqflags);
+}
 #endif
 
 /*
-- 
2.19.1

