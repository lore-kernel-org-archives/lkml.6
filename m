Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967281AbeBNKjZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:39:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55333 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967089AbeBNKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:39:22 -0500
X-Google-Smtp-Source: AH8x224EUs8nDqzgo3Eye0s2ry6tAFwrswDP3JOHsNUWj4/kRGfgEx4vtxSCRevYF9WCjxvH7ic/aQ==
Date: Wed, 14 Feb 2018 11:39:18 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Dave Hansen <dave@sr71.net>,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] watchdog: hpwdt: Remove spinlock acquire and BIOS calls
 from NMI context
Message-ID: <20180214103918.shra2d5vg5gczjy3@gmail.com>
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
 <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
 <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
 <20180214093159.mdzfupne547bi5qx@gmail.com>
 <20180214093835.GW25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214093835.GW25181@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 14, 2018 at 10:31:59AM +0100, Ingo Molnar wrote:
> > Because in this particular case it does not appear to be so: the reason for the 
> > BIOS/firmware call appears to be to determine how we nmi_panic() after receiving 
> > an NMI that no other NMI handler handled: with a passive-aggressive "I don't know" 
> > panic message or with a slightly more informative panic message.
> 
> However much I like just ripping all that out, I think the ROM call
> actually does that logging, or that is how I read things.
> 
> If you look at the original Changelog for that driver:
> 
>     Hp is providing a Hardware WatchDog Timer driver that will only work with the
>     specific HW Timer located in the HP ProLiant iLO 2 ASIC. The iLO 2 HW Timer
>     will generate a Non-maskable Interrupt (NMI) 9 seconds before physically
>     resetting the server, by removing power, so that the event can be logged to
>     the HP Integrated Management Log (IML), a Non-Volatile Random Access Memory
>     (NVRAM). The logging of the event is performed using the HP ProLiant ROM via
>     an Industry Standard access known as a BIOS Service Directory Entry.

Ok, that appears to be the case, too bad.

But the good news: if this callback is executed only once per system lifetime then 
we don't actually have to perform *any* modification on this driver, right? The 
reason is that this callback will panic unconditionally after performing the BIOS 
call. The control flow to the panic is unconditional:

        spin_lock_irqsave(&rom_lock, rom_pl);
        if (!die_nmi_called && !is_icru && !is_uefi)
                asminline_call(&cmn_regs, cru_rom_addr);

	...

        if (!is_icru && !is_uefi) { 
                if (cmn_regs.u1.ral == 0) {
                        nmi_panic(regs, "An NMI occurred, but unable to determine source.\n");
			...

        nmi_panic(regs, "An NMI occurred. Depending on your system the reason "
                "for the NMI is logged in any one of the following "
                "resources:\n"
                "1. Integrated Management Log (IML)\n"
                "2. OA Syslog\n"
                "3. OA Forward Progress Log\n"
                "4. iLO Event Log");


This callback does not get executed when we get perf NMIs, correct?

	Ingo
