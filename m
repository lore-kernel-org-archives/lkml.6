Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AB8JxZom0REBGs/xAGl8izTrapwwbEvgTADXdGq0hNFOhb5gQpNpfCLQm28ByDdjvD9LMQKkJzFE
ARC-Seal: i=1; a=rsa-sha256; t=1524400446; cv=none;
        d=google.com; s=arc-20160816;
        b=BvxiuZSGRQaM7GUgJ/76ZExNHIFCWzosmYGIPOpWo77PUQQdR/q4GNbJMCuuPgLTvz
         5+Qi6EqXImW/2tagDwattomRX2URqY/tcL35iHgNfmy703ac+ikp3aEf9p0XVjzC/1cp
         rQWIU/XwZ//vEtA5U3G+ldUqdYgyZEcHbdVAZRzCEBK+tInxhH18BmvakwaitXBuGH1m
         z4TK77ZjJcB5xx+urxPFtkX39yQB19Fxq59otup8105WRN7lVm9qG0oYHltt1i3rD7l1
         oYeCvDw4w/aGcW8Ea69Ly2NYk8HjnpMh6dd9vgQC6hK0uP0Eqf9Q/NqnM+EV8cPfV9GE
         CPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=68553pEvc0KVKtrfaMaATr88xrJQZ36PMjpEqcjbBKk=;
        b=ssFx9eLyyNQoEo3HWbvH0H6FxvWAu8H/x5A4oKda+8D5ED/om+ydYY2ITJfpsd20cT
         EkCpGrUl5MEcVf9xV12ly4KF2RTxv4VlqBkM4pjS11GrM+jJvpHNLr4e9qszrocwdFb3
         WE6zVdIzNkgitRUvEd97a9zNgdex08zyBZYTgRKn+vw71vOqbQPAMne9YmRe5iA1/p/n
         dzL93fyUtW07rrd+KY4jf4geHEMN8DuPdD0AADz2TEVwD+d7+6zlUxq56UP6fdtlLoG9
         gVHXllsYhDdVZI3H8JEW7/lkbo0ff7zb9513vFdikwnuKoZV5kVOIH71JOahZSBPt9Rj
         Z1Fg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
From: Marc Zyngier <marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Allen Yan <yanwei@marvell.com>,
	Miquel Raynal <miquel.raynal@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] serial: mvebu-uart: Fix local flags handling on termios update
Date: Sun, 22 Apr 2018 13:33:46 +0100
Message-Id: <20180422123346.15538-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598449722207347809?=
X-GMAIL-MSGID: =?utf-8?q?1598449722207347809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 68a0db1d7da2 reworked the baud rate selection, but also added
a (not so) subtle change in the way the local flags (c_lflag in the
termios structure) are handled, forcing the new flags to always be the
same as the old ones.

The reason for that particular change is both obscure and undocumented.
It also completely breaks userspace. Something as trivial as getty is
unusable:

<example>
	Debian GNU/Linux 9 sy-borg ttyMV0

	sy-borg login: root
	root
	[timeout]

	Debian GNU/Linux 9 sy-borg ttyMV0
</example>

which is quite obvious in retrospect: getty cannot get in control of
the echo mode, is stuck in canonical mode, and times out without ever
seeing anything valid. It also begs the question of how this change was
ever tested.

The fix is pretty obvious: stop messing with c_lflag, and the world
will be a happier place.

Cc: stable@vger.kernel.org # 4.15+
Fixes: 68a0db1d7da2 ("serial: mvebu-uart: add function to change baudrate")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/tty/serial/mvebu-uart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 750e5645dc85..f503fab1e268 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -495,7 +495,6 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 		termios->c_iflag |= old->c_iflag & ~(INPCK | IGNPAR);
 		termios->c_cflag &= CREAD | CBAUD;
 		termios->c_cflag |= old->c_cflag & ~(CREAD | CBAUD);
-		termios->c_lflag = old->c_lflag;
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
2.14.2
