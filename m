Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427259AbeCBL0I (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:26:08 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53751 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427120AbeCBL0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:26:05 -0500
Date: Fri, 2 Mar 2018 12:26:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC/PATCH RT] Revert "rt,ntp: Move call to schedule_delayed_work()
 to helper thread"
In-Reply-To: <20180302111050.dlrh4egvgns6wwwj@linutronix.de>
Message-ID: <alpine.DEB.2.21.1803021221010.1803@nanos.tec.linutronix.de>
References: <20180302111050.dlrh4egvgns6wwwj@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2018, Sebastian Andrzej Siewior wrote:

> I've been looking at this in v3.10-RT where it got in. The patch
> description says
> 
> |The ntp code for notify_cmos_timer() is called from a hard interrupt
> |context.
> 
> I see only one caller of ntp_notify_cmos_timer() and that is
> do_adjtimex() after "raw_spin_unlock_irqrestore()".
> I see a few callers of do_adjtimex() which is SYS_adjtimex() (+compat)
> and posix_clock_realtime_adj() which in turn is called by
> SYS_clock_adjtime().
> 
> I can't find the hard interrupt context. May I revert this patch?

That really looks bogus. ntp_notify_cmos_timer() has never been invoked
from hard interrupt context or from a atomic region. No idea how that patch
ended up in RT...

Thanks,

	tglx
