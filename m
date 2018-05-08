Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZrGGu2jNI4bWRZVo97m7jxng9fqHtFWZhqaaicoZtbvedpflQNRCGFw4v7igKaeg8mCDfce
ARC-Seal: i=1; a=rsa-sha256; t=1525794849; cv=none;
        d=google.com; s=arc-20160816;
        b=FOstLR5n6yyJaHwaXX7Z46hkuqh45lr3JFlobaKvjG5y0Mls2klxB5zou8mFHhQEUV
         nXlwuUKyvDLf/HBAUs22wlipGj64EibnDdVTw0PNzdeDZvhXZEdlEIb+KxCV4VUbJgq6
         fmY536QpVWMYjHPTWN7Dv9sMxxTbzqL2zQR6bnsrNBRY/Ht4EP0qMspR8k5MyjWPoUYX
         pJn5+9I1ycmGmm0xLdFLsghGFkz9IJNZZin4ZkxO/ilIng92ib8cb3n1dqClDkLWsiro
         8foTKTVbOYI3BwEMrQJJ3lPWdUp2SneydpQMjKQ960Qy6XnqiX0pUJpl4KG4cxZoKuE4
         6iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=C+rMVsGVmyaj1IlpZTTAWJ9zqZWHqB8z8ESFpfDmHyI=;
        b=UC2d9IRKQpiyXrPqt/RqcWRcyp/OhkHUUdXH9TY+Vpq2pq/sj4Wfz5mkD2dI0ypxS2
         qkSqh8MQm7GxayfcPCOxsKYmUYmIUL7Dc12px1DYRr3Np1atROvllJDK9QFc3gut0bZ7
         j3DnK+U58kDpMFwlwG6USnmqj73nXo/pM48Tee581fXYFd/EkRxItublmch4y7MNhrVC
         3VS1gEo9w4BCB6JxvIFyfpTIbuKKkiZXEI30kweUjG3XaaypaPFhKC5vy+XTw4w2Xdka
         BPX97VNg8yhewpx0GyfYu4qwY2tEtVfifCcRmJWdFd/822+tbQvIRXQ2OyuSnZuOCNVo
         qDsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Tue, 8 May 2018 08:54:05 -0700
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
Message-ID: <20180508155405.GX98604@atomide.com>
References: <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508154756.GW98604@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647064088300079?=
X-GMAIL-MSGID: =?utf-8?q?1599911860256349946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [180508 08:47]:
> * Tony Lindgren <tony@atomide.com> [180508 08:22]:
> > * Johan Hovold <johan@kernel.org> [180508 07:00]:
> > > With the negative autosuspend set in both omap drivers probe functions,
> > > this is the expected behaviour. Which I think we must fix.
> > 
> > Yes indeed. I've been using my script for years now and have
> > completely missed the fact that the unused ports are not idled
> > at all on start-up when unused.
> 
> This might be all that's needed, care to try it and if it works
> I'll send out two separate proper patches?
> 
> I'm seeing this now on my bbb after temporarily disabling my
> UART idle init script:
> 
> # rwmem -s32 0x44e004b4           # uart 1 on l4_wkup
> 0x44e004b4 = 0x00000002
> 
> # rwmem -s32 0x44e0006c+0x10      # uart 2 - 5 on l4_per
> 0x44e0006c = 0x00030000
> 0x44e00070 = 0x00030000
> 0x44e00074 = 0x00030000
> 0x44e00078 = 0x00030000
> 
> # rwmem -s32 0x44e00038           # uart 6 on l4_per
> 0x44e00038 = 0x00030000

Hmm I forgot to remove status = "disabled" from the other ports,
still not idling the unused ports with the patch below it seems.

Regards,

Tony

> 8< ----------------------
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -685,8 +685,7 @@ static void omap_8250_shutdown(struct uart_port *port)
>  		serial_out(up, UART_LCR, up->lcr & ~UART_LCR_SBC);
>  	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
>  
> -	pm_runtime_mark_last_busy(port->dev);
> -	pm_runtime_put_autosuspend(port->dev);
> +	pm_runtime_put_sync(port->dev);
>  	free_irq(port->irq, port);
>  	dev_pm_clear_wake_irq(port->dev);
>  }
> @@ -1265,8 +1264,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  	}
>  	priv->line = ret;
>  	platform_set_drvdata(pdev, priv);
> -	pm_runtime_mark_last_busy(&pdev->dev);
> -	pm_runtime_put_autosuspend(&pdev->dev);
> +	pm_runtime_put_sync(&pdev->dev);
>  	return 0;
>  err:
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -821,8 +821,7 @@ static void serial_omap_shutdown(struct uart_port *port)
>  	if (serial_in(up, UART_LSR) & UART_LSR_DR)
>  		(void) serial_in(up, UART_RX);
>  
> -	pm_runtime_mark_last_busy(up->dev);
> -	pm_runtime_put_autosuspend(up->dev);
> +	pm_runtime_put_sync(up->dev);
>  	free_irq(up->port.irq, up);
>  	dev_pm_clear_wake_irq(up->dev);
>  }
> @@ -1751,8 +1750,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>  	if (ret != 0)
>  		goto err_add_port;
>  
> -	pm_runtime_mark_last_busy(up->dev);
> -	pm_runtime_put_autosuspend(up->dev);
> +	pm_runtime_put_sync(&pdev->dev);
>  	return 0;
>  
>  err_add_port:
> -- 
> 2.17.0
