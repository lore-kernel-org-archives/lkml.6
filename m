Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeCEReR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:34:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751880AbeCEReQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:34:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293F721486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 5 Mar 2018 12:34:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC/PATCH RT] Revert "rt,ntp: Move call to
 schedule_delayed_work() to helper thread"
Message-ID: <20180305123411.3b1626e8@gandalf.local.home>
In-Reply-To: <alpine.DEB.2.21.1803021221010.1803@nanos.tec.linutronix.de>
References: <20180302111050.dlrh4egvgns6wwwj@linutronix.de>
        <alpine.DEB.2.21.1803021221010.1803@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2018 12:26:03 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Fri, 2 Mar 2018, Sebastian Andrzej Siewior wrote:
> 
> > I've been looking at this in v3.10-RT where it got in. The patch
> > description says
> > 
> > |The ntp code for notify_cmos_timer() is called from a hard interrupt
> > |context.
> > 
> > I see only one caller of ntp_notify_cmos_timer() and that is
> > do_adjtimex() after "raw_spin_unlock_irqrestore()".
> > I see a few callers of do_adjtimex() which is SYS_adjtimex() (+compat)
> > and posix_clock_realtime_adj() which in turn is called by
> > SYS_clock_adjtime().
> > 
> > I can't find the hard interrupt context. May I revert this patch?  
> 
> That really looks bogus. ntp_notify_cmos_timer() has never been invoked
> from hard interrupt context or from a atomic region. No idea how that patch
> ended up in RT...
>

I'm looking into why I did that. Unless I ended up converting the wrong
function. The patch is from 2013, and I'm sure it was due to some bug
that was triggered with the Red Hat RT kernel. Unless the RH version had
a call somewhere to it.

I'll dig a little further because I'm curious to why I added that
patch, but in the mean time, by all means, revert it.

Thanks!

-- Steve
