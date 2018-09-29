Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118D2C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45C92087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jF24iOXn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45C92087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeI2Q7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 12:59:00 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39988 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeI2Q7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 12:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BcGJSVe35QGbB7GkZ5cWUwnvCicTDtbg3QLQES+7XGQ=; b=jF24iOXnGXxqLcYr3IQzGnH55
        lDM5rmO1ci3ASyV3t30Qmkpisavliau2xqRtuXjUg2TL0b3z6KiFZdehiPCEh1Hv5i07/xF+iRXuJ
        Rnn6SewRSguuONXk6Qm2H+ESlntkBCaEhHfGd2g7VcMGL5ttp8GScWj5i36fjGq1Aq+ok=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:47876)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g6CWP-0002Sz-Pd; Sat, 29 Sep 2018 11:30:52 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g6CWM-0000WR-Ps; Sat, 29 Sep 2018 11:30:46 +0100
Date:   Sat, 29 Sep 2018 11:30:45 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [BUG] sleep in atomic in 8250 runtime PM code path
Message-ID: <20180929103045.GQ30658@n2100.armlinux.org.uk>
References: <20180929132036.0323e24b@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929132036.0323e24b@xhacker.debian>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 01:20:36PM +0800, Jisheng Zhang wrote:
> Hi,
> 
> Recently I found I could trigger sleep in atomic bug on berlin after commit
> d76c74387e1c ("serial: 8250_dw: Fix runtime PM handling"). The path looks like:
> 
> dw8250_probe => serial850_register_8250_port => uart_add_one_port=>
> register_console => console_unlock => univ8250_console_write =>
> serial8250_console_write => serial8250_rpm_get => pm_runtime_get_sync
> 
> The irq is disabled by printk_safe_enter_irqsave() in console_unlock, but
> pm_runtime_get_sync can't be called in atomic context...
> 
> I guess the reason why we didn't notice it is due to the fact that
> only OMAP and DW sets UART_CAP_RPM currently, and DW set the flag in
> May 2018.
> 
> Per my understanding, the bug sits in the 8250 core driver rather than
> 8250_dw.c.

(Adding Tony and Sebastian, presumably CAP_RPM comes from OMAP since
that is the only other user, and this same bug is present there too.)

Correct.  printk() can be called from atomic contexts (consider what
happens when an oops or similar occurs - we can be in any context,
holding any locks etc.)  Plain printk() can also be used from within
spinlocked irqs-off regions.

This means the console's write function may be called in these contexts.
Since pm_runtime_get_sync() is may sleep, it means that its use in the
console path is _fundamentally_ wrong, and will lead to exactly this
problem.

I don't see a way around that other than to avoid RPM on consoles.
(which makes the presence of the RPM code in serial8250_console_write()
completely unnecessary.)

When I rewrote the serial drivers and created serial_core & 8250, this
is something that I realised, and I arranged the PM support at the time
to always maintain the console in active state (this is prior to RPM).

While I'm looking at commit d74d5d1b7288 ("tty: serial: 8250_core: add
run time pm"):

+static void serial8250_rpm_get_tx(struct uart_8250_port *p)
+{
+       unsigned char rpm_active;
+
+       if (!(p->capabilities & UART_CAP_RPM))
+               return;
+
+       rpm_active = xchg(&p->rpm_tx_active, 1);
+       if (rpm_active)
+               return;
+       pm_runtime_get_sync(p->port.dev);
+}

is particularly "interesting" - if this is called from sections of
code that allow it to be called concurrently from different contexts,
then we could have:

rpm_tx_active	thread 0			thread 1
0
		xchg(, 1)
1
						xchg(, 1)
						... goes on to use port ...
		pm_runtime_get_sync()

In other words, the port can be used _before_ pm_runtime_get_sync() is
called.

If, on the other hand, this can't race, then considering the
serial8250_rpm_put_tx() path as well, what stops this race from
happening:

rpm_tx_active	thread 0			thread 1
1
		serial8250_rpm_get_tx()
						serial8250_rpm_put_tx()
		xchg(, 1)
1
						xchg(, 0)
0
						pm_runtime_put_autosuspend()

Now to the real point about the above - if _neither_ race is possible,
then what is the point of the more expensive xchg() here rather than
simple test-and-assignment of rpm_tx_active?  Either these paths can't
race with each other and xchg() is unnecessary, or they can and they
_could_ fail as shown above.  My suspicion is that xchg() is an attempt
to reduce the likelyhood of one of these races being hit.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 14.8Mbps down 650kbps up
According to speedtest.net: 13Mbps down 490kbps up
