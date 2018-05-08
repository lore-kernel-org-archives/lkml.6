Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZrJy0Ijn81VkOvc4JehRpy5bObsuAhKaOQnXYF+Y8ryeKcKl838KXqG6fm7rTar6Jq2C7XS
ARC-Seal: i=1; a=rsa-sha256; t=1525798149; cv=none;
        d=google.com; s=arc-20160816;
        b=yQOG+xq9HoHjpEQelhco7UXMQUmXJs/5ZyiEUHc4x42Tqh/qyY3IEoVUF69+9/sCck
         /HqIQn8E65Hk03bqI1XprnG2tUbgcuXlNuzUb4yxWn4taA2krmkRqXCoGSar7dV5lYjk
         XpMW4TFuOWl6g9OVqb3DgH74z5FqsjNP7fDcxY1CEE4wmkTI/twQIBd6MokxoFpbRtnA
         qrv7ClnOWbwbUCzc4p56Z1IsUWUrznUoxAuM9LBEz8UhT/q/mRcY3XrbGa2iBOikinw9
         XBm10OT4b1xMtNVQ+lhNlsNcNkIZof4F7xy2tf7KOQqhoXOdiHR9rHJGD6VwhUfppdF5
         3uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=dBdghWFAFOEmovwFF/zXwTvkVNlMADdmsxI2WDk3bBo=;
        b=MgG4KpWP7MwsKvPVG8DKO8zb3fjpVkCSRBlcNoO322GS8y8ySes+7+vJwJbeQvOHjI
         bV/K1Og8nuin1gBq+/xx4eCYUWEcLAPOc7ghOM6zLxlhkp8UrHSTR+HzTrMbWXUSWkE2
         wPlCBsAWc7l6iXQK0+lC1S/Cy+Beo/pEWoPCTCG4TZXkYcRS1WbqiV1lUlXkcXanUG4M
         +WdFlfc0AAg7TpEEQ1RUOMNken4P1dyDn3UH2cLd0e4kH6ZzxOKVR3lqS6bSfSjq08B8
         l+GkwYWAmQQ7sAI96D+5aT7q6h/yhY52holw8BefG4AWVMcfTz3UpR1AKeM8PQNb20Pi
         b/9A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Tue, 8 May 2018 09:49:04 -0700
From: Tony Lindgren <tony@atomide.com>
To: Johan Hovold <johan@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Pavel Machek <pavel@ucw.cz>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: gnss: add u-blox binding
Message-ID: <20180508164904.GZ98604@atomide.com>
References: <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508155405.GX98604@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599915320240611357?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [180508 08:54]:
> * Tony Lindgren <tony@atomide.com> [180508 08:47]:
> > * Tony Lindgren <tony@atomide.com> [180508 08:22]:
> > > * Johan Hovold <johan@kernel.org> [180508 07:00]:
> > > > With the negative autosuspend set in both omap drivers probe functions,
> > > > this is the expected behaviour. Which I think we must fix.
> > > 
> > > Yes indeed. I've been using my script for years now and have
> > > completely missed the fact that the unused ports are not idled
> > > at all on start-up when unused.
> > 
> > This might be all that's needed, care to try it and if it works
> > I'll send out two separate proper patches?
> > 
> > I'm seeing this now on my bbb after temporarily disabling my
> > UART idle init script:
> > 
> > # rwmem -s32 0x44e004b4           # uart 1 on l4_wkup
> > 0x44e004b4 = 0x00000002
> > 
> > # rwmem -s32 0x44e0006c+0x10      # uart 2 - 5 on l4_per
> > 0x44e0006c = 0x00030000
> > 0x44e00070 = 0x00030000
> > 0x44e00074 = 0x00030000
> > 0x44e00078 = 0x00030000
> > 
> > # rwmem -s32 0x44e00038           # uart 6 on l4_per
> > 0x44e00038 = 0x00030000
> 
> Hmm I forgot to remove status = "disabled" from the other ports,
> still not idling the unused ports with the patch below it seems.

No need to enable/disable autosuspend except in startup and shutdown
I think. The patch below works for me, now includes removal of the
status = "disabled" flags too. Only tested with 8250_omap on bbb
so far.

I wonder if other places still need fixing for autosuspend
like console support?

Regards,

Tony

