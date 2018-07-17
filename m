Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F82DECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527AD2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFPUYeJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527AD2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbeGQVXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:23:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38625 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeGQVXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:23:19 -0400
Received: by mail-qt0-f196.google.com with SMTP id y19-v6so2172623qto.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3h+oy1U4RdrmAPTWr7DjkEDlEMVvXOYwM3teP4fl850=;
        b=IFPUYeJhsSf/owmm3y3Nvm1vt7snZWGdAlVP3B7thYbD765lKtyK1Clnw7R7BpzIcC
         mwuWOhQWUY4CMQUP0o3kydfJBs9XnvvdF0jV55bhJgBD00iUVcM2sg3+glhrkMOJA3Zo
         PzresC5bSF72kvmU4YtYx3Jh63TaGJwK+zNr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3h+oy1U4RdrmAPTWr7DjkEDlEMVvXOYwM3teP4fl850=;
        b=ANmXnciHt/6U5I+r8ZtQG8oci+GqqpCeqSIhROsMyne97j/eopy+FP+ndh0q6KFGJm
         ECGMIqGe622iV5a5sdKjqrPqE2T3jzOKzFK5G2THycos8FCS01gM4LPEwRfFar362Z+n
         c5R3T/brz+UiokvGI1HXxvGns3wWlGKUCxCG+lMvsNEYMEwLBhD92n2oBttzdjsHMC48
         wmTOiswONtkiWijCF1PqeWm7+yTjGUCI+s1f7I9HwXOm1GMC0GIrN1D+hLu4iDvTtuOm
         MCNeyG/qNKXA85bsnodBydgmTRLNJY5dbxALk2c1l0Wm/vLOjBLxJie5N/Z5zLFbU6Mp
         w6Ig==
X-Gm-Message-State: AOUpUlF8VlXCfekcrxFnemw5GPErGA3ZTsSZ7fqzAuv80KWrUib9BXqP
        bKLcmVIRVyng+b4Fs8ukPb4OoA==
X-Google-Smtp-Source: AAOMgpeMHTHN3ZeptkDNmPnHln4K8UtqdOUItDLruT/StOqtkq3qmtitsKJB8gLzil3QGbUCO88L3w==
X-Received: by 2002:ac8:19cb:: with SMTP id s11-v6mr3239594qtk.229.1531860535405;
        Tue, 17 Jul 2018 13:48:55 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id 49-v6sm1784368qtu.0.2018.07.17.13.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:48:54 -0700 (PDT)
Date:   Tue, 17 Jul 2018 16:48:54 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: early_printk: respect keep parameter
In-Reply-To: <20180717203153.GC3211@piout.net>
Message-ID: <nycvar.YSQ.7.76.1807171641470.20892@knanqh.ubzr>
References: <20180711183239.21023-1-alexandre.belloni@bootlin.com> <nycvar.YSQ.7.76.1807171603240.20892@knanqh.ubzr> <20180717203153.GC3211@piout.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018, Alexandre Belloni wrote:

> On 17/07/2018 16:16:44-0400, Nicolas Pitre wrote:
> > On Wed, 11 Jul 2018, Alexandre Belloni wrote:
> > 
> > > Parse and use the keep parameter of earlyprintk to avoid having the kernel
> > > output stop with:
> > > 
> > > Console: colour dummy device 80x30
> > > console [tty0] enabled
> > > bootconsole [earlycon0] disabled
> > > 
> > > This happens because once tty0, the virtual terminal console is registered,
> > > it is selected as the default console, disregarding an existing stdout-path
> > > DT property and the early console is shutdown before the console driver is
> > > probed.
> > > 
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > 
> > Why can't you have a real console driver that takes over at that point 
> > which respects whatever DT property you give it?
> > 
> 
> See Russell's analysis here:
> 
> https://www.spinics.net/lists/linux-serial/msg25363.html

That is a good analysis, but not necessarily a good argument for this 
particular patch.

> > The early_printk code is very raw and inefficient, and it shouldn't be 
> > used for anything but the debugging of early boot hangs.
> > 
> 
> The issue I had is that he pinctrl driver wasn't probing so the real
> console driver could never probe. I think this fits the use case.

Yes, that certainly fits.  This is not what your commit log message is 
saying though.

> Also, atmel_serial doesn't yet have earlycon support.

Fair enough, and probably something you should mention too.

> > > ---
> > >  arch/arm/kernel/early_printk.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/arm/kernel/early_printk.c b/arch/arm/kernel/early_printk.c
> > > index 9257736ec9fa..bbb10150b11a 100644
> > > --- a/arch/arm/kernel/early_printk.c
> > > +++ b/arch/arm/kernel/early_printk.c
> > > @@ -42,6 +42,9 @@ static struct console early_console_dev = {
> > >  
> > >  static int __init setup_early_printk(char *buf)
> > >  {
> > > +	if (buf && strstr(buf, "keep"))
> > > +		early_console_dev.flags &= ~CON_BOOT;
> > > +
> > >  	early_console = &early_console_dev;
> > >  	register_console(&early_console_dev);
> > >  	return 0;
> > > -- 
> > > 2.18.0
> > > 
> > > 
> > 
> 
> -- 
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
