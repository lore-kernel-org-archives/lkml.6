Return-Path: <wagi@monom.org>
X-Google-Smtp-Source: AB8JxZoktmookwzR9+E6AfGb4yH1ZNinV4zMzl8xKYEwtKWKIs6THJmHBQt4HXbJWM65dGm7tqYB
ARC-Seal: i=1; a=rsa-sha256; t=1525075763; cv=none;
        d=google.com; s=arc-20160816;
        b=thiaH41+3ba724ay/55A4OOX4hFccl0eo8HD48+QJu/5RQWyEMkazYaMQ0rjYGpRM9
         12QrWnYoJHzprTuzxR6sBAdoF/if5jVAiJTnMjuMAH187ZFzmoje3qDsn+9PZOM7eYS0
         F7HZXdaG23iSshaObOHqM6I8s54yNiGyzkPIzqVMr7tgPWwzUs8jfZHuRV2Xad3T33Fi
         hpVL9d+/o19n9BiKMSnZqpBEO35cpT1IJT/8i2Exz3d3OVvXiNMHpKnJQ05VdhNDfdKt
         NJXEObAvb6Y7ZHhf6lMqirrM6A5t6sBG2qnb4EOcAw1v9HgqoOJrah8asho6oJxob5H5
         J0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=LssdaY6mEzioW8JiMUvjue4g8S0Ndyyz1FwiglxTfJI=;
        b=q6Uw+LQ/+oG/UtH7BVk4xWMTbvIg3nRZRa3FzbX1zQCAEN/9npIHvDYlGllZh+OTSa
         Qt9kT27JV3kDB6M1/r/rg3IsQTPaThqOcFU3FXjehijYpv0ZBh0WxcQ9a2jEz2pVgLh5
         jX05B9EdEEWezxkwa10OvE5Ga2P04Q+H06r2tKJyp38wcfWVVCVWFcjJLDZ3o01FeSh4
         99txHQ0fNX0bloUCxYQlQBWYkY5n4sYsBE8zeu5gkxwATybZWbKy4J1nrPGA16QHDXBz
         YKm9DN5PgDwLBggEVytLWXLng31SBU1xiPwrPr29jV8MiJp3jnXUy4FeE3izPJQ4BoqO
         rATQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of wagi@monom.org designates 188.138.9.77 as permitted sender) smtp.mailfrom=wagi@monom.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=monom.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of wagi@monom.org designates 188.138.9.77 as permitted sender) smtp.mailfrom=wagi@monom.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=monom.org
From: Daniel Wagner <wagi@monom.org>
To: linux-kernel@vger.kernel.org
Cc: linux-rt-users@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sh@vger.kernel.org,
	Daniel Wagner <daniel.wagner@siemens.com>,
	Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Subject: [PATCH] serial: sh-sci: Use spin_{try}lock_irqsave instead of open coding version
Date: Mon, 30 Apr 2018 10:09:18 +0200
Message-Id: <20180430080918.16763-1-wagi@monom.org>
X-Mailer: git-send-email 2.14.3
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599157843339362856?=
X-GMAIL-MSGID: =?utf-8?q?1599157843339362856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@siemens.com>

