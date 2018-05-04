Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZon34RduSmT7lzS1/OadP/2BMt6fwE5zNt/biPEuSmH04Sn06xg2JcCXDwnvMoNE4SUWbcW
ARC-Seal: i=1; a=rsa-sha256; t=1525455858; cv=none;
        d=google.com; s=arc-20160816;
        b=1AMHfojEHKk4DDyUKit2l3DsvmSzQhqj1mpJiPzitqvPhSDKmjj81XvZBQNBFt+XtI
         5LnhxihBNKcwdqRmMRpa86PtDWOWgTEsywkGja0TSwVCGmtZWp0KvCL03xKYcXg15leZ
         X32q7Ch8ksqFncGzzQCPpkjTM3NIAIftr+T2OkfKqakVfEsOUHWAHz7QQ4Y1gxDL1BTn
         lJ+TECa6B9YNJBA3SxeyGtmR/yW/QLRNUtAXHYQ0lrvSHGv5ZOZSQy9+WM1iF6HD2csa
         9dCEotw3gSEZzOhczC02C840Aev3VXxIl5bYhg4hjZXcG/rr8fvjzEFDq3YNst4a2jDZ
         4nSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=+Iruz5kV7v7PP7CU3K6YPejkyabU32gQ0LbwGYnW1i0=;
        b=0fJ5HvrUl60KKU6fSBTpHeyR47PawxG+jMZRmogZxARshMNdlSE3JEfjnDi3cJWi3q
         K2Sx2PFN/fYFljTmPAUw2kULO2wx0njYPIQKWX82VMTlnGazVD81oWu8z+4qJo5wQXba
         V/SYCYFqrfV6vEhMau3FvtqBVJULFjkWwouLaUTLXwCDOyfyHkCXtoRT8nUvZCTx/bqP
         DmQyQksOE17QcnR6q3fNMnSETLf3yjwevptFCE+IM/GM6Gp2+3UtcRZNWGbTRJYBq2Kx
         5GekIo1sNO7hz+xpcBf27aaTCkItJOZmz+fvOPFqCEn9Iy7tr+xj3Ivo8C+I2s8t9tUL
         shIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
From: Tony Lindgren <tony@atomide.com>
To: Peter Hurley <peter@hurleysoftware.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh R <vigneshr@ti.com>,
	linux-serial@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Keerthy <j-keerthy@ti.com>,
	Matthijs van Duin <matthijsvanduin@gmail.com>,
	Sekhar Nori <nsekhar@ti.com>,
	Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3] serial: 8250: omap: Fix idling of clocks for unused uarts
Date: Fri,  4 May 2018 10:44:09 -0700
Message-Id: <20180504174409.74565-1-tony@atomide.com>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599555575142976735?=
X-GMAIL-MSGID: =?utf-8?q?1599556402119999411?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I noticed that unused UARTs won't necessarily idle properly always
unless at least one byte tx transfer is done first.

After some debugging I narrowed down the problem to the scr register
dma configuration bits that need to be set before softreset for the
clocks to idle. Unless we do this, the module clkctrl idlest bits
may be set to 1 instead of 3 meaning the clock will never idle and
is blocking deeper idle states for the whole domain.

This might be related to the configuration done by the bootloader
or kexec booting where certain configurations cause the 8250 or
the clkctrl clock to jam in a way where setting of the scr bits
and reset is needed to clear it. I've tried diffing the 8250
registers for the various modes, but did not see anything specific.
So far I've only seen this on omap4 but I'm suspecting this might
also happen on the other clkctrl using SoCs considering they
already have a quirk enabled for UART_ERRATA_CLOCK_DISABLE.

Let's fix the issue by configuring scr before reset for basic dma
even if we don't use it. The scr register will be reset when we do
softreset few lines after, and we restore scr on resume. We should
do this for all the SoCs with UART_ERRATA_CLOCK_DISABLE quirk flag
set since the ones with UART_ERRATA_CLOCK_DISABLE are all based
using clkctrl similar to omap4.

Looks like both OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL
bits are needed for the clkctrl to idle after a softreset.

And we need to add omap4 to also use the UART_ERRATA_CLOCK_DISABLE
for the related workaround to be enabled. This same compatible
value will also be used for omap5.

Fixes: cdb929e4452a ("serial: 8250_omap: workaround errata around idling UART after using DMA")
Cc: Keerthy <j-keerthy@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: stable <stable@vger.kernel.org>
---

Changes since v2:

- Fix to remove extra changes I accidentally commited while updating
  comments (Sebastian's "arm: Convert arm boot_lock to raw" :)

Changes since v1:

- Do the write in two steps as noted by Vignesh

- Update the comments for clkctrl status bits, it's two bits
  instead of just one bit

---
 drivers/tty/serial/8250/8250_omap.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1110,13 +1110,14 @@ static int omap8250_no_handle_irq(struct uart_port *port)
 	return 0;
 }
 
+static const u8 omap4_habit = UART_ERRATA_CLOCK_DISABLE;
 static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
 static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
 
 static const struct of_device_id omap8250_dt_ids[] = {
 	{ .compatible = "ti,omap2-uart" },
 	{ .compatible = "ti,omap3-uart" },
-	{ .compatible = "ti,omap4-uart" },
+	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
 	{ .compatible = "ti,am3352-uart", .data = &am3352_habit, },
 	{ .compatible = "ti,am4372-uart", .data = &am3352_habit, },
 	{ .compatible = "ti,dra742-uart", .data = &dra742_habit, },
@@ -1362,6 +1363,19 @@ static int omap8250_soft_reset(struct device *dev)
 	int sysc;
 	int syss;
 
+	/*
+	 * At least on omap4, unused uarts may not idle after reset without
+	 * a basic scr dma configuration even with no dma in use. The
+	 * module clkctrl status bits will be 1 instead of 3 blocking idle
+	 * for the whole clockdomain. The softreset below will clear scr,
+	 * and we restore it on resume so this is safe to do on all SoCs
+	 * needing omap8250_soft_reset() quirk. Do it in two writes as
+	 * recommended in the comment for omap8250_update_scr().
+	 */
+	serial_out(up, UART_OMAP_SCR, OMAP_UART_SCR_DMAMODE_1);
+	serial_out(up, UART_OMAP_SCR,
+		   OMAP_UART_SCR_DMAMODE_1 | OMAP_UART_SCR_DMAMODE_CTL);
+
 	sysc = serial_in(up, UART_OMAP_SYSC);
 
 	/* softreset the UART */
-- 
2.17.0