8< -------------------
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -347,7 +347,6 @@
 			clock-frequency = <48000000>;
 			reg = <0x44e09000 0x2000>;
 			interrupts = <72>;
-			status = "disabled";
 			dmas = <&edma 26 0>, <&edma 27 0>;
 			dma-names = "tx", "rx";
 		};
@@ -358,7 +357,6 @@
 			clock-frequency = <48000000>;
 			reg = <0x48022000 0x2000>;
 			interrupts = <73>;
-			status = "disabled";
 			dmas = <&edma 28 0>, <&edma 29 0>;
 			dma-names = "tx", "rx";
 		};
@@ -369,7 +367,6 @@
 			clock-frequency = <48000000>;
 			reg = <0x48024000 0x2000>;
 			interrupts = <74>;
-			status = "disabled";
 			dmas = <&edma 30 0>, <&edma 31 0>;
 			dma-names = "tx", "rx";
 		};
@@ -380,7 +377,6 @@
 			clock-frequency = <48000000>;
 			reg = <0x481a6000 0x2000>;
 			interrupts = <44>;
-			status = "disabled";
 		};
 
 		uart4: serial@481a8000 {
@@ -389,7 +385,6 @@
 			clock-frequency = <48000000>;
 			reg = <0x481a8000 0x2000>;
 			interrupts = <45>;
-			status = "disabled";
 		};
 
 		uart5: serial@481aa000 {
@@ -398,7 +393,6 @@
 			clock-frequency = <48000000>;
 			reg = <0x481aa000 0x2000>;
 			interrupts = <46>;
-			status = "disabled";
 		};
 
 		i2c0: i2c@44e0b000 {
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -605,6 +605,7 @@ static int omap_8250_startup(struct uart_port *port)
 			return ret;
 	}
 
+	pm_runtime_use_autosuspend(port->dev);
 	pm_runtime_get_sync(port->dev);
 
 	up->mcr = 0;
@@ -685,8 +686,8 @@ static void omap_8250_shutdown(struct uart_port *port)
 		serial_out(up, UART_LCR, up->lcr & ~UART_LCR_SBC);
 	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
 
-	pm_runtime_mark_last_busy(port->dev);
-	pm_runtime_put_autosuspend(port->dev);
+	pm_runtime_dont_use_autosuspend(port->dev);
+	pm_runtime_put_sync(port->dev);
 	free_irq(port->irq, port);
 	dev_pm_clear_wake_irq(port->dev);
 }
@@ -1226,7 +1227,7 @@ static int omap8250_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->rx_dma_lock);
 
 	device_init_wakeup(&pdev->dev, true);
-	pm_runtime_use_autosuspend(&pdev->dev);
+	/* See omap_8250_startup and shutdown for autosuspend */
 	pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
 
 	pm_runtime_irq_safe(&pdev->dev);
@@ -1265,8 +1266,8 @@ static int omap8250_probe(struct platform_device *pdev)
 	}
 	priv->line = ret;
 	platform_set_drvdata(pdev, priv);
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
+
 	return 0;
 err:
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -740,6 +740,7 @@ static int serial_omap_startup(struct uart_port *port)
 
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
 
+	pm_runtime_use_autosuspend(up->dev);
 	pm_runtime_get_sync(up->dev);
 	/*
 	 * Clear the FIFO buffers and disable them.
@@ -821,8 +822,8 @@ static void serial_omap_shutdown(struct uart_port *port)
 	if (serial_in(up, UART_LSR) & UART_LSR_DR)
 		(void) serial_in(up, UART_RX);
 
-	pm_runtime_mark_last_busy(up->dev);
-	pm_runtime_put_autosuspend(up->dev);
+	pm_runtime_dont_use_autosuspend(up->dev);
+	pm_runtime_put_sync(up->dev);
 	free_irq(up->port.irq, up);
 	dev_pm_clear_wake_irq(up->dev);
 }
@@ -1733,7 +1734,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 		omap_up_info->autosuspend_timeout = -1;
 
 	device_init_wakeup(up->dev, true);
-	pm_runtime_use_autosuspend(&pdev->dev);
+	/* See serial_omap_startup and shutdown for autosuspend */
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 			omap_up_info->autosuspend_timeout);
 
@@ -1751,8 +1752,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto err_add_port;
 
-	pm_runtime_mark_last_busy(up->dev);
-	pm_runtime_put_autosuspend(up->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	return 0;
 
 err_add_port:
