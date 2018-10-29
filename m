Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DDEC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25B852082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GvF8M/Ui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B852082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeJ3C6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:58:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43768 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbeJ3C6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:58:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id n10-v6so4276024pgv.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+DfJTCgTrDrgr1unfFr6CBi7BtxDoFYat5GCtU07b48=;
        b=GvF8M/UiJ8sZKIjYsPt8+tHO6DisFzsGwBFaTakGpnXcTryXUWOu5ScpUdoNaq+W4a
         hfCxWdSouk6+dPGzqFfzm3QFqtwAm7BXtZ3kM3awAHHk3Aqz+rKfNIHss6V37SO8CKUW
         33HJ88I05e3mny+lc9O70F3LRmWIZfnKPTfKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DfJTCgTrDrgr1unfFr6CBi7BtxDoFYat5GCtU07b48=;
        b=XzaoQt81GsMv3jQUond/gtvyjzvKw9XrMrRntTrTyT4udX8HhjDl3mV6RmAyu3h2IJ
         F9FFgS0lN82MQ3c1bdlor48ZlOqK3qm3fd6tIQ6R17vGA1PPu2ykehNW8/Yx8qQ3aK5W
         or+2WLE/JSJMsuhQb1+/7UEXtm3yKtjK6OOUu59CO9Y0owGBZyaPkbJlR+PeBrp+iY/X
         krqjwapcGuq7JkHwJI7dhhJ+/mLXEzGgtFrbcJEkrgIA4PpG/ixC0FPPP9ZR04+ZeoXT
         W7iAL2tQVWbxC9F1uYDw8lecYWyetridVRucnvhmbs2UNbmdd2xxroQp5odCCZM+dG/d
         jVEw==
X-Gm-Message-State: AGRZ1gKJ7KiyTrIgDV+s018DsMvMN7i8h+J2GZ9WLTiGqu0Rfb1FLfs8
        vj5PYTf05Y8ub7B0XzqLtnkcng==
X-Google-Smtp-Source: AJdET5cSK9jLpnEsAIhNs/yvp1Ie4J9F1Ud3hSol1CBZtDQgPB8bWg9s/zGMnSU3bPnIyAte/4gIkQ==
X-Received: by 2002:a63:bd01:: with SMTP id a1-v6mr14829419pgf.58.1540836505789;
        Mon, 29 Oct 2018 11:08:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:08:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, jslaby@suse.com
Subject: [PATCH 2/7] serial: core: Allow processing sysrq at port unlock time
Date:   Mon, 29 Oct 2018 11:07:02 -0700
Message-Id: <20181029180707.207546-3-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---

 include/linux/serial_core.h | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 047fa67d039b..78de9d929762 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -175,6 +175,7 @@ struct uart_port {
 	struct console		*cons;			/* struct console, if any */
 #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
 	unsigned long		sysrq;			/* sysrq timeout */
+	unsigned int		sysrq_ch;		/* char for sysrq */
 #endif
 
 	/* flags must be updated while holding port mutex */
@@ -485,8 +486,42 @@ uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
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
2.19.1.568.g152ad8e336-goog