Commit 40f70c03e33a ("serial: sh-sci: add locking to console write
function to avoid SMP lockup") copied the strategy to avoid locking
problems in conjuncture with the console from the UART8250
driver. Instead using directly spin_{try}lock_irqsave(),
local_irq_save() followed by spin_{try}lock() was used. While this is
correct on mainline, for -rt it is a problem. spin_{try}lock() will
check if it is running in a valid context. Since the local_irq_save()
has already been executed, the context has changed and
spin_{try}lock() will complain. The reason why spin_{try}lock()
complains is that on -rt the spin locks are turned into mutexes and
therefore can sleep. Sleeping with interrupts disabled is not valid.

BUG: sleeping function called from invalid context at /home/wagi/work/rt/v4.4-cip-rt/kernel/locking/rtmutex.c:995
in_atomic(): 0, irqs_disabled(): 128, pid: 778, name: irq/76-eth0
CPU: 0 PID: 778 Comm: irq/76-eth0 Not tainted 4.4.126-test-cip22-rt14-00403-gcd03665c8318 #12
Hardware name: Generic RZ/G1 (Flattened Device Tree)
Backtrace:
[<c00140a0>] (dump_backtrace) from [<c001424c>] (show_stack+0x18/0x1c)
 r7:c06b01f0 r6:60010193 r5:00000000 r4:c06b01f0
[<c0014234>] (show_stack) from [<c01d3c94>] (dump_stack+0x78/0x94)
[<c01d3c1c>] (dump_stack) from [<c004c134>] (___might_sleep+0x134/0x194)
 r7:60010113 r6:c06d3559 r5:00000000 r4:ffffe000
[<c004c000>] (___might_sleep) from [<c04ded60>] (rt_spin_lock+0x20/0x74)
 r5:c06f4d60 r4:c06f4d60
[<c04ded40>] (rt_spin_lock) from [<c02577e4>] (serial_console_write+0x100/0x118)
 r5:c06f4d60 r4:c06f4d60
[<c02576e4>] (serial_console_write) from [<c0061060>] (call_console_drivers.constprop.15+0x10c/0x124)
 r10:c06d2894 r9:c04e18b0 r8:00000028 r7:00000000 r6:c06d3559 r5:c06d2798
 r4:c06b9914 r3:c02576e4
[<c0060f54>] (call_console_drivers.constprop.15) from [<c0062984>] (console_unlock+0x32c/0x430)
 r10:c06d30d8 r9:00000028 r8:c06dd518 r7:00000005 r6:00000000 r5:c06d2798
 r4:c06d2798 r3:00000028
[<c0062658>] (console_unlock) from [<c0062e1c>] (vprintk_emit+0x394/0x4f0)
 r10:c06d2798 r9:c06d30ee r8:00000006 r7:00000005 r6:c06a78fc r5:00000027
 r4:00000003
[<c0062a88>] (vprintk_emit) from [<c0062fa0>] (vprintk+0x28/0x30)
 r10:c060bd46 r9:00001000 r8:c06b9a90 r7:c06b9a90 r6:c06b994c r5:c06b9a3c
 r4:c0062fa8
[<c0062f78>] (vprintk) from [<c0062fb8>] (vprintk_default+0x10/0x14)
[<c0062fa8>] (vprintk_default) from [<c009cd30>] (printk+0x78/0x84)
[<c009ccbc>] (printk) from [<c025afdc>] (credit_entropy_bits+0x17c/0x2cc)
 r3:00000001 r2:decade60 r1:c061a5ee r0:c061a523
 r4:00000006
[<c025ae60>] (credit_entropy_bits) from [<c025bf74>] (add_interrupt_randomness+0x160/0x178)
 r10:466e7196 r9:1f536000 r8:fffeef74 r7:00000000 r6:c06b9a60 r5:c06b9a3c
 r4:dfbcf680
[<c025be14>] (add_interrupt_randomness) from [<c006536c>] (irq_thread+0x1e8/0x248)
 r10:c006537c r9:c06cdf21 r8:c0064fcc r7:df791c24 r6:df791c00 r5:ffffe000
 r4:df525180
[<c0065184>] (irq_thread) from [<c003fba4>] (kthread+0x108/0x11c)
 r10:00000000 r9:00000000 r8:c0065184 r7:df791c00 r6:00000000 r5:df791d00
 r4:decac000
[<c003fa9c>] (kthread) from [<c00101b8>] (ret_from_fork+0x14/0x3c)
 r8:00000000 r7:00000000 r6:00000000 r5:c003fa9c r4:df791d00

Cc: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---
 drivers/tty/serial/sh-sci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index cf8d0955657d..3900711b60fc 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2516,13 +2516,12 @@ static void serial_console_write(struct console *co, const char *s,
 	unsigned long flags;
 	int locked = 1;
 
-	local_irq_save(flags);
 	if (port->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&port->lock);
+		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
 
 	/* first save the SCSCR then disable the interrupts */
 	ctrl = serial_port_in(port, SCSCR);
@@ -2539,8 +2538,7 @@ static void serial_console_write(struct console *co, const char *s,
 	serial_port_out(port, SCSCR, ctrl);
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static int serial_console_setup(struct console *co, char *options)
-- 
2.14.3
