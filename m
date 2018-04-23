Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AIpwx4+UAibCqMB4psDVKK1eoFttb6+xI7XsQTxttIHjYUA2JoIFJQHRNDZDW/p1ablpsGjUEuYt
ARC-Seal: i=1; a=rsa-sha256; t=1524505165; cv=none;
        d=google.com; s=arc-20160816;
        b=sTNW1aTVjViSRc8avPLpvyJzwgHzCDL+eS6WOpNmcF/tRXp6IeZ4AdkFAr+hFQZzYn
         t1ehff4FeF6WZXC4rccSmq/zL6m7eHYPsvav3BVwOBUtNQ6TJJW+Y4zmZqwYp1rJNOYR
         QckQyMZ1vO3ftrUHjaLgwJEjTo/wsdYk55LuPBicE8iJ5QISo2kfl63J/85qLskMSeEp
         QRRLRt+CZKeRyK0v69nXOZvNwEwlN/iTPWNWsrHVMYxUKY8NPwH8ASN+QhiUXNafCxaz
         anyBPFsVdeD8SF4MYI89vuTL0+atDBYiXqiEQ+1GIgozWM4vKfGAUD/pcOH6Xb6GYPhw
         z7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=O24IDOM1P5jJFGQ0Nl0BaFohTCJk/zy8CoUCM3pgAmE=;
        b=SIp1rZwXl2zFHfU7HTrCcNCI3zPnnrN2dsGd6Cigkk1nwEKWGz/NMJrysjzBveZ0WW
         CXiqmhQC0laYCDIYl1yIAhbSkx16Do/In0sYioYjbPnSXgXNMNTJY2YwClsdOGEmDAi1
         ZKniBQD9Gp5e4gjkprvnRi62mT5uVi3W8egzzoHNhaDmfJ1/PSQdJENM9ibAtHVrEIDK
         Bg+UciZrbf/BNHU+Z1QUCKcsrx1A20/uTBLTsia+GZZ6zp2FibeEVn16P+6efnnPTrBH
         xhUnn5iL3Bto3XI9fYq76OjQMpGCciUYGLi7w7rzXHiNbB51lca81dXMQ08fALzX9DDY
         id+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=PF5BDRDq;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=PF5BDRDq;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Mon, 23 Apr 2018 18:39:04 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Allen Yan <yanwei@marvell.com>,
	Miquel Raynal <miquel.raynal@free-electrons.com>,
	Gregory CLEMENT <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: mvebu-uart: Fix local flags handling on termios
 update
Message-ID: <20180423173904.GG16141@n2100.armlinux.org.uk>
References: <20180422123346.15538-1-marc.zyngier@arm.com>
 <20180422155515.GC16141@n2100.armlinux.org.uk>
 <20180422180728.42d7b354@why.wild-wind.fr.eu.org>
 <20180422195803.GD16141@n2100.armlinux.org.uk>
 <20180423150406.GE16141@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423150406.GE16141@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598449722207347809?=
