Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743A1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B40C2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 10:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B40C2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937635AbeFSKwT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 06:52:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:55130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936108AbeFSKwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 06:52:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 997ECAC84;
        Tue, 19 Jun 2018 10:52:14 +0000 (UTC)
Date:   Tue, 19 Jun 2018 12:52:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180619105213.uzf6ba3oo3475icz@pathway.suse.cz>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
 <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
 <20180618061550.GA27996@jagdpanzerIV>
 <20180618062306.GA29683@jagdpanzerIV>
 <20180619093244.ehj34uhpnpv6447f@pathway.suse.cz>
 <20180619094953.GB2631@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619094953.GB2631@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-06-19 18:49:53, Sergey Senozhatsky wrote:
> On (06/19/18 11:32), Petr Mladek wrote:
> > > -               if (suppress_message_printing(msg->level)) {
> > > +               if (!ignore_loglevel && (msg->flags & LOG_NOCONS)) {
> > > 
> > > 
> > > `ignore_loglevel' is a module param and can change any time via
> > > 	/sys/module/printk/parameters/ignore_loglevel
> > > we need to respect its value.
> > 
> > I would prefer to keep the patch as is. I see it the following way.
> > 
> > Also console_loglevel can be changed anytime by /proc/sys/kernel/printk.
> > The patch basically moves the decision about the message visibility from
> > console_unlock() to vprintk_emit(). The logic is easier when all
> > aspects are handled in a single location and only once.
> 
> But when I set /sys/module/printk/parameters/ignore_loglevel I naturally
> expect it to take an immediate action. Without waiting for the consoles
> to catch up and to discard N messages [if the consoles were behind the
> logbuf head].

Yeah, I understand this view. I thought about it as well. But did you
ever needed this behavior in the real life?

I personally changed ignore_loglevel only before I wanted to reproduce a
bug. Then it would be perfectly fine to handle it only in
vprintk_emit(). In fact, it would be even better because it would
affect only messages that happened after I triggered the bug.

Anyway, changing ignore_loglevel during a printk flood has undefined
behavior by definition. If you do this manually, it would depend on
the speed of the console, your typing capabilities, possibility to
login as administrator, load of the system, ... If you do this
by a script, you would probably do it in advance. I do not see
this a reason for a more complicated and even schizophrenic logic.

Best Regards,
Petr
