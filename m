Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A25C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A122083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A122083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966443AbeFSN0f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966193AbeFSN0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:26:32 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49B62075E;
        Tue, 19 Jun 2018 13:26:30 +0000 (UTC)
Date:   Tue, 19 Jun 2018 09:26:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        a.sahrawat@samsung.com, pankaj.m@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH v2] printk: make sure to print log on console.
Message-ID: <20180619092629.55146df7@gandalf.local.home>
In-Reply-To: <20180619094953.GB2631@jagdpanzerIV>
References: <CGME20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26@epcas5p3.samsung.com>
        <20180601090029epcas5p3cc93d4bfbebb3199f0a2684058da7e26~z-a_jkmrI2993329933epcas5p3q@epcas5p3.samsung.com>
        <20180618061550.GA27996@jagdpanzerIV>
        <20180618062306.GA29683@jagdpanzerIV>
        <20180619093244.ehj34uhpnpv6447f@pathway.suse.cz>
        <20180619094953.GB2631@jagdpanzerIV>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 18:49:53 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

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
>

It's not that critical to have that change take immediate effect. It's
not a common operation, and I doubt anyone (but perhaps you ;-) will
even notice any difference.

-- Steve