X-GMAIL-MSGID: =?utf-8?q?1598559528299188093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:04:06PM +0100, Russell King - ARM Linux wrote:
> On Sun, Apr 22, 2018 at 08:58:04PM +0100, Russell King - ARM Linux wrote:
> > On Sun, Apr 22, 2018 at 06:07:28PM +0100, Marc Zyngier wrote:
> > > On Sun, 22 Apr 2018 16:55:16 +0100
> > > Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> > > 
> > > > On Sun, Apr 22, 2018 at 01:33:46PM +0100, Marc Zyngier wrote:
> > > > > Commit 68a0db1d7da2 reworked the baud rate selection, but also added
> > > > > a (not so) subtle change in the way the local flags (c_lflag in the
> > > > > termios structure) are handled, forcing the new flags to always be the
> > > > > same as the old ones.
> > > > > 
> > > > > The reason for that particular change is both obscure and undocumented.
> > > > > It also completely breaks userspace. Something as trivial as getty is
> > > > > unusable:
> > > > > 
> > > > > <example>
> > > > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > > > 
> > > > > 	sy-borg login: root
> > > > > 	root
> > > > > 	[timeout]
> > > > > 
> > > > > 	Debian GNU/Linux 9 sy-borg ttyMV0
> > > > > </example>
> > > > > 
> > > > > which is quite obvious in retrospect: getty cannot get in control of
> > > > > the echo mode, is stuck in canonical mode, and times out without ever
> > > > > seeing anything valid. It also begs the question of how this change was
> > > > > ever tested.
> > > > > 
> > > > > The fix is pretty obvious: stop messing with c_lflag, and the world
> > > > > will be a happier place.  
> > > > 
> > > > The c_iflag code also looks suspicious as well.  Apparently, the driver
> > > > only supports INPCK and IGNPAR, but things such as ISTRIP, INLCR, IGNCR,
> > > > ICRNL, IUCLC, IMAXBEL and IUTF8 are all software things done by the TTY
> > > > layer and have nothing to do with the driver.
> > > 
> > > Indeed. I stuck with the most glaring issue (well, the one that
> > > prevented me from using this particular box), but the whole termios
> > > massaging is quite odd. Someone with a good understanding of the
> > > intricacies of the TTY layer should definitely have a look at this.
> > 
> > Right, remember, I'm the author of the serial core layer (I took over
> > from tytso back in the 2.x era.)
> > 
> > POSIX requirements are:
> > 
> >   The tcsetattr() function shall return successfully if it
> >   was able to perform any of the requested actions, even if
> >   some of the requested actions could not be performed. It
> >   shall set all the attributes that the implementation
> >   supports as requested and leave all the attributes not
> >   supported by the implementation unchanged.
> > 
> > In other words, if the system does not support two stop bits, asking
> > for CSTOPB to be set results in CSTOPB being ignored but all other
> > supported modes being updated.  This is what the code in that commit
> > is trying to implement, but it forgets that the TTY layer implements
> > a whole load of termios modes that are not specific to the serial
> > driver.
> 
> I've just been talking to Jon Nettleton about this, and it seems that
> he reported the exact same bug that you've found to Marvell a while
> back, yet it seems that the bug was still propagated into mainline.

Erm...

I wonder if anyone has _really_ looked at the commit?

+       baud = uart_get_baud_rate(port, termios, old, 0, 230400);
+       if (mvebu_uart_baud_rate_set(port, baud)) {
+               /* No clock available, baudrate cannot be changed */
+               if (old)
+                       baud = uart_get_baud_rate(port, old, NULL, 0, 230400);
+       } else {
+               tty_termios_encode_baud_rate(termios, baud, baud);
+               uart_update_timeout(port, termios->c_cflag, baud);
+       }

What is the effect if mvebu_uart_baud_rate_set() returns non-zero?  We
get the baud rate for the _old_ termios correctly, but then what do we
do with it?  "baud" is not used by this function after this point, so
what's the point of making that second call to uart_get_baud_rate()?

uart_get_baud_rate() already contains the logic to select the supported
baud rate from the new or old termios depending on the supplied
capabilities.

If there is no UART clock provided, then the above quite simply becomes
a complete no-op.

The whole thing can be simplified to:

	if (!IS_ERR(mvuart->clk)) {
		baud = uart_get_baud_rate(port, termios, old, 0, 230400);
		mvebu_uart_baud_rate_set(port, baud);
		tty_termios_encode_baud_rate(termios, baud, baud);
		uart_update_timeout(port, termios->c_cflag, baud);
	}

and the conditional in mvebu_uart_baud_rate_set() removed.

However, I suspect that the real intention of the code is actually
this:

	if (!IS_ERR(mvuart->clk)) {
		baud = uart_get_baud_rate(port, termios, old, 0, 230400);
		mvebu_uart_baud_rate_set(port, baud);
	} else {
		baud = uart_get_baud_rate(port, old, NULL, 0, 230400);
	}

	tty_termios_encode_baud_rate(termios, baud, baud);
	uart_update_timeout(port, termios->c_cflag, baud);

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
