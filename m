Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042B6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F4DD2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4DD2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKSDdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:33:41 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeKSDdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:33:41 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gOQcp-0002jF-0v; Sun, 18 Nov 2018 18:12:47 +0100
Date:   Sun, 18 Nov 2018 18:12:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Finn Thain <fthain@telegraphics.com.au>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 13/13] m68k: mvme16x: Convert to clocksource APIy
In-Reply-To: <alpine.LNX.2.21.1811140925270.371@nippy.intranet>
Message-ID: <alpine.DEB.2.21.1811181759330.9459@nanos.tec.linutronix.de>
References: <cover.1541995959.git.fthain@telegraphics.com.au> <2f4015ba435f6f06b874295d2a47319875474c7f.1541995959.git.fthain@telegraphics.com.au> <alpine.DEB.2.21.1811121001140.14703@nanos.tec.linutronix.de> <alpine.LNX.2.21.1811130826260.356@nippy.intranet>
 <alpine.LNX.2.21.1811132137180.371@nippy.intranet> <alpine.DEB.2.21.1811131407120.2697@nanos.tec.linutronix.de> <alpine.LNX.2.21.1811140925270.371@nippy.intranet>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finn,

On Wed, 14 Nov 2018, Finn Thain wrote:
> On Tue, 13 Nov 2018, Thomas Gleixner wrote:
> > Urgh. Then you have more serious trouble. If the interrupting handler 
> > calls any of the time accessor functions then you can actually live lock 
> > when the interrupt happens in the middle of the write locked section of 
> > the core timekeeping update.
> 
> Does this apply to arch_gettimeoffset also? If so, that would mean another 
> bug fix patch for -stable...

arch_gettimeoffset() can be called from any context. The only interrupt
which can affect it is the timer interrupt. As m68k are all UP machines
this is not a problem because:

  ktime_get()
     do {
        seq = read_seqcount_begin(tk.seq);
	nsec = .... + arch_gettimeoffset();
     } while (seqcount_retry(tk.seq);

and the timer interrupt does:

  arch_timeoffset += value;
  ...
    xtime_update()
      ...
        write_seqcount_begin(tk.seq);
        ....
        write_seqcount_end(tk.seq);

So where ever the timer interrupt hits inside of ktime_get() or any other
accessor the seqcount will make it retry, so the result is always
consistent.

For SMP that would be a different story.

> > So you really want to disable interrupts across the whole timer 
> > interrupt function or make sure that the timer interrupt is the highest 
> > priority one on the system.
> > 
> 
> The timer interrupt priority isn't always what one would hope. 
> 
> But I can certainly disable interrupts for timer_interrupt() execution 
> (that is, xtime_update() etc.)

Oh yes, you should.

Thanks,

	tglx
