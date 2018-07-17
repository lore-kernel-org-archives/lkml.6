Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286C1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F13206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F13206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeGQVGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:06:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55812 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729657AbeGQVGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:06:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 60920207AB; Tue, 17 Jul 2018 22:31:53 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 30702206FF;
        Tue, 17 Jul 2018 22:31:53 +0200 (CEST)
Date:   Tue, 17 Jul 2018 22:31:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: early_printk: respect keep parameter
Message-ID: <20180717203153.GC3211@piout.net>
References: <20180711183239.21023-1-alexandre.belloni@bootlin.com>
 <nycvar.YSQ.7.76.1807171603240.20892@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1807171603240.20892@knanqh.ubzr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2018 16:16:44-0400, Nicolas Pitre wrote:
> On Wed, 11 Jul 2018, Alexandre Belloni wrote:
> 
> > Parse and use the keep parameter of earlyprintk to avoid having the kernel
> > output stop with:
> > 
> > Console: colour dummy device 80x30
> > console [tty0] enabled
> > bootconsole [earlycon0] disabled
> > 
> > This happens because once tty0, the virtual terminal console is registered,
> > it is selected as the default console, disregarding an existing stdout-path
> > DT property and the early console is shutdown before the console driver is
> > probed.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Why can't you have a real console driver that takes over at that point 
> which respects whatever DT property you give it?
> 

See Russell's analysis here:

https://www.spinics.net/lists/linux-serial/msg25363.html


> The early_printk code is very raw and inefficient, and it shouldn't be 
> used for anything but the debugging of early boot hangs.
> 

The issue I had is that he pinctrl driver wasn't probing so the real
console driver could never probe. I think this fits the use case.

Also, atmel_serial doesn't yet have earlycon support.

> > ---
> >  arch/arm/kernel/early_printk.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
> > index 9257736ec9fa..bbb10150b11a 100644
> > --- a/arch/arm/kernel/early_printk.c
> > +++ b/arch/arm/kernel/early_printk.c
> > @@ -42,6 +42,9 @@ static struct console early_console_dev = {
> >  
> >  static int __init setup_early_printk(char *buf)
> >  {
> > +	if (buf && strstr(buf, "keep"))
> > +		early_console_dev.flags &= ~CON_BOOT;
> > +
> >  	early_console = &early_console_dev;
> >  	register_console(&early_console_dev);
> >  	return 0;
> > -- 
> > 2.18.0
> > 
> > 
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
